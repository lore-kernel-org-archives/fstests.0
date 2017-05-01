Received: from mail-pg0-f67.google.com ([74.125.83.67]:33292 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbdEARE2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 May 2017 13:04:28 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so5212744pgc.0
        for <fstests@vger.kernel.org>; Mon, 01 May 2017 10:04:28 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] kvm-xfstests: unmount /results before shutting down
Date: Mon,  1 May 2017 10:04:20 -0700
Message-Id: <20170501170420.94456-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

kvm-xfstests shuts down the VM with 'poweroff -f', which with old
versions of systemd's 'poweroff' command (including the version included
in Debian Jessie) does not call sync().  This could cause data written
to the /results filesystem to be lost.  Work around this by unmounting
/results before shutting down.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot b/kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot
index 2eb3a2b..cd01ffd 100755
--- a/kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot
+++ b/kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot
@@ -92,6 +92,7 @@ then
 	/bin/rm -f /run/gce-finalize-wait
     else
 	/root/runtests.sh
+	umount /results
 	poweroff -f > /dev/null 2>&1
     fi
 else
-- 
2.13.0.rc0.306.g87b477812d-goog

