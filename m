Received: from mail-pf0-f194.google.com ([209.85.192.194]:41259 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeADBSw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Jan 2018 20:18:52 -0500
Received: by mail-pf0-f194.google.com with SMTP id j28so97548pfk.8
        for <fstests@vger.kernel.org>; Wed, 03 Jan 2018 17:18:52 -0800 (PST)
From: harshads <harshads@google.com>
Subject: [PATCH v3] ext4/030: Ext4 online resize with bigalloc tests.
Date: Wed,  3 Jan 2018 17:18:00 -0800
Message-Id: <20180104011801.10141-1-harshads@google.com>
In-Reply-To: <20171101001159.88570-1-harshads@google.com>
References: <20171101001159.88570-1-harshads@google.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, harshads <harshads@google.com>
List-ID: <fstests@vger.kernel.org>

Add tests to verify Ext4 online resizing feature with bigalloc feature
enabled. We test various resizing scenarios with different cluster
sizes.

Signed-off-by: Harshad Shirwadkar <harshads@google.com>
---
 common/rc          |  23 ++++++++
 tests/ext4/030     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/030.out | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/group   |   1 +
 4 files changed, 330 insertions(+)
 create mode 100755 tests/ext4/030
 create mode 100644 tests/ext4/030.out

diff --git a/common/rc b/common/rc
index 9216efdb..052dadae 100644
--- a/common/rc
+++ b/common/rc
@@ -1845,6 +1845,29 @@ _require_scratch_ext4_feature()
     _scratch_unmount
 }
 
+# Check whether the specified feature whether it is supported by
+# mkfs.ext4 and the kernel by using a sparse file image.
+_require_ext4_feature()
+{
+    if [ -z "$1" ]; then
+        echo "Usage: _require_loop_ext4_feature feature"
+        exit 1
+    fi
+    local test_image="${TEST_DIR}/test_image"
+    local test_mnt="${TEST_DIR}/test_mnt"
+    rm -rf $test_image $test_mnt
+    mkdir -p $test_mnt || _fail "cannot create loopback mount point"
+    $XFS_IO_PROG -f -c "truncate 512m" $test_image >/dev/null 2>&1
+    $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" $test_image 512m >/dev/null 2>&1 \
+	|| _notrun "mkfs.ext4 doesn't support $1 feature"
+    _mount -t $FSTYP `_common_dev_mount_options $test_image $test_mnt` \
+        >/dev/null 2>&1 \
+	|| _notrun "Kernel doesn't support the ext4 feature(s): $1"
+    $UMOUNT_PROG $test_mnt >/dev/null 2>&1
+    rm -f $test_image >/dev/null 2>&1
+    rmdir $test_mnt >/dev/null 2>&1
+}
+
 # this test requires that external log/realtime devices are not in use
 #
 _require_nonexternal()
diff --git a/tests/ext4/030 b/tests/ext4/030
new file mode 100755
index 00000000..add063a6
--- /dev/null
+++ b/tests/ext4/030
@@ -0,0 +1,158 @@
+#! /bin/bash
+# FS QA Test ext4/030
+#
+# Ext4 online resize tests of small and crucial resizes with bigalloc
+# feature.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
+#
+# Author: Harshad Shirwadkar <harshads@google.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_bytes2blk()
+{
+    local bytes=$1
+    BLKSIZ=4096
+    echo $((bytes / $BLKSIZ))
+}
+
+_ext4_online_resize()
+{
+    local image_file=$1
+    local image_mount=$2
+    local original_size=$3
+    local final_size=$4
+    local cluster_size=$5
+
+    echo "+ truncate image file to $(_bytes2blk $final_size)"
+    # If 'final_size' is not suffixed (like 24576), then the
+    # caller assumes that it is the number of blocks.
+    $XFS_IO_PROG -f -c "truncate ${final_size}" ${image_file}
+    LOOP_DEVICE=`_create_loop_device $image_file || _fail "losetup failed"`
+
+    echo "+ create fs on image file $(_bytes2blk $original_size)"
+    ${MKFS_PROG}.${FSTYP} -F -O bigalloc,resize_inode,metadata_csum \
+		-C ${cluster_size} -b 4096 \
+		${LOOP_DEVICE} $(_bytes2blk $original_size) > /dev/null 2>&1 || \
+	_fail "mkfs failed"
+
+    echo "+ mount image file"
+    $MOUNT_PROG -t ${FSTYP} ${LOOP_DEVICE} ${image_mount} > \
+		/dev/null 2>&1 || _fail "mount failed"
+
+    echo "+ resize fs to $(_bytes2blk $final_size)"
+    resize2fs -f ${LOOP_DEVICE} $(_bytes2blk $final_size) >> $seqres.full 2>&1 || \
+	_fail "resize2fs failed"
+
+    echo "+ umount fs"
+    $UMOUNT_PROG ${image_mount}
+
+    echo "+ check fs"
+    _check_generic_filesystem $LOOP_DEVICE >> $seqres.full 2>&1 || \
+	_fail "fsck should not fail"
+    _destroy_loop_device $LOOP_DEVICE && LOOP_DEVICE=
+}
+
+_cleanup()
+{
+    cd /
+    [ -n "$LOOP_DEVICE" ] && _destroy_loop_device $LOOP_DEVICE > /dev/null 2>&1
+    rm -f $tmp.*
+    umount ${IMG_MNT} > /dev/null 2>&1
+    rm -f ${IMG_FILE} > /dev/null 2>&1
+}
+
+# get standard environment and checks
+. ./common/rc
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+
+_require_loop
+_require_ext4_feature "bigalloc,resize_inode,metadata_csum"
+
+IMG_FILE=$TEST_DIR/$seq.fs
+IMG_MNT=$TEST_DIR/$seq.mnt
+
+rm -f $seqres.full
+
+rmdir $IMG_MNT 2>/dev/null
+mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
+
+## We perform resizing to various multiples of block group sizes to
+## ensure that we cover maximum edge cases in the kernel code.
+for cluster_size in 4096 16384 65536; do
+    echo "+ set cluster size to ${cluster_size}"
+    ## Extending from 1/2 block group to 2/3 block group.
+    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+			$((16384 * $cluster_size)) \
+			$((24576 * $cluster_size)) ${cluster_size}
+
+    ## Extending from 1/2 block group to one cluster less than
+    ## full block group.
+    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+			$((24576 * $cluster_size)) \
+			$((32767 * $cluster_size)) ${cluster_size}
+
+    ## Extending from 1/2 block group to a full block group.
+    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+			$((24576 * $cluster_size)) \
+			$((32768 * $cluster_size)) ${cluster_size}
+
+    ## Extending from 1/2 block group to 2 full block groups.
+    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+			$((24576 * $cluster_size)) \
+			$((65536 * $cluster_size)) ${cluster_size}
+
+    ## Extending from 1/2 block group to 15 block groups and one
+    ## cluster.
+    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+			$((24576 * $cluster_size)) \
+			$((491521 * $cluster_size)) ${cluster_size}
+
+    ## Extending from 1/2 block group to 15 full and one (last)
+    ## half block groups.
+    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+			$((24576 * $cluster_size)) \
+			$((507904 * $cluster_size)) ${cluster_size}
+
+    ## Extending from 1/2 block group to 16 full block groups.
+    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+			$((24576 * $cluster_size)) \
+			$((524288 * $cluster_size)) ${cluster_size}
+
+    ## Extending from 1/2 block group to 160 full block groups.
+    _ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+			$((24576 * $cluster_size)) \
+			$((5242880 * $cluster_size)) ${cluster_size}
+done
+
+status=0
+exit
diff --git a/tests/ext4/030.out b/tests/ext4/030.out
new file mode 100644
index 00000000..17cc4d99
--- /dev/null
+++ b/tests/ext4/030.out
@@ -0,0 +1,148 @@
+QA output created by 030
++ set cluster size to 4096
++ truncate image file to 24576
++ create fs on image file 16384
++ mount image file
++ resize fs to 24576
++ umount fs
++ check fs
++ truncate image file to 32767
++ create fs on image file 24576
++ mount image file
++ resize fs to 32767
++ umount fs
++ check fs
++ truncate image file to 32768
++ create fs on image file 24576
++ mount image file
++ resize fs to 32768
++ umount fs
++ check fs
++ truncate image file to 65536
++ create fs on image file 24576
++ mount image file
++ resize fs to 65536
++ umount fs
++ check fs
++ truncate image file to 491521
++ create fs on image file 24576
++ mount image file
++ resize fs to 491521
++ umount fs
++ check fs
++ truncate image file to 507904
++ create fs on image file 24576
++ mount image file
++ resize fs to 507904
++ umount fs
++ check fs
++ truncate image file to 524288
++ create fs on image file 24576
++ mount image file
++ resize fs to 524288
++ umount fs
++ check fs
++ truncate image file to 5242880
++ create fs on image file 24576
++ mount image file
++ resize fs to 5242880
++ umount fs
++ check fs
++ set cluster size to 16384
++ truncate image file to 98304
++ create fs on image file 65536
++ mount image file
++ resize fs to 98304
++ umount fs
++ check fs
++ truncate image file to 131068
++ create fs on image file 98304
++ mount image file
++ resize fs to 131068
++ umount fs
++ check fs
++ truncate image file to 131072
++ create fs on image file 98304
++ mount image file
++ resize fs to 131072
++ umount fs
++ check fs
++ truncate image file to 262144
++ create fs on image file 98304
++ mount image file
++ resize fs to 262144
++ umount fs
++ check fs
++ truncate image file to 1966084
++ create fs on image file 98304
++ mount image file
++ resize fs to 1966084
++ umount fs
++ check fs
++ truncate image file to 2031616
++ create fs on image file 98304
++ mount image file
++ resize fs to 2031616
++ umount fs
++ check fs
++ truncate image file to 2097152
++ create fs on image file 98304
++ mount image file
++ resize fs to 2097152
++ umount fs
++ check fs
++ truncate image file to 20971520
++ create fs on image file 98304
++ mount image file
++ resize fs to 20971520
++ umount fs
++ check fs
++ set cluster size to 65536
++ truncate image file to 393216
++ create fs on image file 262144
++ mount image file
++ resize fs to 393216
++ umount fs
++ check fs
++ truncate image file to 524272
++ create fs on image file 393216
++ mount image file
++ resize fs to 524272
++ umount fs
++ check fs
++ truncate image file to 524288
++ create fs on image file 393216
++ mount image file
++ resize fs to 524288
++ umount fs
++ check fs
++ truncate image file to 1048576
++ create fs on image file 393216
++ mount image file
++ resize fs to 1048576
++ umount fs
++ check fs
++ truncate image file to 7864336
++ create fs on image file 393216
++ mount image file
++ resize fs to 7864336
++ umount fs
++ check fs
++ truncate image file to 8126464
++ create fs on image file 393216
++ mount image file
++ resize fs to 8126464
++ umount fs
++ check fs
++ truncate image file to 8388608
++ create fs on image file 393216
++ mount image file
++ resize fs to 8388608
++ umount fs
++ check fs
++ truncate image file to 83886080
++ create fs on image file 393216
++ mount image file
++ resize fs to 83886080
++ umount fs
++ check fs
diff --git a/tests/ext4/group b/tests/ext4/group
index 257bb646..f29d3de6 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -32,6 +32,7 @@
 027 auto quick fsmap
 028 auto quick fsmap
 029 auto quick fsmap
+030 auto quick ioctl resize
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.15.1.620.gb9897f4670-goog

