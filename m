Received: from cn.fujitsu.com ([222.73.24.84]:40161 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S933968AbcLVCDh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Dec 2016 21:03:37 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: btrfs: Test scrub and replace race for RAID56
Date: Thu, 22 Dec 2016 10:02:51 +0800
Message-Id: <20161222020251.12272-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Although by design, btrfs scrub and replace share the same code path, so
they are exclusive to each other.

But the fact is, there is still some critical region not protected well,
so we can have the following kernel panic, especially easy to trigger on
RAID5/6 profiles.

general protection fault: 0000 [#1] SMP
Call Trace:
 [<ffffffff813a4caf>] ? generic_make_request+0xcf/0x290
 [<ffffffff813a4c04>] generic_make_request+0x24/0x290
 [<ffffffff813a4caf>] ? generic_make_request+0xcf/0x290
 [<ffffffff813a4ede>] submit_bio+0x6e/0x120
 [<ffffffffa021f7d0>] ? rbio_orig_end_io+0x80/0x80 [btrfs]
 [<ffffffffa021fe31>] finish_rmw+0x401/0x550 [btrfs]
 [<ffffffffa0220fc6>] validate_rbio_for_rmw+0x36/0x40 [btrfs]
 [<ffffffffa022104d>] raid_rmw_end_io+0x7d/0x90 [btrfs]
 [<ffffffff8139c4e6>] bio_endio+0x56/0x60
 [<ffffffffa0192e5c>] end_workqueue_fn+0x3c/0x40 [btrfs]
 [<ffffffffa01d45bf>] btrfs_scrubparity_helper+0xef/0x610 [btrfs]
 [<ffffffffa01d4b9e>] btrfs_endio_raid56_helper+0xe/0x10 [btrfs]
 [<ffffffff810ec8df>] process_one_work+0x2af/0x720
 [<ffffffff810ec85b>] ? process_one_work+0x22b/0x720
 [<ffffffff810ecd9b>] worker_thread+0x4b/0x4f0
 [<ffffffff810ecd50>] ? process_one_work+0x720/0x720
 [<ffffffff810ecd50>] ? process_one_work+0x720/0x720
 [<ffffffff810f39d3>] kthread+0xf3/0x110
 [<ffffffff810f38e0>] ? kthread_park+0x60/0x60
 [<ffffffff818578c7>] ret_from_fork+0x27/0x40
RIP  [<ffffffff813a2f58>] generic_make_request_checks+0x198/0x5a0
 RSP <ffffc90001e37b08>
---[ end trace f48aec343095cd83 ]---

Since it's a racy panic, the reproducibility may var on different
platforms.
In my physical test machine, it takes less than 10s to trigger panic,
while in my VM, it takes about 40~60s for one panic,

So this test case uses TIME_FACTOR to meet different needs.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/133     | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/133.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 129 insertions(+)
 create mode 100755 tests/btrfs/133
 create mode 100644 tests/btrfs/133.out

diff --git a/tests/btrfs/133 b/tests/btrfs/133
new file mode 100755
index 0000000..c912e40
--- /dev/null
+++ b/tests/btrfs/133
@@ -0,0 +1,126 @@
+#! /bin/bash
+# FS QA Test 133
+#
+# Test scrub and replace race for RAID5/6
+#
+# Even these 2 operations are exclusive to each other, they can still
+# cause race and trigger a NULL pointer panic for any multi-device
+# profile.
+#
+# This bug is most obvoious for RAID5/6 profiles, although other profile
+# like RAID0 can also trigger it, the possibility is quite low compared to
+# RAID5/6
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch_dev_pool 5
+_require_scratch_dev_pool_equal_size
+
+runtime=$((60 * $TIME_FACTOR))
+
+nr_devs=$(($(echo $SCRATCH_DEV_POOL | wc -w) - 1))
+
+run_test()
+{
+	local mkfs_opts=$1
+	local saved_scratch_dev_pool=$SCRATCH_DEV_POOL
+
+	echo "Test $mkfs_opts" >>$seqres.full
+
+	# remove the last device from the SCRATCH_DEV_POOL list so
+	# _scratch_pool_mkfs won't use all devices in pool
+	local last_dev="`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $NF}'`"
+	SCRATCH_DEV_POOL=`echo $SCRATCH_DEV_POOL | sed -e "s# *$last_dev *##"`
+	_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
+	# make sure we created btrfs with desired options
+	if [ $? -ne 0 ]; then
+		echo "mkfs $mkfs_opts failed"
+		SCRATCH_DEV_POOL=$saved_scratch_dev_pool
+		return
+	fi
+	_scratch_mount >>$seqres.full 2>&1
+	SCRATCH_DEV_POOL=$saved_scratch_dev_pool
+
+	# Fill the fs so that each device has at least 64M data
+	# This will slow down replace and increase the possibility to
+	# trigger the bug
+	_pwrite_byte 0xcdcdcdcd 0 $(($nr_devs * 64 * 1024 * 1024)) \
+		$SCRATCH_MNT/file > /dev/null 2>&1
+	sync
+
+	echo -n "Start replace worker: " >>$seqres.full
+	_btrfs_stress_replace $SCRATCH_MNT >>$seqres.full 2>&1 &
+	replace_pid=$!
+	echo "$replace_pid" >>$seqres.full
+
+	echo -n "Start scrub worker: " >>$seqres.full
+	_btrfs_stress_scrub $SCRATCH_MNT >/dev/null 2>&1 &
+	scrub_pid=$!
+	echo "$scrub_pid" >>$seqres.full
+
+	echo "Wait for $runtime seconds" >>$seqres.full
+	sleep $runtime
+	kill $replace_pid $scrub_pid
+	wait
+
+	# wait for the scrub and replace operations to finish
+	while ps aux | grep "scrub start" | grep -qv grep; do
+		sleep 1
+	done
+	while ps aux | grep "replace start" | grep -qv grep; do
+		sleep 1
+	done
+
+	_scratch_unmount
+}
+
+run_test "-d raid5 -m raid5"
+run_test "-d raid6 -m raid6"
+run_test "-d raid0 -m raid0"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/133.out b/tests/btrfs/133.out
new file mode 100644
index 0000000..e914d62
--- /dev/null
+++ b/tests/btrfs/133.out
@@ -0,0 +1,2 @@
+QA output created by 133
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index b4e4ff2..c02361e 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -135,3 +135,4 @@
 130 auto clone send
 131 auto quick
 132 auto enospc
+133 auto scrub replace
-- 
2.7.4



