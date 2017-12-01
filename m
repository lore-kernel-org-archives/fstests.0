Received: from mail.cn.fujitsu.com ([183.91.158.132]:28117 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751628AbdLAKFs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Dec 2017 05:05:48 -0500
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 36C4548AE739
        for <fstests@vger.kernel.org>; Fri,  1 Dec 2017 18:05:44 +0800 (CST)
From: yang xu <xuyang.jy@cn.fujitsu.com>
Subject: [PATCH] generic/459: Fix check for ro-remount in extN
Date: Fri, 1 Dec 2017 18:05:36 +0800
Message-ID: <1512122736-6045-1-git-send-email-xuyang.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: yang xu <xuyang.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Currently ,freeze failure caused by the lack of space can not
guarantee to remount extN filesystem in read-only mode.
We can add a touch to trigger the action which aborts journal
and ro-remounts the fs.

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 tests/generic/459 |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/generic/459 b/tests/generic/459
index eb05fb8..197d729 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -132,9 +132,11 @@ ret=$?
 #	- The filesystem turns into Read-Only and reject further writes
 #	- The filesystem stays in Read-Write mode, but can be frozen/thawed
 #	  without getting stuck.
-ISRO=$(_fs_options /dev/mapper/$vgname-$snapname | grep -w "ro")
-
-if [ $ret -ne 0 ]; then
+if [ $ret -ne 0 ]; then	
+	# fsfreeze failed, filesystem should reject further writes and remount
+	# as readonly
+	touch $SCRATCH_MNT/newfile >/dev/null 2>&1
+	ISRO=$(_fs_options /dev/mapper/$vgname-$snapname | grep -w "ro")
 	if [ -n "$ISRO" ]; then
 		echo "Test OK"
 	else
-- 
1.7.1



