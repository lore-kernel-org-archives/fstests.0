Received: from mail-wm0-f65.google.com ([74.125.82.65]:38693 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbdIDMPC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2017 08:15:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id u26so145981wma.5
        for <fstests@vger.kernel.org>; Mon, 04 Sep 2017 05:15:02 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] kvm-xfstests: use aio=native for test drives
Date: Mon,  4 Sep 2017 15:15:28 +0300
Message-Id: <1504527328-24615-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eryu Guan <eguan@redhat.com>, Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Lost IOs have been observed with the default aio=threads with
QEMU 2.5.0 when running crash consistency tests.
The issue has not been observed with QEMU 2.9.0.
Native AIO is probably better for our goal which is test proofing
production systems.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Ted,

Not sure you have been following the crash consistency tests threads.

Anyway, I ran into an issue of sucessfuly completed bio's that
did not make it to storage device when running in kvm-xfstests.

Josef reported that he did not observe the issue with newer QEMU
and the issue is gone with aio=native on my version of QEMU.

Crash consistency tests still can't run properly on kvm-xfstests
without this fix to kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git/commit/?h=dm-log-writes-fixes&id=08c7d64773091c7d2e0147da7064aa4dc297629d
After the fix is merged I will post a patch to enable running
dm-log-write tests in kvm-xfstest.

Mean while, the change to aio=native seems like a good move
anyway and if I observed a bio black hole in one test, who's to say
they don't exist for other tests as well.

Amir.


 kvm-xfstests/kvm-xfstests | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kvm-xfstests/kvm-xfstests b/kvm-xfstests/kvm-xfstests
index 305e2f5..98bd76a 100755
--- a/kvm-xfstests/kvm-xfstests
+++ b/kvm-xfstests/kvm-xfstests
@@ -101,15 +101,22 @@ chmod 400 "$VDH"
 
 mkdir -p /tmp/kvm-xfstests-$USER
 
+# Lost IOs have been observed with the default aio=threads with
+# QEMU 2.5.0 when running crash consistency tests.
+# The issue has not been observed with QEMU 2.9.0.
+# Native AIO is probably better for our goal which is test proofing
+# production systems.
+AIO=",aio=native"
+
 $NO_ACTION $IONICE $QEMU -boot order=c $NET \
 	-machine type=pc,accel=kvm:tcg \
 	-drive file=$ROOT_FS,if=virtio$SNAPSHOT \
-	-drive file=$VDB,cache=none,if=virtio,format=raw \
-	-drive file=$VDC,cache=none,if=virtio,format=raw \
-	-drive file=$VDD,cache=none,if=virtio,format=raw \
-	-drive file=$VDE,cache=none,if=virtio,format=raw \
-	-drive file=$VDF,cache=none,if=virtio,format=raw \
-	-drive file=$VDG,cache=none,if=virtio,format=raw \
+	-drive file=$VDB,cache=none,if=virtio,format=raw$AIO \
+	-drive file=$VDC,cache=none,if=virtio,format=raw$AIO \
+	-drive file=$VDD,cache=none,if=virtio,format=raw$AIO \
+	-drive file=$VDE,cache=none,if=virtio,format=raw$AIO \
+	-drive file=$VDF,cache=none,if=virtio,format=raw$AIO \
+	-drive file=$VDG,cache=none,if=virtio,format=raw$AIO \
 	-drive file=$VDH,cache=unsafe,readonly,if=virtio \
 	-vga none -nographic -smp $NR_CPU -m $MEM \
 	-fsdev local,id=v_tmp,path=/tmp/kvm-xfstests-$USER,security_model=none \
-- 
2.7.4

