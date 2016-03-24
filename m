Received: from mx1.redhat.com ([209.132.183.28]:51525 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbcCXMJI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 24 Mar 2016 08:09:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 8632680510
	for <fstests@vger.kernel.org>; Thu, 24 Mar 2016 12:09:07 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common: make sure dm error device is all settled before removing it
Date: Thu, 24 Mar 2016 20:08:31 +0800
Message-Id: <1458821311-18968-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

_dmerror_cleanup() may fail to remove error-test device due to EBUSY and
cause subsequent tests to fail.

Fix it by calling $UDEV_SETTLE_PROG before remove error-test device to
make sure no one is using it.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/dmerror | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/dmerror b/common/dmerror
index 004530d..5d2c1b6 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -54,6 +54,9 @@ _dmerror_unmount()
 _dmerror_cleanup()
 {
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	# wait for device to be fully settled so that 'dmsetup remove' doesn't
+	# fail due to EBUSY
+	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG remove error-test > /dev/null 2>&1
 }
 
-- 
2.5.5

