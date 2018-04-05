Received: from mail-pl0-f67.google.com ([209.85.160.67]:46616 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbeDEWWb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Apr 2018 18:22:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id 59-v6so18589095plc.13
        for <fstests@vger.kernel.org>; Thu, 05 Apr 2018 15:22:31 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [xfstests-bld PATCH] test-appliance: support f2fs-tools v1.9 and later
Date: Thu,  5 Apr 2018 15:21:41 -0700
Message-Id: <20180405222141.42376-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Pass the -f option to mkfs.f2fs when it appears to support it.  This is
required by f2fs-tools v1.9 and later in order to format the filesystem
even when an existing filesystem is detected.  But earlier versions did
not accept this option.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/f2fs/config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index 45fb2dd..0efcb76 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -20,6 +20,10 @@ function format_filesystem()
     local dev="$1"
     local opts="$2"
 
+    if grep -q 'force overwrite' /sbin/mkfs.f2fs; then
+	# f2fs-tools v1.9+
+	opts+=" -f"
+    fi
     /sbin/mkfs.f2fs -q $opts "$dev"
     return $?
 }
-- 
2.17.0.484.g0c8726318c-goog

