Received: from mail-pf0-f194.google.com ([209.85.192.194]:37473 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbeD0Ih4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Apr 2018 04:37:56 -0400
Date: Fri, 27 Apr 2018 16:37:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] btrfs: Add test that checks rmdir(2) can delete a
 subvolume
Message-ID: <20180427083751.GN11384@desktop>
References: <a7ba61de-3bbc-92fd-68db-2521f4bc8545@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ba61de-3bbc-92fd-68db-2521f4bc8545@jp.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 27, 2018 at 05:02:45PM +0900, Misono Tomohiro wrote:
> Add btrfs test that checks "rmdir" or "rm -r" command can delete a
> subvolume like an ordinary drectory.
> 
> This behavior has been restricted long time but becomes allowed by
> following patch in the kernel:
>   btrfs: Allow rmdir(2) to delete an empty subvolume
> 
> Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>

Looks good to me, thanks! But still, I'd like to see a Reviewed-by tag
from btrfs developers.

Thanks,
Eryu

> ---
> v1 -> v2
>   - rebase to current master
>   - remove underscore from local function
>   - remove source common/btrfs
>   - remove unnecessary _filter_scratch and echo messages when fail
> 
> As I will take a whole week vacation next week, my replay will be late.
> Thanks,
> Tomohiro Misono
> 
> 
>  tests/btrfs/160     | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/160.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 144 insertions(+)
>  create mode 100755 tests/btrfs/160
>  create mode 100644 tests/btrfs/160.out
> 
> diff --git a/tests/btrfs/160 b/tests/btrfs/160
> new file mode 100755
> index 00000000..86d2dca7
> --- /dev/null
> +++ b/tests/btrfs/160
> @@ -0,0 +1,141 @@
> +#! /bin/bash
> +# FS QA Test btrfs/159
> +#
> +# QA test that checks rmdir(2) works for subvolumes like ordinary directories.
> +#
> +# This behavior has been restricted long time but becomes allowed by following
> +# patch in the kernel:
> +#   btrfs: Allow rmdir(2) to delete an empty subvolume
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 Fujitsu. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
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
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
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
> diff --git a/tests/btrfs/160.out b/tests/btrfs/160.out
> new file mode 100644
> index 00000000..abad21f9
> --- /dev/null
> +++ b/tests/btrfs/160.out
> @@ -0,0 +1,2 @@
> +QA output created by 160
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index ba766f6b..ff362dd2 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -162,3 +162,4 @@
>  157 auto quick raid
>  158 auto quick raid scrub
>  159 auto quick
> +160 auto quick subvol
> -- 
> 2.14.3
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
