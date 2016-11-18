Received: from mail-pg0-f41.google.com ([74.125.83.41]:33569 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbcKRV1e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Nov 2016 16:27:34 -0500
Received: by mail-pg0-f41.google.com with SMTP id 3so106829118pgd.0
        for <fstests@vger.kernel.org>; Fri, 18 Nov 2016 13:27:33 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] xfstests-bld: fix typo in command to download root_fs.img
Date: Fri, 18 Nov 2016 13:27:02 -0800
Message-Id: <1479504422-123825-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: tytso@mit.edu
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/kvm-quickstart.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kvm-quickstart.md b/Documentation/kvm-quickstart.md
index 94829c6..c18a39e 100644
--- a/Documentation/kvm-quickstart.md
+++ b/Documentation/kvm-quickstart.md
@@ -11,7 +11,7 @@
 
         git clone git://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git fstests
         cd fstests/kvm-xfstests
-        wget -O test_appliance/root_fs.img https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/root_fs.img.i386
+        wget -O test-appliance/root_fs.img https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/root_fs.img.i386
 
 3.  Build a kernel with all of the necessary drivers for kvm built
     into the kernel.  No modules should be used, since kvm-xfstests
-- 
2.8.0.rc3.226.g39d4020

