Received: from mail-pl0-f68.google.com ([209.85.160.68]:38960 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934778AbeE1Qfs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 12:35:48 -0400
Date: Tue, 29 May 2018 00:35:41 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] ext4: Test for s_inodes_count overflow during fs resize
Message-ID: <20180528163541.GD6581@desktop>
References: <20180524183140.16125-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524183140.16125-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 24, 2018 at 08:31:40PM +0200, Jan Kara wrote:
> Test for overflow of s_inodes_count during filesystem resizing.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  common/config      |   1 +
>  common/rc          |   7 ++++
>  tests/ext4/033     | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/033.out |   6 +++
>  tests/ext4/group   |   1 +
>  5 files changed, 133 insertions(+)
>  create mode 100755 tests/ext4/033
>  create mode 100644 tests/ext4/033.out
> 
> diff --git a/common/config b/common/config
> index fa07a6799824..659ebeed3ffc 100644
> --- a/common/config
> +++ b/common/config
> @@ -170,6 +170,7 @@ export INDENT_PROG="`set_prog_path indent`"
>  export XFS_COPY_PROG="`set_prog_path xfs_copy`"
>  export FSTRIM_PROG="`set_prog_path fstrim`"
>  export DUMPE2FS_PROG="`set_prog_path dumpe2fs`"
> +export RESIZE2FS_PROG="`set_prog_path resize2fs`"
>  export FIO_PROG="`set_prog_path fio`"
>  export FILEFRAG_PROG="`set_prog_path filefrag`"
>  export E4DEFRAG_PROG="`set_prog_path e4defrag`"
> diff --git a/common/rc b/common/rc
> index 7368e2e12988..b8aad429e153 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3176,6 +3176,13 @@ _require_dumpe2fs()
>  	fi
>  }
>  
> +_require_resize2fs()
> +{
> +	if [ -z "$RESIZE2FS_PROG" ]; then
> +		_notrun "This test requires resize2fs utility."
> +	fi
> +}
> +

I think this could simply be done by

_require_command "$RESIZE2FS_PROG" resize2fs

in the test.

And this could be added to other existing resize2fs tests too, e.g.
ext4/010, ext4/032 and ext4/306, and convert 'resize2fs' to
'$RESIZE2FS_PROG', in a follow-up patch.

>  _require_ugid_map()
>  {
>  	if [ ! -e /proc/self/uid_map ]; then
> diff --git a/tests/ext4/033 b/tests/ext4/033
> new file mode 100755
> index 000000000000..66760182e80f
> --- /dev/null
> +++ b/tests/ext4/033
> @@ -0,0 +1,118 @@
> +#! /bin/bash
> +# FS QA Test 033
> +#
> +# Test s_inodes_count overflow for huge filesystems. This bug was fixed
> +# by commit "ext4: Forbid overflowing inode count when resizing".
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 Jan Kara, SUSE.  All Rights Reserved.
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
> +	_dmhugedisk_cleanup
> +	# Recreate scratch so that _check_filesystems() does not complain
> +	_scratch_mkfs >/dev/null 2>&1

This could be done by calling _require_scratch_nocheck, instead of
_require_scratch.

But I'm not sure why it's expected to leave a corrupted fs behind after?

> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmhugedisk
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_supported_os Linux
> +_require_scratch
> +_require_dmhugedisk
> +_require_dumpe2fs
> +_require_resize2fs
> +
> +# Figure out block size
> +echo "Figure out block size"
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount >> $seqres.full
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +blksz="$(_get_block_size $SCRATCH_MNT)"
> +
> +umount $SCRATCH_MNT

_scratch_unmount

> +
> +INODES_PER_GROUP=$((blksz*8))
> +GROUP_BLOCKS=$((blksz*8))
> +
> +# Number of groups to overflow s_inodes_count
> +LIMIT_GROUPS=$(((1<<32)/INODES_PER_GROUP))

Use lower case for local variables?

> +
> +# Create device huge enough so that overflowing inode count is possible
> +echo "Format huge device"
> +_dmhugedisk_init $(((LIMIT_GROUPS + 16)*GROUP_BLOCKS*(blksz/512)))

I think we need to require a minimum size on SCRATCH_DEV too, otherwise
I got mkfs failure when testing with 1k block size on a 10G SCRATCH_DEV,
the backing device didn't have enough space to store the metadata.

After assigning a 25G device to SCRATCH_DEV, mkfs with 1k block size
passed, but test still failed in the end, I'm not sure what's going
wrong this time..

--- tests/ext4/033.out  2018-05-28 22:12:56.234867728 +0800
+++ /root/workspace/xfstests/results//ext4_1k/ext4/033.out.bad
2018-05-29 00:20:56.907283189 +0800
@@ -3,4 +3,4 @@
 Format huge device
 Resizing to inode limit + 1...
 Resizing to max group count...
-Resizing device size...
+Resizing failed!

And dmesg showed:

[166934.718495] run fstests ext4/033 at 2018-05-29 00:07:04
[166937.651454] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[167629.640111] EXT4-fs (dm-11): mounted filesystem with ordered data mode. Opts: (null)
[167632.068897] EXT4-fs (dm-11): resizing filesystem from 4294836224 to 4294967296 blocks
[167632.069900] EXT4-fs warning (device dm-11): ext4_resize_fs:1937: resize would cause inodes_count overflow
[167765.672787] EXT4-fs (dm-11): resizing filesystem from 4294836224 to 4294959104 blocks
[167765.673573] EXT4-fs error (device dm-11): ext4_resize_fs:1950: comm resize2fs: resize_inode and meta_bg enabled simultaneously
[167766.005282] EXT4-fs warning (device dm-11): ext4_resize_begin:45: There are errors in the filesystem, so online resizing is not allowed

Tests with 2k/4k block sizes all passed.

Thanks,
Eryu

> +
> +# Start with small fs
> +GROUP_COUNT=$((LIMIT_GROUPS-16))
> +_mkfs_dev -N $((GROUP_COUNT*INODES_PER_GROUP)) -b $blksz \
> +	$DMHUGEDISK_DEV $((GROUP_COUNT*GROUP_BLOCKS))
> +
> +_mount $DMHUGEDISK_DEV $SCRATCH_MNT
> +
> +echo "Initial fs dump" >> $seqres.full
> +$DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
> +
> +# This should fail, s_inodes_count would just overflow!
> +echo "Resizing to inode limit + 1..."
> +$RESIZE2FS_PROG $DMHUGEDISK_DEV $((LIMIT_GROUPS*GROUP_BLOCKS)) >> $seqres.full 2>&1
> +if [ $? -eq 0 ]; then
> +	echo "Resizing succeeded but it should fail!"
> +	exit
> +fi
> +
> +# This should succeed, we are maxing out inodes
> +echo "Resizing to max group count..."
> +$RESIZE2FS_PROG $DMHUGEDISK_DEV $(((LIMIT_GROUPS-1)*GROUP_BLOCKS)) >> $seqres.full 2>&1
> +if [ $? -ne 0 ]; then
> +	echo "Resizing failed!"
> +	exit
> +fi
> +
> +echo "Fs dump after resize" >> $seqres.full
> +$DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
> +
> +# This should fail, s_inodes_count would overflow by quite a bit!
> +echo "Resizing device size..."
> +$RESIZE2FS_PROG $DMHUGEDISK_DEV >> $seqres.full 2>&1
> +if [ $? -eq 0 ]; then
> +	echo "Resizing succeeded but it should fail!"
> +	exit
> +fi
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/033.out b/tests/ext4/033.out
> new file mode 100644
> index 000000000000..3b7c748c6994
> --- /dev/null
> +++ b/tests/ext4/033.out
> @@ -0,0 +1,6 @@
> +QA output created by 033
> +Figure out block size
> +Format huge device
> +Resizing to inode limit + 1...
> +Resizing to max group count...
> +Resizing device size...
> diff --git a/tests/ext4/group b/tests/ext4/group
> index 5bd15f82b3be..b850f568e674 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -35,6 +35,7 @@
>  030 auto quick dax
>  031 auto quick dax
>  032 auto quick ioctl resize
> +033 auto ioctl resize
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
