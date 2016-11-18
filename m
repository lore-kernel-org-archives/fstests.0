Received: from mail-pg0-f49.google.com ([74.125.83.49]:33443 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbcKRV0g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Nov 2016 16:26:36 -0500
Received: by mail-pg0-f49.google.com with SMTP id 3so106822277pgd.0
        for <fstests@vger.kernel.org>; Fri, 18 Nov 2016 13:26:36 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] xfstests-bld: correct file permissions in xfstests.tar.gz
Date: Fri, 18 Nov 2016 13:25:50 -0800
Message-Id: <1479504350-123472-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: tytso@mit.edu
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

The bug with --update-files also affected --update-xfstests-tar.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 gen-tarball | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gen-tarball b/gen-tarball
index daa6d4f..2626996 100755
--- a/gen-tarball
+++ b/gen-tarball
@@ -50,4 +50,5 @@ cp bld/lib/client.txt xfstests/lib
 echo "STRIP xfstests/*"
 find xfstests -mindepth 2 -type f -perm /0111 | xargs $STRIP 2> /dev/null
 echo "TAR xfstests"
-tar cf - xfstests | $GZIP -9 > xfstests.tar.gz
+tar c --owner=root --group=root --mode=o+g-w xfstests | \
+	$GZIP -9 > xfstests.tar.gz
-- 
2.8.0.rc3.226.g39d4020

