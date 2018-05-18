Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752073AbeERLKc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 May 2018 07:10:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68551BB405
        for <fstests@vger.kernel.org>; Fri, 18 May 2018 11:10:32 +0000 (UTC)
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH] common/rc: add the function _require_noatime
Date: Fri, 18 May 2018 19:10:29 +0800
Message-Id: <1526641829-9893-1-git-send-email-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xiaoli feng <xifeng@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: xiaoli feng <xifeng@redhat.com>

In the generic/120, it will make the test not-pass if the filesystem
mounts failed with noatime. Now change this result to norun. The
filesystem cifs doesn't support noatime. Just make the test norun
until it supports noatime.

Signed-off-by: xiaoli feng <xifeng@redhat.com>
---
 common/rc         | 8 +++++++-
 tests/generic/120 | 7 +------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index ffe5323..9c45f1b 100644
--- a/common/rc
+++ b/common/rc
@@ -3244,7 +3244,13 @@ _require_atime()
 	_exclude_scratch_mount_option "noatime"
 	if [ "$FSTYP" == "nfs" ]; then
 		_notrun "atime related mount options have no effect on NFS"
-	fi
+}
+
+_require_noatime()
+{
+	_exclude_scratch_mount_option "atime"
+	 _try_scratch_mount -o noatime || \
+                _notrun "noatime not supported by the current tested filesystem"
 }
 
 _require_relatime()
diff --git a/tests/generic/120 b/tests/generic/120
index 1180c10..ddd61b3 100755
--- a/tests/generic/120
+++ b/tests/generic/120
@@ -60,12 +60,7 @@ _compare_access_times()
 
 }
 
-if ! _try_scratch_mount "-o noatime" >$tmp.out 2>&1
-then
-    cat $tmp.out
-    echo "!!! mount failed"
-    exit
-fi
+_require_noatime
 
 #executable file
 echo "*** copying file ***"
-- 
1.8.3.1

