Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52850 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbbBFGhh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:37 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/9 v5] common/rc: add _require_scratch_shtudown
Date: Thu,  5 Feb 2015 22:37:05 -0800
Message-Id: <1423204633-66673-2-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This is to detect whether filesystem supports shutdown feature or not.
And let use this into the following xfs tests.

 xfs/053         (data exposure)
 xfs/137         (data vs filesize)
 xfs/138         (data vs filesize vs truncate)
 xfs/139         (data vs filesize vs partial truncate)
 xfs/140         (data vs filesize vs extending truncate)
 xfs/179         (data vs filesize w/ fsync)
 xfs/180         (data vs filesize w/ sync)
 xfs/182         (data vs filesize w/ recovery)
 xfs/200         (recovery vs ro-block device)
 xfs/306         (fsstress vs recovery)

 xfs/085
 xfs/086
 xfs/087

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc     | 12 ++++++++++++
 tests/xfs/053 |  1 +
 tests/xfs/085 |  1 +
 tests/xfs/086 |  1 +
 tests/xfs/087 |  1 +
 tests/xfs/137 |  1 +
 tests/xfs/138 |  1 +
 tests/xfs/139 |  1 +
 tests/xfs/140 |  1 +
 tests/xfs/179 |  1 +
 tests/xfs/180 |  1 +
 tests/xfs/182 |  1 +
 tests/xfs/200 |  1 +
 tests/xfs/306 |  1 +
 14 files changed, 25 insertions(+)

diff --git a/common/rc b/common/rc
index 5377ba0..234638b 100644
--- a/common/rc
+++ b/common/rc
@@ -2320,6 +2320,18 @@ _require_freeze()
 	[ $result -eq 0 ] || _notrun "$FSTYP does not support freezing"
 }
 
+# Does shutdown work on this fs?
+_require_scratch_shutdown()
+{
+	[ -x src/godown ] || _notrun "src/godown executable not found"
+
+	_scratch_mkfs > /dev/null 2>&1
+	_scratch_mount
+	src/godown -f $SCRATCH_MNT 2>&1 \
+		|| _notrun "$FSTYP does not support shutdown"
+	_scratch_unmount
+}
+
 # arg 1 is dev to remove and is output of the below eg.
 # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
 _devmgt_remove()
diff --git a/tests/xfs/053 b/tests/xfs/053
index 9749345..6428d5c 100755
--- a/tests/xfs/053
+++ b/tests/xfs/053
@@ -86,6 +86,7 @@ _crashtest()
 _supported_fs xfs
 _supported_os Linux
 _require_scratch
+_require_scratch_shutdown
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "fzero"
diff --git a/tests/xfs/085 b/tests/xfs/085
index 54c2d01..539f324 100755
--- a/tests/xfs/085
+++ b/tests/xfs/085
@@ -47,6 +47,7 @@ rm -f $seqres.full
 rm -f $tmp.log
 
 _require_scratch
+_require_scratch_shutdown
 
 echo "mkfs"
 _scratch_mkfs_xfs >>$seqres.full 2>&1 \
diff --git a/tests/xfs/086 b/tests/xfs/086
index af09c7f..08566d7 100755
--- a/tests/xfs/086
+++ b/tests/xfs/086
@@ -44,6 +44,7 @@ _supported_os IRIX Linux
 
 rm -f $seqres.full $tmp.*
 _require_scratch
+_require_scratch_shutdown
 _require_v2log
 
 echo "*** init FS"
diff --git a/tests/xfs/087 b/tests/xfs/087
index 3a3fb49..42c7d3b 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -59,6 +59,7 @@ _supported_os IRIX Linux
 
 rm -f $seqres.full $tmp.*
 _require_scratch
+_require_scratch_shutdown
 _require_v2log 
 _require_xfs_quota
 
diff --git a/tests/xfs/137 b/tests/xfs/137
index 79b3b89..662a267 100755
--- a/tests/xfs/137
+++ b/tests/xfs/137
@@ -40,6 +40,7 @@ _supported_fs xfs
 _supported_os Linux IRIX
 
 _require_scratch
+_require_scratch_shutdown
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/138 b/tests/xfs/138
index 1b11cf6..3fb182c 100755
--- a/tests/xfs/138
+++ b/tests/xfs/138
@@ -40,6 +40,7 @@ _supported_fs xfs
 _supported_os Linux IRIX
 
 _require_scratch
+_require_scratch_shutdown
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/139 b/tests/xfs/139
index e5296f7..6986c17 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -40,6 +40,7 @@ _supported_fs xfs
 _supported_os Linux IRIX
 
 _require_scratch
+_require_scratch_shutdown
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/140 b/tests/xfs/140
index cccf262..b82e43b 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -40,6 +40,7 @@ _supported_fs xfs
 _supported_os Linux IRIX
 
 _require_scratch
+_require_scratch_shutdown
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/179 b/tests/xfs/179
index ce50d99..87fac8a 100755
--- a/tests/xfs/179
+++ b/tests/xfs/179
@@ -41,6 +41,7 @@ _supported_fs xfs
 _supported_os Linux IRIX
 
 _require_scratch
+_require_scratch_shutdown
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/180 b/tests/xfs/180
index a0fb69a..b3b0fe4 100755
--- a/tests/xfs/180
+++ b/tests/xfs/180
@@ -41,6 +41,7 @@ _supported_fs xfs
 _supported_os Linux IRIX
 
 _require_scratch
+_require_scratch_shutdown
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/182 b/tests/xfs/182
index b75e4fc..dac15d4 100755
--- a/tests/xfs/182
+++ b/tests/xfs/182
@@ -41,6 +41,7 @@ _supported_fs xfs
 _supported_os Linux IRIX
 
 _require_scratch
+_require_scratch_shutdown
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/200 b/tests/xfs/200
index f0c4337..c62d2b8 100755
--- a/tests/xfs/200
+++ b/tests/xfs/200
@@ -45,6 +45,7 @@ _supported_fs xfs
 _supported_os Linux
 
 _require_scratch_nocheck
+_require_scratch_shutdown
 
 _scratch_mkfs_xfs >/dev/null 2>&1
 
diff --git a/tests/xfs/306 b/tests/xfs/306
index 3053fd9..5af5ace 100755
--- a/tests/xfs/306
+++ b/tests/xfs/306
@@ -49,6 +49,7 @@ _supported_fs xfs
 _supported_os Linux
 
 _require_scratch
+_require_scratch_shutdown
 
 rm -f $seqres.full
 
-- 
2.1.1

