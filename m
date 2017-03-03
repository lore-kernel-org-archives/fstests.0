Received: from mail-pf0-f194.google.com ([209.85.192.194]:35298 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdCCCEh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Mar 2017 21:04:37 -0500
Received: by mail-pf0-f194.google.com with SMTP id 67so3952056pfg.2
        for <fstests@vger.kernel.org>; Thu, 02 Mar 2017 18:04:36 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: add an android-xfstests command
Date: Thu,  2 Mar 2017 17:02:38 -0800
Message-Id: <20170303010238.76005-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add a command android-xfstests which has an interface similar to
kvm-xfstests and gce-xfstests, but runs xfstests on the internal storage
of an Android device instead.  It works by setting up temporary
partitions in space freed up by reformatting the userdata filesystem
with a smaller size, then running the tests in a Debian chroot.  More
information can be found in the documentation in android-xfstests.md.

Some features of kvm-xfstests and gce-xfstests, such as selecting the
kernel to use, are not yet implemented for android-xfstests but may be
possible to add later.

So far I have only tested android-xfstests on two devices, but it's
intended to work on other devices too.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .gitignore                                         |   1 +
 Documentation/00-index.md                          |   2 +-
 Documentation/android-xfstests.md                  | 214 +++++++++++----
 Makefile                                           |  15 +-
 kvm-xfstests/android-xfstests                      | 289 +++++++++++++++++++++
 kvm-xfstests/android-xfstests.in                   |   7 +
 kvm-xfstests/config                                |  30 ++-
 kvm-xfstests/gce-xfstests                          |   2 +-
 kvm-xfstests/kvm-xfstests                          |   1 +
 kvm-xfstests/test-appliance/.gitignore             |   1 +
 .../test-appliance/android-setup-partitions        | 221 ++++++++++++++++
 kvm-xfstests/test-appliance/android-test-config    |  13 +
 kvm-xfstests/test-appliance/gce-create-image       |   2 +-
 kvm-xfstests/test-appliance/gce-export-image       |   2 +-
 kvm-xfstests/test-appliance/gce-import-image       |   2 +-
 kvm-xfstests/util/gce-do-setup                     |   2 +-
 kvm-xfstests/util/get-config                       |  23 +-
 kvm-xfstests/util/parse_cli                        | 169 ++++++------
 18 files changed, 824 insertions(+), 172 deletions(-)
 create mode 100755 kvm-xfstests/android-xfstests
 create mode 100644 kvm-xfstests/android-xfstests.in
 create mode 100755 kvm-xfstests/test-appliance/android-setup-partitions
 create mode 100644 kvm-xfstests/test-appliance/android-test-config

diff --git a/.gitignore b/.gitignore
index 96f011a..db604f8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@ config.log
 config.status
 config.custom
 MAKELOG
+/android-xfstests.sh
 /kvm-xfstests/config-*
 /kvm-xfstests.sh
 /gce-xfstests.sh
diff --git a/Documentation/00-index.md b/Documentation/00-index.md
index 335324b..302b137 100644
--- a/Documentation/00-index.md
+++ b/Documentation/00-index.md
@@ -6,7 +6,7 @@ eventually use gce-xfstests.  Also please see the top-level
 [README](../README.md) file for this project.
 
 * [android-xfstests](android-xfstests.md)
-  * Instructions for running xfstests on an Android device
+  * Instructions for using android-xfstests
 * [building-rootfs](building-rootfs.md)
   * Documentation for the gen-image script
 * [building-xfstests](building-xfstests.md)
diff --git a/Documentation/android-xfstests.md b/Documentation/android-xfstests.md
index 7712c8b..b309c21 100644
--- a/Documentation/android-xfstests.md
+++ b/Documentation/android-xfstests.md
@@ -1,55 +1,165 @@
 # Running xfstests on Android
 
-These instructions are still Alpha quality.  They haven't been
-verified, although a developer has reported success following them at
-least roughly.  Sorry, I haven't had a chance to verify them yet.
-
-These instructions assume you have either fetched the
-armhf_root_fs.tar.gz file from
-[kernel.org](http://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests)
-or you have build the armhf_root_fs.tar.gz on a Debian arm build
-server as described in the [building-xfstests](building-xfstests.md)
-documentation file.
-
-1. Set up a USB attached SSD such that it has at least 5 partitions,
-each of them 5GB each.  (You will need to format partitions #1, #2,
-and #5 using "mke2fs -t ext4".)
-
-  Note: you will need to adjust /root/test-config so that settings for
-  VDB, VDC, VDD, and VDG point at partition #2, #3, #4, and #5
-  respectively.
-
-  * Partition #1 --- will contain the chroot directory (unpack root_fs.tar.gz)
-  * Partition #2 --- will contain a "normal" formatted ext4 file system
-  * Partition #3 --- will be used as a scratch partition
-	(will be formatted multiple times, by individual tests)
-  * Partition #4 --- will be used to test non-standard ext4 file systems
-  	(such as ext4 encryption; formatted by runtests.sh)
-  * Partition #5 --- will contain the test results (will be mounted on /results)
-
-2.  Attach the SSD to the Android device with a USB C connector using a
-USB C hub with power delivery.  (Anker makes a good one which is
-available on Amazon.)
-
-3. Build and install a test kernel which has SELinux in permissive mode
-
-4. Mount the chroot partition on the USB attached SSD on /chroot, and
-then set it up as follows:
-
-        mount -t proc proc /chroot/proc
-        mount -t sysfs sysfs /chroot/sys
-        mount --bind /dev /chroot/dev
-        mount /dev/partition#5 /chroot/results
-
-  (note, if you don't have a mount with --bind support, you can also use
-  tar to copy in a /dev into the chroot)
-
-5. To run the tests in the chroot:
-
-        chroot /chroot /bin/bash
-        cd /root
-        . test-env
-        FSTESTCFG=4k,encrypt
-        FSTESTSET="-g auto"
-        ./runtests.sh >& /results/runtests.log
+## Introduction
 
+android-xfstests runs xfstests on the internal storage of an Android
+device, offering an interface similar to
+[kvm-xfstests](kvm-xfstests.md) and [gce-xfstests](gce-xfstests.md).
+It uses adb and fastboot to control the device, and it runs the tests
+in a Debian chroot.  (The chroot is needed for compatibility with
+xfstests and the various helper programs it invokes.)
+android-xfstests should only be run on a device on which you don't
+mind all user data being deleted.
+
+Currently, android-xfstests has only been tested on a small number of
+devices.  If you encounter a problem, please submit a fix!
+
+## Requirements
+
+- The android-xfstests script installed:
+  run `make android-xfstests.sh` in the top-level directory of
+  xfstests-bld, then move android-xfstests.sh to
+  ~/bin/android-xfstests or another location on your $PATH.
+
+- A rooted Android device with sufficient internal storage.  For most
+  test configurations, about 24 GiB of internal storage should be
+  sufficient.  This is the sum of three 5 GiB partitions, a shrunken 4
+  GiB userdata partition, and the various other partitions used by
+  Android devices.  For test configurations requiring large
+  partitions, like bigalloc, you'll need about 64 GiB instead.
+
+- Ability to connect to the Android device with adb and fastboot.
+  Usually this is done via a USB cable.
+
+- An armhf Debian root filesystem set up with xfstests and the
+  xfstests-bld scripts.  Either fetch the prebuilt
+  armhf_root_fs.tar.gz from
+  [kernel.org](http://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests),
+  or build one yourself on a Debian ARM build server as described in
+  [building-xfstests](building-xfstests.md).  Then, either put the
+  chroot tarball in the default location of
+  kvm-xfstests/test-appliance/armhf_root_fs.tar.gz, or specify it with
+  the -I option to android-xfstests.
+
+## Procedure
+
+### (Optional) Build a custom kernel
+
+You may be able to run xfstests with the kernel already installed on
+your device, but you may wish to build your own kernel instead.  The
+exact procedure for building the kernel is device-dependent, but here
+are example commands for building a kernel using the public source
+code for the Google Pixel phone (2016 edition), code name "marlin":
+
+    git clone https://android.googlesource.com/kernel/msm msm-linux
+    cd msm-linux
+    git checkout android-msm-marlin-3.18-nougat-mr1
+    export CROSS_COMPILE=aarch64-linux-android-
+    export ARCH=arm64
+    make marlin_defconfig
+    make -j$(grep -c processor /proc/cpuinfo)
+
+This will produce a kernel image arch/arm64/boot/Image.gz-dtb.
+
+Also consider the following config options:
+
+    CONFIG_SYSV_IPC=y
+        Makes some tests using dm-setup stop failing.
+
+    CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n
+        Include crypto self-tests.  This may be useful if you are
+        using xfstests to test file-based encryption.
+
+### (Optional) Boot into your custom kernel
+
+To boot into your new kernel, you'll first need to reboot your device
+into fastboot mode by running 'adb reboot-bootloader' or by holding a
+device-dependent key combination (e.g. Power + Vol-Down on the Pixel).
+Then do *one* of the following:
+
+- Run 'fastboot boot arch/arm64/boot/Image.gz-dtb' to boot the kernel
+  directly.  Careful: this is good for one boot only (it's not
+  persistent), and it doesn't work on all devices.
+
+- Build and flash a boot.img to your device's boot partition.  This is
+  device-dependent, but for "marlin" devices one would copy
+  arch/arm64/boot/Image.gz-dtb into device/google/marlin-kernel/ in
+  the Android source tree, then run the following commands from the
+  root of the Android source tree:
+
+    . build/envsetup.sh
+    lunch marlin-userdebug
+    make -j16 bootimage
+    fastboot flash boot out/target/product/marlin/boot.img
+    fastboot continue
+
+### Running tests
+
+To run tests, first ensure your device is connected with adb, then run
+a command like the following:
+
+    android-xfstests -c 4k -g auto
+
+The options accepted by android-xfstests are generally the same as
+those accepted by [kvm-xfstests](kvm-xfstests.md).  However, some
+options do not apply or are not yet implemented.
+
+If you have never before run android-xfstests on the device, then
+android-xfstests will first need to resize the userdata filesystem to
+make room for the xfstests partitions.  Currently, this is implemented
+by rebooting into fastboot mode and reformatting the userdata
+filesystem.  Since this causes all user data to be wiped,
+android-xfstests will ask for confirmation before doing this.
+
+## Known issues
+
+android-xfstests doesn't yet do kernel installation; you have to do
+that yourself.
+
+Terminating android-xfstests with Ctrl-C doesn't stop the test process
+on the device.
+
+'android-xfstests shell' gives you a shell, but not in the chroot.
+
+Android devices usually run an older version of the Linux kernel.  At
+the same time, xfstests is constantly being updated to add new tests.
+Therefore, you can expect there to be a significant number of failing
+tests due to bugs.  Some tests may even cause a kernel crash or
+deadlock and will need to be excluded with -X in order for the test
+run to complete.  Note, however, that bugs reproduced by xfstests are
+not necessarily reachable by unprivileged users (though they can be!).
+
+Tests which create loopback or device-mapper devices currently fail
+because the corresponding device nodes do not get automatically
+created on Android.
+
+Any test that requires non-root users currently fails because xfstests
+incorrectly thinks that YP/NIS is enabled.
+
+On recent versions of Android, all new files inherit SELinux xattrs.
+This confuses generic/062 and generic/377 and causes them to fail.
+
+generic/240 and tests using dmsetup fail on kernels configured without
+SysV IPC support, which includes most Android kernels.
+
+generic/004 fails because of glibc bug
+https://sourceware.org/bugzilla/show_bug.cgi?id=17912.
+
+## Resetting userdata
+
+The partitions set up by android-xfstests are transient, so they will
+not show up in the device's on-disk partition table or fstab, and they
+will go away after reboot.  However, the reformatting of the userdata
+filesystem with a smaller size to free up space is persistent.  If you
+are done running xfstests and wish to expand userdata to take up its
+full partition again, then reboot into fastboot mode and run 'fastboot
+-w' to wipe and reformat userdata again, this time with the full size.
+
+## Other notes
+
+Note that xfstests does pretty heavy I/O.  It is also possible to run
+xfstests on external storage, e.g. on a USB-attached SSD.  However,
+android-xfstests currently only supports internal storage because it
+is easier to automate, requires less hardware, and is more
+representative of how the device will actually be used; for example,
+hardware-specific features can be tested.
diff --git a/Makefile b/Makefile
index f5a90af..f5e2245 100644
--- a/Makefile
+++ b/Makefile
@@ -16,18 +16,17 @@ SUBDIRS =	acl \
 		xfsprogs-dev \
 		xfstests-dev
 
-all: xfsprogs-dev xfstests-dev fio quota \
-	gce-xfstests.sh kvm-xfstests.sh
+SCRIPTS =	android-xfstests.sh \
+		gce-xfstests.sh \
+		kvm-xfstests.sh
+
+all: xfsprogs-dev xfstests-dev fio quota $(SCRIPTS)
 	./build-all
 
 xfsprogs-dev xfstests-dev fio quota:
 	./get-all
 
-gce-xfstests.sh: kvm-xfstests/gce-xfstests.in
-	sed -e "s;@DIR@;$$(pwd);" < $< > $@
-	chmod +x $@
-
-kvm-xfstests.sh: kvm-xfstests/kvm-xfstests.in
+$(SCRIPTS): %.sh: kvm-xfstests/%.in
 	sed -e "s;@DIR@;$$(pwd);" < $< > $@
 	chmod +x $@
 
@@ -38,7 +37,7 @@ clean:
 	done
 	make -C xfsprogs-dev realclean
 	rm -rf bld xfstests
-	rm -f kvm-xfstests/util/zerofree gce-xfstests.sh kvm-xfstests.sh
+	rm -f kvm-xfstests/util/zerofree $(SCRIPTS)
 
 kvm-xfstests/util/zerofree: kvm-xfstests/util/zerofree.c
 	cc -static -o $@ $< -lext2fs -lcom_err -lpthread
diff --git a/kvm-xfstests/android-xfstests b/kvm-xfstests/android-xfstests
new file mode 100755
index 0000000..7e3eab3
--- /dev/null
+++ b/kvm-xfstests/android-xfstests
@@ -0,0 +1,289 @@
+#!/bin/bash
+
+set -e -o pipefail
+
+XFSTESTS_FLAVOR=android
+DIR=.
+if [ -n "$ANDROID_XFSTESTS_DIR" ]; then
+    DIR="$ANDROID_XFSTESTS_DIR"
+fi
+
+. "$DIR/util/get-config"
+
+# Path to chroot tarball; can be overridden with -I
+ROOT_FS="$DIR/test-appliance/armhf_root_fs.tar.gz"
+
+# Where to download the tarball from (at user's request) if we don't have it
+ROOT_FS_URL="https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/armhf_root_fs.tar.gz"
+
+# Chroot directory on device.
+# Note: this will be wiped clean when deploying a new chroot tarball.
+CHROOT_DIR="/data/xfstests-chroot"
+
+# Results directory.
+RESULTS_DIR="/data/xfstests-results"
+
+. "$DIR/util/parse_cli"
+
+if test -n "$SKIP_LOG" ; then
+    LOGFILE=/tmp/log.$(date +%Y%m%d%H%M)
+else
+    mkdir -p "$DIR/logs"
+    LOGFILE="$DIR/logs/log.$(date +%Y%m%d%H%M)"
+fi
+
+die()
+{
+    echo -e 1>&2 "[ERROR] android-xfstests: $*"
+    exit 1
+}
+
+ask_yesno()
+{
+    local response
+    echo -n -e "$@ (y/n) "
+    read response
+    if [ "$response" != y ]; then
+	exit 1
+    fi
+}
+
+wait_for_device()
+{
+    local unauthorized=false
+    local waiting=false
+    while true; do
+	if adb devices | grep -q 'device$'; then
+	    break
+	fi
+	if adb devices | grep -q 'unauthorized$' && ! $unauthorized; then
+	    echo "adb is not authorized.  Authorize it using the dialog on the device to continue."
+	    unauthorized=true
+	fi
+	if ! $waiting && ! $unauthorized; then
+	    echo "Waiting for device..."
+	    waiting=true
+	fi
+	sleep 0.5
+    done
+
+    # Make sure adbd is running as root and that SELinux is in permissive mode.
+    if ! adb root > /dev/null ; then
+	die "Unable to restart adbd as root on the device.  Maybe your device is not rooted?"
+    fi
+    adb shell "setenforce 0"
+}
+
+chroot_prepare()
+{
+    cat <<EOF | adb shell
+! mountpoint $CHROOT_DIR/sys > /dev/null && mount sysfs -t sysfs $CHROOT_DIR/sys
+! mountpoint $CHROOT_DIR/proc > /dev/null && mount proc -t proc $CHROOT_DIR/proc
+! mountpoint $CHROOT_DIR/dev > /dev/null && mount --bind /dev $CHROOT_DIR/dev
+
+# 'mountpoint' doesn't work with directory bind mounts; use /proc/mounts instead
+if ! cut -d' ' -f2 /proc/mounts 2>/dev/null | grep -q '^$CHROOT_DIR/results$'; then
+    mkdir -p $RESULTS_DIR
+    mount --bind $RESULTS_DIR $CHROOT_DIR/results
+fi
+EOF
+}
+
+chroot_wipe()
+{
+    cat <<EOF | adb shell
+umount $CHROOT_DIR/sys &> /dev/null
+umount $CHROOT_DIR/proc &> /dev/null
+umount $CHROOT_DIR/dev &> /dev/null
+umount $CHROOT_DIR/results &> /dev/null
+rm -rf $CHROOT_DIR
+mkdir $CHROOT_DIR
+EOF
+}
+
+CHROOT_CMD="HOME=/root TMPDIR=/tmp chroot $CHROOT_DIR"
+
+chroot_run()
+{
+    adb shell "$CHROOT_CMD /bin/bash -c \"$*\""
+}
+
+chroot_interactive_shell()
+{
+    echo "Run '$CHROOT_CMD /bin/bash' to enter the chroot."
+    adb shell
+
+    # TODO: figure out how to enter the chroot automatically and still have an
+    # interactive shell
+    #stty raw -echo
+    #( echo "$CHROOT_CMD /bin/bash -i" && cat) | adb shell
+    #stty sane
+}
+
+setup_chroot()
+{
+    if ! [ -f "$ROOT_FS" ]; then
+	echo "The xfstests chroot tarball does not exist:"
+	echo "        $ROOT_FS"
+	ask_yesno "Would you like to download the latest public tarball to that location?"
+	wget -O "$ROOT_FS" "$ROOT_FS_URL"
+	echo "Finished downloading chroot tarball."
+    fi
+    local old_md5sum="$(adb shell '[ -e '$CHROOT_DIR'/chroot_md5sum ] &&
+					cat '$CHROOT_DIR'/chroot_md5sum')"
+    local new_md5sum="$(md5sum "$ROOT_FS" | cut -d' ' -f1)"
+    if [ "$old_md5sum" = "$new_md5sum" ]; then
+	chroot_prepare
+	return 0
+    fi
+
+    echo "Deploying chroot tarball to device (path=$ROOT_FS, md5sum=$new_md5sum)..."
+    stop_existing_tests
+    chroot_wipe
+
+    # If the chroot tarball is in .tar.xz format, then decompress it host-side,
+    # since Android devices don't usually include the xz program.
+    local srcfile="$ROOT_FS"
+    local decompress="cat"
+    if file "$ROOT_FS" | grep -q '\<XZ compressed\>'; then
+	xz -d -c "$ROOT_FS" > "$tmpfile"
+	srcfile="$tmpfile"
+    elif file "$ROOT_FS" | grep -q '\<gzip compressed\>'; then
+	decompress="gzip -d -c"
+    fi
+
+    local destfile=$CHROOT_DIR/"$(basename "$ROOT_FS")"
+    adb push "$srcfile" "$destfile"
+    cat <<EOF | adb shell
+$decompress "$destfile" | tar -C $CHROOT_DIR -x
+mv $CHROOT_DIR/root/test-config $CHROOT_DIR/root/test-config.orig
+echo $new_md5sum > $CHROOT_DIR/chroot_md5sum
+EOF
+    adb push "$DIR/test-appliance/android-test-config" "$CHROOT_DIR/root/test-config"
+    chroot_prepare
+}
+
+try_shrink_userdata()
+{
+    cat <<EOF
+
+It seems you haven't run android-xfstests on this device yet, so
+there isn't any space for the xfstests partitions.  Would you like
+to make space for them by reformatting the userdata filesystem with
+a smaller size?  WARNING: THIS WILL DELETE ALL USER DATA!
+
+EOF
+    ask_yesno "    Erase and reformat userdata with smaller size?"
+    adb reboot bootloader
+    fastboot format::0x100000000 userdata # 4 GiB
+    fastboot continue
+    wait_for_device
+}
+
+setup_partitions()
+{
+    adb push $DIR/test-appliance/android-setup-partitions \
+	    $CHROOT_DIR/setup-partitions > /dev/null
+    adb shell "rm -f $CHROOT_DIR/setup-partitions-result"
+    chroot_run /setup-partitions
+    echo "unknown" > "$tmpfile"
+    adb pull $CHROOT_DIR/setup-partitions-result "$tmpfile" &> /dev/null || true
+    local result="$(<"$tmpfile")"
+    case "$result" in
+    ready)
+	;;
+    shrink_userdata)
+	if [ "$1" = second_try ]; then
+	    die "An unexpected problem occurred when shrinking userdata."
+	fi
+	try_shrink_userdata
+	setup_chroot
+	setup_partitions second_try
+	;;
+    insufficient_space)
+	die "This device doesn't have enough space on its internal storage to run android-xfstests."
+	;;
+    *)
+	die "An unexpected problem occurred while setting up the xfstests partitions."
+	;;
+    esac
+}
+
+# If xfstests is already running, ask the user if they want to terminate it
+stop_existing_tests()
+{
+    local existing=$(adb shell 'pgrep runtests\.sh')
+    if [ -z "$existing" ]; then
+	return 0
+    fi
+    ask_yesno "xfstests is already running!  Terminate it?"
+    adb shell "pkill -f \"bash \./check\""
+    local start=$(date +%s)
+    while (( $(date +%s) <= start + 10 )); do
+	local existing=$(adb shell 'pgrep runtests\.sh')
+	if [ -z "$existing" ]; then
+	    return 0
+	fi
+	sleep 1
+    done
+    die "Failed to stop existing xfstests instance."
+}
+
+tmpfile="$(mktemp)"
+trap "rm -f \"$tmpfile\"" EXIT
+
+if ! type -P adb > /dev/null;  then
+    die "adb is not installed"
+fi
+
+if ! type -P fastboot > /dev/null ; then
+    die "fastboot is not installed"
+fi
+
+wait_for_device
+setup_chroot
+
+case "$ARG" in
+    cmd=shell*|cmd=maint*)
+	chroot_interactive_shell
+	exit 0
+	;;
+esac
+
+stop_existing_tests
+setup_partitions first_try
+
+cat > "$tmpfile" <<EOF
+#!/bin/bash
+
+cd /root
+. test-config
+
+export FSTESTAPI="$(echo $API | sed -e 's/\./ /g')"
+export FSTESTCFG="$(echo $FSTESTCFG | sed -e 's/,/ /g')"
+export FSTESTSET="$(echo $FSTESTSET | sed -e 's/,/ /g')"
+export FSTESTOPT="$(echo $FSTESTOPT | sed -e 's/,/ /g')"
+export FSTESTTYP="$PRIMARY_FSTYPE"
+export MNTOPTS="$MNTOPTS"
+export FSTESTEXC="$(echo $FSTESTEXC | sed -e 's/,/ /g')"
+
+umount \$PRI_TST_MNT &> /dev/null
+umount \$SM_TST_MNT &> /dev/null
+umount \$SM_SCR_MNT &> /dev/null
+umount \$LG_TST_MNT &> /dev/null
+umount \$LG_SCR_MNT &> /dev/null
+
+./runtests.sh
+EOF
+adb push "$tmpfile" $CHROOT_DIR/run-xfstests > /dev/null
+adb shell "chmod +x $CHROOT_DIR/run-xfstests"
+
+chroot_run /run-xfstests |& tee $LOGFILE
+
+$DIR/get-results $LOGFILE
+
+if test -n "$SKIP_LOG" ; then
+    rm $LOGFILE
+else
+    echo "logfile in $LOGFILE"
+fi
diff --git a/kvm-xfstests/android-xfstests.in b/kvm-xfstests/android-xfstests.in
new file mode 100644
index 0000000..634c93d
--- /dev/null
+++ b/kvm-xfstests/android-xfstests.in
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+DIR=@DIR@
+
+ANDROID_XFSTESTS_DIR=$DIR/kvm-xfstests
+export ANDROID_XFSTESTS_DIR
+exec $ANDROID_XFSTESTS_DIR/android-xfstests "$@"
diff --git a/kvm-xfstests/config b/kvm-xfstests/config
index 0f1d432..4e7bb19 100644
--- a/kvm-xfstests/config
+++ b/kvm-xfstests/config
@@ -1,14 +1,30 @@
 #
-# Customize these or put new values in ~/.config/kvm-xfstests or config.custom
+# Customize these, or put new values in:
+#
+#		~/.config/kvm-xfstests
+#	or
+#		~/.config/gce-xfstests
+#	or
+#		~/.config/android-xfstests
+#
+# ... to affect specific commands only;
+#
+# or in config.custom to affect all commands.
+#
+
+###############################################################################
+# Common configuration
+#
+PRIMARY_FSTYPE="ext4" # all commands
+NR_CPU=2 # kvm-xfstests and gce-xfstests
+MEM=2048 # kvm-xfstests and gce-xfstests
+
+###############################################################################
+# KVM configuration
 #
 #QEMU=/usr/local/bin/qemu-system-x86_64
 QEMU=/usr/bin/kvm
 KERNEL=$HOME/linux
-NR_CPU=2
-MEM=2048
-CONFIG_DIR=$HOME/.config
-
-PRIMARY_FSTYPE="ext4"
 ROOT_FS=$DIR/test-appliance/root_fs.img
 ROOT_DEV=/dev/vda
 VDB=$DIR/disks/vdb
@@ -40,10 +56,10 @@ MONITOR="-monitor telnet:localhost:7498,server,nowait"
 CONSOLE=" -serial mon:stdio"
 #CONSOLE=" -chardev stdio,id=console,signal=off -serial chardev:console"
 
+###############################################################################
 # GCE configuration
 #
 # GS_BUCKET=gs_bucket.thunk.org
 # GCE_PROJECT=tytso-xfstests-project
 # GCE_ZONE=us-central1-c
 # GCE_KERNEL=/u1/ext4-64/arch/x86/boot/bzImage
-
diff --git a/kvm-xfstests/gce-xfstests b/kvm-xfstests/gce-xfstests
index 084b30c..7b678bc 100755
--- a/kvm-xfstests/gce-xfstests
+++ b/kvm-xfstests/gce-xfstests
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-GCE_XFSTESTS=yes
+XFSTESTS_FLAVOR=gce
 DIR=.
 if test -n "$GCE_XFSTESTS_DIR"
 then
diff --git a/kvm-xfstests/kvm-xfstests b/kvm-xfstests/kvm-xfstests
index 0d764a2..01fbee3 100755
--- a/kvm-xfstests/kvm-xfstests
+++ b/kvm-xfstests/kvm-xfstests
@@ -1,5 +1,6 @@
 #!/bin/bash
 
+XFSTESTS_FLAVOR=kvm
 DIR=.
 if test -n "$KVM_XFSTESTS_DIR"
 then
diff --git a/kvm-xfstests/test-appliance/.gitignore b/kvm-xfstests/test-appliance/.gitignore
index 2c0d90e..14bb19a 100644
--- a/kvm-xfstests/test-appliance/.gitignore
+++ b/kvm-xfstests/test-appliance/.gitignore
@@ -1,3 +1,4 @@
+armhf_root_fs.*
 debs
 root_fs.img*
 root_fs.raw
diff --git a/kvm-xfstests/test-appliance/android-setup-partitions b/kvm-xfstests/test-appliance/android-setup-partitions
new file mode 100755
index 0000000..5ed5896
--- /dev/null
+++ b/kvm-xfstests/test-appliance/android-setup-partitions
@@ -0,0 +1,221 @@
+#!/bin/bash
+#
+# This script runs inside the Debian chroot on Android and sets up the xfstests
+# partitions.  We create the xfstests partitions in the area that is part of the
+# userdata partition on-disk but becomes unused by the userdata filesystem after
+# it is reformatted with a smaller size.  We number the xfstests partitions
+# starting at 100 (arbitrary), so they'll show up as /dev/block/sda100,
+# /dev/block/sda101, etc.  We also create symlinks like
+# /dev/block/xfstests/PRI_TST_DEV => /dev/block/sda100.
+#
+# We set up the partitions transiently, by changing the kernel's view of the
+# partitions.  The on-disk partition table is untouched.  Therefore, the
+# partitions will revert to normal after a reboot, and android-xfstests will
+# have to set them up again.  This has two main advantages: (1) it makes it
+# harder to mess things up and easier to revert the device to its original
+# state, and (2) it works even on devices that don't reserve enough extra
+# entries in their partition tables.  (While GPT partition tables normally have
+# space for 128 partitions, one Android device I tested had 35 partitions with
+# just 36 entries in the GPT, so only one more partition could be created!)
+#
+
+set -e -u -o pipefail
+RESULT_FILE=/setup-partitions-result
+rm -f $RESULT_FILE
+
+# Partitions to create: their names, their sizes in GiB, and whether they are
+# required or not.  If a partition is not required, then we create it only if
+# there is enough space.
+PARTITION_NAMES=(PRI_TST_DEV SM_TST_DEV SM_SCR_DEV LG_TST_DEV LG_SCR_DEV)
+PARTITION_SIZES=(5 5 5 20 20)
+PARTITION_REQUIRED=(true true true false false)
+
+BYTES_PER_GIB=$(( 1 << 30 ))
+START_PARTITION_NUMBER=100
+USERDATA_SHRUNKEN_SIZE=$(( 4 * BYTES_PER_GIB ))
+
+# device node for userdata partition, e.g. /dev/block/sda35
+USERDATA_DEV=$(readlink /dev/block/bootdevice/by-name/userdata)
+
+# Device node for disk containing userdata partition, e.g. /dev/block/sda.
+# This is the Android device's internal storage.
+DISK_DEV=${USERDATA_DEV%%[0-9]*}
+
+finished()
+{
+    echo "$*" > $RESULT_FILE
+    exit 0
+}
+
+die()
+{
+    echo 1>&2 "[ERROR] android-setup-partitions: $*"
+    exit 1
+}
+
+# Pretty-print a byte count
+pprint_bytes()
+{
+    local bytes=$1
+    echo "$(( bytes / BYTES_PER_GIB )) GiB ($bytes bytes)"
+}
+
+# Get the number of the given partition
+get_partition_number()
+{
+    local dev=$1
+    echo $dev | egrep -o '[0-9]+$'
+}
+
+# Get the size in bytes of the given partition, as stored in the partition table
+get_partition_disk_size()
+{
+    local dev=$1
+    local sectors=$(partx --output SECTORS --noheadings $dev)
+    echo $(( sectors * 512 ))
+}
+
+# Get the size in bytes of the given partition, as viewed by the kernel
+get_partition_size()
+{
+    local dev=$1
+    local sectors=$(< /sys/class/block/$(basename $dev)/size)
+    echo $(( sectors * 512 ))
+}
+
+# Get the start offset in bytes of the given partition, as viewed by the kernel.
+# (If the partition is also in the partition table, the start offset should be
+# the same, at least based on what this script does.)
+get_partition_start()
+{
+    local dev=$1
+    local start_sector=$(< /sys/class/block/$(basename $dev)/start)
+    echo $(( start_sector * 512 ))
+}
+
+# Check whether all the needed partitions are present and are large enough
+all_partitions_present()
+{
+    local i
+    for i in ${!PARTITION_NAMES[@]}; do
+	local link=/dev/block/xfstests/${PARTITION_NAMES[$i]}
+	if [ ! -L $link ]; then
+	    return 1
+	fi
+	local dev=$(readlink $link)
+	local wanted_size=$(( ${PARTITION_SIZES[$i]} * BYTES_PER_GIB ))
+	local actual_size=$(get_partition_size $dev)
+	if [ -z "$actual_size" ] || (( actual_size < wanted_size )); then
+	    return 1
+	fi
+    done
+    return 0
+}
+
+# Shrink the userdata partition if it's not fully used by the filesystem on it
+shrink_userdata_partition()
+{
+    local fs_size=$(dumpe2fs -h $USERDATA_DEV 2>/dev/null | \
+	    awk '/^Block count:/{blockcount=$3}
+		 /^Block size:/{blocksize=$3}
+		  END { print blockcount * blocksize }')
+    local part_size=$(get_partition_size $USERDATA_DEV)
+
+    if (( fs_size <= 0 )); then
+	die "unable to determine size of userdata filesystem"
+    fi
+    if (( fs_size % 512 != 0 )); then
+	die "Weird: the userdata filesystem takes up $fs_size bytes," \"
+	    "which is not a whole number of 512-byte sectors!"
+    fi
+    if (( part_size < fs_size )); then
+	die "Weird: the userdata partition is only $part_size bytes," \
+	    "but the filesystem on it is $fs_size bytes!"
+    fi
+    if (( part_size == fs_size )); then
+	return 0
+    fi
+    echo "Shrinking userdata partition..."
+    echo "    Old size: $(pprint_bytes $part_size)"
+    echo "    New size: $(pprint_bytes $fs_size)"
+    resizepart $DISK_DEV $(get_partition_number $USERDATA_DEV) \
+		$(( fs_size / 512 ))
+}
+
+# Delete the existing xfstests partitions, if any.
+delete_xfstests_partitions()
+{
+    if [ -d /dev/block/xfstests ] && \
+      (( $(ls /dev/block/xfstests | wc -l) != 0 )); then
+	local link
+	for link in /dev/block/xfstests/*; do
+	    local dev=$(readlink $link)
+	    umount $dev &> /dev/null || true
+	    local partno=$(get_partition_number $dev)
+	    delpart $DISK_DEV $partno
+	    rm $link
+	done
+    fi
+}
+
+create_xfstests_partitions()
+{
+    local userdata_disk_size=$(get_partition_disk_size $USERDATA_DEV)
+    local userdata_used_size=$(get_partition_size $USERDATA_DEV)
+    local start=$(get_partition_start $USERDATA_DEV)
+    local end=$(( start + userdata_disk_size ))
+    local i
+    local alignment=$(( 1 << 20 )) # 1 MiB alignment, for good measure
+
+    if (( userdata_used_size > userdata_disk_size )); then
+	die "Weird: the userdata partition is using $userdata_used_size" \
+	    "bytes, which is more than its on-disk size of" \
+	    "$userdata_disk_size bytes!"
+    fi
+
+    start=$(( start + userdata_used_size ))
+
+    local total_size_required=0
+    for i in ${!PARTITION_NAMES[@]}; do
+	if ${PARTITION_REQUIRED[$i]}; then
+	    total_size_required=$(( total_size_required +
+				    BYTES_PER_GIB * ${PARTITION_SIZES[$i]} ))
+	fi
+    done
+
+    mkdir -p /dev/block/xfstests
+    for i in ${!PARTITION_NAMES[@]}; do
+	start=$(( start + (alignment - start % alignment) % alignment ))
+	local name=${PARTITION_NAMES[$i]}
+	local size=$(( BYTES_PER_GIB * ${PARTITION_SIZES[$i]} ))
+	local remaining=$(( end - start ))
+	local partno=$(( START_PARTITION_NUMBER + i ))
+	if (( size > remaining )); then
+	    if ! ${PARTITION_REQUIRED[$i]}; then
+		echo "Not enough space to create the $name partition."
+		continue
+	    fi
+	    # Not enough space!  Check whether we should shrink userdata or not.
+	    if (( userdata_used_size > USERDATA_SHRUNKEN_SIZE &&
+		  USERDATA_SHRUNKEN_SIZE + total_size_required <=
+		    userdata_disk_size )); then
+		finished "shrink_userdata"
+	    else
+		finished "insufficient_space"
+	    fi
+	fi
+	echo "$name is ${DISK_DEV}${partno}: $(pprint_bytes $size) at offset $start"
+	addpart $DISK_DEV $partno $(( start / 512)) $(( size / 512 ))
+	ln -s ${DISK_DEV}${partno} /dev/block/xfstests/$name
+	start=$(( start + size ))
+    done
+}
+
+if ! all_partitions_present ; then
+    # Free up as much space as we can, then create the partitions.
+    shrink_userdata_partition
+    delete_xfstests_partitions
+    create_xfstests_partitions
+fi
+
+finished "ready"
diff --git a/kvm-xfstests/test-appliance/android-test-config b/kvm-xfstests/test-appliance/android-test-config
new file mode 100644
index 0000000..0bb8ffd
--- /dev/null
+++ b/kvm-xfstests/test-appliance/android-test-config
@@ -0,0 +1,13 @@
+export PRI_TST_DEV=$(readlink /dev/block/xfstests/PRI_TST_DEV)
+export SM_SCR_DEV=$(readlink /dev/block/xfstests/SM_SCR_DEV)
+export SM_TST_DEV=$(readlink /dev/block/xfstests/SM_TST_DEV)
+export LG_SCR_DEV=$(readlink /dev/block/xfstests/LG_SCR_DEV)
+export LG_TST_DEV=$(readlink /dev/block/xfstests/LG_TST_DEV)
+
+export PRI_TST_MNT=/vdb
+export SM_SCR_MNT=/vdc
+export SM_TST_MNT=/vdd
+export LG_SCR_MNT=/vde
+export LG_TST_MNT=/vdf
+
+PATH="/root/xfstests/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
diff --git a/kvm-xfstests/test-appliance/gce-create-image b/kvm-xfstests/test-appliance/gce-create-image
index c82ce04..913286f 100755
--- a/kvm-xfstests/test-appliance/gce-create-image
+++ b/kvm-xfstests/test-appliance/gce-create-image
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-GCE_XFSTESTS=yes
+XFSTESTS_FLAVOR=gce
 DIR=..
 if test -n "$GCE_XFSTESTS_DIR"
 then
diff --git a/kvm-xfstests/test-appliance/gce-export-image b/kvm-xfstests/test-appliance/gce-export-image
index 3d0f1b9..3ef1607 100755
--- a/kvm-xfstests/test-appliance/gce-export-image
+++ b/kvm-xfstests/test-appliance/gce-export-image
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-GCE_XFSTESTS=yes
+XFSTESTS_FLAVOR=gce
 DIR=..
 if test -n "$GCE_XFSTESTS_DIR"
 then
diff --git a/kvm-xfstests/test-appliance/gce-import-image b/kvm-xfstests/test-appliance/gce-import-image
index d4b75df..8e8a43b 100755
--- a/kvm-xfstests/test-appliance/gce-import-image
+++ b/kvm-xfstests/test-appliance/gce-import-image
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-GCE_XFSTESTS=yes
+XFSTESTS_FLAVOR=gce
 DIR=..
 if test -n "$GCE_XFSTESTS_DIR"
 then
diff --git a/kvm-xfstests/util/gce-do-setup b/kvm-xfstests/util/gce-do-setup
index cd4cd6e..386ea6d 100755
--- a/kvm-xfstests/util/gce-do-setup
+++ b/kvm-xfstests/util/gce-do-setup
@@ -3,7 +3,7 @@
 # For a more fool-proof gce-xfstests setup,,,
 #
 
-GCE_XFSTESTS=yes
+XFSTESTS_FLAVOR=gce
 DIR=.
 if test -n "$GCE_XFSTESTS_DIR"
 then
diff --git a/kvm-xfstests/util/get-config b/kvm-xfstests/util/get-config
index 0b40d9f..b1ffc8f 100644
--- a/kvm-xfstests/util/get-config
+++ b/kvm-xfstests/util/get-config
@@ -1,25 +1,24 @@
 #
-# Read the config files used for kvm-xfstests
+# Read the config files used for kvm-xfstests, gce-xfstests, etc.
 #
 # Shell scripts should use this file as follows:
 #
-#DIR=.
-#if test -n "$KVM_XFSTESTS_DIR"
-#then
-#    DIR="$KVM_XFSTESTS_DIR"
-#fi
+# XFSTESTS_FLAVOR=kvm # (or gce, etc.)
+# DIR=.
+# if test -n "$KVM_XFSTESTS_DIR" # (or $GCE_XFSTESTS_DIR, etc.)
+# then
+#     DIR="$KVM_XFSTESTS_DIR"
+# fi
 #
 # . "$DIR/util/get-config"
 
 . $DIR/config
 
-if test -n "$GCE_XFSTESTS" -a -f "$CONFIG_DIR/gce-xfstests" ; then
-   . $CONFIG_DIR/gce-xfstests
-elif test -f "$CONFIG_DIR/kvm-xfstests"; then
-   . $CONFIG_DIR/kvm-xfstests
-fi
+# Source the user-provided config if present (e.g. ~/.config/kvm-xfstests)
+[ -f "$HOME/.config/${XFSTESTS_FLAVOR}-xfstests" ] && \
+	. "$HOME/.config/${XFSTESTS_FLAVOR}-xfstests"
 
-if test -n "$GCE_XFSTESTS" -a -z "$GCE_ACCOUNT" -a \
+if test "$XFSTESTS_FLAVOR" = "gce" -a -z "$GCE_ACCOUNT" -a \
    -n "$(ls $DIR/config-* 2> /dev/null)"
 then
    # We aren't just using GCE_ACCOUNT=$(...) to work around a performance
diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
index 0956ebb..655a49d 100644
--- a/kvm-xfstests/util/parse_cli
+++ b/kvm-xfstests/util/parse_cli
@@ -5,6 +5,23 @@ SNAPSHOT=",snapshot=on"
 DO_AEX="yes"
 API="1.3"
 
+# Is the invoked interface (kvm-xfstests, gce-xfstests, etc.) in the given list?
+flavor_in ()
+{
+    local flavor
+    for flavor ; do
+	if test "$XFSTESTS_FLAVOR" = "$flavor" ; then
+	    return 0
+	fi
+    done
+    return 1
+}
+
+supported_flavors ()
+{
+    flavor_in "$@" || print_help
+}
+
 print_help ()
 {
     PROG=$(basename "$0")
@@ -19,23 +36,35 @@ print_help ()
     echo "	-C count	- Run the specified tests multiple times"
     echo "	-I image	- Use this test appliance image"
     echo "	-m mountopts	- Append mount options to fs config"
-    echo "	-n nr_cpus	- Specify the number of cpu's"
-    if test "$GCE_XFSTESTS" != "yes" ; then
+    if flavor_in kvm gce ; then
+	echo "	-n nr_cpus	- Specify the number of cpu's"
+    fi
+    if flavor_in kvm ; then
 	echo "	-numa num	- Ask KVM to create <num> NUMA nodes"
 	echo "	-N		- Enable networking (requires root)"
     fi
-    echo "	-o opts		- Extra kernel command line options"
-    echo "	-r ram		- Specify memory to be used in megabytes"
+    if flavor_in kvm gce ; then
+	echo "	-o opts		- Extra kernel command line options"
+    fi
+    if flavor_in kvm gce ; then
+	echo "	-r ram		- Specify memory to be used in megabytes"
+    fi
     echo "	-x group	- Exclude group of tests from running"
     echo "	-X test		- Exclude test from running"
-    echo "	--kernel file	- Boot the specified kernel"
-    if test "$GCE_XFSTESTS" != "yes" ; then
+    if flavor_in kvm gce ; then
+	echo "	--kernel file	- Boot the specified kernel"
+    fi
+    if flavor_in kvm ; then
 	echo "	--initrd initrd	- Boot with the specified initrd"
-    else
+    elif flavor_in gce ; then
 	echo "	--pmem-device	- Set up persistent memory devices for DAX"
     fi
-    echo "	--no-log	- Don't save the log file for this run"
-    echo "	--no-action	- Print the command to start the VM"
+    if flavor_in kvm android ; then
+	echo "	--no-log	- Don't save the log file for this run"
+    fi
+    if flavor_in kvm gce ; then
+	echo "	--no-action	- Print the command to start the VM"
+    fi
     echo ""
     echo "Common file system configurations are:"
     echo "	4k 1k ext3 nojournal ext3conv metacsum dioread_nolock "
@@ -43,7 +72,7 @@ print_help ()
     echo ""
     echo "xfstest names have the form: ext4/NNN generic/NNN shared/NNN"
     echo ""
-    if test "$GCE_XFSTESTS" = "yes" ; then
+    if flavor_in gce ; then
 	echo "Common gce-xfstests commands:"
         echo "	ls		- List running xfstests instances"
         echo "	abort		- Abort a xfstests instance"
@@ -138,6 +167,7 @@ while [ "$1" != "" ]; do
 	    MNTOPTS="$1"
 	    ;;
 	-r) shift
+	    supported_flavors kvm gce
 	    case "$1" in
 		*[mM])
 		    MEM=$(echo "$1" | sed -e 's/[mM]$//')
@@ -166,13 +196,16 @@ while [ "$1" != "" ]; do
 	    ROOT_FS="$1"
 	    ;;
 	-n) shift
+	    supported_flavors kvm gce
 	    NR_CPU="$1"
 	    EXPLICIT_CPU=yes
 	    ;;
 	-o) shift
+	    supported_flavors kvm gce
 	    EXTRA_ARG=$(echo "$1" | sed -e 's/ /:/g')
 	    ;;
 	-v)
+	    supported_flavors kvm gce
 	    if test "$V" = "1" ; then
 		QUIET=""
 		V=2
@@ -182,11 +215,8 @@ while [ "$1" != "" ]; do
 	    fi
 	    ;;
 	-N)
-	    if test "$GCE_XFSTESTS" != "yes" ; then
-		DO_NET=yes
-	    else
-		print_help
-	    fi
+	    supported_flavors kvm
+	    DO_NET=yes
 	    ;;
 	-X) shift
 	    if test -n "$FSTESTEXC" ; then
@@ -196,19 +226,17 @@ while [ "$1" != "" ]; do
 	    fi
 	    ;;
 	--hooks)
-	    if test "$GCE_XFSTESTS" = "yes"
-	    then
-		shift
-		GCE_HOOKS="$1"
-	    else
-		print_help
-	    fi
+	    supported_flavors gce
+	    shift
+	    GCE_HOOKS="$1"
 	    ;;
 	--update-xfstests-tar)
+	    supported_flavors kvm gce
 	    UPDATE_XFSTESTS_TAR=yes
 	    UPDATE_XFSTESTS=yes
 	    ;;
 	--update-xfstests)
+	    supported_flavors kvm gce
 	    if ! test -f "$DIR/../xfstests.tar.gz"
 	    then
 		echo "The xfstests.tar.gz file has not been built!"
@@ -217,13 +245,11 @@ while [ "$1" != "" ]; do
 	    UPDATE_XFSTESTS=yes
 	    ;;
 	--update-files)
+	    supported_flavors kvm gce
 	    UPDATE_FILES=yes
 	    ;;
 	--numa) shift
-	    if test "$GCE_XFSTESTS" = "yes"
-	    then
-		print_help
-	    fi
+	    supported_flavors kvm
 	    NUMA_NUM="$1"
 	    case "$NUMA_NUM" in
 		''|*[!0-9]*)
@@ -232,6 +258,7 @@ while [ "$1" != "" ]; do
 	    esac
 	    ;;
 	--no-action)
+	    supported_flavors kvm gce
 	    NO_ACTION="echo -e Would execute:\n\t"
 	    SKIP_LOG=yes
 	    ;;
@@ -248,83 +275,51 @@ while [ "$1" != "" ]; do
 	    NO_ZERO=yes
 	    ;;
 	--no-log)
-	    if test "$GCE_XFSTESTS" != "yes" ; then
-		SKIP_LOG=yes
-	    else
-		print_help
-	    fi
+	    supported_flavors kvm android
+	    SKIP_LOG=yes
 	    ;;
 	--log)
-	    if test "$GCE_XFSTESTS" != "yes" ; then
-		SKIP_LOG=no
-	    else
-		print_help
-	    fi
+	    supported_flavors kvm android
+	    SKIP_LOG=no
 	    ;;
 	--kernel) shift
-		  KERNEL="$1"
-		  if test -d "$KERNEL" ; then
-		      KERNEL="$KERNEL/arch/x86/boot/bzImage"
-		  fi
-		  OVERRIDE_KERNEL="$KERNEL"
-		  ;;
+	    supported_flavors kvm gce
+	    KERNEL="$1"
+	    if test -d "$KERNEL" ; then
+		KERNEL="$KERNEL/arch/x86/boot/bzImage"
+	    fi
+	    OVERRIDE_KERNEL="$KERNEL"
+	    ;;
 	--initrd) shift
-		  if test "$GCE_XFSTESTS" = "yes"
-		  then
-		      print_help
-		  fi
-		  INITRD="$1"
-		  if test ! -f "$INITRD" ; then
-		      print_help
-		  fi
-		  ;;
-	--local-ssd)
-	    if test "$GCE_XFSTESTS" = "yes"
-	    then
-		DO_LOCAL_SSD=yes
-	    else
+	    supported_flavors kvm
+	    INITRD="$1"
+	    if test ! -f "$INITRD" ; then
 		print_help
 	    fi
 	    ;;
+	--local-ssd)
+	    supported_flavors gce
+	    DO_LOCAL_SSD=yes
+	    ;;
 	--pmem-device)
-	    if test "$GCE_XFSTESTS" = "yes"
-	    then
-		PMEM_DEVICE=yes
-	    else
-		print_help
-	    fi
+	    supported_flavors gce
+	    PMEM_DEVICE=yes
 	    ;;
 	--machtype)
-	    if test "$GCE_XFSTESTS" = "yes"
-	    then
-		shift
-		GCE_MACHTYPE="$1"
-	    else
-		print_help
-	    fi
+	    supported_flavors gce
+	    GCE_MACHTYPE="$1"
 	    ;;
 	--image-project)
-	    if test "$GCE_XFSTESTS" = "yes" ; then
-		shift
-		GCE_IMAGE_PROJECT="$1"
-	    else
-		print_help
-	    fi
+	    supported_flavors gce
+	    GCE_IMAGE_PROJECT="$1"
 	    ;;
 	--instance-name)
-	    if test "$GCE_XFSTESTS" = "yes" ; then
-		shift
-		INSTANCE_NAME="$1"
-	    else
-		print_help
-	    fi
+	    supported_flavors gce
+	    INSTANCE_NAME="$1"
 	    ;;
 	--no-virtio-rng)
-	    if test "$GCE_XFSTESTS" = "yes" ; then
-		print_help
-	    else
-		NO_VIRTIO_RNG=yes
-	    fi
+	    supported_flavors kvm
+	    NO_VIRTIO_RNG=yes
 	    ;;
 	smoke)
 	    if test -n "$FSTESTCFG" ; then
@@ -345,7 +340,7 @@ while [ "$1" != "" ]; do
 	    ARG="cmd=maint"
 	    ;;
 	maint)
-	    if test "$GCE_XFSTESTS" != "yes" ; then
+	    if ! flavor_in gce ; then
 		ARG="cmd=maint"
 		EPH="-root_ephemeral=no"
 		SNAPSHOT=""
-- 
2.12.0.rc1.440.g5b76565f74-goog

