Received: from mail-it0-f65.google.com ([209.85.214.65]:43955 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdLEDoy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Dec 2017 22:44:54 -0500
Received: by mail-it0-f65.google.com with SMTP id u62so18176341ita.2
        for <fstests@vger.kernel.org>; Mon, 04 Dec 2017 19:44:54 -0800 (PST)
From: harshads <harshads@google.com>
Subject: [PATCH v2] ext4/030: Ext4 online resize tests.
Date: Mon,  4 Dec 2017 19:43:35 -0800
Message-Id: <20171205034335.81702-1-harshads@google.com>
In-Reply-To: <20171101001159.88570-1-harshads@google.com>
References: <20171101001159.88570-1-harshads@google.com>
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com
Cc: fstests@vger.kernel.org, harshads <harshads@google.com>
List-ID: <fstests@vger.kernel.org>

Add tests for Ext4 online resize feature.

Signed-off-by: Harshad Shirwadkar <harshads@google.com>
---
 common/ext4        |  42 +++++++++++++++
 tests/ext4/030     | 101 ++++++++++++++++++++++++++++++++++++
 tests/ext4/030.out | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/group   |   1 +
 4 files changed, 292 insertions(+)
 create mode 100644 common/ext4
 create mode 100755 tests/ext4/030
 create mode 100644 tests/ext4/030.out

diff --git a/common/ext4 b/common/ext4
new file mode 100644
index 00000000..71966bef
--- /dev/null
+++ b/common/ext4
@@ -0,0 +1,42 @@
+#
+# Common ext4 functions
+#
+
+_ext4_online_resize()
+{
+	local image_file=$1
+	local image_mount=$2
+	local original_size=$3
+	local final_size=$4
+	local cluster_size=$5
+
+	echo "+ truncate image file to ${final_size}"
+	# If 'final_size' is not suffixed (like 24576), then the
+	# caller assumes that it is the number of blocks.
+	if [[ "${final_size: -1}" == [a-zA-Z] ]]; then
+		truncate ${image_file} -s ${final_size}
+	else
+		truncate ${image_file} -s ${final_size} -o 4096
+	fi
+	echo "+ create fs on image file ${original_size}"
+	${MKFS_PROG}.${FSTYP} -F -O bigalloc,resize_inode,metadata_csum \
+		-C ${cluster_size} -b 4096 \
+		${image_file} ${original_size} > /dev/null 2>&1
+
+	dumpe2fs -g ${image_file} > /dev/null 2>&1 || \
+		_notrun "dumpe2fs -g not supported"
+
+	echo "+ mount image file"
+	mount -t ${FSTYP} ${image_file} ${image_mount} > /dev/null 2>&1
+
+	echo "+ resize fs to ${final_size}"
+	resize2fs -f ${image_file} ${final_size} >> $seqres.full 2>&1 || \
+		_fail "resize2fs failed"
+
+	echo "+ umount fs"
+	umount ${image_mount}
+
+	echo "+ check fs"
+	e2fsck -fn ${image_file} >> $seqres.full 2>&1 || \
+	    _fail "fsck should not fail"
+}
diff --git a/tests/ext4/030 b/tests/ext4/030
new file mode 100755
index 00000000..2415fb65
--- /dev/null
+++ b/tests/ext4/030
@@ -0,0 +1,101 @@
+#! /bin/bash
+# FS QA Test ext4/031
+#
+# Ext4 online resize tests with small and crucial resizes.
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
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	umount ${IMG_MNT} > /dev/null 2>&1
+	rm -f ${IMG_FILE} > /dev/null 2>&1
+}
+
+# get standard environment and checks
+. ./common/rc
+. ./common/ext4
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+
+_require_loop
+
+IMG_FILE=$TEST_DIR/$seq.fs
+IMG_MNT=$TEST_DIR/$seq.mnt
+
+rm -f $seqres.full
+
+rmdir $IMG_MNT 2>/dev/null
+mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
+
+for cluster_size in 4096 16384 65536
+do
+	blocks_per_cluster=`expr $cluster_size / 4096`
+	echo "+ set cluster size to ${cluster_size}"
+	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+		$((16384 * $blocks_per_cluster)) \
+		$((24576 * $blocks_per_cluster)) ${cluster_size}
+
+	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+		$((24576 * $blocks_per_cluster)) \
+		$((32767 * $blocks_per_cluster)) ${cluster_size}
+
+	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+		$((24576 * $blocks_per_cluster)) \
+		$((32768 * $blocks_per_cluster)) ${cluster_size}
+
+	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+		$((24576 * $blocks_per_cluster)) \
+		$((65536 * $blocks_per_cluster)) ${cluster_size}
+
+	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+		$((24576 * $blocks_per_cluster)) \
+		$((491521 * $blocks_per_cluster)) ${cluster_size}
+
+	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+		$((24576 * $blocks_per_cluster)) \
+		$((507904 * $blocks_per_cluster)) ${cluster_size}
+
+	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+		$((24576 * $blocks_per_cluster)) \
+		$((527488 * $blocks_per_cluster)) ${cluster_size}
+
+	_ext4_online_resize ${IMG_FILE} ${IMG_MNT} \
+		$((24576 * $blocks_per_cluster)) \
+		$((5274880 * $blocks_per_cluster)) ${cluster_size}
+done
+
+status=0
+exit
diff --git a/tests/ext4/030.out b/tests/ext4/030.out
new file mode 100644
index 00000000..5f6441e6
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
++ truncate image file to 527488
++ create fs on image file 24576
++ mount image file
++ resize fs to 527488
++ umount fs
++ check fs
++ truncate image file to 5274880
++ create fs on image file 24576
++ mount image file
++ resize fs to 5274880
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
++ truncate image file to 2109952
++ create fs on image file 98304
++ mount image file
++ resize fs to 2109952
++ umount fs
++ check fs
++ truncate image file to 21099520
++ create fs on image file 98304
++ mount image file
++ resize fs to 21099520
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
++ truncate image file to 8439808
++ create fs on image file 393216
++ mount image file
++ resize fs to 8439808
++ umount fs
++ check fs
++ truncate image file to 84398080
++ create fs on image file 393216
++ mount image file
++ resize fs to 84398080
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
2.15.0.531.g2ccb3012c9-goog

