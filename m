Received: from mail-wm0-f65.google.com ([74.125.82.65]:39498 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeEMQCe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 May 2018 12:02:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id f8-v6so10910152wmc.4
        for <fstests@vger.kernel.org>; Sun, 13 May 2018 09:02:33 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] generic/484: add missing _require_test_program
Date: Sun, 13 May 2018 19:03:59 +0300
Message-Id: <1526227439-20517-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/484 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/484 b/tests/generic/484
index 1c2cd96..cb55414 100755
--- a/tests/generic/484
+++ b/tests/generic/484
@@ -52,6 +52,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_test_program "t_locks_execve"
 
 # prepare a 4k testfile in TEST_DIR
 $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
-- 
2.7.4

