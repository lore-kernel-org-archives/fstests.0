Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbbCTKRn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 06:17:43 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2KAHglp021710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 06:17:43 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 7/9] common: recognise NFS export over IPv6 in _require_scratch_nocheck()
Date: Fri, 20 Mar 2015 18:16:56 +0800
Message-Id: <1426846618-23413-8-git-send-email-eguan@redhat.com>
In-Reply-To: <1426846618-23413-1-git-send-email-eguan@redhat.com>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

This commit

73dfa4a common: Fixes for testing NFS over IPv6

adds NFS over IPv6 support, and commit

76c5f3c common: re-enable tests that require scratch dev on NFS

enables NFS tests on scratch device.

Now do the same updates to _require_scratch_nocheck() to enable NFS over
IPv6 support on scratch device.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 857308a..fbb19c2 100644
--- a/common/rc
+++ b/common/rc
@@ -1111,10 +1111,12 @@ _require_scratch_nocheck()
     esac
 
     # mounted?
-    if _mount | grep -q $SCRATCH_DEV
+    # Note that we use -F here so grep doesn't try to interpret an NFS over
+    # IPv6 server as a regular expression.
+    if _mount | grep -F -q $SCRATCH_DEV
     then
         # if it's mounted, make sure its on $SCRATCH_MNT
-        if ! _mount | grep $SCRATCH_DEV | grep -q $SCRATCH_MNT
+        if ! _mount | grep -F $SCRATCH_DEV | grep -q $SCRATCH_MNT
         then
             echo "\$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT - aborting"
             exit 1
-- 
2.1.0

