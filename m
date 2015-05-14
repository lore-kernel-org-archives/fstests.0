Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59891 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422688AbbENVui (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 May 2015 17:50:38 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 81BBD3C226
	for <fstests@vger.kernel.org>; Thu, 14 May 2015 21:50:38 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4ELoZYC007454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Thu, 14 May 2015 17:50:36 -0400
Message-ID: <555518AB.2030804@redhat.com>
Date: Thu, 14 May 2015 16:50:35 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] xfs: test changing UUID on V5 sueprblock
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Tests xfs_db's ability to change & restore UUIDs on
V5 filesystems, and tests xfs_copy's ability to
change the UUID on the copy.

Update to _filter_uuid is so that it will catch the
UUID output from xfs_admin -u, which is slightly different
than the regexp it was expecting.

This requires new userspace which knows how to change the
UUID on a V5 superblock.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

(I dunno, is 60s "quick?" - I could cut down the fsstress
ops, just wanted to populate the fs w/ metadata).

diff --git a/common/filter b/common/filter
index 05dbae6..8db1b3e 100644
--- a/common/filter
+++ b/common/filter
@@ -275,9 +275,9 @@ _filter_uuid()
 {
 	if [ ! -z $1 ]; then
 		UUID=$1
-		sed -e "s/\(uuid:\) $UUID/\1 <EXACTUUID>/i"
+		sed -e "s/\(uuid[ :=]\+\) $UUID/\1 <EXACTUUID>/i"
 	else
-		sed -e "s/\(uuid:\) *[0-9a-f-][0-9a-f-]*/\1 <UUID>/i"
+		sed -e "s/\(uuid[ :=]\+\) *[0-9a-f-][0-9a-f-]*/\1 <UUID>/ig"
 	fi
 }
 
diff --git a/tests/xfs/074 b/tests/xfs/074
new file mode 100755
index 0000000..738050e
--- /dev/null
+++ b/tests/xfs/074
@@ -0,0 +1,139 @@
+#! /bin/bash
+# FS QA Test 074
+#
+# test UUID modification of CRC-enabled filesystems
+#
+# CRC-enabled / V5 superblock filesystems have a UUID stamped into
+# every piece of metadata, and a mechanism was added later to allow
+# changing the user-visible UUID by copying the original UUID (which
+# matches all the existing metadata) to a new superblock location.
+# Exercise some of that behavior.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
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
+# real QA test starts here
+
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_xfs_crc
+
+_fs_has_META_UUID()
+{
+	FS=$1
+	$XFS_DB_PROG -r -c version $FS | grep -q META_UUID
+}
+
+rm -f $seqres.full
+
+_scratch_mkfs_xfs -m crc=1 >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+xfs_admin -U restore $SCRATCH_DEV 2>&1 | \
+	grep -q "invalid UUID\|supported on V5 fs" && \
+		_notrun "Userspace does not support V5 super UUID modifications"
+
+ORIG_UUID=`xfs_admin -u $SCRATCH_DEV | awk '{print $NF}'`
+
+_scratch_mount
+# Put some stuff on the fs
+$FSSTRESS_PROG -d $SCRATCH_MNT -n 1000 -p 4 >> $seqres.full 2>&1
+_scratch_unmount
+
+# Can xfs_db change it?
+
+echo "== Generate new UUID"
+xfs_admin -U generate $SCRATCH_DEV | _filter_uuid 
+NEW_UUID=`xfs_admin -u $SCRATCH_DEV | awk '{print $NF}'`
+[ "$NEW_UUID" == "$ORIG_UUID" ] && _fail "Failed to change UUID"
+_check_scratch_fs
+_scratch_mount || _notrun "Mount failed; no META_UUID kernel support?"
+_scratch_unmount
+_fs_has_META_UUID $SCRATCH_DEV || _fail "META_UUID feature not set"
+
+# This should be a no-op
+echo "== Rewrite UUID"
+xfs_admin -U rewrite $SCRATCH_DEV | _filter_uuid $NEW_UUID
+_check_scratch_fs
+_scratch_mount || _fail "Mount failed after UUID rewrite"
+_scratch_unmount
+_fs_has_META_UUID $SCRATCH_DEV || _fail "META_UUID feature not set"
+
+# Can we change it back?
+echo "== Restore old UUID"
+xfs_admin -U restore $SCRATCH_DEV | _filter_uuid $ORIG_UUID
+NEW_UUID=`xfs_admin -u $SCRATCH_DEV | awk '{print $NF}'`
+[ "$NEW_UUID" != "$ORIG_UUID" ] && _fail "Failed to restore UUID"
+_check_scratch_fs
+_scratch_mount || _fail "Mount failed after UUID restore"
+_scratch_unmount
+_fs_has_META_UUID $SCRATCH_DEV &&  _fail "META_UUID feature should not be not set"
+
+# This should be a no-op too.
+echo "== Rewrite UUID"
+xfs_admin -U rewrite $SCRATCH_DEV | _filter_uuid  $ORIG_UUID
+_check_scratch_fs
+_scratch_mount || _fail "Mount failed after UUID rewrite"
+_scratch_unmount
+_fs_has_META_UUID $SCRATCH_DEV && _fail "META_UUID feature should not be not set"
+
+# Ok, now what does xfs_copy do; it changes UUID by default
+
+IMGFILE=$TEST_DIR/$seq.copy.img
+rm -f $IMGFILE
+
+# xfs_copy changes the UUID by default
+echo "== xfs_copy with new UUID"
+$XFS_COPY_PROG $SCRATCH_DEV $IMGFILE 2>&1 >> $seqres.full || \
+	_fail "xfs_copy (new UUID) failed"
+_check_xfs_filesystem $IMGFILE none none || _fail "Copy looks corrupted"
+# The copy should have META_UUID feature set
+_fs_has_META_UUID $IMGFILE || _fail "META_UUID feature not set on copy"
+
+rm -f $IMGFILE
+
+# duplicating the UUID should be fine too
+echo "== xfs_copy with duplicate UUID"
+$XFS_COPY_PROG -d $SCRATCH_DEV $IMGFILE 2>&1 >> $seqres.full || \
+	_fail "xfs_copy (duplicate) failed"
+_check_xfs_filesystem $IMGFILE none none || _fail "Duplicate copy looks corrupted"
+# The copy should not have META_UUID feature set
+_fs_has_META_UUID $IMGFILE && _fail "META_UUID feature should not be set on copy"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/074.out b/tests/xfs/074.out
new file mode 100644
index 0000000..b511107
--- /dev/null
+++ b/tests/xfs/074.out
@@ -0,0 +1,21 @@
+QA output created by 074
+== Generate new UUID
+Clearing log and setting UUID
+writing all SBs
+new UUID =  <UUID>
+== Rewrite UUID
+old UUID = <EXACTUUID>
+Clearing log and setting UUID
+writing all SBs
+new UUID = <EXACTUUID>
+== Restore old UUID
+Clearing log and setting UUID
+writing all SBs
+new UUID = <EXACTUUID>
+== Rewrite UUID
+old UUID = <EXACTUUID>
+Clearing log and setting UUID
+writing all SBs
+new UUID = <EXACTUUID>
+== xfs_copy with new UUID
+== xfs_copy with duplicate UUID
diff --git a/tests/xfs/group b/tests/xfs/group
index 58144d2..d1f6121 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -70,6 +71,7 @@
 071 rw auto
 072 rw auto prealloc quick
 073 copy auto
+074 auto quick copy
 078 growfs auto quick
 080 rw ioctl
 081 deprecated # log logprint quota

