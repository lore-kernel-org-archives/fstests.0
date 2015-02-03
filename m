Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56451 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056AbbBCXHi (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 3 Feb 2015 18:07:38 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/8 v4] common/rc: add _require_norecovery
Date: Tue,  3 Feb 2015 15:07:15 -0800
Message-Id: <1423004840-45315-4-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch adds checking code whether filesystem supports norecovery mount
option or not.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index d413721..72e2f99 100644
--- a/common/rc
+++ b/common/rc
@@ -2331,6 +2331,14 @@ _require_scratch_shutdown()
 	_scratch_unmount
 }
 
+# Does norecovery support by this fs?
+_require_norecovery()
+{
+        _scratch_mount -o ro,norecovery || \
+                _notrun "$FSTYP does not support norecovery"
+	_scratch_unmount
+}
+
 # Does bmap work on this fs?
 _require_bmap()
 {
-- 
2.1.1

