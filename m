Received: from mail-pf0-f196.google.com ([209.85.192.196]:33685 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdGZATm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2017 20:19:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id k72so10659745pfj.0
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2017 17:19:41 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/2] android-xfstests: support specifying a kernel to boot
Date: Tue, 25 Jul 2017 17:18:37 -0700
Message-Id: <20170726001838.80452-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Update android-xfstests to support specifying a kernel with KERNEL in
~/.config/android-xfstests or --kernel on the command line, similar to
kvm-xfstests and gce-xfstests.  If it's not already running, the kernel
is booted using the 'fastboot boot' command.  This unfortunately doesn't
work on all devices, but it should still be useful to have.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/android-xfstests | 223 +++++++++++++++++++++++++++++++++++++-----
 kvm-xfstests/config.android   |   5 +
 kvm-xfstests/util/parse_cli   |   5 +-
 3 files changed, 204 insertions(+), 29 deletions(-)

diff --git a/kvm-xfstests/android-xfstests b/kvm-xfstests/android-xfstests
index 6d41540..8e5b77c 100755
--- a/kvm-xfstests/android-xfstests
+++ b/kvm-xfstests/android-xfstests
@@ -50,27 +50,56 @@ die()
 ask_yesno()
 {
     local response
-    echo -n -e "$@ (y/n) "
+    echo -n -e "$@ (y/N) "
     read response
     if [ "$response" != y ]; then
 	exit 1
     fi
 }
 
+adb_ready()
+{
+    adb devices | grep -q 'device$'
+}
+
+fastboot_ready()
+{
+    fastboot devices | grep -q 'fastboot$'
+}
+
 wait_for_device()
 {
+    local want_adb=false
+    local want_fastboot=false
+    local waiting_for=""
     local unauthorized=false
     local waiting=false
+
+    if [[ ,$1, == *,adb,* ]]; then
+	want_adb=true
+	waiting_for="adb to be ready"
+    fi
+    if [[ ,$1, == *,fastboot,* ]]; then
+	want_fastboot=true
+	waiting_for+="${waiting_for:+ or for }device to enter fastboot mode"
+    fi
+    : "${waiting_for:=device}"
+
     while true; do
-	if adb devices | grep -q 'device$'; then
-	    break
+	if $want_adb; then
+	    if adb_ready; then
+		break
+	    fi
+	    if ! $unauthorized && adb devices | grep -q 'unauthorized$'; then
+		echo "adb is not authorized.  Authorize it using the dialog on the device to continue."
+		unauthorized=true
+	    fi
 	fi
-	if adb devices | grep -q 'unauthorized$' && ! $unauthorized; then
-	    echo "adb is not authorized.  Authorize it using the dialog on the device to continue."
-	    unauthorized=true
+	if $want_fastboot && fastboot_ready; then
+	    return
 	fi
 	if ! $waiting && ! $unauthorized; then
-	    echo "Waiting for device..."
+	    echo "Waiting for $waiting_for..."
 	    waiting=true
 	fi
 	sleep 0.5
@@ -83,6 +112,115 @@ wait_for_device()
     adb shell "setenforce 0"
 }
 
+wait_for_adb()
+{
+    wait_for_device adb
+}
+
+wait_for_fastboot()
+{
+    wait_for_device fastboot
+}
+
+wait_for_adb_or_fastboot()
+{
+    wait_for_device adb,fastboot
+}
+
+reboot_into_fastboot_mode()
+{
+    adb reboot bootloader
+    wait_for_fastboot
+}
+
+# Query the version of the kernel running on the device
+query_kernel_version()
+{
+    adb shell "uname -r -v"
+}
+
+# Try to extract the version information from the $KERNEL image by grepping for
+# the linux_banner[] string.  It's a hack, but there doesn't seem to be a better
+# way, and scripts elsewhere supposedly have been doing this for a long time...
+extract_kernel_version()
+{
+    local decompress
+
+    # Note: we use the filename extension rather than the 'file' program to get
+    # the compression format because old versions of 'file' don't recognize
+    # LZ4-compressed files.
+    case "$(basename "$KERNEL")" in
+    Image.gz*)
+	decompress="gzip -d -c"
+	;;
+    Image.bz2*)
+	decompress="bzip2 -d -c"
+	;;
+    Image.xz*)
+	decompress="xz -d -c"
+	;;
+    Image.lz4*)
+	decompress="lz4 -d" # no -c option; stdout is assumed when not a tty
+	;;
+    *)
+	decompress="cat"
+	;;
+    esac
+    local banner="$($decompress "$KERNEL" \
+	| grep -a -m1 'Linux version [0-9]\+\.[0-9]\+.*#.*$')"
+
+    if [ -n "$banner" ]; then
+	local krelease="$(echo "$banner" | awk '{print $3}')"
+	local kver="#${banner##*#}"
+	echo "$krelease $kver"
+    fi
+}
+
+# If the specified $KERNEL isn't already running on the device, try to boot it
+# using 'fastboot boot'.
+boot_kernel()
+{
+    local version actual_version
+    local have_version=true
+
+    if [ ! -f "$KERNEL" ]; then
+	die "The specified kernel image does not exist: $KERNEL"
+    fi
+
+    version="$(extract_kernel_version "$KERNEL")"
+    if [ -z "$version" ]; then
+	cat 1>&2 <<EOF
+Warning: unable to extract version information from $KERNEL.
+We won't be able to verify that the device has successfully booted the kernel!
+EOF
+	version="(unknown version)"
+	have_version=false
+    fi
+
+    wait_for_adb_or_fastboot
+    if adb_ready; then
+	actual_version="$(query_kernel_version)"
+	if $have_version && [ "$version" = "$actual_version" ]; then
+	    # Kernel is already running.
+	    return
+	fi
+	echo "Rebooting to start new kernel: $version"
+	stop_existing_tests
+	reboot_into_fastboot_mode
+    else
+	echo "Starting kernel: $version"
+    fi
+    fastboot boot "$KERNEL"
+    wait_for_adb
+
+    actual_version="$(query_kernel_version)"
+    if $have_version && [ "$version" != "$actual_version" ]; then
+	 die "Kernel did not successfully boot!\n" \
+	     "Expected: $version\n" \
+	     "Actual: $actual_version\n"
+    fi
+}
+
 chroot_prepare()
 {
     cat <<EOF | adb shell
@@ -203,10 +341,9 @@ a smaller size?  WARNING: THIS WILL DELETE ALL USER DATA!
 
 EOF
     ask_yesno "    Erase and reformat userdata with smaller size?"
-    adb reboot bootloader
+    echo
+    reboot_into_fastboot_mode
     fastboot format::0x100000000 userdata # 4 GiB
-    fastboot continue
-    wait_for_device
 }
 
 setup_partitions()
@@ -222,12 +359,7 @@ setup_partitions()
     ready)
 	;;
     shrink_userdata)
-	if [ "$1" = second_try ]; then
-	    die "An unexpected problem occurred when shrinking userdata."
-	fi
-	try_shrink_userdata
-	setup_chroot
-	setup_partitions second_try
+	return 1
 	;;
     insufficient_space)
 	die "This device doesn't have enough space on its internal storage to run android-xfstests."
@@ -236,6 +368,7 @@ setup_partitions()
 	die "An unexpected problem occurred while setting up the xfstests partitions."
 	;;
     esac
+    return 0
 }
 
 xfstests_running()
@@ -273,20 +406,60 @@ if ! type -P fastboot > /dev/null ; then
     die "fastboot is not installed"
 fi
 
-wait_for_device
-setup_chroot
-if ! xfstests_running; then
-    setup_partitions first_try
-fi
-
 case "$ARG" in
     cmd=shell*|cmd=maint*)
-	chroot_interactive_shell
-	exit 0
+	want_shell=true
+	;;
+    *)
+	want_shell=false
+	if adb_ready; then
+	    stop_existing_tests
+	fi
 	;;
 esac
 
-stop_existing_tests
+# Set up the kernel, the chroot, and the xfstests partitions.
+
+tried_to_shrink_userdata=false
+while true; do
+
+    # Start by booting into the correct kernel.
+    if [ -n "$KERNEL" ]; then
+	boot_kernel
+    elif fastboot_ready; then
+	fastboot continue
+    fi
+
+    wait_for_adb
+
+    # Set up the chroot and xfstests partitions.  Note: if an interactive shell
+    # is requested and tests are currently running, we won't mess around with
+    # the partitions.  However, we'll still try to set up the chroot just in
+    # case a different ROOT_FS was specified (in which case the existing tests
+    # will need to be stopped).
+    setup_chroot
+    if $want_shell && xfstests_running; then
+	break
+    fi
+    if setup_partitions; then
+	break
+    fi
+
+    # Need to shrink userdata to make space for the xfstests partitions!
+    if $tried_to_shrink_userdata; then
+	die "An unexpected problem occurred when shrinking userdata."
+    fi
+    try_shrink_userdata
+    tried_to_shrink_userdata=true
+
+    # 'userdata' has just been formatted and the device is now in fastboot mode.
+    # Start the configuration over again.
+done
+
+if $want_shell; then
+    chroot_interactive_shell
+    exit 0
+fi
 
 cat > "$tmpfile" <<EOF
 #!/bin/bash
diff --git a/kvm-xfstests/config.android b/kvm-xfstests/config.android
index ed7098c..1db38a5 100644
--- a/kvm-xfstests/config.android
+++ b/kvm-xfstests/config.android
@@ -10,3 +10,8 @@ ROOT_FS="$DIR/test-appliance/armhf_root_fs.tar.gz"
 # Where to download the tarball from (at user's request) if we don't have it.
 # If you want to disable this functionality, set this to an empty string.
 ROOT_FS_URL="https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/armhf_root_fs.tar.gz"
+
+# Path to the kernel which android-xfstests will boot on the device using
+# 'fastboot boot', if it's not already running.  This can also be set by the
+# --kernel option.  If unset or empty, the existing kernel will be used.
+#KERNEL=$HOME/linux/arch/arm64/boot/Image.lz4-dtb
diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
index 874916a..2d6717a 100644
--- a/kvm-xfstests/util/parse_cli
+++ b/kvm-xfstests/util/parse_cli
@@ -51,9 +51,7 @@ print_help ()
     fi
     echo "	-x group	- Exclude group of tests from running"
     echo "	-X test		- Exclude test from running"
-    if flavor_in kvm gce ; then
-	echo "	--kernel file	- Boot the specified kernel"
-    fi
+    echo "	--kernel file	- Boot the specified kernel"
     if flavor_in kvm ; then
 	echo "	--initrd initrd	- Boot with the specified initrd"
     elif flavor_in gce ; then
@@ -282,7 +280,6 @@ while [ "$1" != "" ]; do
 	    SKIP_LOG=no
 	    ;;
 	--kernel) shift
-	    supported_flavors kvm gce
 	    KERNEL="$1"
 	    if test -d "$KERNEL" ; then
 		KERNEL="$KERNEL/arch/x86/boot/bzImage"
-- 
2.14.0.rc0.400.g1c36432dff-goog

