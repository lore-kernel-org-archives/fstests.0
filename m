Received: from mail.sigma-star.at ([95.130.255.111]:45997 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbdEQJ4Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 05:56:16 -0400
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH 1/2] Add support for UBIFS
Date: Wed, 17 May 2017 11:55:29 +0200
Message-Id: <20170517095531.11818-2-david.oberhollenzer@sigma-star.at>
In-Reply-To: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
References: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, richard@nod.at, David Oberhollenzer <david.oberhollenzer@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

This patch is mostly based on the previous attempts of Eric Biggers
and Dongsheng Yang at adding UBIFS support to xfstests.

In addition to rebasing the previous attempts to recent xfstests,
most of the encryption tests now also support UBIFS with this patch.

Since mkfs.ubifs doesn't support creating encryption-capable filesystems
yet, _scratch_mkfs_encrypted() is modified to wipe the underlying UBI
volume. The filesystem is then created when mounting the emtpy volume.

Some tests that require SCRATCH_DEV to be a block device, despite
not using device-mapper or otherwise doing something block device
specific have that requirement removed.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 check             |  2 ++
 common/config     |  7 +++++++
 common/encrypt    |  3 +++
 common/rc         | 24 ++++++++++++++++++++++++
 tests/generic/076 |  1 -
 tests/generic/409 |  1 -
 tests/generic/410 |  1 -
 tests/generic/411 |  1 -
 8 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/check b/check
index 9cef58b4..f8db3cd6 100755
--- a/check
+++ b/check
@@ -70,6 +70,7 @@ check options
     -overlay		test overlay
     -pvfs2          test PVFS2
     -tmpfs              test TMPFS
+    -ubifs              test ubifs
     -l			line mode diff
     -udiff		show unified diff (default)
     -n			show me, do not run tests
@@ -267,6 +268,7 @@ while [ $# -gt 0 ]; do
 	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
 	-pvfs2)		FSTYP=pvfs2 ;;
 	-tmpfs)		FSTYP=tmpfs ;;
+	-ubifs)		FSTYP=ubifs ;;
 
 	-g)	group=$2 ; shift ;
 		GROUP_LIST="$GROUP_LIST ${group//,/ }"
diff --git a/common/config b/common/config
index 59041a39..6c58e888 100644
--- a/common/config
+++ b/common/config
@@ -336,6 +336,9 @@ _mount_opts()
 		# We need to specify the size at mount, use 1G by default
 		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
 		;;
+	ubifs)
+		export MOUNT_OPTIONS=$UBIFS_MOUNT_OPTIONS
+		;;
 	*)
 		;;
 	esac
@@ -475,6 +478,10 @@ _check_device()
 		if [ ! -d "$dev" ]; then
 			_fatal "common/config: $name ($dev) is not a directory for overlay"
 		fi
+	elif [ "$FSTYP" == "ubifs" ]; then
+		if [ ! -c "$dev" ]; then
+			_fatal "common/config: $name ($dev) is not a character device"
+		fi
 	else
 		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
 	fi
diff --git a/common/encrypt b/common/encrypt
index 723f1b11..b444c82d 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -71,6 +71,9 @@ _scratch_mkfs_encrypted()
 	ext4|f2fs)
 		_scratch_mkfs -O encrypt
 		;;
+	ubifs)
+		ubiupdatevol ${SCRATCH_DEV} -t
+		;;
 	*)
 		_notrun "No encryption support for $FSTYP"
 		;;
diff --git a/common/rc b/common/rc
index 257b1903..6191a0c0 100644
--- a/common/rc
+++ b/common/rc
@@ -1556,6 +1556,15 @@ _require_scratch_nocheck()
 		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
 		fi
 		;;
+	ubifs)
+		# ubifs needs an UBI volume. This will be a char device, not a block device.
+		if [ ! -c "$SCRATCH_DEV" ]; then
+			_notrun "this test requires a valid UBI volume for \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	*)
 		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
 		 then
@@ -1650,6 +1659,15 @@ _require_test()
 		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
 		fi
 		;;
+	ubifs)
+		# ubifs needs an UBI volume. This will be a char device, not a block device.
+		if [ ! -c "$TEST_DEV" ]; then
+			_notrun "this test requires a valid UBI volume for \$TEST_DEV"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	*)
 		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
 		 then
@@ -2490,6 +2508,9 @@ _check_test_fs()
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
+    ubifs)
+	# there is no fsck program for ubifs yet
+	;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -2539,6 +2560,9 @@ _check_scratch_fs()
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
+    ubifs)
+	# there is no fsck program for ubifs yet
+	;;
     *)
 	_check_generic_filesystem $device
 	;;
diff --git a/tests/generic/076 b/tests/generic/076
index 64e69583..53e56a69 100755
--- a/tests/generic/076
+++ b/tests/generic/076
@@ -56,7 +56,6 @@ _supported_fs generic
 _supported_os IRIX Linux
 
 _require_scratch
-_require_block_device $SCRATCH_DEV
 
 echo "*** init fs"
 
diff --git a/tests/generic/409 b/tests/generic/409
index 4bfedf73..3be58ba5 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -64,7 +64,6 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch
-_require_block_device $SCRATCH_DEV
 
 fs_stress()
 {
diff --git a/tests/generic/410 b/tests/generic/410
index f2e0d1bb..e3a933ce 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -72,7 +72,6 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch
-_require_block_device $SCRATCH_DEV
 
 fs_stress()
 {
diff --git a/tests/generic/411 b/tests/generic/411
index 7b2dd33b..08b861c5 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -53,7 +53,6 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch
-_require_block_device $SCRATCH_DEV
 
 fs_stress()
 {
-- 
2.12.0

