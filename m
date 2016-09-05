Received: from mx1.redhat.com ([209.132.183.28]:59702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbcIEFbs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 5 Sep 2016 01:31:48 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/279: filter scsi debug device correctly
Date: Mon,  5 Sep 2016 13:30:27 +0800
Message-Id: <1473053427-15498-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, linux-xfs@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

This test assumes scsi debug device is "/dev/sd." when doing the
filter, but that isn't always true, I've seen failure like

  -mkfs with opts: DEVICE
  +mkfs with opts: DEVICEl

So use $SCSI_DEBUG_DEV to match the correct scsi debug device name.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/279 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/279 b/tests/xfs/279
index cde7d21..9dee4cf 100755
--- a/tests/xfs/279
+++ b/tests/xfs/279
@@ -61,7 +61,7 @@ _wipe_device()
 _check_mkfs()
 {
 	echo "===================" 
-	echo "mkfs with opts: $@" | sed -e "s,/dev/sd.,DEVICE,"
+	echo "mkfs with opts: $@" | sed -e "s,$SCSI_DEBUG_DEV,DEVICE,"
 	$MKFS_XFS_PROG $@ 2>/dev/null > $tmp.mkfs.full
 	if [ $? -ne 0 ]; then
 		echo "Failed."
-- 
2.7.4

