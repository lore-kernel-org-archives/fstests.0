Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52886 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbbBFGhk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:40 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/9 v5] common/rc: add _require_norecovery
Date: Thu,  5 Feb 2015 22:37:07 -0800
Message-Id: <1423204633-66673-4-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch adds checking code whether filesystem supports norecovery mount
option or not.
And let use this into the following xfs test.

 xfs/200         (recovery vs ro-block device)

* Currently, norecovery mount option is used by xfs only. But some of log-based
filesystems (e.g., f2fs) are able to support it later.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc     | 8 ++++++++
 tests/xfs/200 | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index 078d3ca..395bf6c 100644
--- a/common/rc
+++ b/common/rc
@@ -2332,6 +2332,14 @@ _require_scratch_shutdown()
 	_scratch_unmount
 }
 
+# Does norecovery support by this fs?
+_require_norecovery()
+{
+	_scratch_mount -o ro,norecovery || \
+		_notrun "$FSTYP does not support norecovery"
+	_scratch_unmount
+}
+
 # Does fiemap support?
 _require_fiemap()
 {
diff --git a/tests/xfs/200 b/tests/xfs/200
index c62d2b8..bd6d0fd 100755
--- a/tests/xfs/200
+++ b/tests/xfs/200
@@ -46,6 +46,7 @@ _supported_os Linux
 
 _require_scratch_nocheck
 _require_scratch_shutdown
+_require_norecovery
 
 _scratch_mkfs_xfs >/dev/null 2>&1
 
-- 
2.1.1

