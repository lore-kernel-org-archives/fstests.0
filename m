Received: from mail-pl0-f66.google.com ([209.85.160.66]:33614 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeDHCIC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 Apr 2018 22:08:02 -0400
Date: Sun, 8 Apr 2018 10:07:54 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: generic test for fsync after fallocate
Message-ID: <20180408020754.GA2932@desktop>
References: <20180405215614.611-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405215614.611-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 05, 2018 at 10:56:14PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that fsync operations preserve extents allocated with fallocate(2)
> that are placed beyond a file's size.
> 
> This test is motivated by a bug found in btrfs where unwritten extents
> beyond the inode's i_size were not preserved after a fsync and power
> failure. The btrfs bug is fixed by the following patch for the linux
> kernel:
> 
>  "Btrfs: fix loss of prealloc extents past i_size after fsync log replay"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Hmm, xfs fails this test, while ext4 passes.

# diff -u tests/generic/483.out /root/workspace/xfstests/results//xfs_4k_crc/generic/483.out.bad
--- tests/generic/483.out       2018-04-07 23:35:00.555555511 +0800
+++ /root/workspace/xfstests/results//xfs_4k_crc/generic/483.out.bad    2018-04-07 23:39:48.780659707 +0800
@@ -6,5 +6,5 @@
 0: [0..511]: data
 1: [512..2559]: unwritten
 File baz fiemap:
-0: [0..511]: data
-1: [512..6143]: unwritten
+0: [0..895]: data
+1: [896..6143]: unwritten

I'm not sure what the problem is yet, but IMHO controlling on-disk
layout of a file from userspace is hard and should be avoided if
possible.

Why not dumping md5sum to .out file like other dmflakey tests? I've
checked the md5sum of all the three test files, and they're the same on
xfs as on ext4, so the files are not corrupted on xfs.

Thanks,
Eryu

> ---
>  tests/generic/482     | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/482.out |  10 +++++
>  tests/generic/group   |   1 +
>  3 files changed, 129 insertions(+)
>  create mode 100755 tests/generic/482
>  create mode 100644 tests/generic/482.out
> 
> diff --git a/tests/generic/482 b/tests/generic/482
> new file mode 100755
> index 00000000..43bbc913
> --- /dev/null
> +++ b/tests/generic/482
> @@ -0,0 +1,118 @@
> +#! /bin/bash
> +# FSQA Test No. 482
> +#
> +# Test that fsync operations preserve extents allocated with fallocate(2) that
> +# are placed beyond a file's size.
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
> +# Author: Filipe Manana <fdmanana@suse.com>
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
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +. ./common/punch
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_dm_target flakey
> +_require_xfs_io_command "falloc" "-k"
> +_require_xfs_io_command "fiemap"
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test files.
> +$XFS_IO_PROG -f -c "pwrite -S 0xea 0 256K" $SCRATCH_MNT/foo >/dev/null
> +
> +# Create a file with many extents. We later want to shrink truncate it and
> +# add a prealloc extent beyond its new size.
> +for ((i = 1; i <= 500; i++)); do
> +	offset=$(((i - 1) * 4 * 1024))
> +	$XFS_IO_PROG -f -s -c "pwrite -S 0xcf $offset 4K" \
> +		$SCRATCH_MNT/bar >/dev/null
> +done
> +
> +# A file which already has a prealloc extent beyond its size.
> +# The fsync done on it is motivated by differences in the btrfs implementation
> +# of fsync (first fsync has different logic from subsequent fsyncs).
> +$XFS_IO_PROG -f -c "pwrite -S 0xf1 0 256K" \
> +	     -c "falloc -k 256K 768K" \
> +	     -c "fsync" \
> +	     $SCRATCH_MNT/baz >/dev/null
> +
> +# Make sure everything done so far is durably persisted.
> +sync
> +
> +# Allocate an extent beyond the size of the first test file and fsync it.
> +$XFS_IO_PROG -c "falloc -k 256K 1M"\
> +	     -c "fsync" \
> +	     $SCRATCH_MNT/foo
> +
> +# Do a shrinking truncate of our test file, add a prealloc extent to it after
> +# its new size and fsync it.
> +$XFS_IO_PROG -c "truncate 256K" \
> +	     -c "falloc -k 256K 1M"\
> +	     -c "fsync" \
> +	     $SCRATCH_MNT/bar
> +
> +# Allocate another extent beyond the size of file baz.
> +$XFS_IO_PROG -c "falloc -k 1M 2M"\
> +	     -c "fsync" \
> +	     $SCRATCH_MNT/baz
> +
> +# Simulate a power failure and mount the filesystem to check that the extents
> +# previously allocated were not lost.
> +_flakey_drop_and_remount
> +
> +echo "File foo fiemap:"
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap
> +
> +echo "File bar fiemap:"
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/bar | _filter_fiemap
> +
> +echo "File baz fiemap:"
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/baz | _filter_fiemap
> +
> +_unmount_flakey
> +_cleanup_flakey
> +
> +status=0
> +exit
> diff --git a/tests/generic/482.out b/tests/generic/482.out
> new file mode 100644
> index 00000000..7e3ed139
> --- /dev/null
> +++ b/tests/generic/482.out
> @@ -0,0 +1,10 @@
> +QA output created by 482
> +File foo fiemap:
> +0: [0..511]: data
> +1: [512..2559]: unwritten
> +File bar fiemap:
> +0: [0..511]: data
> +1: [512..2559]: unwritten
> +File baz fiemap:
> +0: [0..511]: data
> +1: [512..6143]: unwritten
> diff --git a/tests/generic/group b/tests/generic/group
> index e8676062..58ac1f00 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -484,3 +484,4 @@
>  479 auto quick metadata
>  480 auto quick metadata
>  481 auto quick log metadata
> +482 auto quick log metadata
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
