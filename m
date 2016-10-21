Received: from mail-pf0-f179.google.com ([209.85.192.179]:33406 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935516AbcJUVWe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Oct 2016 17:22:34 -0400
Received: by mail-pf0-f179.google.com with SMTP id 128so63352952pfz.0
        for <fstests@vger.kernel.org>; Fri, 21 Oct 2016 14:22:33 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] generic/314: remove from acl group
Date: Fri, 21 Oct 2016 14:22:06 -0700
Message-Id: <1477084926-100420-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

generic/314 no longer tests POSIX ACLs.  It only tests the SGID bit.
Therefore, it should not be in the acl group anymore.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index fc32cfd..d7f5f7c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -316,7 +316,7 @@
 311 auto metadata log
 312 auto quick prealloc enospc
 313 auto quick
-314 auto quick acl
+314 auto quick
 315 auto quick rw prealloc
 316 auto quick punch
 317 auto metadata quick
-- 
2.8.0.rc3.226.g39d4020

