Received: from mail-wr0-f195.google.com ([209.85.128.195]:38404 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdHXORs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Aug 2017 10:17:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id 94so1708146wri.5
        for <fstests@vger.kernel.org>; Thu, 24 Aug 2017 07:17:47 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g133sm7431123wmd.48.2017.08.24.07.17.45
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 07:17:45 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] fstests: don't _require_metadata_journaling before _scratch_mkfs
Date: Thu, 24 Aug 2017 16:17:38 +0200
Message-Id: <1503584258-14804-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is obviously wrong and makes ./check -r skip over tests on ext4
with "ext4 on $DEV not configured with metadata journaling".

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 tests/btrfs/095   | 2 +-
 tests/btrfs/098   | 2 +-
 tests/btrfs/118   | 2 +-
 tests/btrfs/119   | 2 +-
 tests/btrfs/120   | 2 +-
 tests/ext4/021    | 2 +-
 tests/generic/034 | 3 +--
 tests/generic/039 | 3 +--
 tests/generic/040 | 2 +-
 tests/generic/041 | 2 +-
 tests/generic/056 | 2 +-
 tests/generic/057 | 2 +-
 tests/generic/059 | 2 +-
 tests/generic/065 | 2 +-
 tests/generic/066 | 2 +-
 tests/generic/073 | 2 +-
 tests/generic/090 | 2 +-
 tests/generic/101 | 2 +-
 tests/generic/104 | 2 +-
 tests/generic/106 | 2 +-
 tests/generic/107 | 2 +-
 tests/generic/177 | 2 +-
 tests/generic/311 | 2 +-
 tests/generic/321 | 2 +-
 tests/generic/322 | 2 +-
 tests/generic/325 | 3 +--
 tests/generic/335 | 2 +-
 tests/generic/336 | 2 +-
 tests/generic/341 | 2 +-
 tests/generic/342 | 2 +-
 tests/generic/343 | 2 +-
 tests/generic/348 | 2 +-
 tests/generic/376 | 2 +-
 tests/shared/002  | 2 +-
 34 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/tests/btrfs/095 b/tests/btrfs/095
index f256e8892238..29e828c3ba4f 100755
--- a/tests/btrfs/095
+++ b/tests/btrfs/095
@@ -53,12 +53,12 @@ _supported_os Linux
 _require_scratch
 _require_dm_target flakey
 _require_cloner
-_require_metadata_journaling $SCRATCH_DEV
 _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/btrfs/098 b/tests/btrfs/098
index ba95fd390db0..c7211a66f55a 100755
--- a/tests/btrfs/098
+++ b/tests/btrfs/098
@@ -49,11 +49,11 @@ _supported_os Linux
 _require_scratch
 _require_dm_target flakey
 _require_cloner
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/btrfs/118 b/tests/btrfs/118
index 740cb92b0669..e66a4bdc5f75 100755
--- a/tests/btrfs/118
+++ b/tests/btrfs/118
@@ -49,11 +49,11 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/btrfs/119 b/tests/btrfs/119
index cf075502d7a2..4414f02f687c 100755
--- a/tests/btrfs/119
+++ b/tests/btrfs/119
@@ -48,11 +48,11 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/btrfs/120 b/tests/btrfs/120
index 329b45c29203..72108ffc095f 100755
--- a/tests/btrfs/120
+++ b/tests/btrfs/120
@@ -50,7 +50,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
@@ -64,6 +63,7 @@ populate_testdir()
 }
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/ext4/021 b/tests/ext4/021
index d5fad7ceed51..8a78087352d3 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -48,11 +48,11 @@ _supported_fs ext4
 _supported_os Linux
 _require_scratch
 _require_dumpe2fs
-_require_metadata_journaling $SCRATCH_DEV
 
 # 8M in bytes
 fssize=$((8 * 1024 * 1024))
 _scratch_mkfs_sized $fssize >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 
 blocksize=`$DUMPE2FS_PROG -h $SCRATCH_DEV 2>/dev/null | grep "Block size" | \
 	awk '{print $3}'`
diff --git a/tests/generic/034 b/tests/generic/034
index 6727b98bd35d..facf060c79d1 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -52,12 +52,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
-
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/039 b/tests/generic/039
index 7d62393ed7e5..271798a8c025 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -56,12 +56,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
-
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/040 b/tests/generic/040
index 2aeccdd37654..c47f73db0bc4 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -61,7 +61,6 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
@@ -74,6 +73,7 @@ else
 	_scratch_mkfs >> $seqres.full 2>&1
 fi
 
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/041 b/tests/generic/041
index 283c305e459c..def959d9d98a 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -65,7 +65,6 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
@@ -78,6 +77,7 @@ else
 	_scratch_mkfs >> $seqres.full 2>&1
 fi
 
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/056 b/tests/generic/056
index 6ca3b1ace058..71ba2ae0d37b 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -54,11 +54,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/057 b/tests/generic/057
index 76f438edff75..8839597b4c08 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -54,11 +54,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/059 b/tests/generic/059
index c3a60448e569..9fc660111e90 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -59,12 +59,12 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 _require_xfs_io_command "fpunch"
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/065 b/tests/generic/065
index 935f414bad10..9294a068e1de 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -55,11 +55,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/066 b/tests/generic/066
index c42b11bb23ca..7dea54f9b27e 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -60,11 +60,11 @@ _supported_os Linux
 _require_scratch
 _require_dm_target flakey
 _require_attrs
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/073 b/tests/generic/073
index 9e3794fd2e73..5e07d542adf5 100755
--- a/tests/generic/073
+++ b/tests/generic/073
@@ -55,11 +55,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/090 b/tests/generic/090
index eeb1831eed09..6b412d11586b 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -53,11 +53,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/101 b/tests/generic/101
index f4f6c3620be2..a16c58b7bbe0 100755
--- a/tests/generic/101
+++ b/tests/generic/101
@@ -51,7 +51,6 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 # This test was motivated by an issue found in btrfs when the btrfs no-holes
 # feature is enabled (introduced in kernel 3.14). So enable the feature if the
@@ -65,6 +64,7 @@ fi
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/104 b/tests/generic/104
index 79171994e4f4..1bb5d10c450d 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -49,11 +49,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/106 b/tests/generic/106
index efad8c8304cc..d7f7a694245f 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -48,11 +48,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/107 b/tests/generic/107
index e0a92457f1ca..488abfb52639 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -51,11 +51,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/177 b/tests/generic/177
index 0aeb8e4eb313..ec65d28b9a80 100755
--- a/tests/generic/177
+++ b/tests/generic/177
@@ -54,11 +54,11 @@ _require_scratch
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "fiemap"
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/311 b/tests/generic/311
index d5102040548b..50a464ececaa 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -56,7 +56,6 @@ _supported_os Linux
 _require_scratch_nocheck
 _require_odirect
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 # xfs_io is not required for this test, but it's the best way to verify
 # the test system supports fallocate() for allocation
@@ -97,6 +96,7 @@ _run_test()
 }
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 
 # Create a basic flakey device that will never error out
 _init_flakey
diff --git a/tests/generic/321 b/tests/generic/321
index 8798503186b7..6cf80e2daa10 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -44,7 +44,6 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch_nocheck
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
@@ -118,6 +117,7 @@ _replay_rename_test()
 }
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 
 # Create a basic flakey device that will never error out
 _init_flakey
diff --git a/tests/generic/322 b/tests/generic/322
index 475a31ceb7aa..60ae5eab6b2a 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -44,7 +44,6 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch_nocheck
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
@@ -93,6 +92,7 @@ _write_after_fsync_rename_test()
 }
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 
 # Create a basic flakey device that will never error out
 _init_flakey
diff --git a/tests/generic/325 b/tests/generic/325
index a0b641a20fe0..fc5bbedfb8d2 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -54,12 +54,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
-
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/335 b/tests/generic/335
index 0f79b6db5ee0..d9ca2683a2c5 100755
--- a/tests/generic/335
+++ b/tests/generic/335
@@ -49,11 +49,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/336 b/tests/generic/336
index acf9856b9619..82e74295baec 100755
--- a/tests/generic/336
+++ b/tests/generic/336
@@ -50,11 +50,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/341 b/tests/generic/341
index 1fde346adc85..8102a617b72c 100755
--- a/tests/generic/341
+++ b/tests/generic/341
@@ -50,11 +50,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/342 b/tests/generic/342
index f1edc2df2653..ed64e0593074 100755
--- a/tests/generic/342
+++ b/tests/generic/342
@@ -50,11 +50,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/343 b/tests/generic/343
index bc7980cfd317..bbc57c41d884 100755
--- a/tests/generic/343
+++ b/tests/generic/343
@@ -50,11 +50,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/348 b/tests/generic/348
index a14e2e954ebf..3cf85659b007 100755
--- a/tests/generic/348
+++ b/tests/generic/348
@@ -50,11 +50,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/376 b/tests/generic/376
index a519203fb2c4..ad32cba19fb2 100755
--- a/tests/generic/376
+++ b/tests/generic/376
@@ -50,11 +50,11 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
diff --git a/tests/shared/002 b/tests/shared/002
index 88b28260b995..0b278396de5c 100755
--- a/tests/shared/002
+++ b/tests/shared/002
@@ -60,11 +60,11 @@ _supported_os Linux
 _require_scratch
 _require_dm_target flakey
 _require_attrs
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
-- 
2.4.3

