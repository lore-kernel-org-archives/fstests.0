Received: from mail.cn.fujitsu.com ([183.91.158.132]:22477 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725923AbeLKGga (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Dec 2018 01:36:30 -0500
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 2AF8F4B6ED63
        for <fstests@vger.kernel.org>; Tue, 11 Dec 2018 14:36:24 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/062, 520: Don't remove lost+found during cleanup
Date: Tue, 11 Dec 2018 14:36:17 +0800
Message-ID: <1544510177-30609-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On older e2fsprogs, fsck command will check lost+found for extX,
so that it will get error if lost+found has been removed during
cleanup.  For example:
----------------------------------------------------------
e2fsck 1.41.12 (17-May-2010)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
/lost+found not found.  Create? no
...
----------------------------------------------------------
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/062 |    2 +-
 tests/generic/520 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/062 b/tests/generic/062
index b6e28e0..3fef02e 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -176,7 +176,7 @@ echo "*** backup everything"
 _backup $tmp.backup1
 
 echo "*** clear out the scratch device"
-rm -fr $SCRATCH_MNT/*
+rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
 echo "AFTER REMOVE" >>$seqres.full
 getfattr -L -R -m '.' $SCRATCH_MNT >>$seqres.full
 
diff --git a/tests/generic/520 b/tests/generic/520
index 4058262..167d707 100755
--- a/tests/generic/520
+++ b/tests/generic/520
@@ -57,7 +57,7 @@ after=""
 clean_dir()
 {
 	_mount_flakey
-	rm -rf $SCRATCH_MNT/*
+	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
 	sync
 	_unmount_flakey
 }
-- 
1.7.1
