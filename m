Received: from mail.cn.fujitsu.com ([183.91.158.132]:53914 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726766AbeK2S7E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Nov 2018 13:59:04 -0500
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 405864B7349C
        for <fstests@vger.kernel.org>; Thu, 29 Nov 2018 15:54:32 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] ext4/002: Fix obsolete TEST_DEV/TEST_DIR in _check_ext4_eof_flag()
Date: Thu, 29 Nov 2018 15:15:32 +0800
Message-ID: <1543475732-10002-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Commit 6b06a9bb6fb0 has used SCRATCH_DEV/SCRATCH_MNT rather than
TEST_DEV/TEST_DIR for holding the test files, so we need to use
SCRATCH_DEV/SCRATCH_MNT in _check_ext4_eof_flag() as well.

Fixes: 6b06a9bb6fb0 ("ext4/002: Work with 64k block size")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/ext4/002 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/ext4/002 b/tests/ext4/002
index b911b1a..986834b 100755
--- a/tests/ext4/002
+++ b/tests/ext4/002
@@ -62,11 +62,11 @@ _check_ext4_eof_flag()
   if [ "${FSTYP}" == "ext4" ]; then
     bit_set=1
 
-    # Unmount the ${TEST_DEV}
-    _test_unmount
+    # Unmount the ${SCRATCH_DEV}
+    _scratch_unmount
 
     # Run debugfs to gather file_parameters - specifically iflags.
-    file_params=`debugfs ${TEST_DEV} -R "stat ${1}" 2>&1 | grep -e Flags:`
+    file_params=`debugfs ${SCRATCH_DEV} -R "stat ${1}" 2>&1 | grep -e Flags:`
     iflags=${file_params#*Flags: }
 
     # Ensure that the iflags value was parsed correctly.
@@ -92,8 +92,8 @@ _check_ext4_eof_flag()
       exit ${status}
     fi
 
-    # Mount the ${TEST_DEV}
-    mount ${TEST_DEV} -t ${FSTYP} ${TEST_DIR}
+    # Mount the ${SCRATCH_DEV}
+    _scratch_mount
   fi
 }
 
-- 
1.8.3.1
