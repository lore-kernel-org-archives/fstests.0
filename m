Received: from mail-pf0-f195.google.com ([209.85.192.195]:34717 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbdIHX6X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Sep 2017 19:58:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id g65so1870817pfe.1
        for <fstests@vger.kernel.org>; Fri, 08 Sep 2017 16:58:23 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH] android-xfstests: mount /dev/pts in chroot
Date: Fri,  8 Sep 2017 16:56:47 -0700
Message-Id: <20170908235647.67225-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Since the upgrade of the chroot tarball to Debian Stretch, it's now
expected that devpts be mounted in the chroot.  Otherwise there is a
warning message like the following when the shell starts:

    mesg: ttyname failed: Success

Android mounts devpts already, so just bind-mount it into the chroot.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/android-xfstests | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kvm-xfstests/android-xfstests b/kvm-xfstests/android-xfstests
index 8e5b77c..e204e2f 100755
--- a/kvm-xfstests/android-xfstests
+++ b/kvm-xfstests/android-xfstests
@@ -227,6 +227,7 @@ chroot_prepare()
 ! mountpoint $CHROOT_DIR/sys > /dev/null && mount sysfs -t sysfs $CHROOT_DIR/sys
 ! mountpoint $CHROOT_DIR/proc > /dev/null && mount proc -t proc $CHROOT_DIR/proc
 ! mountpoint $CHROOT_DIR/dev > /dev/null && mount --bind /dev $CHROOT_DIR/dev
+! mountpoint $CHROOT_DIR/dev/pts > /dev/null && mount --bind /dev/pts $CHROOT_DIR/dev/pts
 
 # Allow xfstests to detect that SELinux is in use.
 ! mountpoint $CHROOT_DIR/sys/fs/selinux > /dev/null && \
@@ -258,6 +259,7 @@ chroot_wipe()
 umount $CHROOT_DIR/sys/fs/selinux &> /dev/null
 umount $CHROOT_DIR/sys &> /dev/null
 umount $CHROOT_DIR/proc &> /dev/null
+umount $CHROOT_DIR/dev/pts &> /dev/null
 umount $CHROOT_DIR/dev &> /dev/null
 umount $CHROOT_DIR/results &> /dev/null
 rm -rf $CHROOT_DIR
-- 
2.14.1.581.gf28d330327-goog

