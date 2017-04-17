Received: from mail-pf0-f194.google.com ([209.85.192.194]:32917 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbdDQVeS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2017 17:34:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id c198so27153539pfc.0
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2017 14:34:18 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/3] xfstests-bld: use a separate default config file for each test runner
Date: Mon, 17 Apr 2017 14:33:25 -0700
Message-Id: <20170417213327.36520-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Instead of mixing together the default configuration for kvm-xfstests,
gce-xfstests, and android-xfstests in a single file "config", split it
into separate files for each test runner, along with a config.common
(named "xfstests-common" if overridden in ~/.config/).  This will allow
setting defaults for variables such as ROOT_FS, NR_CPU, and MEM that may
be meaningful for more than one test runner but should have different
default values.  It also more closely matches how the configs in
~/.config/ work.

For now keep sourcing kvm-xfstests/config.custom if present, but suggest
that the user move their settings into ~/.config/ where they aren't all
mixed together for all test runners.  Also keep supporting per-account
configs for gce-xfstests, though really one could instead just make
their ~/.config/gce-xfstests enable different settings based on their
active account (it is a shell script after all).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/kvm-quickstart.md     |  8 ++++----
 Documentation/kvm-xfstests.md       |  9 ++++-----
 config                              |  4 +++-
 kvm-xfstests/config.android         |  6 ++++++
 kvm-xfstests/config.common          |  7 +++++++
 kvm-xfstests/config.gce             | 15 +++++++++++++++
 kvm-xfstests/{config => config.kvm} | 35 ++++-------------------------------
 kvm-xfstests/util/get-config        | 22 +++++++++++++++++-----
 8 files changed, 60 insertions(+), 46 deletions(-)
 create mode 100644 kvm-xfstests/config.android
 create mode 100644 kvm-xfstests/config.common
 create mode 100644 kvm-xfstests/config.gce
 rename kvm-xfstests/{config => config.kvm} (54%)

diff --git a/Documentation/kvm-quickstart.md b/Documentation/kvm-quickstart.md
index c18a39e..8dcdc90 100644
--- a/Documentation/kvm-quickstart.md
+++ b/Documentation/kvm-quickstart.md
@@ -22,10 +22,10 @@
     kernel-configs directory; pick one whose version number is close
     to the kernel version you wish to build.
 
-4.  In the fstests/kvm-xfstests directory, take a look at the "config"
-    file and either edit that file in place, or (this is preferred)
-    put override values in ~/.config/kvm-xfstests or config.custom.
-    The most common values you will likely need to override is the
+4.  In the fstests/kvm-xfstests/ directory, take a look at the
+    "config.kvm" file and either edit that file in place, or (this is
+    preferred) put override values in ~/.config/kvm-xfstests.  The
+    most common values you will likely need to override are the
     location of the compiled kernel and the preferred timezone if you
     wish the log files to display times in your local timezone.
 
diff --git a/Documentation/kvm-xfstests.md b/Documentation/kvm-xfstests.md
index c480e4a..72f3aae 100644
--- a/Documentation/kvm-xfstests.md
+++ b/Documentation/kvm-xfstests.md
@@ -39,11 +39,10 @@ Please see the relevant documentation files for more details.
 ## Setup and configuration
 
 The configuration file for kvm-xfstests is found in the kvm-xfstests
-directory and is named config.  You can edit this file directly, but
-the better thing to do is to place override values in
-~/.config/kvm-xfstests or in kvm-xfstests/config.custom.  Please look
-at the kvm-xfstests/config file to see the shell variables you can
-set.
+directory and is named config.kvm.  You can edit this file directly,
+but the better thing to do is to place override values in
+~/.config/kvm-xfstests.  Please look at the kvm-xfstests/config.kvm
+file to see the shell variables you can set.
 
 Perhaps the most important configuration variable to set is KERNEL.
 This should point at the default location for the kernel that qemu
diff --git a/config b/config
index af0f21e..f28bf9f 100644
--- a/config
+++ b/config
@@ -1,4 +1,6 @@
-# Configuration file for xfstests-bld
+#
+# Configuration file for building xfstests and root filesystem images
+#
 
 XFSTESTS_GIT=git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
 XFSPROGS_GIT=git://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git
diff --git a/kvm-xfstests/config.android b/kvm-xfstests/config.android
new file mode 100644
index 0000000..4b668f8
--- /dev/null
+++ b/kvm-xfstests/config.android
@@ -0,0 +1,6 @@
+#
+# Default configuration for android-xfstests
+#
+# Variables set here may be overridden in ~/.config/android-xfstests
+#
+
diff --git a/kvm-xfstests/config.common b/kvm-xfstests/config.common
new file mode 100644
index 0000000..12cae0a
--- /dev/null
+++ b/kvm-xfstests/config.common
@@ -0,0 +1,7 @@
+#
+# Default configuration for all test runners (kvm-xfstests, gce-xfstests, etc.)
+#
+# Variables set here may be overridden in ~/.config/xfstests-common
+#
+
+PRIMARY_FSTYPE="ext4"
diff --git a/kvm-xfstests/config.gce b/kvm-xfstests/config.gce
new file mode 100644
index 0000000..96b64f8
--- /dev/null
+++ b/kvm-xfstests/config.gce
@@ -0,0 +1,15 @@
+#
+# Default configuration for gce-xfstests
+#
+# Variables set here may be overridden in ~/.config/gce-xfstests
+#
+
+#
+# GS_BUCKET=gs_bucket.thunk.org
+# GCE_PROJECT=tytso-xfstests-project
+# GCE_ZONE=us-central1-c
+# GCE_KERNEL=/u1/ext4-64/arch/x86/boot/bzImage
+
+# List of firewall rules to create.  By default the gce-xfstests web interface
+# is made available to everyone over the public Internet.
+GCE_FIREWALL_RULES=("allow-http --allow tcp:80 --target-tags http-server")
diff --git a/kvm-xfstests/config b/kvm-xfstests/config.kvm
similarity index 54%
rename from kvm-xfstests/config
rename to kvm-xfstests/config.kvm
index 994dcd3..43df96a 100644
--- a/kvm-xfstests/config
+++ b/kvm-xfstests/config.kvm
@@ -1,27 +1,12 @@
 #
-# Customize these, or put new values in:
+# Default configuration for kvm-xfstests
 #
-#		~/.config/kvm-xfstests
-#	or
-#		~/.config/gce-xfstests
-#	or
-#		~/.config/android-xfstests
-#
-# ... to affect specific commands only;
-#
-# or in config.custom to affect all commands.
+# Variables set here may be overridden in ~/.config/kvm-xfstests
 #
 
-###############################################################################
-# Common configuration
-#
-PRIMARY_FSTYPE="ext4" # all commands
-NR_CPU=2 # kvm-xfstests and gce-xfstests
-MEM=2048 # kvm-xfstests and gce-xfstests
+NR_CPU=2
+MEM=2048
 
-###############################################################################
-# KVM configuration
-#
 #QEMU=/usr/local/bin/qemu-system-x86_64
 QEMU=/usr/bin/kvm
 KERNEL=$HOME/linux
@@ -55,15 +40,3 @@ MONITOR="-monitor telnet:localhost:7498,server,nowait"
 # interception entirely.
 CONSOLE=" -serial mon:stdio"
 #CONSOLE=" -chardev stdio,id=console,signal=off -serial chardev:console"
-
-###############################################################################
-# GCE configuration
-#
-# GS_BUCKET=gs_bucket.thunk.org
-# GCE_PROJECT=tytso-xfstests-project
-# GCE_ZONE=us-central1-c
-# GCE_KERNEL=/u1/ext4-64/arch/x86/boot/bzImage
-
-# List of firewall rules to create.  By default the gce-xfstests web interface
-# is made available to everyone over the public Internet.
-GCE_FIREWALL_RULES=("allow-http --allow tcp:80 --target-tags http-server")
diff --git a/kvm-xfstests/util/get-config b/kvm-xfstests/util/get-config
index b1ffc8f..f37d8c1 100644
--- a/kvm-xfstests/util/get-config
+++ b/kvm-xfstests/util/get-config
@@ -12,12 +12,16 @@
 #
 # . "$DIR/util/get-config"
 
-. $DIR/config
+# Source the default configs
+. $DIR/config.common
+. $DIR/config.${XFSTESTS_FLAVOR}
 
-# Source the user-provided config if present (e.g. ~/.config/kvm-xfstests)
+# Source custom configs in ~/.config/ if present
+[ -f "$HOME/.config/xfstests-common" ] && . "$HOME/.config/xfstests-common"
 [ -f "$HOME/.config/${XFSTESTS_FLAVOR}-xfstests" ] && \
 	. "$HOME/.config/${XFSTESTS_FLAVOR}-xfstests"
 
+# For gce-xfstests, source the config for the active account if present
 if test "$XFSTESTS_FLAVOR" = "gce" -a -z "$GCE_ACCOUNT" -a \
    -n "$(ls $DIR/config-* 2> /dev/null)"
 then
@@ -32,11 +36,19 @@ then
 fi
 
 if test -n "$GCE_ACCOUNT" -a -f "$DIR/config-$GCE_ACCOUNT" ; then
-   . "$DIR/config-$GCE_ACCOUNT"
+    . "$DIR/config-$GCE_ACCOUNT"
 elif test -f $DIR/config.custom ; then
-   . $DIR/config.custom
+# Else, source kvm-xfstests/config.custom if present (deprecated)
+    echo -e 1>&2 "Warning: use of kvm-xfstests/config.custom is deprecated." \
+	    "Move your settings\n         into ~/.config/kvm-xfstests," \
+	    "~/.config/gce-xfstests,\n         ~/.config/android-xfstests," \
+	    "and/or ~/.config/xfstests-common"
+    . $DIR/config.custom
 fi
 
+# Source $KVM_CONFIG if present (deprecated)
 if test -n "$KVM_CONFIG" -a -f "$KVM_CONFIG"; then
-   . $KVM_CONFIG
+    echo -e 1>&2 "Warning: use of \$KVM_CONFIG is deprecated." \
+	    "Move your settings into\n         ~/.config/kvm-xfstests"
+    . $KVM_CONFIG
 fi
-- 
2.12.2.762.g0e3151a226-goog

