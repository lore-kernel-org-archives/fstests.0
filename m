Received: from mx1.redhat.com ([209.132.183.28]:41130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbdJZI5m (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Oct 2017 04:57:42 -0400
Date: Thu, 26 Oct 2017 16:57:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: add a simple cgroup2 writeback test
Message-ID: <20171026085740.GM3235@eguan.usersys.redhat.com>
References: <3d68f8b67b575bd82083db4111aa4c5b75be7830.1508303489.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d68f8b67b575bd82083db4111aa4c5b75be7830.1508303489.git.shli@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Shaohua Li <shli@kernel.org>
Cc: fstests@vger.kernel.org, Kernel-team@fb.com, Dave Chinner <david@fromorbit.com>, Shaohua Li <shli@fb.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 17, 2017 at 10:20:49PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> If filesystem supports cgroup2 writeback, the writeback IO should belong
> to the cgroup which writes the file. To verify this, we set a write
> bandwidth limit for a cgroup using block-throttling, the writeback IO
> should be throttled according to the write bandwidth.
> 
> Thanks Dave Chinner's idea to use syncfs to wait for writeback
> completion.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  common/cgroup2        | 18 +++++++++++++
>  tests/generic/463     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/463.out |  3 +++
>  tests/generic/group   |  1 +
>  4 files changed, 97 insertions(+)
>  create mode 100644 common/cgroup2
>  create mode 100755 tests/generic/463
>  create mode 100644 tests/generic/463.out
> 
> diff --git a/common/cgroup2 b/common/cgroup2
> new file mode 100644
> index 00000000..bf935fee
> --- /dev/null
> +++ b/common/cgroup2
> @@ -0,0 +1,18 @@
> +#!/bin/bash

No need to use "#!/bin/bash" for a common file to be sourced by other
scripts.

> +# cgroup2 specific common functions
> +
> +export CGROUP2_PATH="/sys/fs/cgroup"

Make it configurable? e.g.
export CGROUP2_PATH="${CGROUP2_PATH:-"/sys/fs/cgroup"}

Because on my fedora test host, cgroup is mounted at
/sys/fs/cgroup/unified by default.

> +
> +_require_cgroup2()
> +{
> +    if [ ! -f ${CGROUP2_PATH}/cgroup.subtree_control ]; then
> +        _notrun "Test requires cgroup2 enabled"
> +    fi

Please use tab for indention.

> +}
> +
> +_get_scratch_dev_devt()
> +{
> +    ls -l $SCRATCH_DEV | awk '{printf("%s:%s", substr($5, 1, length($5)-1), 0)}'
> +}

stat -c %t for major and stat -c %T for minor? And seems that the minor
device id returned here is always 0, is that intentional?

Also, you need to call _real_dev first in case $SCRATCH_DEV is a
symlink, e.g. device mapper device. And this helper can be moved to
common/rc, it's not cgroup2 specific.

I think you can factor out "get the device id" part of _sysfs_dev() into
a new helper, and use the new one in _sysfs_dev() and this test.

> +
> +/bin/true
> diff --git a/tests/generic/463 b/tests/generic/463
> new file mode 100755
> index 00000000..620a14a4
> --- /dev/null
> +++ b/tests/generic/463
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/cgroup2
> +
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +cgname=`mktemp -du ${CGROUP2_PATH}/test.XXXXXX`
> +_cleanup()
> +{
> +    cd /
> +    _scratch_unmount

check will do this automatically :)

> +    sync
> +    rmdir $cgname
> +}
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_cgroup2
> +
> +# Setup Filesystem
> +_scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
> +
> +_scratch_mount || _fail "mount failed"
> +
> +test_speed()
> +{
> +    start=$(date +%s)
> +    $XFS_IO_PROG -f -d -c "pwrite -b 1m 0 500m" "$SCRATCH_MNT/image" \
> +        > /dev/null 2>&1
> +    echo $(($(date +%s) - $start))
> +}
> +time=$(test_speed)
> +
> +if [ $time -gt 25 ]; then
> +    echo "Disk is too slow, make sure disk can do 20MB/s at least"
> +    status=1
> +    exit 1

We should call _notrun here if device speed is too slow, that's not a
failure, but a un-met test requirement.

> +fi
> +
> +echo "Disk speed is ok, start throttled writeback test"
> +
> +echo +io > ${CGROUP2_PATH}/cgroup.subtree_control

Make sure if io is available first in cgroup.controllers? Because on my
fedora rawhide test host, cgroup.controllers is empty, because all io,
cpu and mem controls are bound to cgroup v1 by default. I think this
check could be integrated with _require_cgroup2, e.g.

_require_cgroup2 io

> +mkdir $cgname
> +echo "$(_get_scratch_dev_devt) wbps=$((5*1024*1024))" > $cgname/io.max
> +
> +run_writeback()
> +{
> +    start=$(date +%s)
> +    $XFS_IO_PROG -f -c "pwrite 0 500m" -c "syncfs" "$SCRATCH_MNT/image" \
> +        > /dev/null 2>&1
> +    echo $(($(date +%s) - $start))
> +}
> +time=$(
> +echo $BASHPID > $cgname/cgroup.procs;
> +run_writeback
> +)
> +_within_tolerance "Throttled writeback runtime" $time 100 10% -v
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/463.out b/tests/generic/463.out
> new file mode 100644
> index 00000000..c69f87c2
> --- /dev/null
> +++ b/tests/generic/463.out
> @@ -0,0 +1,3 @@
> +QA output created by 463
> +Disk speed is ok, start throttled writeback test
> +Throttled writeback runtime is in range
> diff --git a/tests/generic/group b/tests/generic/group
> index f2a6cdad..ea7b6956 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -465,3 +465,4 @@
>  460 auto quick rw
>  461 auto shutdown stress
>  462 auto quick dax
> +463 cgroup writeback test

s/test/auto/, I don't see the meaning of a 'test' group :)

Thanks,
Eryu

> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
