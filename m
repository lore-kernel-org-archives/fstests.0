Received: from mx1.redhat.com ([209.132.183.28]:8712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbcCXNZw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 24 Mar 2016 09:25:52 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 7C22B2541
	for <fstests@vger.kernel.org>; Thu, 24 Mar 2016 13:25:50 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] common: make sure dm device is all settled before removing it
Date: Thu, 24 Mar 2016 21:25:22 +0800
Message-Id: <1458825922-21165-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1458821311-18968-1-git-send-email-eguan@redhat.com>
References: <1458821311-18968-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

_dmerror_cleanup()/_cleanup_flakey may fail to remove dm device due to
EBUSY and cause subsequent tests to fail.

Fix it by calling $UDEV_SETTLE_PROG before remove dm device to make sure
no one is using it.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---

v2:
- fix _cleanup_flakey() as well, thanks to Filipe for pointing it out

 common/dmerror  | 3 +++
 common/dmflakey | 3 +++
 2 files changed, 6 insertions(+)

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
 
diff --git a/common/dmflakey b/common/dmflakey
index 3b6521a..4434307 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -54,6 +54,9 @@ _cleanup_flakey()
 	# otherwise the umount will hang
 	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	# wait for device to be fully settled so that 'dmsetup remove' doesn't
+	# fail due to EBUSY
+	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG remove flakey-test > /dev/null 2>&1
 	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
-- 
2.5.5

