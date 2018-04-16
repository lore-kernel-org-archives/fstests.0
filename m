Received: from mail-pf0-f193.google.com ([209.85.192.193]:42154 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPWGp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Apr 2018 18:06:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id o16so11168297pfk.9
        for <fstests@vger.kernel.org>; Mon, 16 Apr 2018 15:06:45 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH] test-appliance: detect 'mkfs.f2fs -f' support by grepping help output
Date: Mon, 16 Apr 2018 15:06:21 -0700
Message-Id: <20180416220621.196700-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y . Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Grep the help output rather than the binary itself.  This matches the
detection method that was implemented in xfstests common/config.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/f2fs/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index 0efcb76..b0c2196 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -20,7 +20,7 @@ function format_filesystem()
     local dev="$1"
     local opts="$2"
 
-    if grep -q 'force overwrite' /sbin/mkfs.f2fs; then
+    if /sbin/mkfs.f2fs --help |& grep -q "[[:space:]]-f[[:space:]|]"; then
 	# f2fs-tools v1.9+
 	opts+=" -f"
     fi
-- 
2.17.0.484.g0c8726318c-goog

