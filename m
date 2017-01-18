Received: from mx1.redhat.com ([209.132.183.28]:58260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbdARGjz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jan 2017 01:39:55 -0500
Date: Wed, 18 Jan 2017 14:39:53 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: btrfs/047: check btrfs-convert with extent and
 non-extent source
Message-ID: <20170118063953.GO1859@eguan.usersys.redhat.com>
References: <20170118014702.GA6682@giis.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118014702.GA6682@giis.co.in>
Sender: fstests-owner@vger.kernel.org
To: "Lakshmipathi.G" <Lakshmipathi.G@giis.co.in>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 18, 2017 at 07:17:02AM +0530, Lakshmipathi.G wrote:
> Signed-off-by: Lakshmipathi.G <Lakshmipathi.G@giis.co.in>

Need detailed test description in commit log too.

> ---
>  tests/btrfs/047     | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/047.out |   1 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 110 insertions(+)
>  create mode 100755 tests/btrfs/047
>  create mode 100644 tests/btrfs/047.out
> 
> diff --git a/tests/btrfs/047 b/tests/btrfs/047
> new file mode 100755
> index 0000000..0c4b2c7
> --- /dev/null
> +++ b/tests/btrfs/047
> @@ -0,0 +1,108 @@
> +#! /bin/bash
> +# FS QA Test 047
> +#
> +# Test btrfs-convert
> +# 

Trailing whitespace in above line.

> +# 1) create ext3 filesystem & populate it.
> +# 2) update ext3 filesystem to ext4.
> +# 3) populate data.
> +# 4) source has combination of non-extent and extent files.
> +# 5) convert it btrfs, mount and verify contents.
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Lakshmipathi.G  All Rights Reserved.
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
> +_require_scratch_nocheck
> +
> +BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
> +E2FSCK_PROG="`set_prog_path e2fsck`"
> +TUNE2FS_PROG="`set_prog_path tune2fs`"

These should go to common/config. Can you please update btrfs/012 as
well to move such defines to common/config?

> +
> +_require_command "$BTRFS_CONVERT_PROG" btrfs-convert
> +_require_command "$MKFS_EXT4_PROG" mkfs.ext4
> +_require_command "$E2FSCK_PROG" e2fsck
> +_require_command "$TUNE2FS_PROG" tune2fs
> +
> +rm -f $seqres.full
> +
> +BLOCK_SIZE=`_get_block_size $TEST_DIR`
> +
> +# Create & populate an ext3 filesystem
> +$MKFS_EXT4_PROG -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
> +	_notrun "Could not create ext3 filesystem"

Better to add "-F" option to mkfs to force mkfs so it won't stop when
there's an existing fs on SCRATCH_DEV.

> +
> +# mount and populate non-extent file
> +mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
> +dd if=/dev/urandom of=$SCRATCH_MNT/f1.txt bs=1MB count=10 >> $seqres.full 2>&1
> +NON_EXTENT_MD5=`md5sum $SCRATCH_MNT/f1.txt  | awk '{print $1}' `

Better to have different files with different file sizes and different
types, e.g. run fsstress to create such a fs structure.

> +_scratch_unmount
> +
> +# Upgrade it to ext4.
> +$TUNE2FS_PROG -O extents,uninit_bg,dir_index $SCRATCH_DEV >> $seqres.full 2>&1
> +$E2FSCK_PROG -fyD $SCRATCH_DEV >> $seqres.full 2>&1

Why is this e2fsck needed? Add some comments? Or it just can be removed?

> +
> +# mount and populate extent file
> +mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> +dd if=/dev/urandom of=$SCRATCH_MNT/f2.txt bs=1MB count=10 >> $seqres.full 2>&1
> +EXTENT_MD5=`md5sum $SCRATCH_MNT/f2.txt  | awk '{print $1}'`
> +_scratch_unmount
> +
> +# Convert non-extent & extent data to btrfs, mount it, verify the data
> +$BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
> +	_fail "btrfs-convert failed"
> +_scratch_mount || _fail "Could not mount new btrfs fs"
> +
> +F1_MD5=`md5sum $SCRATCH_MNT/f1.txt  | awk '{print $1}'`
> +F2_MD5=`md5sum $SCRATCH_MNT/f2.txt  | awk '{print $1}'`
> +if [ $NON_EXTENT_MD5 != $F1_MD5 ] ; then 

Trailing whitespace in above line.

> +_fail "ext3 file mismatch."

No need to _fail, just echo this message to break golden image.

And need indention inside "if-then-fi"

> +fi
> +
> +if [ $EXTENT_MD5 != $F2_MD5 ] ; then 

Trailing whitespace.

> +_fail "ext4 file mismatch."

Same here. Use echo and indention.

> +fi
> +   

Trailing whitespace.

> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/047.out b/tests/btrfs/047.out
> new file mode 100644
> index 0000000..58e2353
> --- /dev/null
> +++ b/tests/btrfs/047.out
> @@ -0,0 +1 @@
> +QA output created by 047

Usually we print a message "Silence is golden" to indicate that this
test doesn't expect any output.

Thanks,
Eryu

> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 3fbf706..224a082 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -49,6 +49,7 @@
>  044 auto quick send
>  045 auto quick send
>  046 auto quick send
> +047 auto convert
>  048 auto quick
>  049 auto quick
>  050 auto quick send
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
