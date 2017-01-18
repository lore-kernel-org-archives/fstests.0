Received: from mx1.redhat.com ([209.132.183.28]:48576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750712AbdARFti (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jan 2017 00:49:38 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D2CD7F7C3
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2017 05:48:47 +0000 (UTC)
From: bxue@redhat.com
Subject: [PATCH v1 1/2] common/dmthin: call $UDEV_SETTLE_PROG before 'dmsetup remove'
Date: Wed, 18 Jan 2017 13:48:29 +0800
Message-Id: <1484718510-7433-1-git-send-email-bxue@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Boyang Xue <bxue@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Boyang Xue <bxue@redhat.com>

Wait for device to be fully settled so that 'dmsetup remove' doesn't
fail due to EBUSY.

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
 common/dmthin | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/dmthin b/common/dmthin
index 3cd206a..e774175 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -38,6 +38,9 @@ DMTHIN_VOL_DEV="/dev/mapper/$DMTHIN_VOL_NAME"
 _dmthin_cleanup()
 {
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	# wait for device to be fully settled so that 'dmsetup remove' doesn't
+	# fail due to EBUSY
+	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG remove $DMTHIN_VOL_NAME> /dev/null 2>&1
 	$DMSETUP_PROG remove $DMTHIN_POOL_NAME> /dev/null 2>&1
 	$DMSETUP_PROG remove $DMTHIN_META_NAME> /dev/null 2>&1
-- 
1.8.3.1

