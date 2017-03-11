Received: from mail-pf0-f193.google.com ([209.85.192.193]:34288 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbdCKAxi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 19:53:38 -0500
Received: by mail-pf0-f193.google.com with SMTP id o126so12421929pfb.1
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 16:53:37 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] android-xfstests: allow detection of SELinux
Date: Fri, 10 Mar 2017 16:53:06 -0800
Message-Id: <20170311005306.129624-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

xfstests is supposed to disable the creation of SELinux xattrs because
this interferes with some tests (e.g. generic/062 and generic/377), but
this was not working on Android.  For the android-xfstests portion of
the fix, make the following changes:

1. To stop the mount program from stripping the 'context' mount option,
mount selinuxfs and create an empty /etc/selinux/config.  This makes the
is_selinux_enabled() function from libselinux return true.

2. To stop xfstests from thinking that SELinux is disabled, link
/usr/sbin/selinuxenabled to /bin/true.  (Note: getting the real version
of selinuxenabled by adding selinux-utils to the chroot tarball would
also work, though no other programs from it are needed yet, and some
don't work in the chroot environment yet.)

In combination with the xfstests patch to stop hard-coding SELinux
contexts in xfstests, this fixes the failing tests.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/android-xfstests | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kvm-xfstests/android-xfstests b/kvm-xfstests/android-xfstests
index 7e3eab3..e798c7e 100755
--- a/kvm-xfstests/android-xfstests
+++ b/kvm-xfstests/android-xfstests
@@ -81,6 +81,14 @@ chroot_prepare()
 ! mountpoint $CHROOT_DIR/proc > /dev/null && mount proc -t proc $CHROOT_DIR/proc
 ! mountpoint $CHROOT_DIR/dev > /dev/null && mount --bind /dev $CHROOT_DIR/dev
 
+# Allow xfstests to detect that SELinux is in use.
+! mountpoint $CHROOT_DIR/sys/fs/selinux > /dev/null && \
+		mount selinuxfs -t selinuxfs $CHROOT_DIR/sys/fs/selinux
+touch $CHROOT_DIR/etc/selinux/config
+if [ ! -e $CHROOT_DIR/usr/sbin/selinuxenabled ]; then
+	ln $CHROOT_DIR/bin/true $CHROOT_DIR/usr/sbin/selinuxenabled
+fi
+
 # 'mountpoint' doesn't work with directory bind mounts; use /proc/mounts instead
 if ! cut -d' ' -f2 /proc/mounts 2>/dev/null | grep -q '^$CHROOT_DIR/results$'; then
     mkdir -p $RESULTS_DIR
@@ -92,6 +100,7 @@ EOF
 chroot_wipe()
 {
     cat <<EOF | adb shell
+umount $CHROOT_DIR/sys/fs/selinux &> /dev/null
 umount $CHROOT_DIR/sys &> /dev/null
 umount $CHROOT_DIR/proc &> /dev/null
 umount $CHROOT_DIR/dev &> /dev/null
-- 
2.12.0.246.ga2ecc84866-goog

