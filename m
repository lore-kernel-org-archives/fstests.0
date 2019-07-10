Received: from mail.cn.fujitsu.com ([183.91.158.132]:19332 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbfGKFYU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Jul 2019 01:24:20 -0400
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/553[4]: correct kernel fix commit
Date: Wed, 10 Jul 2019 19:35:22 +0800
Message-ID: <1562758522-6359-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, amir73il@gmail.com
Cc: fstests@vger.kernel.org, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

commit 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
adds checks for immutablefile and swapfile instead of commit a31713517d
("vfs: introduce generic_file_rw_checks()").

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/553 | 2 +-
 tests/generic/554 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/553 b/tests/generic/553
index aefb0819..a836e602 100755
--- a/tests/generic/553
+++ b/tests/generic/553
@@ -7,7 +7,7 @@
 # Check that we cannot copy_file_range() to an immutable file
 #
 # This is a regression test for kernel commit:
-#   a31713517dac ("vfs: introduce generic_file_rw_checks()")
+#   96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
diff --git a/tests/generic/554 b/tests/generic/554
index fa19d580..eaf1f45a 100755
--- a/tests/generic/554
+++ b/tests/generic/554
@@ -7,7 +7,7 @@
 # Check that we cannot copy_file_range() to a swapfile
 #
 # This is a regression test for kernel commit:
-#   a31713517dac ("vfs: introduce generic_file_rw_checks()")
+#   96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
-- 
2.18.1
