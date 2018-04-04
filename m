Received: from mail-pl0-f65.google.com ([209.85.160.65]:32816 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754966AbeDDAO4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Apr 2018 20:14:56 -0400
Received: by mail-pl0-f65.google.com with SMTP id s10-v6so9468098plp.0
        for <fstests@vger.kernel.org>; Tue, 03 Apr 2018 17:14:56 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [xfstests-bld PATCH] gen-image: fix running in a foreign build chroot
Date: Tue,  3 Apr 2018 17:14:21 -0700
Message-Id: <20180404001421.81698-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Building an android-xfstests test appliance on x86_64 with the
documented command (e.g. './do-all --chroot=stretch-arm64 --out-tar') no
longer works.  The problem is that when the gen-image script is run in a
foreign build chroot, it incorrectly considers the root_fs's chroot to
be a "native" chroot and doesn't copy the needed /usr/bin/qemu-*-static
binary into it.  This is because both 'uname -m' and 'dpkg
--print-architecture' will return the same architecture (the foreign
one), so is_native_chroot() returns true.

This did used to work, but I think it stopped working with 5c76a88c0e57
("test-appliance: improve image generation for chroot tar files")
because previously it was using 'fakechroot' which doesn't actually
change the real root directory, so the /usr/bin directory stayed the
same from the kernel's perspective.  But now it uses real chroot.

Fix this by detecting a foreign build chroot by instead mounting
binfmt_misc and checking whether there is an entry for qemu-$(uname -m).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/gen-image | 58 +++++++++++++++------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/kvm-xfstests/test-appliance/gen-image b/kvm-xfstests/test-appliance/gen-image
index bba7e88..8d4bebb 100755
--- a/kvm-xfstests/test-appliance/gen-image
+++ b/kvm-xfstests/test-appliance/gen-image
@@ -8,7 +8,6 @@ SUITE=stretch
 MIRROR=http://mirrors.kernel.org/debian
 DIR=$(pwd)
 ROOTDIR=$DIR/rootdir
-#ARCH="--arch=i386"
 RAW_ROOT_FS=$DIR/root_fs.raw
 ROOT_FS=$DIR/root_fs.img
 COMPAT="-o compat=0.10"
@@ -21,18 +20,6 @@ if test -r config.custom ; then
    . $(pwd)/config.custom
 fi
 
-is_native_chroot()
-{
-    DEBIAN_ARCH="$(dpkg --print-architecture)"
-    case "$(uname -m)" in
-    x86_64)	[[ $DEBIAN_ARCH = amd64 || $DEBIAN_ARCH = i386 ]] ;;
-    aarch64)	[[ $DEBIAN_ARCH = arm64 || $DEBIAN_ARCH = armhf ]] ;;
-    arm)	[[ $DEBIAN_ARCH = armhf ]] ;;
-    ppc64le)	[[ $DEBIAN_ARCH = ppc64el ]] ;;
-    *)		[[ $DEBIAN_ARCH = "$(uname -m)" ]] ;;
-    esac
-}
-
 while [ "$1" != "" ]; do
   case $1 in
     --save_raw_root)
@@ -215,20 +202,39 @@ if test $DO_UPDATE = "yes" ; then
    exit 0
 fi
 
-if ! is_native_chroot ; then
-    case "$DEBIAN_ARCH" in
-	armhf)		QEMU=/usr/bin/qemu-arm-static ;;
-	arm64)		QEMU=/usr/bin/qemu-aarch64-static ;;
-	ppc64el)	QEMU=/usr/bin/qemu-ppc64le-static ;;
-	*)		QEMU="/usr/bin/qemu-$DEBIAN_ARCH-static" ;;
-    esac
-    if ! test -x $QEMU ; then
-	echo "Can't find qemu interpreter for non-native gen-image"
-#	cleanup_on_abort
-#	exit 1
+detect_foreign_chroot()
+{
+    local BINFMT_MISC_MNT=/proc/sys/fs/binfmt_misc
+
+    if [ ! -d "$BINFMT_MISC_MNT" ]; then
+	# binfmt_misc disabled in kernel
+	return
+    fi
+
+    if ! mountpoint "$BINFMT_MISC_MNT" &>/dev/null; then
+	mount binfmt_misc -t binfmt_misc "$BINFMT_MISC_MNT"
+	trap "umount \"$BINFMT_MISC_MNT\"" EXIT
     fi
+
+    if [ "$(<"$BINFMT_MISC_MNT/status")" = "disabled" ]; then
+	return
+    fi
+
+    local binfmt="qemu-$(uname -m)"
+    local binfmt_file="$BINFMT_MISC_MNT/$binfmt"
+
+    if [ ! -e "$binfmt_file" ]; then
+	return
+    fi
+
+    QEMU="$(awk '/^interpreter/{print $2}' "$binfmt_file")"
     FOREIGN="--foreign"
-fi
+    echo "Detected foreign chroot, using user-mode emulation with $QEMU"
+}
+
+QEMU=
+FOREIGN=
+detect_foreign_chroot
 
 mkdir -p var.cache.apt.archives
 mkdir -p var.lib.apt.lists
@@ -255,7 +261,7 @@ else
    export FAKECHROOT_CMD_SUBST=/usr/bin/chfn=/bin/true
 fi
 trap cleanup_on_abort INT TERM
-debootstrap --variant=minbase --include=$PACKAGES $EXCLUDE $ARCH \
+debootstrap --variant=minbase --include=$PACKAGES $EXCLUDE \
 	    $FOREIGN $SUITE $ROOTDIR $MIRROR $DIR/debootstrap.script
 if test $? -ne 0 ; then
     echo "Deboostrap failed, aborting."
-- 
2.17.0.484.g0c8726318c-goog

