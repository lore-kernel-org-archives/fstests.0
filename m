Received: from mail-pl1-f196.google.com ([209.85.214.196]:42907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeJGVFX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Oct 2018 17:05:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so8876513plo.9
        for <fstests@vger.kernel.org>; Sun, 07 Oct 2018 06:58:04 -0700 (PDT)
Date: Sun, 7 Oct 2018 21:57:56 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 3/3] generic: test creation time recovery after power
 failure
Message-ID: <20181007135756.GO17817@desktop>
References: <20181004043502.15005-1-chao@kernel.org>
 <20181004043502.15005-3-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004043502.15005-3-chao@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 04, 2018 at 12:35:02PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> After fsync, filesystem should guarantee inode metadata including
> creation time being persisted, so even after sudden power-cut, during
> mount, we should recover i_crtime_{,nsec} fields correctly, in order
> to not loss those meta info.
> 
> So adding this testcase to check whether generic filesystem can
> guarantee that.
> 
> Note that, it needs inode creation time support on specified filesystem.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  tests/generic/508     | 96 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/508.out |  2 +
>  tests/generic/group   |  1 +
>  3 files changed, 99 insertions(+)
>  create mode 100755 tests/generic/508
>  create mode 100644 tests/generic/508.out
> 
> diff --git a/tests/generic/508 b/tests/generic/508
> new file mode 100755
> index 00000000..61cd3397
> --- /dev/null
> +++ b/tests/generic/508
> @@ -0,0 +1,96 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 508
> +#
> +# This testcase is trying to test recovery flow of generic filesystem, it needs
> +# creation time support on specified filesystem.
> +# With below steps, once the file is created, creation time attribute should be
> +# valid on the file, after we fsync that file, it expects creation time can be
> +# recovered after sudden power-cuts.
> +# 1. touch testfile;
> +# 1.1 sync (optional)
> +# 2. xfs_io -f testfile -c "fsync";
> +# 3. godown;
> +# 4. umount;
> +# 5. mount;
> +# 6. check creation time
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/quota

This file is not needed by the test.

> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_test_lsattr
> +_require_xfs_io_command "statx" "-v"

This only checks if "statx" subcommand is supported by xfs_io, we also
need "_require_statx" to check if statx(2) is supported by the kernel.

> +
> +_require_scratch
> +_require_scratch_shutdown
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +do_check()
> +{
> +	_scratch_mount
> +
> +	touch $testfile
> +
> +	if [ "$1" == "sync" ]; then
> +		sync
> +	fi
> +
> +	before=`$XFS_IO_PROG -f $testfile -c "statx -v" | grep btime` || \
> +		_notrun "inode creation time not supported by this filesystem"

Introduce a new '_require_btime' helper function to do this check.

> +
> +	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
> +
> +	_scratch_shutdown | tee -a $seqres.full
> +	_scratch_cycle_mount
> +
> +	after=`$XFS_IO_PROG -f $testfile -c "statx -v" | grep btime`
> +
> +	# check inode's uid/gid

check inode's creation time

> +	if [ "$before" != "$after" ]; then
> +		echo "Before: $before"
> +		echo "After : $after"
> +	fi
> +	echo "Before: $before" >> $seqres.full
> +	echo "After : $after" >> $seqres.full
> +
> +	rm $testfile

rm -f $testfile

Thanks,
Eryu

> +	_scratch_unmount
> +}
> +
> +echo "Silence is golden"
> +
> +do_check
> +do_check sync
> +
> +status=0
> +exit
> diff --git a/tests/generic/508.out b/tests/generic/508.out
> new file mode 100644
> index 00000000..a5ceec05
> --- /dev/null
> +++ b/tests/generic/508.out
> @@ -0,0 +1,2 @@
> +QA output created by 508
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index e94253dc..8f26ee6a 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -510,3 +510,4 @@
>  505 shutdown auto quick metadata
>  506 shutdown auto quick metadata quota
>  507 shutdown auto quick metadata
> +508 shutdown auto quick metadata
> -- 
> 2.18.0
> 
