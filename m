Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21019C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 19:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbiEXT1F (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiEXT1E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 15:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF406CF61
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 12:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79C87615CA
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 19:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B3FC34100;
        Tue, 24 May 2022 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653420420;
        bh=5Ld9hmyaFFPaXDBMzxM2VPUnz+8dZcpp63AGdvX9n2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjknBq0RiCUBkZjmtwZbCUmoy0+F2SVX7pJIcF+sLqaEKtBp+cOOp9WnnLAsFW72S
         +DTP6uQzXdza90PTcwOdjRUeFYCc2U8HfAkyLpmc7zxhIhRK0YXLysowlcL4fTG8O9
         fkgI6eV+VzPJJTdNSXWcXdDmkh6ITWjWylwmVuuaHiAtkofW/tFLzeKiuDDPnsANj8
         OHjwp0rSx2MuQRCvTQP7MDNHS5hROP5jnFieNHFo01KKsAPP5m7gLjpW9uOxZO6CxY
         TCAf7m76nLkdyyljt2g1/xrTEzZi1eWVA1dk3bxzfj/rwyoLB3zJF0rkPm921JwheP
         7FeQKZgTobyNg==
Date:   Tue, 24 May 2022 19:26:59 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, enwlinux@gmail.com,
        leah.rumancik@gmail.com, harshadshirwadkar@gmail.com
Subject: Re: Directory reorganization in xfstests-bld pushed out
Message-ID: <Yo0xg6BofOdo6dGu@gmail.com>
References: <YozjGjNv9dEW/m0L@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YozjGjNv9dEW/m0L@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 09:52:26AM -0400, Theodore Ts'o wrote:
> I've justed pushed out a change to the xfstests-bld directory which is
> especially disruptive for people who are building test appliances
> using xfstests-bld.
> 
> The directory structure in xfstests-bld reflects its original design
> as a hermetic build system for xfstests.  However, these days, its
> primary focus is the an test appliance featuring xfstests (but these
> days, we also support blktests the Phoronix test suite, etc.) and
> drivers to run the test appliance on a variety of environments ---
> e.g., kvm-xfstests, gce-xfstests, and android-xfstests.
> 
> To make life easier for new users of xfstests-bld, especially who want
> to use kvm-xfstests, I've reorganized the directory structure and
> moved around files and directories so they are sorted into four
> top-level directories:
>     
>     fstests-bld		The hermetic build system for xfstests
>     test-appliance	The test runner infrastructure for xfstests (and blktests
> 			and Phoronix Test Suite....)
>     run-fstests		The test runner command line utilities, namely kvm-xfstests,
> 			gce-xfstests, etc.
>     build-kernel	Utilities to build and configure the Linux kernel in a
> 			standard way which is easy for the test runners to run.
>     
> There is a script in fstests-bld/misc/post-reorg-cleanup which may be
> helpful in moving the external repos and other files to the proper
> places after this reorganization.  Please take a look at it before
> running it, and I recommend that you use the --no-action option first.
> Since the most developers will only need to run the script once, it
> may be a little rough, and it does delete some files and directories.
> 

Thanks Ted!  It looks like some of the documentation still needs to be updated;
can you consider the following patch?

From 3b71e78b41f292107b819804eb6ec2fe8038dd65 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@google.com>
Date: Tue, 24 May 2022 19:15:08 +0000
Subject: [PATCH] Fix up some documentation following the reorganization

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/building-rootfs.md         | 54 ++++++++++++------------
 Documentation/building-xfstests.md       |  6 +--
 Documentation/kvm-quickstart.md          | 10 ++---
 Documentation/kvm-xfstests.md            | 14 +++---
 Documentation/ltm-kcs-developer-notes.md |  6 +--
 build-appliance                          |  4 +-
 config                                   | 10 ++---
 setup-buildchroot                        |  5 ++-
 8 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/Documentation/building-rootfs.md b/Documentation/building-rootfs.md
index 13c53a5..226de7a 100644
--- a/Documentation/building-rootfs.md
+++ b/Documentation/building-rootfs.md
@@ -12,8 +12,8 @@ unpacked in the `/root` directory.
 Briefly, building either type of `root_fs` requires setting up a
 Debian build chroot and building the xfstests tarball as described in
 [building-xfstests](building-xfstests.md), then running the
-`gen-image` script.  The `do-all` script can automate this process
-slightly, as described below.
+`gen-image` script.  The `build-appliance` script can automate this
+process slightly, as described below.
 
 ## Using a proxy
 
@@ -23,42 +23,42 @@ following line (replacing server:port with your actual settings)
     export http_proxy='http://server:port'
 
 to config.custom in both the root directory of your xfstest-bld checkout
-and to kvm-xfstests/test-appliance.
+and in `test-appliance/`.
 
 ## Using gen-image
 
 After building the xfstests tarball as described in
 [building-xfstests](building-xfstests.md), a `root_fs` may be built
-using the `gen-image` script found in `kvm-xfstests/test-appliance/`.
-By default `gen-image` builds a `root_fs.img`; in this case,
-`gen-image` must be run as root, since it creates a filesystem and
-mounts it as part of the `root_fs` construction process.  To build a
-`root_fs.tar.gz` instead, pass the `--out-tar` option.
+using the `gen-image` script found in `test-appliance/`.  By default
+`gen-image` builds a `root_fs.img`; in this case, `gen-image` must be
+run as root, since it creates a filesystem and mounts it as part of
+the `root_fs` construction process.  To build a `root_fs.tar.gz`
+instead, pass the `--out-tar` option.
 
 Example:
 
-    cd kvm-xfstests/test-appliance
+    cd test-appliance
     sudo ./gen-image
 
-## Using the do-all convenience script
+## Using the build-appliance script
 
-To more easily build a test appliance, you can use the `do-all`
-convenience script.  `do-all` will build the xfstests tarball, then
-invoke `gen-image` to build a `root_fs`.  It allows specifying the
-build chroot to use as well as whether a `root_fs.img` or
-`root_fs.tar.gz` should be created.
+To more easily build a test appliance, you can use the
+`build-appliance` script.  `build-appliance` will build the xfstests
+tarball, then invoke `gen-image` to build a `root_fs`.  It allows
+specifying the build chroot to use as well as whether a `root_fs.img`
+or `root_fs.tar.gz` should be created.
 
 For kvm-xfstests, use one of the following commands to create an i386
 or amd64 test appliance, respectively:
 
-    ./do-all --chroot=bullseye-i386  --no-out-tar
-    ./do-all --chroot=bullseye-amd64 --no-out-tar
+    ./build-appliance --chroot=bullseye-i386  --no-out-tar
+    ./build-appliance --chroot=bullseye-amd64 --no-out-tar
 
 For android-xfstests, use one of the following commands to create an
 armhf or arm64 test appliance, respectively:
 
-    ./do-all --chroot=bullseye-armhf --out-tar
-    ./do-all --chroot=bullseye-arm64 --out-tar
+    ./build-appliance --chroot=bullseye-armhf --out-tar
+    ./build-appliance --chroot=bullseye-arm64 --out-tar
 
 The build chroot(s) can be created using the `setup-buildchroot`
 script as described in [building-xfstests](building-xfstests.md).
@@ -67,9 +67,9 @@ ARM test appliances, since the `setup-buildchroot` script supports
 foreign chroots using QEMU user-mode emulation.
 
 You may also set the shell variables `BUILD_ENV`, `SUDO_ENV`, and/or
-`OUT_TAR` in your `config.custom` file to set defaults for `do-all`.
-For example, if you'd like to default to building an amd64
-kvm-xfstests appliance, use:
+`OUT_TAR` in your `config.custom` file to set defaults for
+`build-appliance`.  For example, if you'd like to default to building
+an amd64 kvm-xfstests appliance, use:
 
     BUILD_ENV="schroot -c bullseye-amd64 --"
     SUDO_ENV="schroot -c bullseye-amd64 -u root --"
@@ -82,11 +82,11 @@ The first is to supply the package name(s) on the command line, using
 the -a option.
 
 The second is to copy the debian packages into the directory
-kvm-xfstests/test-appliance/debs.  This is how the official packages
-on kernel.org have an updated version of e2fsprogs and its support
-packages (e2fslibs, libcomerr2, and libss2).  The latest versions get
-compiled for Debian Bullseye, in a hermetic build environment, and
-placed in the debs directory.  Optionally, the output of the script
+test-appliance/debs.  This is how the official packages on kernel.org
+have an updated version of e2fsprogs and its support packages
+(e2fslibs, libcomerr2, and libss2).  The latest versions get compiled
+for Debian Bullseye, in a hermetic build environment, and placed in
+the debs directory.  Optionally, the output of the script
 [get-ver](https://git.kernel.org/cgit/fs/ext2/e2fsprogs.git/tree/util/get-ver)
 is placed in the e2fsprogs.ver in the top-level directory of
 xfstests-bld.  This gets incorporated into the git-versions file found
diff --git a/Documentation/building-xfstests.md b/Documentation/building-xfstests.md
index 8e318dd..fe6677a 100644
--- a/Documentation/building-xfstests.md
+++ b/Documentation/building-xfstests.md
@@ -130,9 +130,9 @@ optionally `TOOLCHAIN_DIR` in your `config.custom` file as follows:
 ## Building the xfstests tarball
 
 You may skip explicitly building the xfstests tarball if you are using
-the `do-all` convenience script to build a test appliance, as
-described in [building-rootfs](building-rootfs.md).  Otherwise, you
-can build the tarball as follows:
+the `build-appliance` script to build a test appliance, as described
+in [building-rootfs](building-rootfs.md).  Otherwise, you can build
+the tarball as follows:
 
     $BUILD_ENV make clean
     $BUILD_ENV make
diff --git a/Documentation/kvm-quickstart.md b/Documentation/kvm-quickstart.md
index 5228831..bbab180 100644
--- a/Documentation/kvm-quickstart.md
+++ b/Documentation/kvm-quickstart.md
@@ -14,12 +14,12 @@
         wget -O test-appliance/root_fs.img https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/root_fs.img.i386
 
 3.  In the top-level directory of your checked out xfstests-bld
-    repository, run "make kvm-xfstests.sh" and then copy this
-    generated file to a directory which is your shell's PATH.  This
-    allows you to run the kvm-xfstests binary without needing to set
-    the working directory to the kvm-xfstests directory.
+    repository, run "make kvm-xfstests" and then copy this generated
+    file to a directory which is your shell's PATH.  This allows you
+    to run the kvm-xfstests binary without needing to set the
+    working directory to the kvm-xfstests directory.
 
-        make
+        make kvm-xfstests
         cp kvm-xfstests ~/bin/kvm-xfstests
 
 4.  In the fstests/run-fstests/ directory, take a look at the
diff --git a/Documentation/kvm-xfstests.md b/Documentation/kvm-xfstests.md
index 15bcb06..c0a5337 100644
--- a/Documentation/kvm-xfstests.md
+++ b/Documentation/kvm-xfstests.md
@@ -19,8 +19,8 @@ You will find there a 32-bit test appliance named
 [root_fs.img.i386](https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/root_fs.img.i386)
 and a 64-bit test appliance named
 [root_fs.img.amd64](https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/root_fs.img.amd64).
-This file should be installed as root_fs.img in the
-kvm-xfstests/test-appliance directory.
+This file should be installed as root_fs.img in the test-appliance
+directory.
 
 A 64-bit x86 kernel can use both the 32-bit and 64-bit test appliance
 VM, since you can run 32-bit ELF binaries using a 64-bit kernel.
@@ -35,11 +35,9 @@ If you want to build your own test appliance VM, see
 
 ## Setup and configuration
 
-The configuration file for kvm-xfstests is found in the run-fstests
-directory and is named config.kvm.  You can edit this file directly,
-but the better thing to do is to place override values in
-~/.config/kvm-xfstests.  Please look at the kvm-xfstests/config.kvm
-file to see the shell variables you can set.
+The configuration file for kvm-xfstests is run-fstests/config.kvm.
+You can edit this file directly, but the better thing to do is to
+place override values in ~/.config/kvm-xfstests.
 
 Perhaps the most important configuration variable to set is KERNEL.
 This should point at the default location for the kernel that qemu
@@ -90,7 +88,7 @@ Please run "kvm-xfstests help" to get a quick summary of the available
 command-line syntax.  Not all of the available command-line options
 are documented; some of the more specialized options will require that
 you Read The Fine Source --- in particular, in the auxiliary script
-file found in kvm-xfstests/util/parse_cli.
+file found in run-fstests/util/parse_cli.
 
 ### Running file system tests
 
diff --git a/Documentation/ltm-kcs-developer-notes.md b/Documentation/ltm-kcs-developer-notes.md
index 920fba8..885c931 100644
--- a/Documentation/ltm-kcs-developer-notes.md
+++ b/Documentation/ltm-kcs-developer-notes.md
@@ -4,7 +4,7 @@ These notes are for debugging the LTM and KCS servers.
 
 ## Overview
 
-The LTM and KCS go source code is located at [gce-server/](../kvm-xfstests/test-appliance/files/usr/local/lib/gce-server) in this repo. When you use the default GCE test appliance VM image or build your own image, the source code is located at `/usr/local/lib/gce-server/`, and pre-compiled into binary file `ltm` and `kcs` at `/usr/local/lib/bin/`. They are executed when LTM or KCS server is launched respectively.
+The LTM and KCS go source code is located at [gce-server/](../test-appliance/files/usr/local/lib/gce-server) in this repo. When you use the default GCE test appliance VM image or build your own image, the source code is located at `/usr/local/lib/gce-server/`, and pre-compiled into binary file `ltm` and `kcs` at `/usr/local/lib/bin/`. They are executed when LTM or KCS server is launched respectively.
 
 ## SSH into LTM or KCS server to check logs
 
@@ -44,8 +44,8 @@ On the KCS server:
         cd /usr/local/lib/gce-server/kcs
         go run .
 
-To run the server in debug mode, set `DEBUG = true` in [logging.go](../kvm-xfstests/test-appliance/files/usr/local/lib/gce-server/util/logging/logging.go) at `/usr/local/lib/gce-server/util/logging/logging.go` before you execute these commands.
+To run the server in debug mode, set `DEBUG = true` in [logging.go](../test-appliance/files/usr/local/lib/gce-server/util/logging/logging.go) at `/usr/local/lib/gce-server/util/logging/logging.go` before you execute these commands.
 
 In debug mode, logs are redirected to the console with human-friendly format, and KCS server will not shut down itself automatically.
 
-Check code docs and function comments for more details about how the server works.
\ No newline at end of file
+Check code docs and function comments for more details about how the server works.
diff --git a/build-appliance b/build-appliance
index d9313cb..a30284d 100755
--- a/build-appliance
+++ b/build-appliance
@@ -1,6 +1,6 @@
 #!/bin/bash
 #
-# do-all - build or update a test appliance
+# build-appliance - build or update a test appliance
 #
 # For details, see usage() and Documentation/building-rootfs.md
 
@@ -21,7 +21,7 @@ fi
 usage()
 {
     cat <<EOF
-Usage: do-all [OPTION]...
+Usage: build-appliance [OPTION]...
 Build or update a test appliance.
 
 Options:
diff --git a/config b/config
index 1c4b3cb..ea2afe8 100644
--- a/config
+++ b/config
@@ -4,18 +4,14 @@
 
 BUILD_ENV=
 SUDO_ENV=sudo
-# Uncomment these to make the do-all script use the specified
-# Debian chroot by default
+# Uncomment these to use the specified Debian chroot by default
 #
 #BUILD_ENV="schroot -c bullseye-amd64 --"
 #SUDO_ENV="schroot -c bullseye-amd64 -u root --"
 
-# Uncomment this to make the do-all script build a
-# root_fs.tar.gz by default rather than a root_fs.img
+# Uncomment this to build a root_fs.tar.gz by default rather than a root_fs.img
 #
 # OUT_TAR=yes
 
-# Uncomment this to make a kvm-xfstests VM appliance with networking
-# support enabled.
-#
+# Comment this to build kvm-xfstests appliances with networking support disabled
 gen_image_args="--networking"
diff --git a/setup-buildchroot b/setup-buildchroot
index aa92b84..6dac300 100755
--- a/setup-buildchroot
+++ b/setup-buildchroot
@@ -640,8 +640,9 @@ setup_mtab
 install_build_dependencies
 
 log "Build chroot was successfully set up.  To use it to build a test" \
-    "appliance, run './do-all --chroot=$CHROOT_NAME'; or to have do-all use" \
-    "this chroot by default, add the following to your config.custom file:" \
+    "appliance, run './build-appliance --chroot=$CHROOT_NAME'; or to have" \
+    "build-appliance use this chroot by default, add the following to the" \
+    "config.custom file in the top-level directory:" \
     "" \
     "    BUILD_ENV=\"schroot -c $CHROOT_NAME --\"" \
     "    SUDO_ENV=\"schroot -c $CHROOT_NAME -u root --\"" \
-- 
2.36.1.124.g0e6072fb45-goog

