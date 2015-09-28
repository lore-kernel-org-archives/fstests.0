Received: from mx1.redhat.com ([209.132.183.28]:49880 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbbI1Vie (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 28 Sep 2015 17:38:34 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] generic _require_dm_target() helper, use in generic/085
Message-ID: <5609B358.9030601@redhat.com>
Date: Mon, 28 Sep 2015 16:38:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Angelo Dureghello <angelo.dureghello@nomovok.com>
List-ID: <fstests@vger.kernel.org>

generic/085 was failing on a machine w/o devicemapper kernel
support because it requires the linear target, but didn't
explicitly test for it.

I could have cut & pasted _require_dm_linear(), but chose
to go the route of a generic helper, _require_dm_target $FOO,
because some day someone will need the zero target, the error
target, or who knows.

The first 2 files below are functional changes, creating the helper
& using it in generic/085; the rest are just perl edit-in-place
changes to use the new generic helper.

Reported-by: Angelo Dureghello <angelo.dureghello@nomovok.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/rc b/common/rc
index 3e97060..5bc0924 100644
--- a/common/rc
+++ b/common/rc
@@ -1346,32 +1346,21 @@ _require_sane_bdev_flush()
 	fi
 }
 
-# this test requires the device mapper flakey target
-#
-_require_dm_flakey()
+# this test requires a specific device mapper target
+_require_dm_target()
 {
+	_target = $1
+
 	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
 	# behaviour
 	_require_block_device $SCRATCH_DEV
 	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
 
-	modprobe dm-flakey >/dev/null 2>&1
-	$DMSETUP_PROG targets | grep flakey >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		_notrun "This test requires dm flakey support"
-	fi
-}
-
-_require_dm_snapshot()
-{
-	_require_block_device $SCRATCH_DEV
-	_require_sane_bdev_flush $SCRATCH_DEV
-	_require_command "$DMSETUP_PROG" dmsetup
 	modprobe dm-snapshot >/dev/null 2>&1
-	$DMSETUP_PROG targets | grep -q snapshot
+	$DMSETUP_PROG targets | grep -q $_target
 	if [ $? -ne 0 ]; then
-		_notrun "This test requires dm snapshot support"
+		_notrun "This test requires dm $_target support"
 	fi
 }
 
diff --git a/tests/generic/085 b/tests/generic/085
index 8398752..f452e99 100755
--- a/tests/generic/085
+++ b/tests/generic/085
@@ -50,7 +50,7 @@ _supported_fs generic
_supported_os Linux
_require_scratch
_require_block_device $SCRATCH_DEV
-_require_command $DMSETUP_PROG
+_require_dm_target linear
_require_freeze

setup_dmdev()
diff --git a/tests/btrfs/049 b/tests/btrfs/049
index 5b17a77..38ed7ad 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -50,7 +50,7 @@ _supported_fs btrfs
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/056 b/tests/btrfs/056
index 9e9d92b..add8288 100755
--- a/tests/btrfs/056
+++ b/tests/btrfs/056
@@ -55,7 +55,7 @@ _require_scratch
 _require_cloner
 _require_btrfs_fs_feature "no_holes"
 _require_btrfs_mkfs_feature "no-holes"
-_require_dm_flakey
+_require_dm_target flakey
 _need_to_be_root
 
 rm -f $seqres.full
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index 44e476b..d82f79a 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -54,7 +54,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _need_to_be_root
 
 BTRFS_DEBUG_TREE_PROG="`set_prog_path btrfs-debug-tree`"
diff --git a/tests/btrfs/095 b/tests/btrfs/095
index 032d1ff..854ba40 100755
--- a/tests/btrfs/095
+++ b/tests/btrfs/095
@@ -52,7 +52,7 @@ _need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_cloner
 _require_metadata_journaling $SCRATCH_DEV
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/098 b/tests/btrfs/098
index c412c73..f12df5f 100755
--- a/tests/btrfs/098
+++ b/tests/btrfs/098
@@ -48,7 +48,7 @@ _need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_cloner
 _require_metadata_journaling $SCRATCH_DEV
 
diff --git a/tests/generic/034 b/tests/generic/034
index 966b3d2..ee889c2 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -52,7 +52,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/039 b/tests/generic/039
index 4bbfc50..35cb7a4 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -56,7 +56,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/040 b/tests/generic/040
index b44a433..3142bbb 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -61,7 +61,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/041 b/tests/generic/041
index 50fb26f..506d8a9 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -65,7 +65,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/056 b/tests/generic/056
index 8bb1522..2ec155f 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -54,7 +54,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/057 b/tests/generic/057
index 3b9f89e..c11c329 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -54,7 +54,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/059 b/tests/generic/059
index 13dfb09..4b9184a 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -59,7 +59,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/generic/065 b/tests/generic/065
index 739a4d5..ddab687 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -55,7 +55,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/066 b/tests/generic/066
index cb36506..211152d 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -59,7 +59,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_attrs
 _require_metadata_journaling $SCRATCH_DEV
 
diff --git a/tests/generic/073 b/tests/generic/073
index 9cf0d90..759098d 100755
--- a/tests/generic/073
+++ b/tests/generic/073
@@ -55,7 +55,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/081 b/tests/generic/081
index 34da1ac..8334ec9 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -49,7 +49,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch_nocheck
-_require_dm_snapshot
+_require_dm_target snapshot
 _require_command $LVM_PROG lvm
 
 echo "Silence is golden"
diff --git a/tests/generic/085 b/tests/generic/085
index 8398752..f452e99 100755
--- a/tests/generic/085
+++ b/tests/generic/085
@@ -50,7 +50,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_block_device $SCRATCH_DEV
-_require_command $DMSETUP_PROG
+_require_dm_target linear
 _require_freeze
 
 setup_dmdev()
diff --git a/tests/generic/090 b/tests/generic/090
index a1f2b89..3890fc1 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -53,7 +53,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/101 b/tests/generic/101
index 9c46b42..ea98a89 100755
--- a/tests/generic/101
+++ b/tests/generic/101
@@ -51,7 +51,7 @@ _need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 # This test was motivated by an issue found in btrfs when the btrfs no-holes
diff --git a/tests/generic/104 b/tests/generic/104
index fef3583..2eee638 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -49,7 +49,7 @@ _need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/106 b/tests/generic/106
index 0afee41..e4f9cae 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -48,7 +48,7 @@ _need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/107 b/tests/generic/107
index 7d107d7..7503e40 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -51,7 +51,7 @@ _need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/311 b/tests/generic/311
index d21b6eb..f552011 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -55,7 +55,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch_nocheck
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 # xfs_io is not required for this test, but it's the best way to verify
diff --git a/tests/generic/321 b/tests/generic/321
index c821a23..1a89880 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -44,7 +44,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch_nocheck
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/322 b/tests/generic/322
index 4c0edf6..324022b 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -44,7 +44,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch_nocheck
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/generic/325 b/tests/generic/325
index 965a47c..94d30be 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -54,7 +54,7 @@ _supported_fs generic
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
diff --git a/tests/shared/002 b/tests/shared/002
index cc59cdb..cf02fcf 100755
--- a/tests/shared/002
+++ b/tests/shared/002
@@ -59,7 +59,7 @@ _supported_fs btrfs xfs
 _supported_os Linux
 _need_to_be_root
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_attrs
 _require_metadata_journaling $SCRATCH_DEV
 
diff --git a/tests/xfs/051 b/tests/xfs/051
index a84746b..3f33635 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -49,7 +49,7 @@ _supported_fs xfs
 _supported_os Linux
 
 _require_scratch
-_require_dm_flakey
+_require_dm_target flakey
 _require_xfs_sysfs debug/log_recovery_delay
 
 echo "Silence is golden."

