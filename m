Received: from mail.cn.fujitsu.com ([183.91.158.132]:47287 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbeICNfI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Sep 2018 09:35:08 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/504: Check inode number accurately
Date: Mon, 3 Sep 2018 17:36:20 +0800
Message-ID: <1535967380-22601-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xzhou@redhat.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

If inode number is equal to the line number of locks which is
first column in /proc/locks, generic/504 will match wrong number
and get PASS. For example:
-----------------------------------------------------------
inode 12
...
12: FLOCK  ADVISORY  WRITE 1615 00:2e:37889 0 EOF
-----------------------------------------------------------

We should match correct inode number by six column in /proc/locks.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/504 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/504 b/tests/generic/504
index c7d015d..21d8605 100755
--- a/tests/generic/504
+++ b/tests/generic/504
@@ -51,7 +51,7 @@ flock -x 9
 cat /proc/locks >> $seqres.full
 
 # Checking
-grep -qw $tf_inode /proc/locks || echo "lock info not found"
+grep -q ":$tf_inode " /proc/locks || echo "lock info not found"
 
 # success, all done
 status=0
-- 
1.8.3.1
