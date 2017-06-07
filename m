Received: from mail.sigma-star.at ([95.130.255.111]:45998 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdFGIXb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jun 2017 04:23:31 -0400
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 2/4] Add support for UBIFS
Date: Wed,  7 Jun 2017 10:20:45 +0200
Message-Id: <20170607082047.10802-3-david.oberhollenzer@sigma-star.at>
In-Reply-To: <20170607082047.10802-1-david.oberhollenzer@sigma-star.at>
References: <20170607082047.10802-1-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, richard@nod.at, David Oberhollenzer <david.oberhollenzer@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

UBIFS is a filesystem for unmanaged flash memory devices. It works on top of
UBI (Unsorted Block Images) which is a wear leveling and volume management
layer on top of flash memory devices, which are handled by the MTD subsystem
(memory technology device).

Since the semantics of flash devices are drastically different from regular
block devices (blocks or "pages" must be erased before writing, only larger
groups of pages or "erase blocks" can be erased at once, page write must be
in order within an erase block, etc...) it was decided to expose MTD devices
as character devices with ioctls for operations like erase.

Since erasing a flash erase block causes physical wear on the device,
eventually causing the erase blocks to go bad, the UBI layer provides mainly
transparent wear leveling on top of MTD devices. UBI does not attempt to
emulate a regular block device, but rather something like a flash memory with
idealized characteristics that can be partitioned into multiple UBI volumes
in a fashion somewhat similar to LVM. UBI volumes are also exposed to user
space as character devices.

This patch mainly deals with some quirks of UBIFS like working on top of
character devices instead of block devices. Also UBIFS automatically formats
UBI devices when trying to mount an empty device. The mkfs.ubifs program is
mainly used for creating images. This patch changes _scratch_mkfs and
_scratch_mkfs_encrypted to truncate the UBI volume instead, relying on the
kernel to reformat it on the next mount.

For _scratch_mkfs_encrypted this is actually required to get the encryption
tests to run, because mkfs.ubifs, at the time of writing this, the kernel
support for UBIFS encryption is fairly recent and mkfs.ubifs does not have
proper support yet.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 check          |  2 ++
 common/config  | 17 ++++++++++++++---
 common/encrypt |  4 ++++
 common/rc      | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 3 deletions(-)

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
index 090e9117..5091db9d 100644
--- a/common/config
+++ b/common/config
@@ -199,6 +199,7 @@ export TIMEOUT_PROG="`set_prog_path timeout`"
 export MAN_PROG="`set_prog_path man`"
 export NFS4_SETFACL_PROG="`set_prog_path nfs4_setfacl`"
 export NFS4_GETFACL_PROG="`set_prog_path nfs4_getfacl`"
+export UBIUPDATEVOL_PROG="`set_prog_path ubiupdatevol`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
@@ -323,6 +324,9 @@ _mount_opts()
 		# We need to specify the size at mount, use 1G by default
 		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
 		;;
+	ubifs)
+		export MOUNT_OPTIONS=$UBIFS_MOUNT_OPTIONS
+		;;
 	*)
 		;;
 	esac
@@ -458,13 +462,20 @@ _check_device()
 		return 0
 	fi
 
-	if [ "$FSTYP" == "overlay" ]; then
+	case "$FSTYP" in
+	overlay)
 		if [ ! -d "$dev" ]; then
 			_fatal "common/config: $name ($dev) is not a directory for overlay"
 		fi
-	else
+		;;
+	ubifs)
+		if [ ! -c "$dev" ]; then
+			_fatal "common/config: $name ($dev) is not a character device"
+		fi
+		;;
+	*)
 		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
-	fi
+	esac
 }
 
 # check and return a canonical mount point path
diff --git a/common/encrypt b/common/encrypt
index 723f1b11..a6fd89d9 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -71,6 +71,10 @@ _scratch_mkfs_encrypted()
 	ext4|f2fs)
 		_scratch_mkfs -O encrypt
 		;;
+	ubifs)
+		# erase the UBI volume; reformated automatically on next mount
+		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
+		;;
 	*)
 		_notrun "No encryption support for $FSTYP"
 		;;
diff --git a/common/rc b/common/rc
index 372e313a..e81a6335 100644
--- a/common/rc
+++ b/common/rc
@@ -177,6 +177,9 @@ case "$FSTYP" in
 	 ;;
     pvfs2)
 	;;
+    ubifs)
+	[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
+	;;
 esac
 
 if [ ! -z "$REPORT_LIST" ]; then
@@ -813,6 +816,11 @@ _scratch_mkfs()
 		# do nothing for tmpfs
 		return 0
 		;;
+	ubifs)
+		# erase the UBI volume; reformated automatically on next mount
+		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
+		return 0
+		;;
 	ext4)
 		_scratch_mkfs_ext4 $*
 		return $?
@@ -1576,6 +1584,15 @@ _require_scratch_nocheck()
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
@@ -1670,6 +1687,15 @@ _require_test()
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
@@ -2555,6 +2581,9 @@ _check_test_fs()
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
+    ubifs)
+	# there is no fsck program for ubifs yet
+	;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -2604,6 +2633,9 @@ _check_scratch_fs()
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
+    ubifs)
+	# there is no fsck program for ubifs yet
+	;;
     *)
 	_check_generic_filesystem $device
 	;;
-- 
2.12.3

