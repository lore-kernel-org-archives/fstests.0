Received: from mx2.suse.de ([195.135.220.15]:41518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbfCSK6z (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Mar 2019 06:58:55 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Enable btrfs/003
Date: Tue, 19 Mar 2019 12:58:51 +0200
Message-Id: <20190319105851.9280-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, guaneryu@gmail.com, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

For a long time this test has been failing on all kinds of VM configuration,
which are using virtio_blk devices. This is due to the fact that scsi
devices are deletable and virtio_blk are not. However, this only prevents
device replace case to run and has no negative effect on the other
useful test cases.

Re-enable btrfs/003 to run by making _require_deletable_scratch_dev_pool
private to the test case and modifying it to return success (0) or
failure (1) if devices are not deletable. Further modify the replace
test case to check the return value of this function and skip it if
devices are not deletable.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/rc       | 12 ------------
 tests/btrfs/003 | 19 ++++++++++++++++++-
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/common/rc b/common/rc
index 1c42515ff0ea..5693ba3cad18 100644
--- a/common/rc
+++ b/common/rc
@@ -2961,18 +2961,6 @@ _require_scratch_dev_pool_equal_size()
 	done
 }
 
-# We will check if the device is deletable
-_require_deletable_scratch_dev_pool()
-{
-	local i
-	local x
-	for i in $SCRATCH_DEV_POOL; do
-		x=`echo $i | cut -d"/" -f 3`
-		if [ ! -f /sys/class/block/${x}/device/delete ]; then
-			_notrun "$i is a device which is not deletable"
-		fi
-	done
-}
 
 # Check that fio is present, and it is able to execute given jobfile
 _require_fio()
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index 938030ef4c65..2aeb9fe6325a 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -17,6 +17,21 @@ dev_removed=0
 removed_dev_htl=""
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+# Check if all scratch dev pools are deletable
+_require_deletable_scratch_dev_pool()
+{
+	local i
+	local x
+	for i in $SCRATCH_DEV_POOL; do
+		x=`echo $i | cut -d"/" -f 3`
+		if [ ! -f /sys/class/block/${x}/device/delete ]; then
+			return 1
+		fi
+	done
+
+	return 0
+}
+
 _cleanup()
 {
     cd /
@@ -35,7 +50,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_scratch_dev_pool 4
-_require_deletable_scratch_dev_pool
 _require_command "$WIPEFS_PROG" wipefs
 
 rm -f $seqres.full
@@ -111,6 +125,9 @@ _test_replace()
 	local ds
 	local d
 
+	# If scratch devs are not deletable skip this test
+	if ! _require_deletable_scratch_dev_pool; then return 0; fi
+
 	# exclude the first and the last disk in the disk pool
 	n=$(($n-1))
 	ds=${devs[@]:1:$(($n-1))}
-- 
2.7.4
