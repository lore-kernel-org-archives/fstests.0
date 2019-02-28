Received: from mx1.redhat.com ([209.132.183.28]:37756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfB1Olb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Feb 2019 09:41:31 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 2/2] generic/482: use thin volume as data device
Date: Thu, 28 Feb 2019 09:41:28 -0500
Message-Id: <20190228144128.55583-3-bfoster@redhat.com>
In-Reply-To: <20190228144128.55583-1-bfoster@redhat.com>
References: <20190228144128.55583-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>
List-ID: <fstests@vger.kernel.org>

The dm-log-writes replay mechanism issues discards to provide
zeroing functionality to prevent out-of-order replay issues. These
discards don't always result in zeroing bevavior, however, depending
on the underlying physical device. In turn, this causes test
failures on XFS v5 filesystems that enforce metadata log recovery
ordering if the filesystem ends up with stale data from the future
with respect to the active log at a particular recovery point.

To ensure reliable discard zeroing behavior, use a thinly
provisioned volume as the data device instead of using the scratch
device directly. This slows the test down slightly, but provides
reliable functional behavior at a reduced cost from active snapshot
management or forced zeroing.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 tests/generic/482 | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/generic/482 b/tests/generic/482
index 3c2199d7..3b93a7fc 100755
--- a/tests/generic/482
+++ b/tests/generic/482
@@ -22,12 +22,14 @@ _cleanup()
 	cd /
 	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
 	_log_writes_cleanup &> /dev/null
+	_dmthin_cleanup
 	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
+. ./common/dmthin
 . ./common/dmlogwrites
 
 # remove previous $seqres.full before test
@@ -44,6 +46,7 @@ _require_command "$KILLALL_PROG" killall
 _require_scratch
 # and we need extra device as log device
 _require_log_writes
+_require_dm_target thin-pool
 
 
 nr_cpus=$("$here/src/feature" -o)
@@ -53,9 +56,15 @@ if [ $nr_cpus -gt 8 ]; then
 fi
 fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 512 -p $nr_cpus \
 		$FSSTRESS_AVOID)
+devsize=$((1024*1024*200 / 512))	# 200m phys/virt size
+csize=$((1024*64 / 512))		# 64k cluster size
+lowspace=$((1024*1024 / 512))		# 1m low space threshold
 
+# Use a thin device to provide deterministic discard behavior. Discards are used
+# by the log replay tool for fast zeroing to prevent out-of-order replay issues.
 _test_unmount
-_log_writes_init $SCRATCH_DEV
+_dmthin_init $devsize $devsize $csize $lowspace
+_log_writes_init $DMTHIN_VOL_DEV
 _log_writes_mkfs >> $seqres.full 2>&1
 _log_writes_mark mkfs
 
@@ -70,16 +79,15 @@ cur=$(_log_writes_find_next_fua $prev)
 [ -z "$cur" ] && _fail "failed to locate next FUA write"
 
 while [ ! -z "$cur" ]; do
-	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
+	_log_writes_replay_log_range $cur $DMTHIN_VOL_DEV >> $seqres.full
 
 	# Here we need extra mount to replay the log, mainly for journal based
 	# fs, as their fsck will report dirty log as error.
-	# We don't care to preserve any data on $SCRATCH_DEV, as we can replay
+	# We don't care to preserve any data on the replay dev, as we can replay
 	# back to the point we need, and in fact sometimes creating/deleting
 	# snapshots repeatedly can be slower than replaying the log.
-	_scratch_mount
-	_scratch_unmount
-	_check_scratch_fs
+	_dmthin_mount
+	_dmthin_check_fs
 
 	prev=$cur
 	cur=$(_log_writes_find_next_fua $(($cur + 1)))
-- 
2.17.2
