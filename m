Received: from mx1.redhat.com ([209.132.183.28]:39442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbdLEEmP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 4 Dec 2017 23:42:15 -0500
Date: Tue, 5 Dec 2017 12:42:13 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] ext4/030: Ext4 online resize tests.
Message-ID: <20171205044213.GJ2749@eguan.usersys.redhat.com>
References: <20171101001159.88570-1-harshads@google.com>
 <20171205034335.81702-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205034335.81702-1-harshads@google.com>
Sender: fstests-owner@vger.kernel.org
To: harshads <harshads@google.com>
Cc: david@fromorbit.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 04, 2017 at 07:43:35PM -0800, harshads wrote:
> Add tests for Ext4 online resize feature.

The commit log describes the test as a generic ext4 online resize test,
but the actual code is really testing online resize with bigalloc. So
please either update the commit log or make the test generic enough.

> 
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>
> ---
>  common/ext4        |  42 +++++++++++++++
>  tests/ext4/030     | 101 ++++++++++++++++++++++++++++++++++++
>  tests/ext4/030.out | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/group   |   1 +
>  4 files changed, 292 insertions(+)
>  create mode 100644 common/ext4
>  create mode 100755 tests/ext4/030
>  create mode 100644 tests/ext4/030.out
> 
> diff --git a/common/ext4 b/common/ext4
> new file mode 100644
> index 00000000..71966bef
> --- /dev/null
> +++ b/common/ext4
> @@ -0,0 +1,42 @@
> +#
> +# Common ext4 functions
> +#
> +
> +_ext4_online_resize()

With the hardcoded mkfs option "-O bigalloc,resize_inode,metadata_csum",
I don't think this is a function that can be shared with other tests
easily. Maybe it should be moved to the test itself.

> +{
> +	local image_file=$1
> +	local image_mount=$2
> +	local original_size=$3
> +	local final_size=$4
> +	local cluster_size=$5
> +
> +	echo "+ truncate image file to ${final_size}"
> +	# If 'final_size' is not suffixed (like 24576), then the
> +	# caller assumes that it is the number of blocks.
> +	if [[ "${final_size: -1}" == [a-zA-Z] ]]; then
> +		truncate ${image_file} -s ${final_size}

Use xfs_io to do truncate, truncate(1) is not always available (very old
distros don't have it), though that's unlikely to happen these days, why
not using xfs_io when we have better choice :)

	$XFS_IO_PROG -c "truncate <size>" ${image_file}

> +	else
> +		truncate ${image_file} -s ${final_size} -o 4096
> +	fi
> +	echo "+ create fs on image file ${original_size}"
> +	${MKFS_PROG}.${FSTYP} -F -O bigalloc,resize_inode,metadata_csum \
> +		-C ${cluster_size} -b 4096 \
> +		${image_file} ${original_size} > /dev/null 2>&1

We should make sure the userspace tool and kernel support thease
features first. Currently we have a helper function
_require_ext4_mkfs_feature() that checks if a given feature is supported
by e2fsprogs, but it doesn't check if kernel knows the feature too. Ted
is working a rework of that helper, but that's not finalized & merged
yet.

https://www.spinics.net/lists/fstests/msg07880.html

The new helper is _require_scratch_ext4_feature, which is creating new
filesystem with the given feature on $SCRATCH_DEV and try to mount it,
and _notrun if any step fails.

Perhaps we could make it work on sparse fs image not on $SCRATCH_DEV, so
that would be quicker and address Ted's concern too (mkfs twice on
$SCRATCH_DEV, once in the _require rule, once in the test).

Assuming the new helper is "_require_ext4_feature", then you can add the
following rules in your test

_require_ext4_feature "bigalloc,resize_inode,metadata_csum"

> +
> +	dumpe2fs -g ${image_file} > /dev/null 2>&1 || \
> +		_notrun "dumpe2fs -g not supported"

Use $DUMPE2FS_PROG, and this should in the test itself, not a worker
function. Maybe this could be made into a new _require rule too.

> +
> +	echo "+ mount image file"
> +	mount -t ${FSTYP} ${image_file} ${image_mount} > /dev/null 2>&1

$MOUNT_PROG

> +
> +	echo "+ resize fs to ${final_size}"
> +	resize2fs -f ${image_file} ${final_size} >> $seqres.full 2>&1 || \
> +		_fail "resize2fs failed"
> +
> +	echo "+ umount fs"
> +	umount ${image_mount}

$UMOUNT_PROG

> +
> +	echo "+ check fs"
> +	e2fsck -fn ${image_file} >> $seqres.full 2>&1 || \
> +	    _fail "fsck should not fail"

Assign a loop device to the fs image and call _check_generic_filesystem
with the device.

> +}
> diff --git a/tests/ext4/030 b/tests/ext4/030
> new file mode 100755
> index 00000000..2415fb65
> --- /dev/null
> +++ b/tests/ext4/030
> @@ -0,0 +1,101 @@
> +#! /bin/bash
> +# FS QA Test ext4/031
                     ^^^ 030? 031?
> +#
> +# Ext4 online resize tests with small and crucial resizes.

Same here, test description needs to match the actual test.

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
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	umount ${IMG_MNT} > /dev/null 2>&1
> +	rm -f ${IMG_FILE} > /dev/null 2>&1
> +}
> +
> +# get standard environment and checks
> +. ./common/rc
> +. ./common/ext4

This should be done in common/rc (e.g. how common/xfs is sourced), not
in individual test. But if we move the resize test worker into the test
itself, common/ext4 is not needed.

> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_supported_os Linux
> +
> +_require_loop
> +
> +IMG_FILE=$TEST_DIR/$seq.fs
> +IMG_MNT=$TEST_DIR/$seq.mnt
> +
> +rm -f $seqres.full
> +
> +rmdir $IMG_MNT 2>/dev/null
> +mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
> +
> +for cluster_size in 4096 16384 65536
> +do

We prefer this for-do-done format in fstests :)

for ...; do
	<work>
done

> +	blocks_per_cluster=`expr $cluster_size / 4096`
> +	echo "+ set cluster size to ${cluster_size}"
> +	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +		$((16384 * $blocks_per_cluster)) \
> +		$((24576 * $blocks_per_cluster)) ${cluster_size}

These size numbers are a bit hard to read, add human readable comments
on these numbers?

Thanks,
Eryu

> +
> +	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +		$((24576 * $blocks_per_cluster)) \
> +		$((32767 * $blocks_per_cluster)) ${cluster_size}
> +
> +	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +		$((24576 * $blocks_per_cluster)) \
> +		$((32768 * $blocks_per_cluster)) ${cluster_size}
> +
> +	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +		$((24576 * $blocks_per_cluster)) \
> +		$((65536 * $blocks_per_cluster)) ${cluster_size}
> +
> +	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +		$((24576 * $blocks_per_cluster)) \
> +		$((491521 * $blocks_per_cluster)) ${cluster_size}
> +
> +	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +		$((24576 * $blocks_per_cluster)) \
> +		$((507904 * $blocks_per_cluster)) ${cluster_size}
> +
> +	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +		$((24576 * $blocks_per_cluster)) \
> +		$((527488 * $blocks_per_cluster)) ${cluster_size}
> +
> +	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
> +		$((24576 * $blocks_per_cluster)) \
> +		$((5274880 * $blocks_per_cluster)) ${cluster_size}
> +done
> +
> +status=0
> +exit
> diff --git a/tests/ext4/030.out b/tests/ext4/030.out
> new file mode 100644
> index 00000000..5f6441e6
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
> ++ truncate image file to 527488
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 527488
> ++ umount fs
> ++ check fs
> ++ truncate image file to 5274880
> ++ create fs on image file 24576
> ++ mount image file
> ++ resize fs to 5274880
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
> ++ truncate image file to 2109952
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 2109952
> ++ umount fs
> ++ check fs
> ++ truncate image file to 21099520
> ++ create fs on image file 98304
> ++ mount image file
> ++ resize fs to 21099520
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
> ++ truncate image file to 8439808
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 8439808
> ++ umount fs
> ++ check fs
> ++ truncate image file to 84398080
> ++ create fs on image file 393216
> ++ mount image file
> ++ resize fs to 84398080
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
> 2.15.0.531.g2ccb3012c9-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
