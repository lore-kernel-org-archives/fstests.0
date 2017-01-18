Received: from mx1.redhat.com ([209.132.183.28]:45802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbdARDHo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 17 Jan 2017 22:07:44 -0500
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 1/4] common/rc: add _require_scratch_dax
Date: Wed, 18 Jan 2017 11:07:03 +0800
Message-Id: <1484708826-23529-2-git-send-email-xzhou@redhat.com>
In-Reply-To: <1484708826-23529-1-git-send-email-xzhou@redhat.com>
References: <1484708826-23529-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-nvdimm@ml01.01.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

To make sure we can test DAX feature on SCRATCH_DEV.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 common/rc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/rc b/common/rc
index 892c46e..ea7956b 100644
--- a/common/rc
+++ b/common/rc
@@ -2632,6 +2632,16 @@ _require_scratch_shutdown()
 	_scratch_unmount
 }
 
+# Does dax mount option work on this dev/fs?
+_require_scratch_dax()
+{
+	_scratch_unmount
+	_scratch_mkfs > /dev/null 2>&1
+	_scratch_mount -o dax || \
+		_notrun "$SCRATCH_DEV $FSTYP does not support -o dax"
+	_scratch_unmount
+}
+
 # Does norecovery support by this fs?
 _require_norecovery()
 {
-- 
1.8.3.1

