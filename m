Received: from mail-pf0-f195.google.com ([209.85.192.195]:38352 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdHGTza (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2017 15:55:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id h75so1276386pfh.5
        for <fstests@vger.kernel.org>; Mon, 07 Aug 2017 12:55:29 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/4] xfstests-bld: allow overriding chroot for do-all
Date: Mon,  7 Aug 2017 12:52:54 -0700
Message-Id: <20170807195257.61176-2-ebiggers3@gmail.com>
In-Reply-To: <20170807195257.61176-1-ebiggers3@gmail.com>
References: <20170807195257.61176-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add a --chroot argument to do-all to allow easily setting the needed
BUILD_ENV and SUDO_ENV when building or updating a test appliance.  This
is useful to allow building both kvm-xfstests and android-xfstests test
appliances without having to edit config.custom, e.g:

   # build a root_fs.img for kvm-xfstests
   ./do-all --chroot=jessie-i386 --no-out-tar

   # build a root_fs.tar.gz for android-xfstests
   ./do-all --chroot=jessie-armhf --out-tar

As more complexity is being added to do-all, also take the opportunity
to add an --update option and make the do-update script just call
through to 'do-all --update'.  This makes it so that new logic doesn't
have to be duplicated in both scripts.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 config    |  14 ++++----
 do-all    | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
 do-update |  11 +-----
 3 files changed, 100 insertions(+), 38 deletions(-)

diff --git a/config b/config
index c4880f3..e69530f 100644
--- a/config
+++ b/config
@@ -23,15 +23,15 @@ XFSPROGS_COMMIT=v4.11.0-rc1
 EXEC_LDFLAGS=-static
 EXEC_LLDFLAGS=-all-static
 
-# Use these to build in a debian chroot
-#
-#BUILD_ENV="schroot -c jessie --"
-#SUDO_ENV="schroot -c jessie -u root --"
-
 BUILD_ENV=
 SUDO_ENV=sudo
+# Uncomment these to make the do-all script use the specified
+# Debian chroot by default
+#
+#BUILD_ENV="schroot -c jessie-amd64 --"
+#SUDO_ENV="schroot -c jessie-amd64 -u root --"
 
-# Uncomment this to make the do-all script build the
-# chroot tarball by default
+# Uncomment this to make the do-all script build a
+# root_fs.tar.gz by default rather than a root_fs.img
 #
 # OUT_TAR=yes
diff --git a/do-all b/do-all
index d6b8169..0490555 100755
--- a/do-all
+++ b/do-all
@@ -1,35 +1,106 @@
 #!/bin/bash
+#
+# do-all - build or update a test appliance
+#
+# For details, see usage() and Documentation/building-rootfs.md
 
-set -e
+set -e -u
+
+OUT_TAR=
+BUILD_ENV=
+SUDO_ENV=sudo
 
 if test -f config.custom ; then
-	. config.custom
+    . config.custom
 else
-	. config
+    . config
+fi
+
+usage()
+{
+    cat <<EOF
+Usage: do-all [OPTION]...
+Build or update a test appliance.
+
+Options:
+    --chroot=CHROOT Use the specified build chroot, where CHROOT is the chroot
+                    name in /etc/schroot/schroot.conf, e.g. "jessie-amd64".
+    --out-tar       Build a root_fs.tar.gz, not a root_fs.img
+    --no-out-tar    Build/update a root_fs.img, not a root_fs.tar.gz
+    --update        Update only; don't do a clean build.  (Only supported with
+                    .img output currently.)
+EOF
+}
+
+UPDATE=false
+
+longopts="help"
+longopts+=",chroot:"
+longopts+=",out-tar"
+longopts+=",no-out-tar"
+longopts+=",update"
+
+if ! options=$(getopt -o "" -l "$longopts" -- "$@"); then
+    usage 1>&2
+    exit 2
 fi
 
-while [ "$1" != "" ]; do
-    case $1 in
-	--out-tar)
-	    OUT_TAR=yes
-	    ;;
-	--no-out-tar)
-	    OUT_TAR=
-	    ;;
-	*)
-	    echo "usage: do-all [--out-tar]"
-	    exit 1
-	    ;;
+eval set -- "$options"
+while (( $# >= 0 )); do
+    case "$1" in
+    --help)
+	usage
+	exit 0
+	;;
+    --chroot)
+	BUILD_ENV="schroot -c $2 --"
+	SUDO_ENV="schroot -c $2 -u root --"
+	shift
+	;;
+    --out-tar)
+	OUT_TAR=yes
+	;;
+    --no-out-tar)
+	OUT_TAR=
+	;;
+    --update)
+	UPDATE=true
+	;;
+    --)
+	shift
+	break
+	;;
+    *)
+	echo 1>&2 "Invalid option: \"$1\""
+	usage 1>&2
+	exit 2
+	;;
     esac
     shift
 done
 
-$BUILD_ENV make clean
-$BUILD_ENV make
+if $UPDATE && [ "$OUT_TAR" = "yes" ]; then
+    echo 1>&2 "--update is only supported with .img output currently!"
+    exit 1
+fi
+
+gen_image_args=
+
+if $UPDATE; then
+    $BUILD_ENV ./update-all
+    gen_image_args+=" --update"
+else
+    $BUILD_ENV make clean
+    $BUILD_ENV make
+fi
 $BUILD_ENV make tarball
-cd kvm-xfstests/test-appliance
-if test "$OUT_TAR" = "yes" ; then
-    $BUILD_ENV ./gen-image --out-tar
+
+if [ "$OUT_TAR" = "yes" ]; then
+    gen_image_args+=" --out-tar"
+    gen_image_env=$BUILD_ENV
 else
-    $SUDO_ENV ./gen-image
+    gen_image_env=$SUDO_ENV
 fi
+
+cd kvm-xfstests/test-appliance
+$gen_image_env ./gen-image $gen_image_args
diff --git a/do-update b/do-update
index ef5a3a0..7605fd7 100755
--- a/do-update
+++ b/do-update
@@ -1,12 +1,3 @@
 #!/bin/bash
 
-if test -f config.custom ; then
-	. config.custom
-else
-	. config
-fi
-
-$BUILD_ENV ./update-all
-$BUILD_ENV make tarball
-cd kvm-xfstests/test-appliance
-$SUDO_ENV ./gen-image --update
+exec "$(dirname "$0")"/do-all --update "$@"
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

