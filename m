Received: from mail-pf0-f196.google.com ([209.85.192.196]:36448 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755210AbdGSUgT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jul 2017 16:36:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11so783544pfj.3
        for <fstests@vger.kernel.org>; Wed, 19 Jul 2017 13:36:19 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] generic/421: stop test from hanging on buggy kernels
Date: Wed, 19 Jul 2017 13:35:51 -0700
Message-Id: <20170719203551.126851-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

On some buggy kernels, the 'find' command in generic/421 encounters a
"Permission denied" error when trying to search $dir, so it doesn't find
the file it's supposed to.  This causes 'cat' to read from stdin,
hanging the test.  Quote the argument to cat to make the test fail right
away rather than hanging.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/421 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/421 b/tests/generic/421
index 1b2f66f9..9ab48d47 100755
--- a/tests/generic/421
+++ b/tests/generic/421
@@ -98,7 +98,7 @@ keyid=$(_revoke_encryption_key $keydesc)
 # ciphertext on key revocation.  Therefore, the name of the file we're opening
 # here may be in either plaintext or ciphertext depending on the kernel version,
 # and ciphertext names are unpredictable anyway, so just use 'find' to find it.
-cat $(find $dir -type f) > /dev/null
+cat "$(find $dir -type f)" > /dev/null
 
 # Wait for readers to exit
 touch $tmp.done
-- 
2.14.0.rc0.284.gd933b75aa4-goog

