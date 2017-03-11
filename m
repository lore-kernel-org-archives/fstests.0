Received: from mail-pg0-f65.google.com ([74.125.83.65]:35777 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbdCKA5B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 19:57:01 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so7394045pge.2
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 16:57:00 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] android-xfstests: create loopback device nodes in standard location
Date: Fri, 10 Mar 2017 16:56:32 -0800
Message-Id: <20170311005632.130135-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Android creates loopback device nodes in /dev/block/, where they can't
be found by losetup.  Create them in /dev/ too so that losetup can find
them.  This stops tests using loopback devices, e.g. generic/361 and
shared/298, from failing.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/android-xfstests | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kvm-xfstests/android-xfstests b/kvm-xfstests/android-xfstests
index e798c7e..3489bc2 100755
--- a/kvm-xfstests/android-xfstests
+++ b/kvm-xfstests/android-xfstests
@@ -94,6 +94,14 @@ if ! cut -d' ' -f2 /proc/mounts 2>/dev/null | grep -q '^$CHROOT_DIR/results$'; t
     mkdir -p $RESULTS_DIR
     mount --bind $RESULTS_DIR $CHROOT_DIR/results
 fi
+
+# Android puts loopback device nodes in /dev/block/ instead of /dev/.
+# But losetup can only find them in /dev/, so create them there too.
+for i in \`seq 0 7\`; do
+	if [ ! -e /dev/loop\$i ]; then
+		mknod /dev/loop\$i b 7 \$i
+	fi
+done
 EOF
 }
 
-- 
2.12.0.246.ga2ecc84866-goog

