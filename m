Received: from mx1.redhat.com ([209.132.183.28]:35332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdATJO0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 20 Jan 2017 04:14:26 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8ACC0A89D
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2017 09:03:33 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [RFC PATCH] check: add flag file to stop running xfstests
Date: Fri, 20 Jan 2017 17:03:28 +0800
Message-Id: <1484903008-32422-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Check if file /tmp/.stopxfstests exists after every
case, break and report if positive.

This could gentlely end a xfstests run, instead of
killing processes around.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 check | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/check b/check
index 5a93c94..75ef245 100755
--- a/check
+++ b/check
@@ -472,6 +472,7 @@ else
 	trap "_wrapup; exit \$status" 0 1 2 3 15
 fi
 
+rm -f /tmp/.stopxfstests
 for section in $HOST_OPTIONS_SECTIONS; do
 	OLD_FSTYP=$FSTYP
 	OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
@@ -595,6 +596,14 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	for seq in $list
 	do
+	    if [ -e /tmp/.stopxfstests ] ; then
+	        _wrapup
+	        echo "WARN: This is an interruptted run."
+	        echo
+                _test_unmount 2> /dev/null
+                _scratch_unmount 2> /dev/null
+                break 2
+            fi
 	    err=false
 	    if [ ! -f $seq ]; then
 	        # Try to get full name in case the user supplied only seq id
-- 
1.8.3.1

