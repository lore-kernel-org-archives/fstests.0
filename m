Received: from mail-wr0-f196.google.com ([209.85.128.196]:33449 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeFKMM1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Jun 2018 08:12:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id k16-v6so20165968wro.0
        for <fstests@vger.kernel.org>; Mon, 11 Jun 2018 05:12:26 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] get-versions: fix typo in fsverity.ver
Date: Mon, 11 Jun 2018 15:13:57 +0300
Message-Id: <1528719237-1278-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Ted,

BTW, why are fsverity and ima-evm-utils required and not
optional repos?

Thanks,
Amir.

 get-versions | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/get-versions b/get-versions
index 9cbecd0..7058212 100755
--- a/get-versions
+++ b/get-versions
@@ -25,7 +25,7 @@ fi
 if test -d fsverity
 then
     cd fsverity
-    ver=$(git describe --always --dirty); echo "fsverity	$ver ($(git log -1 --pretty=%cD))" > ../$TMPDIR/keyutils.ver
+    ver=$(git describe --always --dirty); echo "fsverity	$ver ($(git log -1 --pretty=%cD))" > ../$TMPDIR/fsverity.ver
     cd ..
 fi
 
-- 
2.7.4

