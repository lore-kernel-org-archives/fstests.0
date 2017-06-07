Received: from mail.sigma-star.at ([95.130.255.111]:46000 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdFGIXb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jun 2017 04:23:31 -0400
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 4/4] Fix block device requirements and manual scratch mounts
Date: Wed,  7 Jun 2017 10:20:47 +0200
Message-Id: <20170607082047.10802-5-david.oberhollenzer@sigma-star.at>
In-Reply-To: <20170607082047.10802-1-david.oberhollenzer@sigma-star.at>
References: <20170607082047.10802-1-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, richard@nod.at, David Oberhollenzer <david.oberhollenzer@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

Some tests require the scratch volume to be a block device,
although they don't do anything block device specific like
the device mapper tests. They actually only require a local
device and fail with network or overlay pseudo mount devices.

The same tests also try to mount the scratch device manually
after running _scratch_mkfs. For UBIFS, _scratch_mkfs simply
truncates the UBI volume and relies on the kernel to re-format
the volume on the next mount. This fails if the fs type is not
specified explicitly when mounting.

This patch replaces the block device requirement with a
generic check for a local device and adds a filesystem
specification to all manual mounts of the scratch device
to a mount point.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 tests/generic/076 |  2 +-
 tests/generic/409 |  8 ++++----
 tests/generic/410 |  8 ++++----
 tests/generic/411 | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/generic/076 b/tests/generic/076
index 64e69583..a29f160a 100755
--- a/tests/generic/076
+++ b/tests/generic/076
@@ -56,7 +56,7 @@ _supported_fs generic
 _supported_os IRIX Linux
 
 _require_scratch
-_require_block_device $SCRATCH_DEV
+_require_local_device $SCRATCH_DEV
 
 echo "*** init fs"
 
diff --git a/tests/generic/409 b/tests/generic/409
index 4bfedf73..22af44c8 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -64,7 +64,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch
-_require_block_device $SCRATCH_DEV
+_require_local_device $SCRATCH_DEV
 
 fs_stress()
 {
@@ -114,7 +114,7 @@ start_test()
 	local type=$1
 
 	_scratch_mkfs >$seqres.full 2>&1
-	_get_mount $SCRATCH_DEV $MNTHEAD
+	_get_mount -t $FSTYP $SCRATCH_DEV $MNTHEAD
 	$MOUNT_PROG --make-"${type}" $MNTHEAD
 	mkdir $mpA $mpB $mpC $mpD
 }
@@ -133,7 +133,7 @@ bind_run()
 	start_test $dest
 
 	echo "bind $source on $dest"
-	_get_mount $SCRATCH_DEV $mpA
+	_get_mount -t $FSTYP $SCRATCH_DEV $mpA
 	mkdir -p $mpA/dir 2>/dev/null
 	$MOUNT_PROG --make-shared $mpA
 	_get_mount --bind $mpA $mpB
@@ -147,7 +147,7 @@ bind_run()
 	fi
 	_get_mount --bind $mpC $mpD
 	for m in $mpA $mpB $mpC $mpD; do
-		_get_mount $SCRATCH_DEV $m/dir
+		_get_mount -t $FSTYP $SCRATCH_DEV $m/dir
 		fs_stress $m/dir
 		find_mnt
 		_put_mount
diff --git a/tests/generic/410 b/tests/generic/410
index f2e0d1bb..18cb0c1c 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -72,7 +72,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch
-_require_block_device $SCRATCH_DEV
+_require_local_device $SCRATCH_DEV
 
 fs_stress()
 {
@@ -120,7 +120,7 @@ start_test()
 	local type=$1
 
 	_scratch_mkfs >$seqres.full 2>&1
-	_get_mount $SCRATCH_DEV $MNTHEAD
+	_get_mount -t $FSTYP $SCRATCH_DEV $MNTHEAD
 	$MOUNT_PROG --make-"${type}" $MNTHEAD
 	mkdir $mpA $mpB $mpC
 }
@@ -143,7 +143,7 @@ run()
 	start_test private
 
 	echo "make-$cmd a $orgs mount"
-	_get_mount $SCRATCH_DEV $mpA
+	_get_mount -t $FSTYP $SCRATCH_DEV $mpA
 	mkdir -p $mpA/dir 2>/dev/null
 	$MOUNT_PROG --make-shared $mpA
 
@@ -165,7 +165,7 @@ run()
 			find_mnt
 		else
 			for m in $mpA $mpB $mpC; do
-				_get_mount $SCRATCH_DEV $m/dir
+				_get_mount -t $FSTYP $SCRATCH_DEV $m/dir
 				fs_stress $m/dir
 				find_mnt
 				_put_mount
diff --git a/tests/generic/411 b/tests/generic/411
index 7b2dd33b..5db49a44 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -53,7 +53,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch
-_require_block_device $SCRATCH_DEV
+_require_local_device $SCRATCH_DEV
 
 fs_stress()
 {
@@ -103,7 +103,7 @@ start_test()
 	local type=$1
 
 	_scratch_mkfs >$seqres.full 2>&1
-	_get_mount $SCRATCH_DEV $MNTHEAD
+	_get_mount -t $FSTYP $SCRATCH_DEV $MNTHEAD
 	$MOUNT_PROG --make-"${type}" $MNTHEAD
 	mkdir $mpA $mpB $mpC
 }
@@ -125,17 +125,17 @@ crash_test()
 {
 	start_test shared
 
-	_get_mount $SCRATCH_DEV $mpA
+	_get_mount -t $FSTYP $SCRATCH_DEV $mpA
 	mkdir $mpA/mnt1
 	$MOUNT_PROG --make-shared $mpA
 	_get_mount --bind $mpA $mpB
 	_get_mount --bind $mpA $mpC
 	$MOUNT_PROG --make-slave $mpB
 	$MOUNT_PROG --make-slave $mpC
-	_get_mount $SCRATCH_DEV $mpA/mnt1
+	_get_mount -t $FSTYP $SCRATCH_DEV $mpA/mnt1
 	mkdir $mpA/mnt1/mnt2
 
-	_get_mount $SCRATCH_DEV $mpB/mnt1/mnt2
+	_get_mount -t $FSTYP $SCRATCH_DEV $mpB/mnt1/mnt2
 	find_mnt
 	fs_stress $mpB/mnt1/mnt2
 
-- 
2.12.3

