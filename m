Received: from mail-pg0-f67.google.com ([74.125.83.67]:35060 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbdGZATp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2017 20:19:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so15735940pgc.2
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2017 17:19:45 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 2/2] android-xfstests: update documentation
Date: Tue, 25 Jul 2017 17:18:38 -0700
Message-Id: <20170726001838.80452-2-ebiggers3@gmail.com>
In-Reply-To: <20170726001838.80452-1-ebiggers3@gmail.com>
References: <20170726001838.80452-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Update the list of known issues, document that specifying a kernel works
now, and make a few other small improvements.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/android-xfstests.md | 142 +++++++++++++++++++++-----------------
 1 file changed, 79 insertions(+), 63 deletions(-)

diff --git a/Documentation/android-xfstests.md b/Documentation/android-xfstests.md
index a93b35c..772356e 100644
--- a/Documentation/android-xfstests.md
+++ b/Documentation/android-xfstests.md
@@ -18,8 +18,8 @@ devices.  If you encounter a problem, please submit a fix!
 
 - The android-xfstests script installed:
   run `make android-xfstests.sh` in the top-level directory of
-  xfstests-bld, then move android-xfstests.sh to
-  ~/bin/android-xfstests or another location on your $PATH.
+  xfstests-bld, then move `android-xfstests.sh` to
+  `~/bin/android-xfstests` or another location on your `$PATH`.
 
 - A rooted Android device with sufficient internal storage.  For most
   test configurations, about 24 GiB of internal storage should be
@@ -33,24 +33,25 @@ devices.  If you encounter a problem, please submit a fix!
 
 - An armhf Debian root filesystem set up with xfstests and the
   xfstests-bld scripts.  Either fetch the prebuilt
-  armhf_root_fs.tar.gz from
+  `armhf_root_fs.tar.gz` from
   [kernel.org](http://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests),
   or build one yourself on a Debian ARM build server as described in
   [building-xfstests](building-xfstests.md).  Then, either put the
   chroot tarball in the default location of
-  kvm-xfstests/test-appliance/armhf_root_fs.tar.gz, or specify it with
-  ROOT_FS in your ~/.config/android-xfstests or the -I option to
-  android-xfstests.
+  `kvm-xfstests/test-appliance/armhf_root_fs.tar.gz`, or specify it
+  with `ROOT_FS` in your `~/.config/android-xfstests` or the `-I`
+  option to android-xfstests.
 
 ## Procedure
 
 ### (Optional) Build a custom kernel
 
-You may be able to run xfstests with the kernel already installed on
-your device, but you may wish to build your own kernel instead.  The
-exact procedure for building the kernel is device-dependent, but here
-are example commands for building a kernel using the public source
-code for the Google Pixel phone (2016 edition), code name "marlin":
+You should be able to run xfstests with the kernel already installed
+on your device, but you may wish to build your own kernel instead.
+The exact procedure for building the kernel is device-dependent, but
+here are example commands for building a kernel using the public
+source code for the Google Pixel phone (2016 edition), code name
+"marlin":
 
     git clone https://android.googlesource.com/kernel/msm msm-linux
     cd msm-linux
@@ -60,36 +61,43 @@ code for the Google Pixel phone (2016 edition), code name "marlin":
     make marlin_defconfig
     make -j$(grep -c processor /proc/cpuinfo)
 
-This will produce a kernel image arch/arm64/boot/Image.gz-dtb.
+This will produce a kernel image `arch/arm64/boot/Image.gz-dtb`.
 
 Also consider the following config options:
 
-    CONFIG_SYSV_IPC=y
-        Makes some tests using dm-setup stop failing.
+* `CONFIG_SYSV_IPC=y`:  Makes several tests stop failing / being
+  skipped (see [Known issues](#known-issues))
 
-    CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n
-        Include crypto self-tests.  This may be useful if you are
-        using xfstests to test file-based encryption.
+* `CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n`: Include crypto self-tests.
+  This may be useful if you are using xfstests to test file-based
+  encryption.
 
 ### (Optional) Boot into your custom kernel
 
-To boot into your new kernel, you'll first need to reboot your device
-into fastboot mode by running 'adb reboot-bootloader' or by holding a
-device-dependent key combination (e.g. Power + Vol-Down on the Pixel).
-Then do *one* of the following:
-
-- Run 'fastboot boot arch/arm64/boot/Image.gz-dtb' to boot the kernel
-  directly.  Careful: this is good for one boot only (it's not
-  persistent), and it doesn't work on all devices.
-
-- Build and flash a boot.img to your device's boot partition.  This is
-  device-dependent, but for "marlin" devices one would copy
-  arch/arm64/boot/Image.gz-dtb into device/google/marlin-kernel/ in
-  the Android source tree, then run the following commands from the
-  root of the Android source tree:
+By default, android-xfstests uses the kernel running on the device.
+However, it also supports booting a kernel automatically.  To do this,
+specify `KERNEL` in your `~/.config/android-xfstests` or use the
+`--kernel` command line option.  If a kernel is specified,
+android-xfstests will boot it on the device using `fastboot boot`.  As
+an optimization, this is skipped if the kernel is already running on
+the device (as detected by checking `uname -r -v`; this usually
+identifies the commit and build timestamp).
+
+Note that `fastboot boot` just boots the kernel once; it doesn't
+install it persistently.  Also, on some devices it doesn't bring up
+the full functionality or even doesn't work at all, since it doesn't
+install kernel modules or device-tree overlays.  If it doesn't work,
+you'll need to install and boot the kernel yourself instead.  See your
+device's documentation for details, but you'll at least need to build
+the kernel into a boot.img and flash it to the "boot" partition.  On
+some devices additional partitions must be flashed as well, e.g.
+vendor and vbmeta.  As an example, for "marlin" devices running
+Android N, one must copy `arch/arm64/boot/Image.gz-dtb` into
+`device/google/marlin-kernel/` in the Android source tree, then run
+the following commands from the root of the Android source tree:
 
     . build/envsetup.sh
-    lunch marlin-userdebug
+    lunch marlin-eng
     make -j16 bootimage
     fastboot flash boot out/target/product/marlin/boot.img
     fastboot continue
@@ -112,41 +120,49 @@ by rebooting into fastboot mode and reformatting the userdata
 filesystem.  Since this causes all user data to be wiped,
 android-xfstests will ask for confirmation before doing this.
 
-## Known issues
-
-android-xfstests doesn't yet do kernel installation; you have to do
-that yourself.
+Note that Android devices usually run an older version of the Linux
+kernel.  At the same time, xfstests is constantly being updated to add
+new tests.  Therefore, it's often the case that some of the more
+recently added tests will fail.  Some tests may even cause a kernel
+crash or deadlock and will need to be excluded with `-X` in order for
+the test run to complete, as a temporary workaround until you can
+backport the needed bug fixes.  It's recommended to keep your device's
+kernel up-to-date with the corresponding LTS kernel to help minimize
+the number of test failures that need to be triaged.  (Of course,
+there are obviously many other benefits of doing that as well...)
+
+## Monitoring and debugging
+
+To get a shell in the chroot, use `android-xfstests shell`.  You can
+do this at any time, regardless of whether tests are currently
+running.  Note that this is a real shell on the device, and it doesn't
+use a snapshot of the root filesystem like `kvm-xfstests shell` does.
+Thus, any changes you make in the shell session are persistent.
 
-Terminating android-xfstests with Ctrl-C doesn't stop the test process
-on the device.
-
-'android-xfstests shell' gives you a shell in the chroot, but it's not
-a snapshot like it is for kvm-xfstests; that is, any changes you make
-in the shell session are persistent.
-
-Android devices usually run an older version of the Linux kernel.  At
-the same time, xfstests is constantly being updated to add new tests.
-Therefore, you can expect there to be a significant number of failing
-tests due to bugs.  Some tests may even cause a kernel crash or
-deadlock and will need to be excluded with -X in order for the test
-run to complete.  Note, however, that bugs reproduced by xfstests are
-not necessarily reachable by unprivileged users (though they can be!).
+## Known issues
 
-Tests which create loopback or device-mapper devices currently fail
-because the corresponding device nodes do not get automatically
-created on Android.
+If using the armhf (32-bit) tarball on an aarch64 kernel, the
+encryption tests may fail due to a kernel bug that caused the keyctl
+system call to be unavailable to 32-bit programs.  This can be fixed
+by cherry-picking commit 5c2a625937ba ("arm64: support keyctl() system
+call in 32-bit mode") into your kernel from Linux v4.11.
 
-Any test that requires non-root users currently fails because xfstests
-incorrectly thinks that YP/NIS is enabled.
+Tests that create device-mapper devices (e.g. generic/250,
+generic/252, generic/338) fail because the Android equivalent of udev
+does not create the dm device nodes in the location expected by
+xfstests (`/dev/mapper/`).
 
-On recent versions of Android, all new files inherit SELinux xattrs.
-This confuses generic/062 and generic/377 and causes them to fail.
+Android kernels are sometimes configured without SysV IPC support ---
+i.e., `CONFIG_SYSVIPC` isn't set.  This can cause several problems:
 
-generic/240 and tests using dmsetup fail on kernels configured without
-SysV IPC support, which includes most Android kernels.
+- Tests that use the `dbench` program (generic/241) fail.
+- Tests that use the `dmsetup` program fail (if they didn't already
+  fail because of the device node issue noted above)
+- Tests that use the `fio` program (e.g. ext4/301, ext4/302, ext4/303,
+  generic/095, generic/299, generic/300) are skipped.
 
-generic/004 fails because of glibc bug
-https://sourceware.org/bugzilla/show_bug.cgi?id=17912.
+generic/004 should work, but in fact it's skipped because of a [glibc
+bug](https://sourceware.org/bugzilla/show_bug.cgi?id=17912).
 
 ## Resetting userdata
 
@@ -155,8 +171,8 @@ not show up in the device's on-disk partition table or fstab, and they
 will go away after reboot.  However, the reformatting of the userdata
 filesystem with a smaller size to free up space is persistent.  If you
 are done running xfstests and wish to expand userdata to take up its
-full partition again, then reboot into fastboot mode and run 'fastboot
--w' to wipe and reformat userdata again, this time with the full size.
+full partition again, then reboot into fastboot mode and run `fastboot
+-w` to wipe and reformat userdata again, this time with the full size.
 
 ## Other notes
 
-- 
2.14.0.rc0.400.g1c36432dff-goog

