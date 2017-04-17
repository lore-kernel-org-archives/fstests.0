Received: from mail-pf0-f193.google.com ([209.85.192.193]:33992 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755247AbdDQXuo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2017 19:50:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id g23so12864248pfj.1
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2017 16:50:38 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] android-xfstests: improve 'android-xfstests shell' command
Date: Mon, 17 Apr 2017 16:49:18 -0700
Message-Id: <20170417234918.81940-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Make several improvements to 'android-xfstests shell':

1.) Make it give a shell inside the chroot, not outside.
2.) Set up the xfstests partitions before entering the chroot.
3.) Make the shell start from /root, similar to 'kvm-xfstests shell'.
4.) Fix setup-fstab to use the new names for the test device variables,
    to not give errors if the /dev/vd[b-f] symlinks already exist, and
    to not create links to the large devices if they weren't specified
    in the test-config.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/android-xfstests.md |  4 +++-
 kvm-xfstests/android-xfstests     | 30 ++++++++++++++++++------------
 misc/setup-fstab                  | 13 ++++++-------
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/Documentation/android-xfstests.md b/Documentation/android-xfstests.md
index 5b37f9e..a93b35c 100644
--- a/Documentation/android-xfstests.md
+++ b/Documentation/android-xfstests.md
@@ -120,7 +120,9 @@ that yourself.
 Terminating android-xfstests with Ctrl-C doesn't stop the test process
 on the device.
 
-'android-xfstests shell' gives you a shell, but not in the chroot.
+'android-xfstests shell' gives you a shell in the chroot, but it's not
+a snapshot like it is for kvm-xfstests; that is, any changes you make
+in the shell session are persistent.
 
 Android devices usually run an older version of the Linux kernel.  At
 the same time, xfstests is constantly being updated to add new tests.
diff --git a/kvm-xfstests/android-xfstests b/kvm-xfstests/android-xfstests
index e33955e..33274e0 100755
--- a/kvm-xfstests/android-xfstests
+++ b/kvm-xfstests/android-xfstests
@@ -112,7 +112,11 @@ mkdir $CHROOT_DIR
 EOF
 }
 
-CHROOT_CMD="HOME=/root TMPDIR=/tmp chroot $CHROOT_DIR"
+# When entering a login shell, we need to override $PATH to allow commands in
+# /etc/profile to run, as they fail with the Android $PATH.  The $PATH will,
+# however, get overridden again when /root/.bashrc is sourced.  (It's fine to do
+# this for noninteractive shell commands too.)
+CHROOT_CMD="HOME=/root TMPDIR=/tmp PATH=\$PATH:/usr/sbin:/usr/bin:/sbin:/bin chroot $CHROOT_DIR"
 
 chroot_run()
 {
@@ -121,14 +125,10 @@ chroot_run()
 
 chroot_interactive_shell()
 {
-    echo "Run '$CHROOT_CMD /bin/bash' to enter the chroot."
-    adb shell
-
-    # TODO: figure out how to enter the chroot automatically and still have an
-    # interactive shell
-    #stty raw -echo
-    #( echo "$CHROOT_CMD /bin/bash -i" && cat) | adb shell
-    #stty sane
+    # The -t option ("force PTY allocation") makes the shell interactive even
+    # though we're passing 'adb shell' a command to run.  This allows us to
+    # start a shell in the chroot.
+    adb shell -t "$CHROOT_CMD /bin/sh -c \"cd ~; /bin/bash --login\""
 }
 
 setup_chroot()
@@ -223,11 +223,15 @@ setup_partitions()
     esac
 }
 
+xfstests_running()
+{
+    [ -n "$(adb shell 'pgrep runtests\.sh')" ]
+}
+
 # If xfstests is already running, ask the user if they want to terminate it
 stop_existing_tests()
 {
-    local existing=$(adb shell 'pgrep runtests\.sh')
-    if [ -z "$existing" ]; then
+    if ! xfstests_running; then
 	return 0
     fi
     ask_yesno "xfstests is already running!  Terminate it?"
@@ -256,6 +260,9 @@ fi
 
 wait_for_device
 setup_chroot
+if ! xfstests_running; then
+    setup_partitions first_try
+fi
 
 case "$ARG" in
     cmd=shell*|cmd=maint*)
@@ -265,7 +272,6 @@ case "$ARG" in
 esac
 
 stop_existing_tests
-setup_partitions first_try
 
 cat > "$tmpfile" <<EOF
 #!/bin/bash
diff --git a/misc/setup-fstab b/misc/setup-fstab
index 5953ddf..99011bd 100755
--- a/misc/setup-fstab
+++ b/misc/setup-fstab
@@ -2,13 +2,12 @@
 
 . /root/test-config
 
-if [ $VDB != "/dev/vdb" ];
-then
-	ln -s $VDB /dev/vdb
-	ln -s $VDC /dev/vdc
-	ln -s $VDD /dev/vdd
-	ln -s $VDE /dev/vde
-	ln -s $VDF /dev/vdf
+if [ ! -e /dev/vdb ]; then
+    ln -s $PRI_TST_DEV /dev/vdb
+    ln -s $SM_SCR_DEV /dev/vdc
+    ln -s $SM_TST_DEV /dev/vdd
+    [ -n "$LG_SCR_DEV" ] && ln -s $LG_SCR_DEV /dev/vde
+    [ -n "$LG_TST_DEV" ] && ln -s $LG_TST_DEV /dev/vdf
 fi
 
 mkdir -p /vdb /vdc /vdd /vde /vdf
-- 
2.12.2.762.g0e3151a226-goog

