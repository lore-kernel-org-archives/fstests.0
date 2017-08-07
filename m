Received: from mail-pf0-f195.google.com ([209.85.192.195]:34053 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdHGTze (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2017 15:55:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id t86so1298910pfe.1
        for <fstests@vger.kernel.org>; Mon, 07 Aug 2017 12:55:33 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 3/4] xfstests-bld: update documentation for building xfstests and appliances
Date: Mon,  7 Aug 2017 12:52:56 -0700
Message-Id: <20170807195257.61176-4-ebiggers3@gmail.com>
In-Reply-To: <20170807195257.61176-1-ebiggers3@gmail.com>
References: <20170807195257.61176-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Make it clear that a Debian build chroot is effectively required when
building xfstests and its dependencies for one of the test appliances,
document how to use the 'setup-buildchroot' script rather than setting
up chroots manually, and document how to use the 'do-all' convenience
script to build both kvm-xfstests and android-xfstests test appliances.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/android-xfstests.md  |   6 +-
 Documentation/building-rootfs.md   |  72 ++++++++++--
 Documentation/building-xfstests.md | 227 ++++++++++++++-----------------------
 Documentation/kvm-xfstests.md      |   7 +-
 4 files changed, 154 insertions(+), 158 deletions(-)

diff --git a/Documentation/android-xfstests.md b/Documentation/android-xfstests.md
index a93b35c..26ff2fd 100644
--- a/Documentation/android-xfstests.md
+++ b/Documentation/android-xfstests.md
@@ -35,9 +35,9 @@ devices.  If you encounter a problem, please submit a fix!
   xfstests-bld scripts.  Either fetch the prebuilt
   armhf_root_fs.tar.gz from
   [kernel.org](http://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests),
-  or build one yourself on a Debian ARM build server as described in
-  [building-xfstests](building-xfstests.md).  Then, either put the
-  chroot tarball in the default location of
+  or build one yourself as described in
+  [building-rootfs](building-rootfs.md).  Then, either put the chroot
+  tarball in the default location of
   kvm-xfstests/test-appliance/armhf_root_fs.tar.gz, or specify it with
   ROOT_FS in your ~/.config/android-xfstests or the -I option to
   android-xfstests.
diff --git a/Documentation/building-rootfs.md b/Documentation/building-rootfs.md
index 8665919..720eed7 100644
--- a/Documentation/building-rootfs.md
+++ b/Documentation/building-rootfs.md
@@ -1,13 +1,69 @@
-# Building the root_fs.img file
+# Building the test appliance
 
-The root_fs.img file is used as the test appliance VM for
-kvm-xfstests.  It consists of a Debian Jessie root file system, some
-configuration files and test runner scripts, and the xfstests.tar.gz
-unpacked in the /root directory.  It is built using the gen-image
-script found in kvm-xfstests/test-appliance.
+## Overview
 
-The gen-image script must be run as root, as it creates a file system
-and mounts it as part of the root_fs construction process.
+For kvm-xfstests, a `root_fs.img` disk image file is used as the test
+VM's root filesystem, while for android-xfstests the tests are run in
+a chroot directory created by unpacking a file `root_fs.tar.gz`.  Both
+types of `root_fs` contain a Debian Jessie root filesystem, some
+configuration files and test runner scripts, and the `xfstests.tar.gz`
+unpacked in the `/root` directory.
+
+Briefly, building either type of `root_fs` requires setting up a
+Debian build chroot and building the xfstests tarball as described in
+[building-xfstests](building-xfstests.md), then running the
+`gen-image` script.  The `do-all` script can automate this process
+slightly, as described below.
+
+## Using gen-image
+
+After building the xfstests tarball as described in
+[building-xfstests](building-xfstests.md), a `root_fs` may be built
+using the `gen-image` script found in `kvm-xfstests/test-appliance/`.
+By default `gen-image` builds a `root_fs.img`; in this case,
+`gen-image` must be run as root, since it creates a filesystem and
+mounts it as part of the `root_fs` construction process.  To build a
+`root_fs.tar.gz` instead, pass the `--out-tar` option.
+
+Example:
+
+    cd kvm-xfstests/test-appliance
+    sudo ./gen-image
+
+## Using the do-all convenience script
+
+To more easily build a test appliance, you can use the `do-all`
+convenience script.  `do-all` will build the xfstests tarball, then
+invoke `gen-image` to build a `root_fs`.  It allows specifying the
+build chroot to use as well as whether a `root_fs.img` or
+`root_fs.tar.gz` should be created.
+
+For kvm-xfstests, use one of the following commands to create an i386
+or amd64 test appliance, respectively:
+
+    ./do-all --chroot=jessie-i386  --no-out-tar
+    ./do-all --chroot=jessie-amd64 --no-out-tar
+
+For android-xfstests, use one of the following commands to create an
+armhf or arm64 test appliance, respectively:
+
+    ./do-all --chroot=jessie-armhf --out-tar
+    ./do-all --chroot=jessie-arm64 --out-tar
+
+The build chroot(s) can be created using the `setup-buildchroot`
+script as described in [building-xfstests](building-xfstests.md).
+Note that you do not need to be running an ARM system to create the
+ARM test appliances, since the `setup-buildchroot` script supports
+foreign chroots using QEMU user-mode emulation.
+
+You may also set the shell variables `BUILD_ENV`, `SUDO_ENV`, and/or
+`OUT_TAR` in your `config.custom` file to set defaults for `do-all`.
+For example, if you'd like to default to building an amd64
+kvm-xfstests appliance, use:
+
+    BUILD_ENV="schroot -c jessie-amd64 --"
+    SUDO_ENV="schroot -c jessie-amd64 -u root --"
+    OUT_TAR=
 
 ## Adding additional packages
 
diff --git a/Documentation/building-xfstests.md b/Documentation/building-xfstests.md
index 93f6de1..dfd9da7 100644
--- a/Documentation/building-xfstests.md
+++ b/Documentation/building-xfstests.md
@@ -36,171 +36,114 @@ The build also supports some optional repositories which are only
 included when their URLs are uncommented in the config file; see the
 config file for a full list.
 
-## Installing the necessary packages to build xfstests
+## Choosing a build type
 
-In order to build xfstests, a number of prerequisite packages are
-needed.  They can be installed using the command:
+xfstests-bld can be used to build xfstests and its dependencies for
+one of the official "test appliances"
+([kvm-xfstests](kvm-xfstests.md), [gce-xfstests](gce-xfstests.md),
+[android-xfstests](android-xfstests.md), etc.), then optionally build
+the test appliance itself.  This normally requires using a Debian
+build chroot.  Alternatively, xfstests-bld can be used to build
+xfstests and its dependencies for a different environment, such as for
+the native system, without using a build chroot.
 
-        % sudo apt-get install build-essential autoconf autoconf2.64 \
-                automake libgdbm-dev libtool-bin qemu-utils gettext \
-                e2fslibs-dev git debootstrap fakechroot libdbus-1-3 \
-                autopoint pkg-config symlinks ca-certificates bison
-
-## Building the xfstests tarball
-
-1.  Run "make clean"
-
-2.  Run "make".  This will run autoconf (if necessary) in the various
-subcomponents, run "make" or the equivalent to build all of the
-subcomponents, and then finally run "make install" to install the
-build artifacts into the bld directory.  The actual work is done via
-the "build-all" script.
-
-3.  Run "make tarball".  This will copy the files actually needed to
-run xfstests into the xfstests scratch directory, and then create the
-xfstests.tar.gz file.  The actual work is done by the "gen-tarball"
-script.
-
-## Build environments for xfstests
-
-There are three important aspects of the environment in which the
-xfstests binaries are built.
-
-* The build utilities: autoconf, automake, libtool, etc.
-* The compiler toolchain: gcc, binutils, ranlib, strip, etc.
-* The (shared) libraries used for linking the executables
+### Preparing a build chroot
 
-In practice, the largest impact will be the compiler toolchain; and on
-the x86 platform, whether 32-bit or 64-bit binaries are generated.
+To build xfstests and its dependencies for one of the official test
+appliances, it is strongly recommended to use a Debian build chroot.
+Using a build chroot ensures that an appropriate compiler toolchain is
+used and that the binaries are linked to the appropriate shared
+libraries.  In addition, using QEMU user-mode emulation it is possible
+to create a chroot for a foreign architecture, making it easy to do
+cross-architecture builds.
 
-The subsections listed below are optional, in that if you are only
-interested in building 64-bit x86 binaries to be run on a 64-bit x86
-kernel, you can probably use your desktop Linux environment to build
-the xfstests.tar.gz file.  However, there reasons why you may want to
-use a more sophisticated way of building xfstests.
+To set up a Debian build chroot, run the `setup-buildchroot` script.
+`setup-buildchroot` will invoke `debootstrap` to bootstrap a minimal
+Debian Jessie system into a directory (by default a subdirectory of
+`/chroots/`), then set it up for use with `schroot` and install into
+it all the Debian packages needed for the build.  `setup-buildchroot`
+must be run as root, since it needs root permission to run
+`debootstrap` and update `/etc/schroot/schroot.conf`.
 
-For example, by default xfstests-bld will link the binaries statically
-to avoid problems between the build environment and the runtime
-environment.  However, statically linked binaries are significantly
-larger.  Using a chroot environment to guarantee that the runtime and
-build environments are in sync results in substantial space savings
-(almost an order of magnitude) since it becomes safe to use
-dynamically linked executables.
-
-
-### Building in a chroot environment
+`setup-buildchroot` supports setting up a chroot using any
+architecture supported by Debian.  For kvm-xfstests appliances, you'll
+need either an i386 or amd64 chroot:
 
-These instructions assumes you are using Debian; they should probably
-work for Ubuntu as well.
+    $ sudo ./setup-buildchroot --arch=i386
+    $ sudo ./setup-buildchroot --arch=amd64
 
-If you want to build a 64-bit test image, just remove the --arch=i386
-in step #3, and use a schroot name of "jessie-64" instead of
-"jessie-32".
+For gce-xfstests test appliances, you'll need an amd64 chroot:
 
-1. Install the necessary packages to build host OS
+    $ sudo ./setup-buildchroot --arch=amd64
 
-        % sudo apt-get install schroot debootstrap
+For android-xfstests test appliances, you'll need an armhf or arm64
+chroot:
 
-2.  Add the following to /etc/schroot/schroot.conf, replacing "tytso"
-with your username, and /u1/jessie-32 with path where you plan to
-put your build chroot
+    $ sudo ./setup-buildchroot --arch=armhf
+    $ sudo ./setup-buildchroot --arch=arm64
 
-        [jessie-32]
-        description=Debian Jessie 32-bit
-        type=directory
-        directory=/u1/jessie-32
-        users=tytso,root
-        root-users=tytso
+Normally ARM will be a foreign architecture, so `setup-buildchroot`
+will walk you through installing the needed QEMU binary and
+binfmt_misc support to get QEMU user-mode emulation working.
+Afterwards, it will behave just like a native chroot.
 
-3. Create the build chroot (again, replace /u1/jessie-root with the
-pathname to your build chroot directory):
+Once you're created a chroot, you should be able to use the `schroot`
+program to enter it, e.g.:
 
-        % cd /u1
-        % sudo debootstrap --arch=i386 jessie /u1/jessie-32
-        % schroot -c jessie-32 -u root
-        (jessie-32)root@closure:/u1# apt-get install build-essential \
-                autoconf autoconf2.64 automake libgdbm-dev libtool-bin \
-                qemu-utils gettext e2fslibs-dev git debootstrap fakechroot \
-                libdbus-1-3 autopoint pkg-config symlinks ca-certificates \
-                bison
-        (jessie-32)root@closure:/u1# exit
+    $ schroot -c jessie-amd64         # enter chroot as regular user
+    $ schroot -c jessie-amd64 -u root # enter chroot as root
 
-4. Copy config to config.custom, and then change the lines which
-define SUDO_ENV and BUILD_ENV to:
+The `-c` option must specify the name of the chroot as listed in
+`/etc/schroot/schroot.conf`.  By default `setup-buildchroot` names the
+chroots after the Debian release and architecture.
 
-        SUDO_ENV="schroot -c jessie-32 -u root --"
-        BUILD_ENV="schroot -c jessie-32 --"
+### Without a build chroot
 
-5. Kick off the build!
+If you want to use xfstests-bld without a dedicated build chroot, a
+number of prerequisite packages are needed.  They can be installed
+using the following command:
 
-        ./do-all
-
-
-### Using an alternate compiler toolchain
-
-A common reason for using an alternate compiler toolchain is to allow
-you to cross-compile xfstests for a different target architecture.
-This is done by setting the CROSS_COMPILE and TOOLCHAIN_DIR shell
-variables in the top-level config file, or (this is preferable) in the
-config.custom file.
-
-To use an alternate toolchain, the shell variable CROSS_COMPILE
-should be set to the target architecture.  For example, on a Debian
-stretch system, you can install the gcc-arm-linux-gnueabihf to build package
-and then set CROSS_COMPILE to "arm-linux-gnueabihf" to cross compile
-for the Debian armhf platform.
-
-The TOOLCHAIN_DIR shell variable can be used to specify the location
-for the alternate compiler toolchain if it is not your path.  For
-example, let's assume you've installed the Android Native Development
-Kit (NDK) and used the make-standalone-toolchain.sh to install a
-toolchain in /u1/arm64-toolchain.  (See the [Android NDK
-documentation](https://developer.android.com/ndk/guides/standalone_toolchain.html)
-for more information.)  To use the standalone toolchain designed for
-Android, configure TOOLCHAIN_DIR to /u1/arm64-toolchain and
-CROSS_COMPILE to aarch64-linux-android.
-
-### Instructions for building an armhf root_fs.tar.gz file
+    $ sudo apt-get install build-essential autoconf autoconf2.64 \
+                automake libgdbm-dev libtool-bin qemu-utils gettext \
+                e2fslibs-dev git debootstrap fakechroot libdbus-1-3 \
+                autopoint pkg-config symlinks ca-certificates bison
 
-The armhf_root_fs.tar.gz file is used for testing file systems on
-Android devices, and was generated as follows:
+It is also possible to use a cross compiler rather than the native
+compiler.  To do this, set the shell variables `CROSS_COMPILE` and
+optionally `TOOLCHAIN_DIR` in your `config.custom` file as follows:
 
-1.  Copy the xfstests-bld git tree to a debian build host running the
-armhf platform.
+* `CROSS_COMPILE` should be set to the target triplet.  For example,
+  on a Debian stretch system, you can install the
+  `gcc-arm-linux-gnueabihf` package and then set
+  `CROSS_COMPILE=arm-linux-gnueabihf` to cross compile for the Debian
+  armhf platform.
 
-2.  Set up a Debian Stable (Jessie) build environment and enter it.  For
-example, if you are doing this on a Debian build server, assuming you
-are a Debian developer with access to the Debian build architecture (I
-was using harris.debian.org)
+* `TOOLCHAIN_DIR` can be set to the directory containing the
+  cross-compiler toolchain, if it is not already on your `$PATH`.  It
+  should specify the directory one level above the `bin` directory
+  containing the compiler executable file.
 
-        schroot -b -c jessie -n tytso-jessie
-        dd-schroot-cmd -c tytso-jessie apt-get install build-essential \
-                autoconf autoconf2.64 automake libgdbm-dev libtool-bin \
-                qemu-utils gettext e2fslibs-dev git debootstrap \
-                fakechroot libdbus-1-3 autopoint pkg-config symlinks rsync \
-                ca-certificates bison
-        schroot -r -c tytso-jessie
-Alternatively, make sure the build system is installed with Debian
-Stable (e.g., Jessie), and install the following packages:
+## Building the xfstests tarball
 
-        % apt-get install build-essential build-essential \
-                autoconf autoconf2.64 automake libgdbm-dev libtool-bin \
-                qemu-utils gettext e2fslibs-dev git debootstrap \
-                fakechroot libdbus-1-3 autopoint pkg-config symlinks rsync \
-                ca-certificates bison
+You may skip explicitly building the xfstests tarball if you are using
+the `do-all` convenience script to build a test appliance, as
+described in [building-rootfs](building-rootfs.md).  Otherwise, you
+can build the tarball as follows:
 
-3.  Build the xfstests.tar.gz file (which contains the actual xfstests binaries built for armhf)
+    $BUILD_ENV make clean
+    $BUILD_ENV make
+    $BUILD_ENV make tarball
 
-        cd xfstests-bld
-        make
-        make tarball
+... where `BUILD_ENV` should be set to `"schroot -c $CHROOT_NAME --"`
+for a chroot build environment (where `$CHROOT_NAME` should be
+replaced with the name of the chroot as listed in
+`/etc/schroot/schroot.conf`) or an empty string otherwise.
 
-4.   Create the root_fs.tar.gz chroot environment
+Briefly, these `make` targets do the following tasks:
 
-        cd kvm-xfstests/test-appliance
-        ./gen-image --out-tar
-
-5.  If you are on a Debian build server, clean up after yourself.
-
-        schroot -e -c tytso-jessie
-        rm -rf /home/tytso/xfstests-bld
+* `make clean` cleans the various components.
+* `make` (or equivalently `make all`) builds the various subcomponents
+  and installs them into the `bld` directory.
+* `make tarball` copies the files actually needed to run xfstests into
+  the `xfstests` scratch directory, then creates `xfstests.tar.gz` by
+  running the `gen-tarball` script.
diff --git a/Documentation/kvm-xfstests.md b/Documentation/kvm-xfstests.md
index 8ed8a9e..68c4f10 100644
--- a/Documentation/kvm-xfstests.md
+++ b/Documentation/kvm-xfstests.md
@@ -30,11 +30,8 @@ addition, if you use the 64-bit kernel with 32-bit interfaces, it
 tests the 32-bit compat ioctl code paths, which otherwise may not get
 sufficient testing.
 
-If you want to build your own test appliance VM, you will first need
-to [build the xfstests.tar.gz tarball](building-xfstests.md) which
-contains the file system tests and its dependencies, and then use the
-gen-image script to [build the root_fs image](building-rootfs.md).
-Please see the relevant documentation files for more details.
+If you want to build your own test appliance VM, see
+[building-rootfs.md](building-rootfs.md).
 
 ## Setup and configuration
 
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

