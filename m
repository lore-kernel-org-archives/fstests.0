Received: from mail-pf0-f196.google.com ([209.85.192.196]:34473 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752886AbdEAREP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 May 2017 13:04:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id g23so28530772pfj.1
        for <fstests@vger.kernel.org>; Mon, 01 May 2017 10:04:15 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] kvm-xfstests: fix running tests with non-primary filesystem type
Date: Mon,  1 May 2017 10:03:58 -0700
Message-Id: <20170501170358.94330-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

With kvm-xfstests, the 'setup-fstab' script would add entries for the
test devices to /etc/fstab, using $PRIMARY_FSTYPE (default "ext4").
This was apparently intended only as a convenience to allow manually
running commands like 'mount /vdb'.  However, it was actually always
executed because the appliance is configured to automatically start
interactive login shells for 'root' on the extra serial ports.  This
broke running tests with filesystem types other than the "primary",
since the wrong fsck program would run.

To fix this, instead use static fstab entries with fstype 'auto'.  This
makes fsck and mount auto-detect the filesystem type, so both the tests
and interactive mounts will work regardless of filesystem type.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/etc/fstab    |  8 ++++++
 kvm-xfstests/test-appliance/files/root/.bashrc | 10 ++++---
 misc/Makefile.in                               |  3 +--
 misc/setup-fstab                               | 36 --------------------------
 4 files changed, 16 insertions(+), 41 deletions(-)
 delete mode 100755 misc/setup-fstab

diff --git a/kvm-xfstests/test-appliance/files/etc/fstab b/kvm-xfstests/test-appliance/files/etc/fstab
index 0122c53..66dd392 100644
--- a/kvm-xfstests/test-appliance/files/etc/fstab
+++ b/kvm-xfstests/test-appliance/files/etc/fstab
@@ -6,4 +6,12 @@ tmpfs		/tmp		tmpfs	mode=1777	0	0
 debugfs		/sys/kernel/debug debugfs defaults	0	0
 v_tmp		/vtmp	9p	trans=virtio,version=9p2000.L,noauto	0	0
 /dev/rootfs	/	ext4    noatime 0 1
+
+# Convenience entries for interactive mounting (e.g. 'mount /vdb')
+/dev/vdb	/vdb	auto	defaults,noauto		0	0
+/dev/vdc	/vdc	auto	defaults,noauto		0	0
+/dev/vdd	/vdd	auto	defaults,noauto		0	0
+/dev/vde	/vde	auto	defaults,noauto		0	0
+/dev/vdf	/vdf	auto	defaults,noauto		0	0
+
 /dev/vdg	/results ext4	defaults 0 2
diff --git a/kvm-xfstests/test-appliance/files/root/.bashrc b/kvm-xfstests/test-appliance/files/root/.bashrc
index 780af73..5938444 100644
--- a/kvm-xfstests/test-appliance/files/root/.bashrc
+++ b/kvm-xfstests/test-appliance/files/root/.bashrc
@@ -4,9 +4,13 @@ if [ "$PS1" ]; then
     . $HOME/test-config
     . $HOME/test-env
     /root/xfstests/bin/resize
-    if test -z "$RUN_ON_GCE"
-    then
-	/root/xfstests/bin/setup-fstab
+    if [ ! -e /dev/vdb ]; then
+	# for interactive mounting using the fstab entries
+	ln -s $PRI_TST_DEV /dev/vdb
+	ln -s $SM_SCR_DEV /dev/vdc
+	ln -s $SM_TST_DEV /dev/vdd
+	[ -n "$LG_SCR_DEV" ] && ln -s $LG_SCR_DEV /dev/vde
+	[ -n "$LG_TST_DEV" ] && ln -s $LG_TST_DEV /dev/vdf
     fi
     dmesg -n 8
 fi
diff --git a/misc/Makefile.in b/misc/Makefile.in
index 572b91c..a71bd6d 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -14,8 +14,7 @@ LDFLAGS = @LDFLAGS@
 PROGS= fname_benchmark postmark resize syncfs
 SCRIPTS= encrypt-fname-benchmark \
 	encrypt-smoketest \
-	encrypt-test-revalidate \
-	setup-fstab
+	encrypt-test-revalidate
 
 all: $(PROGS)
 
diff --git a/misc/setup-fstab b/misc/setup-fstab
deleted file mode 100755
index 99011bd..0000000
--- a/misc/setup-fstab
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-
-. /root/test-config
-
-if [ ! -e /dev/vdb ]; then
-    ln -s $PRI_TST_DEV /dev/vdb
-    ln -s $SM_SCR_DEV /dev/vdc
-    ln -s $SM_TST_DEV /dev/vdd
-    [ -n "$LG_SCR_DEV" ] && ln -s $LG_SCR_DEV /dev/vde
-    [ -n "$LG_TST_DEV" ] && ln -s $LG_TST_DEV /dev/vdf
-fi
-
-mkdir -p /vdb /vdc /vdd /vde /vdf
-
-if test -z "$FS"
-then
-   FS="$FSTESTTYP"
-fi
-
-if test -z "$FS"
-then
-   FS=ext4
-fi
-
-if ! grep -q /dev/vdb /etc/fstab
-then
-   cat >> /etc/fstab << EOF
-/dev/vdb	/vdb	$FS	defaults 0 2
-/dev/vdc	/vdc	$FS	defaults 0 2
-/dev/vdd	/vdd	$FS	defaults 0 2
-/dev/vde	/vde	$FS	defaults 0 2
-/dev/vdf	/vdf	$FS	defaults 0 2
-EOF
-fi
-
-exit 0
-- 
2.13.0.rc0.306.g87b477812d-goog

