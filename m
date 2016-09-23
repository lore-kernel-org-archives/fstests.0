Received: from mail-pf0-f169.google.com ([209.85.192.169]:34419 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761693AbcIWU4u (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Sep 2016 16:56:50 -0400
Received: by mail-pf0-f169.google.com with SMTP id p64so45558470pfb.1
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2016 13:56:49 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] [xfstests-bld] Fix typos in xfstests-bld documentation
Date: Fri, 23 Sep 2016 13:56:11 -0700
Message-Id: <1474664172-84173-2-git-send-email-ebiggers@google.com>
In-Reply-To: <1474664172-84173-1-git-send-email-ebiggers@google.com>
References: <1474664172-84173-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: tytso@mit.edu
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/building-rootfs.md   |  8 ++++----
 Documentation/building-xfstests.md |  8 ++++----
 Documentation/gce-xfstests.md      | 22 +++++++++++-----------
 Documentation/kvm-quickstart.md    | 23 ++++++++++++-----------
 Documentation/kvm-xfstests.md      | 19 ++++++++++---------
 Documentation/what-is-xfstests.md  |  8 ++++----
 README                             |  4 ++--
 kvm-xfstests/util/parse_cli        |  4 ++--
 8 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/Documentation/building-rootfs.md b/Documentation/building-rootfs.md
index 863a755..8665919 100644
--- a/Documentation/building-rootfs.md
+++ b/Documentation/building-rootfs.md
@@ -3,7 +3,7 @@
 The root_fs.img file is used as the test appliance VM for
 kvm-xfstests.  It consists of a Debian Jessie root file system, some
 configuration files and test runner scripts, and the xfstests.tar.gz
-unpacked in the the /root directory.  It is built using the gen-image
+unpacked in the /root directory.  It is built using the gen-image
 script found in kvm-xfstests/test-appliance.
 
 The gen-image script must be run as root, as it creates a file system
@@ -20,16 +20,16 @@ kvm-xfstests/test-appliance/debs.  This is how the official packages
 on kernel.org have an updated version of e2fsprogs and its support
 packages (e2fslibs, libcomerr2, and libss2).  The latest versions get
 compiled for Debian Jessie, in a hermetic build environment, and
-placed in the debs directory.  Optioanlly, the output of the script
+placed in the debs directory.  Optionally, the output of the script
 [get-ver](https://git.kernel.org/cgit/fs/ext2/e2fsprogs.git/tree/util/get-ver)
 is placed in the e2fsprogs.ver in the top-level directory of
-xfstests-bld.  This gets incorprated into the git-versions file found
+xfstests-bld.  This gets incorporated into the git-versions file found
 in the xfstests.tar.gz file, so that there will be a line like this in
 the file:
 
         e2fsprogs       v1.43.1-22-g25c4a20 (Wed, 8 Jun 2016 18:11:27 -0400)
 
-If you don't want to compile your own, very lastest, version of
+If you don't want to compile your own, very latest version of
 e2fsprogs, there is a newer version of e2fsprogs, compiled for the
 Debian Jessie distribution,
 [available](https://packages.debian.org/jessie-backports/admin/e2fsprogs)
diff --git a/Documentation/building-xfstests.md b/Documentation/building-xfstests.md
index 640451c..7de4aa2 100644
--- a/Documentation/building-xfstests.md
+++ b/Documentation/building-xfstests.md
@@ -2,7 +2,7 @@
 
 The xfstests-bld package makes it easy to build xfstests in a hermetic
 build environment (so it is not dependent on possibly out-of-date
-distro versions of libaio, xfsprogs, etc.).  This was the original 
+distro versions of libaio, xfsprogs, etc.).  This was the original
 raison d'etre for xfstests-bld, which explains why it was so named.
 
 ## Fetching the external git trees
@@ -45,7 +45,7 @@ needed.  They can be installed using the command:
 1.  Run "make clean"
 
 2.  Run "make".  This will run autoconf (if necessary) in the various
-subcompoents, run "make" or the equivalent to build all of the
+subcomponents, run "make" or the equivalent to build all of the
 subcomponents, and then finally run "make install" to install the
 build artifacts into the bld directory.  The actual work is done via
 the "build-all" script.
@@ -145,8 +145,8 @@ for the Debian armhf platform.
 
 The TOOLCHAIN_DIR shell variable can be used to specify the location
 for the alternate compiler toolchain if it is not your path.  For
-example, let's assume you've install the Android Native Delevelopment
-Toolkit (NDK) and used the make-standalone-toolchain.sh to install a
+example, let's assume you've installed the Android Native Development
+Kit (NDK) and used the make-standalone-toolchain.sh to install a
 toolchain in /u1/arm64-toolchain.  (See the [Android NDK
 documentation](https://developer.android.com/ndk/guides/standalone_toolchain.html)
 for more information.)  To use the standalone toolchain designed for
diff --git a/Documentation/gce-xfstests.md b/Documentation/gce-xfstests.md
index b0c0096..c677f3f 100644
--- a/Documentation/gce-xfstests.md
+++ b/Documentation/gce-xfstests.md
@@ -12,10 +12,10 @@ need to do a number of setup tasks:
 ## Get a Google Compute Engine account
 
 If you don't have GCE account, you can go to https://cloud.google.com
-and sign up for a free trial.  This will get you $300 dollars worth of
-credit which you can use over a 60 day period (as of this writing).
-Given that a full test for ext4 costs around a $1.50, and a smoke test
-costs pennies, that should be enough for plenty of testing.  :-)
+and sign up for a free trial.  This will get you $300 worth of credit
+which you can use over a 60 day period (as of this writing).  Given
+that a full test for ext4 costs around $1.50, and a smoke test costs
+pennies, that should be enough for plenty of testing.  :-)
 
 ### Setting up a GCE project
 
@@ -46,7 +46,7 @@ test VM's so that you don't have unexpected charges to your account.
 The gce-xfstests system needs a Google Cloud Storage (GCS) bucket to
 send kernel images to be tested and to save the results from the test
 runs.  If you are already using GCS you can use a pre-existing
-bucket, but it is strongly adviseable that you use a dedicated bucket
+bucket, but it is strongly advisable that you use a dedicated bucket
 for this purpose.  Detailed instructions for creating a new bucket can
 be found in the [GCS
 Quickstart](https://cloud.google.com/storage/docs/quickstart-console).
@@ -127,7 +127,7 @@ used):
 ## Configure gce-xfstests
 
 You will need to set up the following configuration parameters in
-~/.config/gce-xfststs:
+~/.config/gce-xfstests:
 
 * GS_BUCKET
   * The name of the Google Storage bucket which should be used by
@@ -219,7 +219,7 @@ are described below:
 
 Remotely login as root to a test instances.  This is a
 convenience shorthand for: "gcloud compute --project
-GCE_PROJECT ssh root@INSTNACE --zone GCE_ZONE".
+GCE_PROJECT ssh root@INSTANCE --zone GCE_ZONE".
 
 ### gce-xfstests console INSTANCE
 
@@ -287,7 +287,7 @@ Storage bucket.  This is a convenience command for
 ### gce-xfstests rm-results RESULT_FILE
 
 Delete a specified result tarball.  This is a convenience
-command for "gsutil ls gs://GS_BUCKET/RESULT_FILE".
+command for "gsutil rm gs://GS_BUCKET/RESULT_FILE".
 
 ### gce-xfstests get-results [--unpack | --summary | --failures ] RESULT_FILE
 
@@ -296,7 +296,7 @@ the Google Cloud Storage bucket.  The --summary or --failures
 option will cause the log file to be piped into the
 "get-results" script to summarize the log file using the "-s"
 or "-F" option, respectively.  The "--failures" or "-F" option
-results in a more succint summary than the "--summary" or "-s"
+results in a more succinct summary than the "--summary" or "-s"
 option.
 
 The --unpack option will cause the complete results directory
@@ -315,11 +315,11 @@ was created (in this case, August 13, 2016 at 22:26).
 
 This image will be created as part of an image family called xfstests.
 By default, when you start a test using gce-xfstests, the most
-recently created image in the xfstests image faily will be used.
+recently created image in the xfstests image family will be used.
 
 In order to use the xfstests image family created in your GCE project
 (instead of the xfstests-cloud project), add the following to your
-`/.config/gce-xfstests configuration file after the GCE_PROJECT
+`~/.config/gce-xfstests` configuration file after the GCE_PROJECT
 variable is defined:
 
         GCE_IMAGE_PROJECT="$GCE_PROJECT"
diff --git a/Documentation/kvm-quickstart.md b/Documentation/kvm-quickstart.md
index 0862ab4..94829c6 100644
--- a/Documentation/kvm-quickstart.md
+++ b/Documentation/kvm-quickstart.md
@@ -5,17 +5,18 @@
         apt-get install qemu-kvm
 
 2.  Run the following commands to install the xfstests-bld repository
-and download a pre-compiled test 6appliance image.  We use the 32-bit
-test appliance here since it can support both 32-bit and 64-bit kernels.
+    and download a pre-compiled test appliance image.  We use the
+    32-bit test appliance here since it can support both 32-bit and
+    64-bit kernels.
 
         git clone git://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git fstests
         cd fstests/kvm-xfstests
         wget -O test_appliance/root_fs.img https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/root_fs.img.i386
 
-3.  Build a kernel with all of the necessary drives for kvm built into
-    the kernel.  No modules should be used, since kvm-xfstests will
-    run the kernel directly from the build tree. This means that there
-    is no need to install any modules or create an initrd, which
+3.  Build a kernel with all of the necessary drivers for kvm built
+    into the kernel.  No modules should be used, since kvm-xfstests
+    will run the kernel directly from the build tree. This means that
+    there is no need to install any modules or create an initrd, which
     significantly speeds up the edit, compile, test, debug development
     cycle.  There are sample 32-bit and 64-bit kernels in the
     kernel-configs directory; pick one whose version number is close
@@ -31,11 +32,11 @@ test appliance here since it can support both 32-bit and 64-bit kernels.
         TZ=America/New_York
         KERNEL=/build/ext4/arch/x86/boot/bzImage
 
-6.  In the top-level directory of your checked outxfstests-git
-repository, run "make kvm-xfstests.sh" and then copy this generated
-file to a directory which is your shell's PATH.  This allows you to
-run the kvm-xfstests binary without needing to set the working
-directory to the kvm-tests directory.
+6.  In the top-level directory of your checked out xfstests-bld
+    repository, run "make kvm-xfstests.sh" and then copy this
+    generated file to a directory which is your shell's PATH.  This
+    allows you to run the kvm-xfstests binary without needing to set
+    the working directory to the kvm-xfstests directory.
 
         cd fstests
         make kvm-xfstests.sh
diff --git a/Documentation/kvm-xfstests.md b/Documentation/kvm-xfstests.md
index b85bb7e..c480e4a 100644
--- a/Documentation/kvm-xfstests.md
+++ b/Documentation/kvm-xfstests.md
@@ -41,8 +41,9 @@ Please see the relevant documentation files for more details.
 The configuration file for kvm-xfstests is found in the kvm-xfstests
 directory and is named config.  You can edit this file directly, but
 the better thing to do is to place override values in
-~/config/kvm-xfstests or in kvm-xfststs/config.custom.  Please look at
-the kvm-xfstests/config file to see the shell variables you can set.
+~/.config/kvm-xfstests or in kvm-xfstests/config.custom.  Please look
+at the kvm-xfstests/config file to see the shell variables you can
+set.
 
 Perhaps the most important configuration variable to set is KERNEL.
 This should point at the default location for the kernel that qemu
@@ -51,8 +52,8 @@ primary build tree that you use for kernel development.  Please use as
 the base for the .config file one of the kernel configurations from
 the kernel-config directory.  It is important that the kernel have all
 of the paravirtual device driver support needed for qemu included in
-the base kernel, since any modules will be ignored, and test appliance
-does not use an initial ramdisk.
+the base kernel, since any modules will be ignored, and the test
+appliance does not use an initial ramdisk.
 
 By default, the scratch disks used by test-appliance will be set up
 automatically, and are stored in the kvm-xfstests directory with the
@@ -86,8 +87,8 @@ kvm-xfstests/kvm-xfstests shell script.
 
 Please run "kvm-xfstests help" to get a quick summary of the available
 command-line syntax.  Not all of the available command-line options
-are documented; some of the more specialized optiosn will require that
-you Read The Fine Source --- in particular, in the auxliary script
+are documented; some of the more specialized options will require that
+you Read The Fine Source --- in particular, in the auxiliary script
 file found in kvm-xfstests/util/parse_cli.
 
 ### Running file system tests
@@ -114,8 +115,8 @@ which runs a subset of the tests designed for a fast smoke test.
 For developer convenience, "kvm-xfstests smoke" is short-hand for
 "kvm-xfstests -c 4k -g quick", which runs the fast subset of tests
 using just 4k block file system configuration.  In addition
-"kvm-xfstests full" is short-hand for "kvm-xfstests -g quto" which
-runs all of the tests using a large set of file system configuration.
+"kvm-xfstests full" is short-hand for "kvm-xfstests -g auto" which
+runs all of the tests using a large set of file system configurations.
 This will take quite a while, so it's best run overnight.  (Or it may
 be better to run the full set of tests using gce-xfstests.)
 
@@ -151,7 +152,7 @@ While kvm-xfstests is running, you can telnet to a number of TCP ports
 (which are bound to localhost).  Ports 7500, 7501, and 7502 will
 connect you to a shell prompts while the tests are running (if you
 want to check on /proc/slabinfo, enable tracing, etc.)  You can also
-use these ports in conjuction with "kvm-xfstests shell" if you want
+use these ports in conjunction with "kvm-xfstests shell" if you want
 additional windows to capture traces using ftrace.
 
 You can also access the qemu monitor on port 7498, and you can debug the
diff --git a/Documentation/what-is-xfstests.md b/Documentation/what-is-xfstests.md
index 1ad3cb7..8bdf7ea 100644
--- a/Documentation/what-is-xfstests.md
+++ b/Documentation/what-is-xfstests.md
@@ -13,12 +13,12 @@ will run a full set of xfstests before sending patches to Linus, and
 will require that any major changes be tested using xfstests before
 they are submitted for integration.
 
-## Individal tests in xfstests
+## Individual tests in xfstests
 
 Tests in xfstests were originally named using a three digit number.
 In 2013 the tests were moved into different classes, depending on
 whether the test was file system specific, "generic" (meaning it was
-was file system indepedent), or "shared" (meaning that test was not
+was file system independent), or "shared" (meaning that test was not
 truly generic, but which was useful on a handful of file systems).  In
 this scheme, tests would have names such as:
 
@@ -77,9 +77,9 @@ sometimes called the TEST-1K device -- although there are many other
 file system configurations which will use /dev/vdd.
 
 The /dev/vde and /dev/vdf file systems are the BIGTEST and BIGSCRATCH
-disks, and are used for those file system configrations which require
+disks, and are used for those file system configurations which require
 a 20GB TEST and SCRATCH device.  Like the TEST-1K device, the BIGTEST
-device will be reformated using mke2fs at the beginning of an xfstests
+device will be reformatted using mke2fs at the beginning of an xfstests
 run for that file system configuration.
 
 The gce-xfstests uses the same set of block devices, although instead
diff --git a/README b/README
index ee1ba0f..ef87668 100644
--- a/README
+++ b/README
@@ -16,7 +16,7 @@ and create something which works for your distribution.  Please let me
 know if create something which works well for other distributions.
 
 1.  "make ; make tarball" to generate the xfstests.tar.gz file.
-2.  cd to kvm-xfststs/test-appliance, and run as root the shell script
+2.  cd to kvm-xfstests/test-appliance, and run as root the shell script
     "gen-image".  This will create the root_fs.img file.
 3.  build a kernel which does not use modules (at least for all of the
     device drivers required for running under kvm).  There are sample
@@ -25,7 +25,7 @@ know if create something which works well for other distributions.
     to build the root_fs.img file in 32-bit build chroot.  You can use
     a 32-bit userspace with a 64-bit kernel; in fact, this is a good
     way to sanity check the ioctl compatibility code.
-4.  Adjust the KERNEL= line in kvm-xfststs/config to point at your
+4.  Adjust the KERNEL= line in kvm-xfstests/config to point at your
     kernel's bzImage file.
 5.  cd to kvm-xfstests, and run "kvm-xfstests smoke".  More details of
     how to run kvm-xfstests can be found in kvm-xfstests/README.  If
diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
index 84f5761..6dae32f 100644
--- a/kvm-xfstests/util/parse_cli
+++ b/kvm-xfstests/util/parse_cli
@@ -43,12 +43,12 @@ print_help ()
     echo "xfstest names have the form: ext4/NNN generic/NNN shared/NNN"
     echo ""
     if test "$GCE_XFSTESTS" = "yes" ; then
-	echo "Common gce-xfststs commands:"
+	echo "Common gce-xfstests commands:"
         echo "	ls		- List running xfstests instances"
         echo "	abort		- Abort a xfstests instance"
         echo "	ls-results	- List saved test results"
         echo "	get-results	- Get and display a specified test result"
-        echo "	setup		- Set up gce-xfststs (only needs to be run once)"
+        echo "	setup		- Set up gce-xfstests (only needs to be run once)"
         echo "	ssh		- Login to a running test instance"
         echo "	console		- Get the console messages from a test instance"
         echo "	serial		- Attach to the serial port of a test instance"
-- 
2.8.0.rc3.226.g39d4020

