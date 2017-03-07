Received: from mx1.redhat.com ([209.132.183.28]:47112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbdCGHuq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Mar 2017 02:50:46 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99EA27E9DC
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2017 07:49:05 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/409-411: remove all after unbind mountpoints
Date: Tue,  7 Mar 2017 15:48:54 +0800
Message-Id: <1488872934-20001-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: zlang@redhat.com
List-ID: <fstests@vger.kernel.org>

After some shared subtrees test (bind/slave/shared/private), maybe
some dentries isn't freed. For example, EBUSY maybe returned due to
some bugs. This patch tries to verify that.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/409 | 1 +
 tests/generic/410 | 1 +
 tests/generic/411 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/generic/409 b/tests/generic/409
index d7c39d6..76d657f 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -48,6 +48,7 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_clear_mount_stack
+	rm -rf $MNTHEAD $mpA $mpB $mpC $mpD
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/410 b/tests/generic/410
index e627cfe..f39b4fe 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -56,6 +56,7 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_clear_mount_stack
+	rm -rf $MNTHEAD $mpA $mpB $mpC
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/411 b/tests/generic/411
index 414d3a5..e6afaf9 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -37,6 +37,7 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_clear_mount_stack
+	rm -rf $MNTHEAD $mpA $mpB $mpC
 }
 
 # get standard environment, filters and checks
-- 
2.7.4

