Received: from szxga07-in.huawei.com ([45.249.212.35]:51320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729070AbeIYPXL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Sep 2018 11:23:11 -0400
Subject: Re: [PATCH] generic: add a testcase to test uid/gid recovery
References: <20180925084558.77190-1-yuchao0@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <ab6235fd-ea62-59d4-246c-9b73bc3983f3@huawei.com>
Date: Tue, 25 Sep 2018 17:16:31 +0800
MIME-Version: 1.0
In-Reply-To: <20180925084558.77190-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

There are several fields in inode rather than uid/gid didn't recover in
f2fs, I'm not sure we need to cover all of them with one generic testcase,
or with several testcases. Any suggestion?

On 2018/9/25 16:45, Chao Yu wrote:
> After fsync, filesystem should guarantee inode metadata including
> uid/gid being persisted, so even after sudden power-cut, durign
> mount, we should recover uid/gid fields correctly, in order to not
> loss those meta info.
> 
> So adding this testcase to check whether generic filesystem can
> guarantee that.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  tests/generic/505     | 95 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/505.out |  2 +
>  tests/generic/group   |  1 +
>  3 files changed, 98 insertions(+)
>  create mode 100755 tests/generic/505
>  create mode 100644 tests/generic/505.out
> 
> diff --git a/tests/generic/505 b/tests/generic/505
> new file mode 100755
> index 000000000000..103a1e9bbe47
> --- /dev/null
> +++ b/tests/generic/505
> @@ -0,0 +1,95 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 505
> +#
> +# This testcase is trying to test recovery flow of generic filesystem, w/ below
> +# steps, once uid or gid changes, after we fsync that file, we can expect that
> +# uid/gid can be recovered after sudden power-cuts.
> +# 1. touch testfile;
> +# 1.1 sync (optional)
> +# 2. chown 100 testfile;
> +# 3. chgrp 100 testfile;
> +# 4. xfs_io -f testfile -c "fsync";
> +# 5. godown;
> +# 6. umount;
> +# 7. mount;
> +# 8. check uid/gid
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
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_scratch
> +_require_scratch_shutdown
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +
> +testfile=$SCRATCH_MNT/testfile
> +stat_opt='-c "uid: %u, gid: %g"'
> +
> +_do_check()
> +{
> +	_scratch_mount
> +
> +	touch $testfile
> +
> +	if [ "$1" == "sync" ]; then
> +		sync
> +	fi
> +
> +	chown 100 $testfile
> +	chgrp 100 $testfile
> +
> +	before=`stat "$stat_opt" $testfile`
> +
> +	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
> +
> +	_scratch_shutdown | tee -a $seqres.full
> +	_scratch_unmount
> +	_scratch_mount
> +
> +	after=`stat "$stat_opt" $testfile`
> +
> +	# check inode's uid/gid
> +	if [ "$before" != "$after" ]; then
> +		echo "Before: $before"
> +		echo "After : $after"
> +	fi
> +	echo "Before: $before" >> $seqres.full
> +	echo "After : $after" >> $seqres.full
> +
> +	rm $testfile
> +	_scratch_unmount
> +}
> +
> +_do_check
> +_do_check sync
> +
> +status=0
> +echo "Silence is golden"
> +exit
> diff --git a/tests/generic/505.out b/tests/generic/505.out
> new file mode 100644
> index 000000000000..80e3bd1d9abb
> --- /dev/null
> +++ b/tests/generic/505.out
> @@ -0,0 +1,2 @@
> +QA output created by 505
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 55155de8bc29..4da0e1888f57 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -507,3 +507,4 @@
>  502 auto quick log
>  503 auto quick dax punch collapse zero
>  504 auto quick locks
> +505 shutdown auto quick metadata
> 
