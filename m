Received: from mx1.redhat.com ([209.132.183.28]:46836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797AbbLWOcS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 23 Dec 2015 09:32:18 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 11147461C4
	for <fstests@vger.kernel.org>; Wed, 23 Dec 2015 14:32:18 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common/scsi_debug: fix removal of scsi_debug module
Date: Wed, 23 Dec 2015 22:29:14 +0800
Message-Id: <1450880954-26921-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Occasionally scsi_debug cannot be removed because it's still in use and
causes xfs/279 to fail.

Now dryrun the removal by modprobe firstly then do the real rmmod.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/scsi_debug | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index d073b6d..eb08126 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -57,7 +57,15 @@ _get_scsi_debug_dev()
 
 _put_scsi_debug_dev()
 {
-	sleep 1
 	lsmod | grep -wq scsi_debug || return
+
+	n=2
+	# use redirection not -q option of modprobe here, because -q of old
+	# modprobe is only quiet when the module is not found, not when the
+	# module is in use.
+	while [ $n -ge 0 ] && ! modprobe -nr scsi_debug >/dev/null 2>&1; do
+		sleep 1
+		n=$((n-1))
+	done
 	rmmod scsi_debug || _fail "Could not remove scsi_debug module"
 }
-- 
1.8.3.1

