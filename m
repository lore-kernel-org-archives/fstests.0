Received: from mx141.netapp.com ([216.240.21.12]:55080 "EHLO mx141.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbdJ3IJI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Oct 2017 04:09:08 -0400
From: Omer Zilberberg <Omer.Zilberberg@netapp.com>
Subject: [PATCH] generic/4[13,62]: restore TEST mount options
Date: Mon, 30 Oct 2017 10:08:31 +0200
Message-ID: <20171030080831.7339-1-Omer.Zilberberg@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Omer Zilberberg <Omer.Zilberberg@netapp.com>
List-ID: <fstests@vger.kernel.org>

These tests locally change the TEST_FS_MOUNT_OPTS/MOUNT_OPTIONS
environment variables, and run _test_cycle_mount. As a result, following
tests using the TEST mount point may start with different mount options,
depending on run order.

This patch restores the TEST mount point's options.

Signed-off-by: Omer Zilberberg <Omer.Zilberberg@netapp.com>
---
 tests/generic/413 | 7 +++++++
 tests/generic/462 | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/tests/generic/413 b/tests/generic/413
index a1cc51443..94633a4d4 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -136,6 +136,8 @@ fi
 _scratch_mkfs "$mkfs_opts" > /dev/null 2>&1
 
 # mount SCRATCH_DEV with dax option, TEST_DEV not
+mount_options_orig=$MOUNT_OPTIONS
+test_fs_mount_opts_orig=$TEST_FS_MOUNT_OPTS
 export MOUNT_OPTIONS=""
 export TEST_FS_MOUNT_OPTS=""
 _test_cycle_mount
@@ -147,6 +149,11 @@ tsize=$((128 * 1024 * 1024))
 
 do_tests
 
+# restore TEST_FS to original mount options
+export MOUNT_OPTIONS=$mount_options_orig
+export TEST_FS_MOUNT_OPTS=$test_fs_mount_opts_orig
+_test_cycle_mount
+
 # success, all done
 echo "Silence is golden"
 status=0
diff --git a/tests/generic/462 b/tests/generic/462
index a5d6c4f85..176035ddc 100755
--- a/tests/generic/462
+++ b/tests/generic/462
@@ -64,6 +64,7 @@ _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount "-o dax"
 
 # remount TEST_DEV wo/ dax
+test_fs_mount_opts_orig=$TEST_FS_MOUNT_OPTS
 export TEST_FS_MOUNT_OPTS=""
 _test_cycle_mount
 
@@ -90,6 +91,10 @@ md5_2="$(_md5_checksum $SCRATCH_MNT/readonlyfile)"
 
 [ "$md5_1" != "$md5_2" ] && echo "read only file changed"
 
+# restore TEST_FS to original mount options
+export TEST_FS_MOUNT_OPTS=$test_fs_mount_opts_orig
+_test_cycle_mount
+
 # success, all done
 status=0
 exit
-- 
2.13.6

