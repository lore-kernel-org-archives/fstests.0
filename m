Received: from p3nlsmtpcp01-03.prod.phx3.secureserver.net ([184.168.200.142]:54592
        "EHLO p3nlsmtpcp01-03.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752436AbdA0SHA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Jan 2017 13:07:00 -0500
Date: Fri, 27 Jan 2017 23:35:01 +0530
From: "Lakshmipathi.G" <Lakshmipathi.G@giis.co.in>
Subject: [PATCH] xfstests: btrfs/047: check btrfs-convert with extent and
 non-extent source
Message-ID: <20170127180501.GA18125@giis.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is used to check the source which contains combination of Ext3 files
in non-extent format and  Ext4 extent-files. And validate the file md5sums
before and after conversion.

btrfs/012: BTRFS_CONVERT_PROG,E2FSCK_PROG definitions reused from common/config

Signed-off-by: Lakshmipathi.G <Lakshmipathi.G@giis.co.in>
---
 common/config       |   3 ++
 tests/btrfs/012     |   3 --
 tests/btrfs/047     | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/047.out |   2 +
 tests/btrfs/group   |   1 +
 5 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100755 tests/btrfs/047
 create mode 100644 tests/btrfs/047.out

diff --git a/common/config b/common/config
index 0706aca..fa89f42 100644
--- a/common/config
+++ b/common/config
@@ -240,11 +240,14 @@ case "$HOSTOS" in
         export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
+	export BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
         export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
         export MKFS_NFS_PROG="false"
         export MKFS_CIFS_PROG="false"
         export MKFS_OVERLAY_PROG="false"
         export MKFS_REISER4_PROG="`set_prog_path mkfs.reiser4`"
+	export E2FSCK_PROG="`set_prog_path e2fsck`"
+	export TUNE2FS_PROG="`set_prog_path tune2fs`"
         ;;
 esac
 
diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 6a3cb81..85c82f0 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -54,9 +54,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch_nocheck
 
-BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
-E2FSCK_PROG="`set_prog_path e2fsck`"
-
 _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
 _require_command "$MKFS_EXT4_PROG" mkfs.ext4
 _require_command "$E2FSCK_PROG" e2fsck
diff --git a/tests/btrfs/047 b/tests/btrfs/047
new file mode 100755
index 0000000..d349d12
--- /dev/null
+++ b/tests/btrfs/047
@@ -0,0 +1,122 @@
+#! /bin/bash
+# FS QA Test 047
+#
+# Test btrfs-convert
+#
+# 1) create ext3 filesystem & populate it.
+# 2) upgrade ext3 filesystem to ext4.
+# 3) populate data.
+# 4) source has combination of non-extent and extent files.
+# 5) convert it to btrfs, mount and verify contents.
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Lakshmipathi.G  All Rights Reserved.
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
+#
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
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch_nocheck
+
+_require_command "$BTRFS_CONVERT_PROG" btrfs-convert
+_require_command "$MKFS_EXT4_PROG" mkfs.ext4
+_require_command "$E2FSCK_PROG" e2fsck
+_require_command "$TUNE2FS_PROG" tune2fs
+
+rm -f $seqres.full
+
+BLOCK_SIZE=`_get_block_size $TEST_DIR`
+EXT_MD5SUM="$tmp.ext43"
+BTRFS_MD5SUM="$tmp.btrfs"
+
+_populate_data(){
+	data_path=$1
+	mkdir -p $data_path
+	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $data_path`
+	echo "Run fsstress $args" >>$seqres.full
+	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	fsstress_pid=$!
+	wait $fsstress_pid
+}
+
+# Create & populate an ext3 filesystem
+$MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
+	_notrun "Could not create ext3 filesystem"
+
+# mount and populate non-extent file
+mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
+_populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
+_scratch_unmount
+
+# Upgrade it to ext4.
+$TUNE2FS_PROG -O extents,uninit_bg,dir_index $SCRATCH_DEV >> $seqres.full 2>&1
+# After Conversion, its highly recommended to run e2fsck.
+$E2FSCK_PROG -fyD $SCRATCH_DEV >> $seqres.full 2>&1
+
+# mount and populate extent file
+mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
+_populate_data "$SCRATCH_MNT/ext3_ext4_data/ext4"
+
+# Compute md5 of ext3,ext4 files.
+find "$SCRATCH_MNT/ext3_ext4_data" -type f -fprint "$EXT_MD5SUM"
+sort "$EXT_MD5SUM" -o "$EXT_MD5SUM"
+_scratch_unmount
+
+# Convert non-extent & extent data to btrfs, mount it, verify the data
+$BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
+	_fail "btrfs-convert failed"
+_scratch_mount || _fail "Could not mount new btrfs fs"
+
+# Compute md5 for converted files.
+find "$SCRATCH_MNT/ext3_ext4_data" -type f -fprint "$BTRFS_MD5SUM"
+sort "$BTRFS_MD5SUM" -o "$BTRFS_MD5SUM"
+
+# Compare two md5sum files.
+btrfs_perm=`md5sum "$BTRFS_MD5SUM" | cut -f1 -d' '`
+ext_perm=`md5sum "$EXT_MD5SUM" | cut -f1 -d' '`
+
+if [ "$btrfs_perm" != "$ext_perm" ];then
+       echo "md5sum mismatch"
+fi
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/047.out b/tests/btrfs/047.out
new file mode 100644
index 0000000..48db9bf
--- /dev/null
+++ b/tests/btrfs/047.out
@@ -0,0 +1,2 @@
+QA output created by 047
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3fbf706..224a082 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -49,6 +49,7 @@
 044 auto quick send
 045 auto quick send
 046 auto quick send
+047 auto convert
 048 auto quick
 049 auto quick
 050 auto quick send
-- 
2.7.4

