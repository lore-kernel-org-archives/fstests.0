Received: from sandeen.net ([63.231.237.45]:46468 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbdHBC6G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Aug 2017 22:58:06 -0400
Subject: [PATCH V2] xfs: test xfs_metadump for leaked strings
References: <f96cbce4-faf0-6a30-508b-39e5d2c17f8b@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <4e801980-9ea5-efaf-f45c-d98df8f1f7e3@sandeen.net>
Date: Tue, 1 Aug 2017 21:58:04 -0500
MIME-Version: 1.0
In-Reply-To: <f96cbce4-faf0-6a30-508b-39e5d2c17f8b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

xfs_metadump by default sanitizes the image so that all strings
longer than 5 chars are obfusccated, and all stale data in metadata
blocks (i.e. unused/unwritten data) is zeroed out.  We didn't have
a test for this, though, so this does it.

It patterns 256M of the scratch device, then uses djwong's
populate infrastructure to write all types of metadata,
metadumps & mdrestores it, then looks for either the leaked
pre-pattern or any leaked strings or filenames.

The strings we look for are, unfortunately, a bit ad-hoc based on
what is currently used in the populate routines.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: include .out file, minor whitespace & typo edits

diff --git a/common/populate b/common/populate
index 498151f..725cad4 100644
--- a/common/populate
+++ b/common/populate
@@ -198,18 +198,20 @@ _scratch_xfs_populate() {
 	touch ${SCRATCH_MNT}/ATTR.SYSTEM
 	setfacl -m u:root:r ${SCRATCH_MNT}/ATTR.SYSTEM
 
+ATTRVALFILE="${SCRATCH_MNT}/attrvalfile"
+
 	# FMT_EXTENTS with a remote less-than-a-block value
 	echo "+ attr extents with a remote less-than-a-block value"
 	touch "${SCRATCH_MNT}/ATTR.FMT_EXTENTS_REMOTE3K"
-	$XFS_IO_PROG -f -c "pwrite -S 0x43 0 $((blksz - 300))" "${SCRATCH_MNT}/attrvalfile" > /dev/null
-	attr -q -s user.remotebtreeattrname "${SCRATCH_MNT}/ATTR.FMT_EXTENTS_REMOTE3K" < "${SCRATCH_MNT}/attrvalfile"
+	$XFS_IO_PROG -f -c "pwrite -S 0x43 0 $((blksz - 300))" "${ATTRVALFILE}" > /dev/null
+	attr -q -s user.remotebtreeattrname "${SCRATCH_MNT}/ATTR.FMT_EXTENTS_REMOTE3K" < "${ATTRVALFILE}"
 
 	# FMT_EXTENTS with a remote block-size value
 	echo "+ attr extents with a remote one-block value"
 	touch "${SCRATCH_MNT}/ATTR.FMT_EXTENTS_REMOTE4K"
-	$XFS_IO_PROG -f -c "pwrite -S 0x44 0 ${blksz}" "${SCRATCH_MNT}/attrvalfile" > /dev/null
-	attr -q -s user.remotebtreeattrname "${SCRATCH_MNT}/ATTR.FMT_EXTENTS_REMOTE4K" < "${SCRATCH_MNT}/attrvalfile"
-	rm -rf "${SCRATCH_MNT}/attrvalfile"
+	$XFS_IO_PROG -f -c "pwrite -S 0x44 0 ${blksz}" "${ATTRVALFILE}" > /dev/null
+	attr -q -s user.remotebtreeattrname "${SCRATCH_MNT}/ATTR.FMT_EXTENTS_REMOTE4K" < "${ATTRVALFILE}"
+	rm -rf "${ATTRVALFILE}"
 
 	# Make an unused inode
 	echo "+ empty file"
diff --git a/tests/xfs/425 b/tests/xfs/425
new file mode 100755
index 0000000..dd11236
--- /dev/null
+++ b/tests/xfs/425
@@ -0,0 +1,121 @@
+#! /bin/bash
+# FS QA Test 425
+#
+# Look for stale data leaks in an xfs_metadump
+#
+# If this fails, get the byte offset of the leaked strings
+# which are found, then on the restored image in $TEST_DIR,
+# do:
+#
+# xfs_db> blockget -n
+# xfs_db> convert byte $BYTE daddr
+# $RESULT
+# xfs_db> daddr $RESULT
+# xfs_db> blockuse -n
+#
+# to see information about the metadata block which contains the
+# leaked strings
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
+. ./common/populate
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_test
+_require_scratch
+_require_populate_commands
+
+METADUMP_FILE="${TEST_DIR}/${seq}_metadump"
+MDRESTORE_FILE="${TEST_DIR}/${seq}_mdrestore"
+
+echo "Silence is golden"
+
+# Pattern the scratch disk, mkfs, and restore.
+$XFS_IO_PROG -d -c "pwrite 0 256M" $SCRATCH_DEV > $seqres.full 2>&1
+_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_populate nofill >> $seqres.full 2>&1
+
+# populate unmounts the fs for us
+
+_scratch_metadump $METADUMP_FILE
+xfs_mdrestore $METADUMP_FILE $MDRESTORE_FILE
+
+# Grep for stale data (leaked cd cd pattern) or strings
+# from populate routine
+
+hexdump -C $MDRESTORE_FILE | grep \
+"cd cd cd cd\| \
+41 41 41 41\|\
+42 42 42 42\|\
+43 43 43 43\|\
+44 44 44 44\|\
+61 61 61 61\|\
+62 62 62 62\|\
+63 63 63 63\|\
+64 64 64 64\|\
+dummy\|\
+S_IF\|\
+FMT_\|\
+INLINE\|\
+BLOCK\|\
+LEAF\|\
+NODE\|\
+BTREE\|\
+LOCAL\|\
+EXTENTS\|\
+REMOTE\|\
+ATTR\|\
+SYSTEM\|\
+TRUSTED\|\
+SECURITY\|\
+attrvalfile\|\
+unused\|\
+BNOBT\|\
+RMAPBT\|\
+RTRMAPBT\|\
+REFCOUNTBT" && echo "Leaked data found; see comments in test to debug"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/425.out b/tests/xfs/425.out
new file mode 100644
index 0000000..7a9714b
--- /dev/null
+++ b/tests/xfs/425.out
@@ -0,0 +1,2 @@
+QA output created by 425
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index 185487d..d0d26ee 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -422,3 +422,4 @@
 422 dangerous_scrub dangerous_online_repair
 423 dangerous_scrub
 424 auto quick dump
+425 auto metadata


