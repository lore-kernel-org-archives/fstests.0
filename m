Received: from mail-pg0-f66.google.com ([74.125.83.66]:36701 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdEQX4C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 19:56:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so3640077pge.3
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 16:56:02 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: clean up outdated documentation files
Date: Wed, 17 May 2017 16:54:56 -0700
Message-Id: <20170517235456.63783-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Replace kvm-xfstests/README and kvm-xfstests/README.GCE with pointers to
where the documentation is now.  Also delete the top-level README, since
it's been replaced with README.md right next to it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 README                  |  85 ---------------------------
 kvm-xfstests/README     |  81 +-------------------------
 kvm-xfstests/README.GCE | 148 +-----------------------------------------------
 3 files changed, 3 insertions(+), 311 deletions(-)
 delete mode 100644 README

diff --git a/README b/README
deleted file mode 100644
index ef87668..0000000
--- a/README
+++ /dev/null
@@ -1,85 +0,0 @@
-
-The xfstests-bld package makes it easy to build xfstests in a hermetic
-build environment (so it is not dependent on possibly out-of-date
-distro versions of libaio, xfsprogs, etc.).  It also contains scripts
-which make it easy to run xfstests in a KVM guest.  It is currently
-optimized for ext4 testing, but it should be fairly simple to
-generalize this for testing other file systems.
-
-If you are using debian testing, it is pretty simple to generate your
-own test appliance which uses kvm to run xfstests.  If you are using a
-different distribution, you can fetch a copy of root_fs.img from
-https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests.
-
-Or you can take a look at the kvm-xfstests/test-appliance/gen-image
-and create something which works for your distribution.  Please let me
-know if create something which works well for other distributions.
-
-1.  "make ; make tarball" to generate the xfstests.tar.gz file.
-2.  cd to kvm-xfstests/test-appliance, and run as root the shell script
-    "gen-image".  This will create the root_fs.img file.
-3.  build a kernel which does not use modules (at least for all of the
-    device drivers required for running under kvm).  There are sample
-    kernel configs found in the top-level kernel-configs directory.
-    Note that if you build a 32-bit i386 kernel, you will need to make
-    to build the root_fs.img file in 32-bit build chroot.  You can use
-    a 32-bit userspace with a 64-bit kernel; in fact, this is a good
-    way to sanity check the ioctl compatibility code.
-4.  Adjust the KERNEL= line in kvm-xfstests/config to point at your
-    kernel's bzImage file.
-5.  cd to kvm-xfstests, and run "kvm-xfstests smoke".  More details of
-    how to run kvm-xfstests can be found in kvm-xfstests/README.  If
-    you adjust the DIR= line in kvm-xfstests, it will not be
-    necessary to be cd'ed into the kvm-xfstests directory before
-    kicking off the shell script.
-
-When the kvm-xfstests is done, it will print a summary of which tests
-passed and failed.  It will also save the output of the test in a
-log.YYYYMMDDHHSS file.  The "get-results" script will parse the log
-file and generate the test summary.
-
-
-Instructions for building a 32-bit test-appliance image in a chroot
--------------------------------------------------------------------
-
-These instructions assumes you are using Debian; it should probably
-work for Ubuntu as well.
-
-If you want to build a 64-bit test image, just remove the --arch=i386
-in step #3, or if you don't want to use a build-chroot, you should be
-able to just use the "./do-all" script all by itself --- or you can
-use the manual instructions described in steps #1 and #2 above.
-
-1)  Install the necessary packages to build host OS
-
-# sudo apt-get install schroot debootstrap
-
-2) Add the following to /etc/schroot.conf, replacing "tytso" with your
-username, and /u1/jessie-root with path where you plan to put your
-build chroot
-
-[jessie]
-description=Debian jessie
-type=directory
-directory=/u1/jessie-root
-users=tytso,root
-root-users=tytso
-
-3) Create the build chroot (again, replace /u1/jessie-root with the
-pathname to your build chroot directory):
-
-# cd /u1
-# debootstrap --arch=i386 jessie /u1/jessie-root
-# schroot -c jessie -u root
-(jessie)root@closure:/u1# apt-get install build-essential autoconf autoconf2.64 automake libgdbm-dev libtool-bin qemu-utils gettext e2fslibs-dev git debootstrap
-(jessie)root@closure:/u1# exit
-
-4) Copy config to config.custom, and then change the lines which
-define SUDO_ENV and BUILD_ENV to:
-
-SUDO_ENV="schroot -c jessie -u root --"
-BUILD_ENV="schroot -c jessie --"
-
-5)  Kick off the build!
-
-./do-all
diff --git a/kvm-xfstests/README b/kvm-xfstests/README
index b213e10..a938488 100644
--- a/kvm-xfstests/README
+++ b/kvm-xfstests/README
@@ -1,79 +1,2 @@
-XFStests using virtualization
-
-To set up the necessary scratch disks used by the kvm-xfstests, run
-the "./setup" script.  You will need approximately 60 gigs of disk
-space to run all of the ext4 tests.
-
-The current working directory must be kvm-xfstests directory.  This
-restriction can be relaxed if you edit the "DIR=" line in the
-kvm-xfstests script.  In addition, you will probably need to customize
-the paths in the "config" file so that your compiled kernel can be
-found, and where to find qemu/kvm binary.
-
-The kvm-xfstests script is used as follows:
-
-*) kvm-xfstests [-c <cfg>] [-g <group>]|[<tests>] ...
-
-	By default <cfg> defaults to all, which will run the following
-	configurations: "4k", "1k", "ext3", "nojournal", "ext3conv",
-	"dioread_nolock, "data_journal", "inline", "bigalloc", and
-	"bigalloc_1k".  You may specify a single configuration or a
-	comma separated list if you want to run a subset of all
-	possible file system configurations.
-
-	Tests can be specified using an xfstests group
-	via "-g <group>", or can be an xfstests (e.g., "generic/068")
-
-*) kvm-xfstests smoke
-
-	This is the equivalent of specifying "-c 4k -g quick"
-
-*) kvm-xfstests shell
-
-	Will allow you to examine the tests environment or to run
-	tests manually.  Any changes to the root partition will be
-	reverted when you exit the VM.
-
-	To run tests manually source the /root/test-env file, and then
-	set the FSTESTCFG and FSTESTSET environment variables before
-	running /root/runtests.sh.
-
-*) kvm-xfstests maint
-
-	Will drop you into a root shell and allows you to modify the
-	root file system.  KVM uses and modifies the root_fs.img file,
-	which is a compressed qcow2 image.  After doing a lot of
-	maintenance, the root_fs.img can get quite large.  If so, the
-	compress-rootfs shell script can be helpful.
-
-
-To extract the interesting results from the log file, run the command
-"get-results":
-
-% ./get-results log.201312220828
-[    0.000000] Linux version 3.13.0-rc2-00010-ge128f1f (tytso@lambda) (gcc version 4.8.2 (Debian 4.8.2-1) ) #1564 SMP Sat Dec 21 23:43:09 EST 2013
-FSTESTCFG is "all"
-FSTESTSET is "-g auto"
-BEGIN TEST: Ext4 4k block Sun Dec 22 08:28:47 EST 2013
-MKFS_OPTIONS  -- -q /dev/vdc
-MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc
-Ran: ext4/271 ext4/305 generic/001 generic/002 generic/005 generic/006 generic/007 generic/011 generic/013 generic/014 generic/015 generic/020 generic/053 generic/062 generic/069 generic/070 generic/074 generic/075 generic/076 generic/079 generic/083 generic/088 generic/089 generic/091 generic/100 generic/105 generic/112 generic/113 generic/117 generic/120 generic/123 generic/124 generic/125 generic/126 generic/127 generic/128 generic/129 generic/130 generic/131 generic/132 generic/133 generic/135 generic/141 generic/169 generic/184 generic/192 generic/193 generic/198 generic/204 generic/207 generic/208 generic/209 generic/210 generic/211 generic/212 generic/213 generic/214 generic/215 generic/219 generic/221 generic/223 generic/224 generic/225 generic/226 generic/228 generic/230 generic/231 generic/232 generic/233 generic/234 generic/235 generic/236 generic/237 generic/239 generic/240 generic/245 generic/246 generic/247 generic/248 generic/249 generic/255 generic/257 gener!
 ic/258 generic/263 generic/269 generic/270 generic/277 generic/280 generic/285 generic/286 generic/294 generic/299 generic/300 generic/306 generic/307 generic/308 generic/309 generic/310 generic/313 generic/314 generic/315 generic/316 generic/317 generic/318 generic/319 shared/218 shared/243 shared/272 shared/289 shared/298
-Failures: generic/223 generic/318 shared/218
-END TEST: Ext4 4k block Sun Dec 22 09:02:47 EST 2013
-BEGIN TEST: Ext4 4k block w/nodelalloc, no flex_bg, and no extents Sun Dec 22 09:02:49 EST 2013
-MKFS_OPTIONS  -- -q -O ^extents,^flex_bg,^uninit_bg /dev/vdc
-MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity,nodelalloc /dev/vdc /vdc
-Ran: ext4/271 ext4/305 generic/001 generic/002 generic/005 generic/006 generic/007 generic/011 generic/013 generic/014 generic/015 generic/020 generic/053 generic/062 generic/069 generic/070 generic/074 generic/075 generic/076 generic/079 generic/083 generic/088 generic/089 generic/091 generic/100 generic/105 generic/112 generic/113 generic/117 generic/120 generic/123 generic/124 generic/125 generic/126 generic/127 generic/128 generic/129 generic/130 generic/131 generic/132 generic/133 generic/135 generic/141 generic/169 generic/184 generic/192 generic/193 generic/198 generic/204 generic/207 generic/208 generic/209 generic/210 generic/211 generic/212 generic/215 generic/219 generic/221 generic/224 generic/225 generic/226 generic/230 generic/231 generic/232 generic/233 generic/234 generic/235 generic/236 generic/237 generic/239 generic/240 generic/245 generic/246 generic/247 generic/248 generic/249 generic/257 generic/258 generic/263 generic/269 generic/270 generic/277 gener!
 ic/280 generic/285 generic/286 generic/294 generic/299 generic/300 generic/306 generic/307 generic/308 generic/309 generic/310 generic/313 generic/314 generic/315 generic/316 generic/317 generic/318 generic/319 shared/218 shared/272 shared/289 shared/298
-Failures: generic/300 generic/318 shared/218
-END TEST: Ext4 4k block w/nodelalloc, no flex_bg, and no extents Sun Dec 22 09:36:38 EST 2013
-BEGIN TEST: Ext4 4k block w/ no journal Sun Dec 22 09:36:39 EST 2013
-MKFS_OPTIONS  -- -q -O ^has_journal /dev/vdc
-MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity,noload /dev/vdc /vdc
-Ran: ext4/271 ext4/305 generic/001 generic/002 generic/005 generic/006 generic/007 generic/011 generic/013 generic/014 generic/015 generic/020 generic/053 generic/062 generic/069 generic/070 generic/074 generic/075 generic/076 generic/079 generic/083 generic/088 generic/089 generic/091 generic/100 generic/105 generic/112 generic/113 generic/117 generic/120 generic/123 generic/124 generic/125 generic/126 generic/127 generic/128 generic/129 generic/130 generic/131 generic/132 generic/133 generic/135 generic/141 generic/169 generic/184 generic/192 generic/193 generic/198 generic/204 generic/207 generic/208 generic/209 generic/210 generic/211 generic/212 generic/213 generic/214 generic/215 generic/219 generic/221 generic/223 generic/224 generic/225 generic/226 generic/228 generic/230 generic/231 generic/232 generic/233 generic/234 generic/235 generic/236 generic/237 generic/239 generic/240 generic/245 generic/246 generic/247 generic/248 generic/249 generic/255 generic/257 gener!
 ic/258 generic/263 generic/269 generic/270 generic/277 generic/285 generic/286 generic/294 generic/299 generic/300 generic/306 generic/307 generic/308 generic/309 generic/310 generic/313 generic/314 generic/315 generic/316 generic/317 generic/318 generic/319 shared/218 shared/243 shared/272 shared/289 shared/298
-Failures: generic/318
-END TEST: Ext4 4k block w/ no journal Sun Dec 22 10:01:56 EST 2013
-....
-
-(If there is a missing "END TEST", it's likely because there was a
-kernel bug which caused the kernel to crash before the test run was
-able to complete.)
+This documentation has been moved to Documentation/kvm-quickstart.md and
+Documentation/kvm-xfstests.md.
diff --git a/kvm-xfstests/README.GCE b/kvm-xfstests/README.GCE
index 8634572..2b561af 100644
--- a/kvm-xfstests/README.GCE
+++ b/kvm-xfstests/README.GCE
@@ -1,147 +1 @@
-
-	      Running xfstests on Google Compute Engine
-
-Getting a Google Compute Engine account
----------------------------------------
-
-If you don't have GCE account, you can go to https://cloud.google.com
-and sign up for a free trial.  This will get you $300 dollars worth of
-credit which you can use over a 60 day period (as of this writing).
-Given that a full test costs around a $1.50, and a smoke test costs
-pennies, that should be enough for plenty of testing.  :-)
-
-Configuration
--------------
-
-You will need to set up the following configuration parameters in
-~/.config/kvm-xfststs:
-
-GS_BUCKET	The name of the Google Storage bucket which should be
-		used by gce-xfstests.  Your Google Compute Engine account
-		must have access to read and write files in this bucket.
-
-GCE_PROJECT	The name of Google Compute Engine project which should
-		be used to create and run GCE instances and disks.
-
-GCE_ZONE	The name of the Google Compute Engine zone which should
-		be used by xfstests.
-
-GCE_KERNEL	The pathname to kernel that should be used for gce-xfstests
-		by default.
-
-If you have a sendgrid account, you can set the following
-configuration parameters in order to have reports e-mailed to you:
-
-GCE_SG_USER	The username for the sendgrid account used to send email
-
-GCE_SG_PASS	The password for the sendgrid account used to send email
-
-GCE_REPORT_EMAIL The email addressed for which test results should be
-sent.
-
-An example ~//.config/kvm-xfstests might look like this:
-
-GS_BUCKET=tytso-xfstests
-GCE_PROJECT=tytso-linux
-GCE_ZONE=us-central1-c
-GCE_KERNEL=/build/ext4-64/arch/x86/boot/bzImage
-
-
-Creating the image
-------------------
-
-You will need to install the following packages (debian package names
-used):
-
-	jq xz-utils git autoconf2.59 libtool-bin automake libc6-dev
-	gcc make e2fslibs-dev pkg-config gettext libpopt-dev
-
-You will also need to install the Google Cloud SDK.
-
-1)  make ; make tarball
-
-2)  cd kvm-xfstests/test-appliance ; ./gce-create-image
-
-Running gce-xfstests
---------------------
-
-Running gce-xfstests is much like kvm-xfstests; see the README file in
-this directory for more details.
-
-The gce-xfstests command also has a few other commands:
-
-gce-xfstests ssh INSTANCE
-
-	Remotely login as root to a test instances.  This is a
-	convenience shorthand for: "gcloud compute --project
-	GCE_PROJECT ssh root@INSTNACE --zone GCE_ZONE".
-
-gce-xfstests console INSTANCE
-
-	Fetch the serial console from a test instance.  This is a
-	convenience shorthand for: "gcloud compute --project
-	GCE_PROJECT get-serial-port-output INSTANCE --zone GCE_ZONE".
-
-gce-xfstests ls-instances [-l ]
-gce-xfstests ls-gce
-
-	List the current test instances.  With the -l option, it will
-	list the current status of each instance.
-
-	The ls-gce option is a convenience command for "gcloud compute
-	--project GCE_PROJECT instances list --regexp ^xfstests.*"
-
-	ALIAS: gce-xfstests ls
-
-gce-xfstests rm-instances INSTANCE
-gce-xfstests abort-instances INSTANCE
-
-	Shut down the instance.  The abort command will delete make
-	sure the results disk to be deleted.  If test kernel has hung,
-	it may be useful to use "gce-xfstests console" to fetch the
-	console, and then use "gce-xfstests rm" and examine the
-	results disk before deleting it.
-
-	ALIAS: gce-xfstests rm
-	ALIAS: gce-xfstests abort
-
-gce-xfstests ls-disks
-
-	List the GCE disks.  This is a convenience command for "gcloud
-	compute --project "$GCE_PROJECT" disks list --regexp
-	^xfstests.*"
-
-	ALIAS: gce-xfstests ls-disk
-
-gce-xfstests rm-disks DISK
-
-	Delete a specified GCE disk.  This is a convenience command
-	for "gcloud compute --project "$GCE_PROJECT" disks delete DISK"
-
-ALIAS: gce-xfstests rm-disk
-
-gce-xfstests ls-results
-gce-xfstests ls-gcs
-
-	List the available results tarballs stored in the Google Cloud
-	Storage bucket.  This is a convenience command for
-	"gsutil ls gs://GS_BUCKET/results.*" (ls-results) or
-	"gsutil ls gs://GS_BUCKET" (ls-gcs).
-
-gce-xfstests rm-results RESULT_FILE
-
-	Delete a specified result tarball.  This is a convenience
-	command for "gsutil ls gs://GS_BUCKET/RESULT_FILE".
-
-gce-xfstests get-results [--unpack | --summary | --failures ] RESULT_FILE
-
-	Fetch the run-tests.log file from the RESULT_FILE stored in
-	the Google Cloud Storage bucket.  The --summary or --failures
-	option will cause the log file to be piped into the
-	"get-results" script to summarize the log file using the "-s"
-	or "-F" option, respectively.  The "--failures" or "-F" option
-	results in a more succint summary than the "--summary" or "-s"
-	option.
-
-	The --unpack option will cause the complete results directory
-	to be unpacked into a directory in /tmp instead.
+This documentation has been moved to Documentation/gce-xfstests.md.
-- 
2.13.0.303.g4ebf302169-goog

