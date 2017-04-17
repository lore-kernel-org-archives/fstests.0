Received: from mail-pg0-f65.google.com ([74.125.83.65]:33285 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754372AbdDQVeX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2017 17:34:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id 63so16626216pgh.0
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2017 14:34:23 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 3/3] android-xfstests: move ROOT_FS and ROOT_FS_URL into config.android
Date: Mon, 17 Apr 2017 14:33:27 -0700
Message-Id: <20170417213327.36520-3-ebiggers3@gmail.com>
In-Reply-To: <20170417213327.36520-1-ebiggers3@gmail.com>
References: <20170417213327.36520-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

This allows them to be overridden by ~/.config/android-xfstests.  Also
start treating an empty ROOT_FS_URL as meaning that no URL is provided.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/android-xfstests.md | 3 ++-
 kvm-xfstests/android-xfstests     | 9 +++------
 kvm-xfstests/config.android       | 6 ++++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/android-xfstests.md b/Documentation/android-xfstests.md
index b309c21..5b37f9e 100644
--- a/Documentation/android-xfstests.md
+++ b/Documentation/android-xfstests.md
@@ -39,7 +39,8 @@ devices.  If you encounter a problem, please submit a fix!
   [building-xfstests](building-xfstests.md).  Then, either put the
   chroot tarball in the default location of
   kvm-xfstests/test-appliance/armhf_root_fs.tar.gz, or specify it with
-  the -I option to android-xfstests.
+  ROOT_FS in your ~/.config/android-xfstests or the -I option to
+  android-xfstests.
 
 ## Procedure
 
diff --git a/kvm-xfstests/android-xfstests b/kvm-xfstests/android-xfstests
index 3489bc2..e33955e 100755
--- a/kvm-xfstests/android-xfstests
+++ b/kvm-xfstests/android-xfstests
@@ -10,12 +10,6 @@ fi
 
 . "$DIR/util/get-config"
 
-# Path to chroot tarball; can be overridden with -I
-ROOT_FS="$DIR/test-appliance/armhf_root_fs.tar.gz"
-
-# Where to download the tarball from (at user's request) if we don't have it
-ROOT_FS_URL="https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/armhf_root_fs.tar.gz"
-
 # Chroot directory on device.
 # Note: this will be wiped clean when deploying a new chroot tarball.
 CHROOT_DIR="/data/xfstests-chroot"
@@ -142,6 +136,9 @@ setup_chroot()
     if ! [ -f "$ROOT_FS" ]; then
 	echo "The xfstests chroot tarball does not exist:"
 	echo "        $ROOT_FS"
+	if [ -z "$ROOT_FS_URL" ]; then
+	    exit 1
+	fi
 	ask_yesno "Would you like to download the latest public tarball to that location?"
 	wget -O "$ROOT_FS" "$ROOT_FS_URL"
 	echo "Finished downloading chroot tarball."
diff --git a/kvm-xfstests/config.android b/kvm-xfstests/config.android
index 4b668f8..ed7098c 100644
--- a/kvm-xfstests/config.android
+++ b/kvm-xfstests/config.android
@@ -4,3 +4,9 @@
 # Variables set here may be overridden in ~/.config/android-xfstests
 #
 
+# Path to chroot tarball; this can also be set by the -I option
+ROOT_FS="$DIR/test-appliance/armhf_root_fs.tar.gz"
+
+# Where to download the tarball from (at user's request) if we don't have it.
+# If you want to disable this functionality, set this to an empty string.
+ROOT_FS_URL="https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/armhf_root_fs.tar.gz"
-- 
2.12.2.762.g0e3151a226-goog

