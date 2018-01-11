Received: from mx1.redhat.com ([209.132.183.28]:53864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932067AbeAKHHn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Jan 2018 02:07:43 -0500
Date: Thu, 11 Jan 2018 15:07:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4] ext4/030: Ext4 online resize with bigalloc tests.
Message-ID: <20180111070740.GE5123@eguan.usersys.redhat.com>
References: <20180104011801.10141-1-harshads@google.com>
 <20180108041815.120821-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108041815.120821-1-harshads@google.com>
Sender: fstests-owner@vger.kernel.org
To: harshads <harshads@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jan 07, 2018 at 08:18:15PM -0800, harshads wrote:
> Add tests to verify Ext4 online resizing feature with bigalloc feature
> enabled. We test various resizing scenarios with different cluster
> sizes.
> 
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>

I have some more comments inline, sorry for not bringing up all comments
in previous reviews.. And please cc ext4 list for new ext4 test.

One minor issue regarding to the patch summary:

ext4/030: Ext4 online resize with bigalloc tests

there's no need to include a fixed test seq number in summary for new
test, new tests usually will be re-numbered on commit.

> ---
>  tests/ext4/030     | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/030.out | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/group   |   1 +
>  3 files changed, 305 insertions(+)
>  create mode 100755 tests/ext4/030
>  create mode 100644 tests/ext4/030.out
> 
> diff --git a/tests/ext4/030 b/tests/ext4/030
> new file mode 100755
> index 00000000..99ca9362
> --- /dev/null
> +++ b/tests/ext4/030
> @@ -0,0 +1,156 @@
> +#! /bin/bash
> +# FS QA Test ext4/030
> +#
> +# Ext4 online resize tests of small and crucial resizes with bigalloc
> +# feature.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
> +#
> +# Author: Harshad Shirwadkar <harshads@google.com>
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
> +_bytes2blk()

Usually the leading underscore is only used for common helper names, not
a local function, "bytes2blk" is fine.

> +{
> +    local bytes=$1

And please indent with tab not 4 spaces.

> +    BLKSIZ=4096

BLKSIZ is always 4096 and is only used in this function, move it out of
bytes2blk? e.g.

BLKSIZ=4096
bytes2blk()
{
...
}

This leads me to wonder that do we need to test other block sizes like
1k and 2k?

> +    echo $((bytes / $BLKSIZ))
> +}
> +
> +_ext4_online_resize()
> +{
> +    local image_file=$1
> +    local image_mount=$2
> +    local original_size=$3
> +    local final_size=$4
> +    local cluster_size=$5
> +
> +    echo "+ truncate image file to $(_bytes2blk $final_size)"

Append such logs to $seqres.full too? I might be easier for debugging.

> +    $XFS_IO_PROG -f -c "truncate ${final_size}" ${image_file}
> +    LOOP_DEVICE=`_create_loop_device $image_file || _fail "losetup failed"`
> +
> +    echo "+ create fs on image file $(_bytes2blk $original_size)"
> +    ${MKFS_PROG}.${FSTYP} -F -O bigalloc,resize_inode,metadata_csum \

Why do we need "metadata_csum" here? Some comments would be fine if it's
really needed. Better to have comments on the "resize_inode" feature
too.

> +		-C ${cluster_size} -b 4096 \
> +		${LOOP_DEVICE} $(_bytes2blk $original_size) > /dev/null 2>&1 || \
> +	_fail "mkfs failed"
> +
> +    echo "+ mount image file"
> +    $MOUNT_PROG -t ${FSTYP} ${LOOP_DEVICE} ${image_mount} > \
> +		/dev/null 2>&1 || _fail "mount failed"
> +
> +    echo "+ resize fs to $(_bytes2blk $final_size)"
> +    resize2fs -f ${LOOP_DEVICE} $(_bytes2blk $final_size) >> $seqres.full 2>&1 || \
> +	_fail "resize2fs failed"

Hmm, online resize support for bigalloc ext4 is added in v4.15-rc1,
tests would fail on old kernels. I think we need a new _require rule to
make sure current kernel does support ext4 online resize with bigalloc
feature.

> +
> +    echo "+ umount fs"
> +    $UMOUNT_PROG ${image_mount}
> +
> +    echo "+ check fs"
> +    _check_generic_filesystem $LOOP_DEVICE >> $seqres.full 2>&1 || \
> +	_fail "fsck should not fail"
> +    _destroy_loop_device $LOOP_DEVICE && LOOP_DEVICE=
> +}
> +
> +_cleanup()
> +{
> +    cd /
> +    [ -n "$LOOP_DEVICE" ] && _destroy_loop_device $LOOP_DEVICE > /dev/null 2>&1
> +    rm -f $tmp.*
> +    umount ${IMG_MNT} > /dev/null 2>&1

$UMOUNT_PROG

> +    rm -f ${IMG_FILE} > /dev/null 2>&1
> +}
> +
> +# get standard environment and checks
> +. ./common/rc
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_supported_os Linux
> +
> +_require_loop
> +_require_scratch
> +_require_scratch_ext4_feature "bigalloc,resize_inode,metadata_csum"
> +
> +IMG_FILE=$TEST_DIR/$seq.fs
> +IMG_MNT=$TEST_DIR/$seq.mnt

We required scratch device, then just create fs images on $SCRATCH_MNT?
i.e.

rm -f $seqres.full
_scratch_mkfs >>$seqres.full 2>&1
_scratch_mount

IMG_FILE=$SCRATCH_MNT/$seq.fs
IMG_MNT=$SCRATCH_MNT/$seq.mnt

> +
> +rm -f $seqres.full
> +
> +rmdir $IMG_MNT 2>/dev/null

Then there's no need to do rmdir on newly created filesystem.

> +mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
> +
> +## We perform resizing to various multiples of block group sizes to
> +## ensure that we cover maximum edge cases in the kernel code.

I found that your reply to Ted in the ext4 bigalloc online resize path
thread provided more details of the test:

"... ensure that all different code paths that resize IOCTL triggers get
executed. At a high level, these different code paths are - 1) extending
last block group, 2) adding new block groups 3) conversion of file
system to meta-bg."

I think it's better to add similar comments in the test too.

Thanks,
Eryu

> +for cluster_size in 4096 16384 65536; do
> +    echo "+ set cluster size to ${cluster_size}"
> +    ## Extending a 1/2 block group to a 2/3 block group.
> +    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +			$((16384 * $cluster_size)) \
> +			$((24576 * $cluster_size)) ${cluster_size}
> +
> +    ## Extending a 2/3rd block group to one cluster less than a
> +    ## full block group.
> +    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +			$((24576 * $cluster_size)) \
> +			$((32767 * $cluster_size)) ${cluster_size}
> +
> +    ## Extending a 2/3rd block group to a full block group.
> +    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +			$((24576 * $cluster_size)) \
> +			$((32768 * $cluster_size)) ${cluster_size}
> +
> +    ## Extending a 2/3rd block group to 2 block groups.
> +    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +			$((24576 * $cluster_size)) \
> +			$((65536 * $cluster_size)) ${cluster_size}
> +
> +    ## Extending a 2/3rd block group to 15 block groups and one
> +    ## cluster.
> +    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +			$((24576 * $cluster_size)) \
> +			$((491521 * $cluster_size)) ${cluster_size}
> +
> +    ## Extending a 2/3rd block group to 15 and a half block groups.
> +    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +			$((24576 * $cluster_size)) \
> +			$((507904 * $cluster_size)) ${cluster_size}
> +
> +    ## Extending a 2/3rd block group to 16 block groups.
> +    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +			$((24576 * $cluster_size)) \
> +			$((524288 * $cluster_size)) ${cluster_size}
> +
> +    ## Extending a 2/3rd block group to 160 block groups.
> +    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +			$((24576 * $cluster_size)) \
> +			$((5242880 * $cluster_size)) ${cluster_size}
> +done
> +
> +status=0
> +exit
> diff --git a/tests/ext4/030.out b/tests/ext4/030.out
> new file mode 100644
> index 00000000..17cc4d99
> --- /dev/null
> +++ b/tests/ext4/030.out
> @@ -0,0 +1,148 @@
> +QA output created by 030
> ++ set cluster size to 4096
> ++ truncate image file to 24576
> ++ create fs on image file 16384
> ++ mount image file
> ++ resize fs to 24576
> ++ umount fs
> ++ check fs
> ++ truncate image file to 32767
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 32767
> ++ umount fs
> ++ check fs
> ++ truncate image file to 32768
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 32768
> ++ umount fs
> ++ check fs
> ++ truncate image file to 65536
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 65536
> ++ umount fs
> ++ check fs
> ++ truncate image file to 491521
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 491521
> ++ umount fs
> ++ check fs
> ++ truncate image file to 507904
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 507904
> ++ umount fs
> ++ check fs
> ++ truncate image file to 524288
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 524288
> ++ umount fs
> ++ check fs
> ++ truncate image file to 5242880
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 5242880
> ++ umount fs
> ++ check fs
> ++ set cluster size to 16384
> ++ truncate image file to 98304
> ++ create fs on image file 65536
> ++ mount image file
> ++ resize fs to 98304
> ++ umount fs
> ++ check fs
> ++ truncate image file to 131068
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 131068
> ++ umount fs
> ++ check fs
> ++ truncate image file to 131072
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 131072
> ++ umount fs
> ++ check fs
> ++ truncate image file to 262144
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 262144
> ++ umount fs
> ++ check fs
> ++ truncate image file to 1966084
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 1966084
> ++ umount fs
> ++ check fs
> ++ truncate image file to 2031616
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 2031616
> ++ umount fs
> ++ check fs
> ++ truncate image file to 2097152
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 2097152
> ++ umount fs
> ++ check fs
> ++ truncate image file to 20971520
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 20971520
> ++ umount fs
> ++ check fs
> ++ set cluster size to 65536
> ++ truncate image file to 393216
> ++ create fs on image file 262144
> ++ mount image file
> ++ resize fs to 393216
> ++ umount fs
> ++ check fs
> ++ truncate image file to 524272
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 524272
> ++ umount fs
> ++ check fs
> ++ truncate image file to 524288
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 524288
> ++ umount fs
> ++ check fs
> ++ truncate image file to 1048576
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 1048576
> ++ umount fs
> ++ check fs
> ++ truncate image file to 7864336
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 7864336
> ++ umount fs
> ++ check fs
> ++ truncate image file to 8126464
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 8126464
> ++ umount fs
> ++ check fs
> ++ truncate image file to 8388608
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 8388608
> ++ umount fs
> ++ check fs
> ++ truncate image file to 83886080
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 83886080
> ++ umount fs
> ++ check fs
> diff --git a/tests/ext4/group b/tests/ext4/group
> index 257bb646..f29d3de6 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -32,6 +32,7 @@
>  027 auto quick fsmap
>  028 auto quick fsmap
>  029 auto quick fsmap
> +030 auto quick ioctl resize
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.16.0.rc0.223.g4a4ac83678-goog
> 
