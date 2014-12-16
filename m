Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33820 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbaLPLmX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Dec 2014 06:42:23 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBGBgMZg017105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 16 Dec 2014 06:42:23 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/3] common: exit only if _check_xxx_filesystem called by tests when corruption found
Date: Tue, 16 Dec 2014 19:41:40 +0800
Message-Id: <1418730102-17061-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Otherwise these functions cause check to exit if they find corruption
and terminate the whole test.

_check_xfs_filesystem already behaves correctly, make
_check_generic_filesystem and _check_btrfs_filesystem follow the same
behavior.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 765e05a..6bbdc69 100644
--- a/common/rc
+++ b/common/rc
@@ -1719,7 +1719,9 @@ _check_generic_filesystem()
 
     if [ $ok -eq 0 ]; then
 	status=1
-	exit 1
+	if [ "$iam" != "check" ]; then
+		exit 1
+	fi
     fi
 
     return 0
@@ -1930,7 +1932,9 @@ _check_btrfs_filesystem()
 
     if [ $ok -eq 0 ]; then
 	status=1
-	exit 1
+	if [ "$iam" != "check" ]; then
+		exit 1
+	fi
     fi
 
     return 0
-- 
2.1.0

