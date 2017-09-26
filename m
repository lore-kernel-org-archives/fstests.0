Received: from mail-wr0-f194.google.com ([209.85.128.194]:37750 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966056AbdIZPwi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Sep 2017 11:52:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id u48so2755551wrf.4
        for <fstests@vger.kernel.org>; Tue, 26 Sep 2017 08:52:37 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] test-appliance: fix MNTOPTS parsing
Date: Tue, 26 Sep 2017 18:53:05 +0300
Message-Id: <1506441185-9690-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When passing MNTOPTS via kvm-xfstests -m command,
mount options where not exported to environment,
unless the specific fs cfg file had already exported
the mount options variable.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Ted,

While working on overlayfs tests, I found out that
kvm-xfstests -m <mount_options> was broken for overlayfs.
I decided to fix the problem in overlay/config instead of
in individual cfg/* files.

I made a similar fix to all other fs, although there may
not be a problem with specific cfg files and although
I tested the -m option only with overlayfs.

This fix is based on an eariler overlay config change
from March and added to the same pull request:
https://github.com/tytso/xfstests-bld/pull/4

If you want to pick only this fix, there will be a
very trivial merge conflict in the overlay cfg files.

Please pull.

Thanks,
Amir.

 kvm-xfstests/test-appliance/files/root/fs/btrfs/config      | 4 ++--
 kvm-xfstests/test-appliance/files/root/fs/ext2/config       | 4 ++--
 kvm-xfstests/test-appliance/files/root/fs/ext4/config       | 6 +++---
 kvm-xfstests/test-appliance/files/root/fs/f2fs/config       | 4 ++--
 kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large | 1 -
 kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small | 1 -
 kvm-xfstests/test-appliance/files/root/fs/overlay/config    | 6 +++---
 kvm-xfstests/test-appliance/files/root/fs/tmpfs/config      | 4 ++--
 kvm-xfstests/test-appliance/files/root/fs/xfs/config        | 4 ++--
 9 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/btrfs/config b/kvm-xfstests/test-appliance/files/root/fs/btrfs/config
index bd51112..51e0e63 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/btrfs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/btrfs/config
@@ -30,9 +30,9 @@ function setup_mount_opts()
 {
     if test -n "$MNTOPTS" ; then
 	if test -n "$MOUNT_OPTIONS" ; then
-            MOUNT_OPTIONS="$MOUNT_OPTIONS,$MNTOPTS"
+            export MOUNT_OPTIONS="$MOUNT_OPTIONS,$MNTOPTS"
 	else
-	    MOUNT_OPTIONS="-o $MNTOPTS"
+	    export MOUNT_OPTIONS="-o $MNTOPTS"
 	fi
     fi
 }
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext2/config b/kvm-xfstests/test-appliance/files/root/fs/ext2/config
index 58803ae..e2ad484 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext2/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext2/config
@@ -30,9 +30,9 @@ function setup_mount_opts()
 {
     if test -n "$MNTOPTS" ; then
 	if test -n "$EXT_MOUNT_OPTIONS" ; then
-            EXT_MOUNT_OPTIONS="$EXT_MOUNT_OPTIONS,$MNTOPTS"
+            export EXT_MOUNT_OPTIONS="$EXT_MOUNT_OPTIONS,$MNTOPTS"
 	else
-	    EXT_MOUNT_OPTIONS="-o $MNTOPTS"
+	    export EXT_MOUNT_OPTIONS="-o $MNTOPTS"
 	fi
     fi
 }
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/config b/kvm-xfstests/test-appliance/files/root/fs/ext4/config
index 3ef2dd6..0a02284 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/config
@@ -30,12 +30,12 @@ function setup_mount_opts()
 {
     export MKFS_OPTIONS="$EXT_MKFS_OPTIONS"
     if test -n "$EXT_MOUNT_OPTIONS" ; then
-	EXT_MOUNT_OPTIONS="-o block_validity,$EXT_MOUNT_OPTIONS"
+	export EXT_MOUNT_OPTIONS="-o block_validity,$EXT_MOUNT_OPTIONS"
     else
-	EXT_MOUNT_OPTIONS="-o block_validity"
+	export EXT_MOUNT_OPTIONS="-o block_validity"
     fi
     if test -n "$MNTOPTS" ; then
-	EXT_MOUNT_OPTIONS="$EXT_MOUNT_OPTIONS,$MNTOPTS"
+	export EXT_MOUNT_OPTIONS="$EXT_MOUNT_OPTIONS,$MNTOPTS"
     fi
     if echo "$EXT_MOUNT_OPTIONS" | grep -q test_dummy_encryption; then
         local mode='\x00\x00\x00\x00'
diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index 3cab963..45fb2dd 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -28,9 +28,9 @@ function setup_mount_opts()
 {
     if test -n "$MNTOPTS" ; then
 	if test -n "$F2FS_MOUNT_OPTIONS" ; then
-	    F2FS_MOUNT_OPTIONS="$F2FS_MOUNT_OPTIONS,$MNTOPTS"
+	    export F2FS_MOUNT_OPTIONS="$F2FS_MOUNT_OPTIONS,$MNTOPTS"
 	else
-	    F2FS_MOUNT_OPTIONS="-o $MNTOPTS"
+	    export F2FS_MOUNT_OPTIONS="-o $MNTOPTS"
 	fi
     fi
 }
diff --git a/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large b/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large
index ab9a2bb..413462e 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large
+++ b/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large
@@ -13,6 +13,5 @@ export TEST_DEV=$LG_TST_DEV
 export TEST_DIR=$LG_TST_MNT
 export SCRATCH_DEV=$LG_SCR_DEV
 export SCRATCH_MNT=$LG_SCR_MNT
-export EXT_MOUNT_OPTIONS=""
 TESTNAME="overlayfs large"
 mkdir -p /test/tmp /test/scratch
diff --git a/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small b/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small
index 552e302..7abb055 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small
+++ b/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small
@@ -13,6 +13,5 @@ export TEST_DEV=$SM_TST_DEV
 export TEST_DIR=$SM_TST_MNT
 export SCRATCH_DEV=$SM_SCR_DEV
 export SCRATCH_MNT=$SM_SCR_MNT
-export EXT_MOUNT_OPTIONS=""
 TESTNAME="overlayfs small"
 mkdir -p /test/tmp /test/scratch
diff --git a/kvm-xfstests/test-appliance/files/root/fs/overlay/config b/kvm-xfstests/test-appliance/files/root/fs/overlay/config
index 3ea3a84..79c87d7 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/overlay/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/overlay/config
@@ -92,10 +92,10 @@ function format_filesystem()
 function setup_mount_opts()
 {
     if test -n "$MNTOPTS" ; then
-	if test -n "OVERLAY_MOUNT_OPTIONS" ; then
-            OVERLAY_MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS,$MNTOPTS"
+	if test -n "$OVERLAY_MOUNT_OPTIONS" ; then
+            export OVERLAY_MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS,$MNTOPTS"
 	else
-	    OVERLAY_MOUNT_OPTIONS="-o $MNTOPTS"
+	    export OVERLAY_MOUNT_OPTIONS="-o $MNTOPTS"
 	fi
     fi
 }
diff --git a/kvm-xfstests/test-appliance/files/root/fs/tmpfs/config b/kvm-xfstests/test-appliance/files/root/fs/tmpfs/config
index 31acc11..fa83208 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/tmpfs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/tmpfs/config
@@ -18,9 +18,9 @@ function setup_mount_opts()
 {
     if test -n "$MNTOPTS" ; then
 	if test -n "$TMPFS_MOUNT_OPTIONS" ; then
-            TMPFS_MOUNT_OPTIONS="$TMPFS_MOUNT_OPTIONS,$MNTOPTS"
+            export TMPFS_MOUNT_OPTIONS="$TMPFS_MOUNT_OPTIONS,$MNTOPTS"
 	else
-	    TMPFS_MOUNT_OPTIONS="-o $MNTOPTS"
+	    export TMPFS_MOUNT_OPTIONS="-o $MNTOPTS"
 	fi
     fi
 }
diff --git a/kvm-xfstests/test-appliance/files/root/fs/xfs/config b/kvm-xfstests/test-appliance/files/root/fs/xfs/config
index 943c8a3..ec03649 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/xfs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/xfs/config
@@ -30,9 +30,9 @@ function setup_mount_opts()
 {
     if test -n "$MNTOPTS" ; then
 	if test -n "$XFS_MOUNT_OPTIONS" ; then
-            XFS_MOUNT_OPTIONS="$XFS_MOUNT_OPTIONS,$MNTOPTS"
+            export XFS_MOUNT_OPTIONS="$XFS_MOUNT_OPTIONS,$MNTOPTS"
 	else
-	    XFS_MOUNT_OPTIONS="-o $MNTOPTS"
+	    export XFS_MOUNT_OPTIONS="-o $MNTOPTS"
 	fi
     fi
 }
-- 
2.7.4

