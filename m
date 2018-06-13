Received: from mail-pl0-f65.google.com ([209.85.160.65]:34030 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933318AbeFMHAV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Jun 2018 03:00:21 -0400
Date: Wed, 13 Jun 2018 15:00:14 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3] btrfs: Add test that checks rmdir(2) can delete a
 subvolume
Message-ID: <20180613070014.GC2780@desktop>
References: <cover.1528866453.git.misono.tomohiro@jp.fujitsu.com>
 <f0463ccd-d192-c10a-4de4-e39c03012593@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0463ccd-d192-c10a-4de4-e39c03012593@jp.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 13, 2018 at 03:06:45PM +0900, Misono Tomohiro wrote:
> Add btrfs test that checks "rmdir" or "rm -r" command can delete a
> subvolume like an ordinary directory.
> 
> This behavior has been restricted long time but becomes allowed by
> following commit in the kernel:
>   btrfs: Allow rmdir(2) to delete an empty subvolume

As the patch is already upstream, I'll add commit id in reference too.

a79a464d5675 ("btrfs: Allow rmdir(2) to delete an empty subvolume")

> 
> The test will be skipped if kernel does not support the feature,
> which can be checked whether /sys/fs/btrfs/features/rmdir_subvol
> exists or not.
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> ---
> changelog:
>  v2 -> v3 - Skip test if kernel does not support the feature by
>             checking sysfs
>           - Update license notation

Thanks a lot for the revision and using new template!

>  
>  This test should pass on kernel 4.18-rc1~ (or in current linus' master),
>  otherwise it will be skipped. Please change the test number appropriately
>  when applied as other pending tests exists.
> 
>  Thanks,
>  Tomohiro Misono
> 
>  tests/btrfs/200     | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/200.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 131 insertions(+)
>  create mode 100755 tests/btrfs/200
>  create mode 100644 tests/btrfs/200.out
> 
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> new file mode 100755
> index 00000000..15213eed
> --- /dev/null
> +++ b/tests/btrfs/200
> @@ -0,0 +1,128 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Fujitsu. All Rights Reserved.
> +#
> +# FS QA Test btrfs/200
> +#
> +# QA test that checks rmdir(2) works for subvolumes like ordinary directories.
> +#
> +# This behavior has been restricted long time but becomes allowed by following
> +# patch in the kernel:
> +#   btrfs: Allow rmdir(2) to delete an empty subvolume
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
> +create_subvol()
> +{
> +	$BTRFS_UTIL_PROG subvolume create $1 >> $seqres.full 2>&1
> +}
> +
> +create_snapshot()
> +{
> +	$BTRFS_UTIL_PROG subvolume snapshot $@ >> $seqres.full 2>&1
> +}
> +
> +rmdir_subvol()
> +{
> +	rmdir $1 >> $seqres.full 2>&1
> +}
> +
> +rm_r_subvol() {
> +	rm -r $1 >> $seqres.full 2>&1
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
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +
> +if [ ! -e /sys/fs/btrfs/features/rmdir_subvol ]; then
> +	_notrun "The kernel does not support the deletion of subvolume by rmdir"
> +fi

Just notice that there's a _require_btrfs_fs_feature helper that could
do this exact check. I'll fix it on commit.

_require_btrfs_fs_feature "rmdir_subvol"

Thanks,
Eryu

> +
> +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# Check that an empty subvolume can be deleted by rmdir
> +create_subvol $SCRATCH_MNT/sub1
> +rmdir_subvol $SCRATCH_MNT/sub1 || \
> +	echo "rmdir should delete an empty subvolume"
> +
> +# Check that non-empty subvolume cannot be deleted by rmdir
> +create_subvol $SCRATCH_MNT/sub2
> +touch $SCRATCH_MNT/sub2/file
> +rmdir_subvol $SCRATCH_MNT/sub2 && \
> +	echo "rmdir should fail for non-empty subvolume"
> +rm $SCRATCH_MNT/sub2/file
> +rmdir_subvol $SCRATCH_MNT/sub2 || \
> +	echo "rmdir should delete an empty subvolume"
> +
> +# Check that read-only empty subvolume can be deleted by rmdir
> +create_subvol $SCRATCH_MNT/sub3
> +create_snapshot -r $SCRATCH_MNT/sub3 $SCRATCH_MNT/snap
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT/sub3 ro true >> $seqres.full 2>&1
> +rmdir_subvol $SCRATCH_MNT/sub3 || \
> +	echo "rmdir should delete an empty subvolume"
> +rmdir_subvol $SCRATCH_MNT/snap || \
> +	echo "rmdir should delete a readonly empty subvolume"
> +
> +# Check that the default subvolume cannot be deleted by rmdir
> +create_subvol $SCRATCH_MNT/sub4
> +subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT sub4)
> +$BTRFS_UTIL_PROG subvolume set-default $subvolid $SCRATCH_MNT \
> +	>> $seqres.full 2>&1
> +rmdir_subvol $SCRATCH_MNT/sub4 && \
> +	echo "rmdir should fail for the default subvolume"
> +
> +# Check that subvolume stub (created by snapshot) can be deleted by rmdir
> +# (Note: this has been always allowed)
> +create_subvol $SCRATCH_MNT/sub5
> +create_subvol $SCRATCH_MNT/sub5/sub6
> +create_snapshot $SCRATCH_MNT/sub5 $SCRATCH_MNT/snap2
> +rmdir $SCRATCH_MNT/snap2/sub6 || \
> +	echo "rmdir should delete a subvolume stub (ino number == 2)"
> +
> +# Check that rm -r works for both non-snapshot subvolume and snapshot
> +create_subvol $SCRATCH_MNT/sub7
> +mkdir $SCRATCH_MNT/sub7/dir
> +create_subvol $SCRATCH_MNT/sub7/dir/sub8
> +touch $SCRATCH_MNT/sub7/dir/sub8/file
> +
> +create_snapshot $SCRATCH_MNT/sub7 $SCRATCH_MNT/snap3
> +create_snapshot -r $SCRATCH_MNT/sub7 $SCRATCH_MNT/snap4
> +
> +rm_r_subvol $SCRATCH_MNT/sub7 || \
> +	echo "rm -r should delete subvolumes recursively"
> +rm_r_subvol $SCRATCH_MNT/snap3 || \
> +	echo "rm -r should delete subvolumes recursively"
> +rm_r_subvol $SCRATCH_MNT/snap4 && \
> +	echo "rm -r should fail for non-empty readonly subvolume"
> +
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap4 ro false >> $seqres.full 2>&1
> +rm_r_subvol $SCRATCH_MNT/snap4 || \
> +	echo "rm -r should delete subvolumes recursively"
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> new file mode 100644
> index 00000000..838404ac
> --- /dev/null
> +++ b/tests/btrfs/200.out
> @@ -0,0 +1,2 @@
> +QA output created by 200
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 35354de2..105b01b9 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -167,3 +167,4 @@
>  162 auto quick volume
>  163 auto quick volume
>  164 auto quick volume
> +200 auto quick subvol
> -- 
> 2.14.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
