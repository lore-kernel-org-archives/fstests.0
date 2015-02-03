Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56409 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbbBCXHe (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 3 Feb 2015 18:07:34 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/8 v4] common/rc: add _require_scratch_shtudown
Date: Tue,  3 Feb 2015 15:07:13 -0800
Message-Id: <1423004840-45315-2-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This is to detect whether filesystem supports shutdown feature or not.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/rc b/common/rc
index 5377ba0..438cd51 100644
--- a/common/rc
+++ b/common/rc
@@ -2320,6 +2320,17 @@ _require_freeze()
 	[ $result -eq 0 ] || _notrun "$FSTYP does not support freezing"
 }
 
+# Does shutdown work on this fs?
+_require_scratch_shutdown()
+{
+	[ -x src/godown ] || _notrun "src/godown executable not found"
+
+        _scratch_mount
+	src/godown -v -f $SCRATCH_MNT >/dev/null 2>&1 \
+		|| _notrun "$FSTYP does not support shutdown"
+	_scratch_unmount
+}
+
 # arg 1 is dev to remove and is output of the below eg.
 # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
 _devmgt_remove()
-- 
2.1.1

