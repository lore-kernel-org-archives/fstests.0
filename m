Received: from cn.fujitsu.com ([59.151.112.132]:63052 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753096AbcL3EOY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Dec 2016 23:14:24 -0500
From: Su Yue <suy.fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] fstests: btrfs/006: Fix false alert due to output change
Date: Thu, 29 Dec 2016 23:14:10 -0500
Message-ID: <20161230041410.10038-2-suy.fnst@cn.fujitsu.com>
In-Reply-To: <20161230041410.10038-1-suy.fnst@cn.fujitsu.com>
References: <20161230041410.10038-1-suy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Btrfs-progs v4.9 changed "device status" output by adding one more
space, which differs from golden output.

Fix it by introducing new filter to convert multi space into one.

Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>
---
 common/filter       |  6 ++++++
 tests/btrfs/006     | 16 ++++++++++++----
 tests/btrfs/006.out | 24 ++++++++++++------------
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/common/filter b/common/filter
index 397b456..4d5e4d0 100644
--- a/common/filter
+++ b/common/filter
@@ -401,5 +401,11 @@ _filter_mknod()
 	sed -e "s/mknod: [\`']\(.*\)': File exists/mknod: \1: File exists/"
 }
 
+# Filter spaces into one
+_filter_spaces()
+{
+	sed -e "s/\s\+/ /g"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/btrfs/006 b/tests/btrfs/006
index 0863394..dc9bfb9 100755
--- a/tests/btrfs/006
+++ b/tests/btrfs/006
@@ -82,13 +82,21 @@ echo "== Sync filesystem"
 $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT > /dev/null
 
 echo "== Show device stats by mountpoint"
-$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_btrfs_device_stats $TOTAL_DEVS
+$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | \
+       	_filter_btrfs_device_stats $TOTAL_DEVS | \
+	_filter_spaces
 echo "== Show device stats by first/scratch dev"
-$BTRFS_UTIL_PROG device stats $SCRATCH_DEV | _filter_btrfs_device_stats
+$BTRFS_UTIL_PROG device stats $SCRATCH_DEV | \
+	_filter_btrfs_device_stats | \
+	_filter_spaces
 echo "== Show device stats by second dev"
-$BTRFS_UTIL_PROG device stats $FIRST_POOL_DEV | sed -e "s,$FIRST_POOL_DEV,FIRST_POOL_DEV,g"
+$BTRFS_UTIL_PROG device stats $FIRST_POOL_DEV | \
+	sed -e "s,$FIRST_POOL_DEV,FIRST_POOL_DEV,g" | \
+	_filter_spaces
 echo "== Show device stats by last dev"
-$BTRFS_UTIL_PROG device stats $LAST_POOL_DEV | sed -e "s,$LAST_POOL_DEV,LAST_POOL_DEV,g"
+$BTRFS_UTIL_PROG device stats $LAST_POOL_DEV | \
+	sed -e "s,$LAST_POOL_DEV,LAST_POOL_DEV,g" | \
+	_filter_spaces
 
 # success, all done
 status=0
diff --git a/tests/btrfs/006.out b/tests/btrfs/006.out
index 05b9ac0..a976972 100644
--- a/tests/btrfs/006.out
+++ b/tests/btrfs/006.out
@@ -16,25 +16,25 @@ Label: 'TestLabel.006'  uuid: <EXACTUUID>
 == Sync filesystem
 == Show device stats by mountpoint
 <NUMDEVS> [SCRATCH_DEV].corruption_errs <NUM>
-<NUMDEVS> [SCRATCH_DEV].flush_io_errs   <NUM>
+<NUMDEVS> [SCRATCH_DEV].flush_io_errs <NUM>
 <NUMDEVS> [SCRATCH_DEV].generation_errs <NUM>
-<NUMDEVS> [SCRATCH_DEV].read_io_errs    <NUM>
-<NUMDEVS> [SCRATCH_DEV].write_io_errs   <NUM>
+<NUMDEVS> [SCRATCH_DEV].read_io_errs <NUM>
+<NUMDEVS> [SCRATCH_DEV].write_io_errs <NUM>
 == Show device stats by first/scratch dev
 [SCRATCH_DEV].corruption_errs <NUM>
-[SCRATCH_DEV].flush_io_errs   <NUM>
+[SCRATCH_DEV].flush_io_errs <NUM>
 [SCRATCH_DEV].generation_errs <NUM>
-[SCRATCH_DEV].read_io_errs    <NUM>
-[SCRATCH_DEV].write_io_errs   <NUM>
+[SCRATCH_DEV].read_io_errs <NUM>
+[SCRATCH_DEV].write_io_errs <NUM>
 == Show device stats by second dev
-[FIRST_POOL_DEV].write_io_errs   0
-[FIRST_POOL_DEV].read_io_errs    0
-[FIRST_POOL_DEV].flush_io_errs   0
+[FIRST_POOL_DEV].write_io_errs 0
+[FIRST_POOL_DEV].read_io_errs 0
+[FIRST_POOL_DEV].flush_io_errs 0
 [FIRST_POOL_DEV].corruption_errs 0
 [FIRST_POOL_DEV].generation_errs 0
 == Show device stats by last dev
-[LAST_POOL_DEV].write_io_errs   0
-[LAST_POOL_DEV].read_io_errs    0
-[LAST_POOL_DEV].flush_io_errs   0
+[LAST_POOL_DEV].write_io_errs 0
+[LAST_POOL_DEV].read_io_errs 0
+[LAST_POOL_DEV].flush_io_errs 0
 [LAST_POOL_DEV].corruption_errs 0
 [LAST_POOL_DEV].generation_errs 0
-- 
2.9.3



