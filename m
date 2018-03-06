Received: from victor.provo.novell.com ([137.65.250.26]:50996 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeCFIQL (ORCPT
        <rfc822;groupwise-fstests@vger.kernel.org:0:0>);
        Tue, 6 Mar 2018 03:16:11 -0500
From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH 3/3] fstests: btrfs: Add test case to check v1 space cache corruption
Date: Tue,  6 Mar 2018 16:15:55 +0800
Message-Id: <20180306081555.3242-3-wqu@suse.com>
In-Reply-To: <20180306081555.3242-1-wqu@suse.com>
References: <20180306081555.3242-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc: dsterba@suse.cz, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

There are some btrfs corruption report in mail list for a while,
although such corruption is pretty rare and almost impossible to
reproduce, with dm-log-writes we found it's highly related to v1 space
cache.

Unlike journal based filesystems, btrfs completely rely on metadata CoW
to protect itself from power loss.
Which needs extent allocator to avoid allocate extents on existing
extent range.
Btrfs also uses free space cache to speed up such allocation.

However there is a problem, v1 space cache is not protected by data CoW,
and can be corrupted during power loss.
So btrfs do extra check on free space cache, verifying its own in-file csum,
generation and free space recorded in cache and extent tree.

The problem is, under heavy concurrency, v1 space cache can be corrupted
even under normal operations without power loss.
And we believe corrupted space cache can break btrfs metadata CoW and
leads to the rare corruption in next power loss.

The most obvious symptom will be difference in free space:

This will be caught by kernel, but such check is quite weak, and if
the net free space change is 0 in one transaction, the corrupted
cache can be loaded by kernel.

In this case, btrfs check would report things like :
------
block group 298844160 has wrong amount of free space
failed to load free space cache for block group 298844160
------

But considering the test case are using notreelog, btrfs won't do
sub-transaction commit which doesn't increase generation, each
transaction should be consistent, and nothing should be reported at all.

Further more, we can even found corrupted file extents like:
------
root 5 inode 261 errors 100, file extent discount
Found file extent holes:
        start: 962560, len: 32768
ERROR: errors found in fs roots
------

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/dmlogwrites  |  72 +++++++++++++++++++++++++++
 tests/btrfs/159     | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/159.out |   2 +
 tests/btrfs/group   |   1 +
 4 files changed, 216 insertions(+)
 create mode 100755 tests/btrfs/159
 create mode 100644 tests/btrfs/159.out

diff --git a/common/dmlogwrites b/common/dmlogwrites
index 467b872e..54e7e242 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -126,3 +126,75 @@ _log_writes_cleanup()
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	_log_writes_remove
 }
+
+# Convert log writes mark to entry number
+# Result entry number is output to stdout, could be empty if not found
+_log_writes_mark_to_entry_number()
+{
+	local _mark=$1
+	local ret
+
+	[ -z "$_mark" ] && _fail \
+		"mark must be given for _log_writes_mark_to_entry_number"
+
+	ret=$($here/src/log-writes/replay-log --find --log $LOGWRITES_DEV \
+		--end-mark $_mark 2> /dev/null)
+	[ -z "$ret" ] && return
+	ret=$(echo "$ret" | cut -f1 -d\@)
+	echo "mark $_mark has entry number $ret" >> $seqres.full
+	echo "$ret"
+}
+
+# Find next fua write entry number
+# Result entry number is output to stdout, could be empty if not found
+_log_writes_find_next_fua()
+{
+	local _start_entry=$1
+	local ret
+
+	if [ -z "$_start_entry" ]; then
+		ret=$($here/src/log-writes/replay-log --find --log $LOGWRITES_DEV \
+			--next-fua 2> /dev/null)
+	else
+		ret=$($here/src/log-writes/replay-log --find --log $LOGWRITES_DEV \
+			--next-fua --start-entry $_start_entry 2> /dev/null)
+	fi
+	[ -z "$ret" ] && return
+
+	ret=$(echo "$ret" | cut -f1 -d\@)
+	echo "next fua is entry number $ret" >> $seqres.full
+	echo "$ret"
+}
+
+# Replay log range to specified entry
+# $1:	End entry. The last entry will *NOT* be replayed
+# $2:	Start entry. If not specified, start from the first entry.
+_log_writes_replay_log_entry_range()
+{
+	local _end=$1
+	local _start=$2
+
+	[ -z "$_end" ] && _fail \
+	"end entry must be specified for _log_writes_replay_log_entry_range"
+
+	if [[ "$_start" && "$_start" -gt "$_end" ]]; then
+		_fail \
+		"wrong parameter order for _log_writes_replay_log_entry_range:start=$_start end=$_end"
+	fi
+
+	# Original replay-log won't replay the last entry. So increase entry
+	# number here to ensure the end entry to be replayed
+	if [ -z "$_start" ]; then
+		echo "=== replay to $_end ===" >> $seqres.full
+		$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
+			--replay $SCRATCH_DEV --limit $_end -v \
+			>> $seqres.full 2>&1
+	else
+		echo "=== replay from $_start to $_end ===" >> $seqres.full
+		$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
+			--replay $SCRATCH_DEV --start-entry $_start \
+			--limit $(($_end - $_start)) -v \
+			>> $seqres.full 2>&1
+	fi
+	[ $? -ne 0 ] && _fail "replay failed"
+}
diff --git a/tests/btrfs/159 b/tests/btrfs/159
new file mode 100755
index 00000000..5113d526
--- /dev/null
+++ b/tests/btrfs/159
@@ -0,0 +1,141 @@
+#! /bin/bash
+# FS QA Test 159
+#
+# Test case for btrfs v1 space cache corruption
+#
+# Btrfs has some unexpected corruption after power loss, during the
+# investigation, the problem leads to v1 space cache corruption, which
+# could be loaded by kernel without detection.
+#
+# Kernel has 3 detection for corrupted space cache, checksum, generation
+# and free space, however the last one is a weak one. If in the one transaction
+# no net space change it can be loaded by kernel and break up metadata CoW,
+# leading serious corruption.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) SUSE.  All Rights Reserved.
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
+	_log_writes_cleanup
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/dmlogwrites
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Small workload is enough to trigger the problem
+workload=$(( 512 * $LOAD_FACTOR ))
+nr_threads=$(($($here/src/feature -o) * $LOAD_FACTOR))
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_log_writes
+_require_scratch
+
+_log_writes_init
+_log_writes_mkfs >> $seqres.full 2>&1
+
+# Here we don't want to create space cache yet
+_log_writes_mount -o nospace_cache
+
+# The SINGLE profile data chunk created by mkfs is too small (8M) so btrfs
+# won't create space cache for it.
+# We need a data chunk large enough so btrfs create space cache for it and
+# store the cache in itself.
+_run_btrfs_util_prog balance start --full-balance "$SCRATCH_MNT"
+
+_log_writes_unmount
+_log_writes_mark mkfs
+
+# Disable tree log, so btrfs will always do full transaction commit
+# It's OK to use tree log, but it will cause extra super block update which
+# doesn't increase generation.
+_log_writes_mount -o space_cache=v1,notreelog
+run_check $FSSTRESS_PROG -w -n $workload -p $nr_threads -d $SCRATCH_MNT \
+	$FSSTRESS_AVOID > /dev/null 2>&1
+_log_writes_unmount
+
+_log_writes_remove
+# Here we manually iterate through the log entries, as we need extra check
+# on the output of btrfs check. And we could have detailed replay log in 
+# $seqres.full
+prev=$(_log_writes_mark_to_entry_number mkfs)
+if [ -z "$prev" ]; then
+	_fail "failed to locate log writes mark 'mkfs'"
+fi
+
+# Here we only checks the result *AFTER* FUA writes, and no tree log, so
+# everything should be valid.
+cur=$(_log_writes_find_next_fua $prev)
+[ -z "$cur" ] && _fail "failed to locate next fua write"
+
+# log-replay will not replay the last item, so manually increase it by one
+cur=$(($cur + 1))
+
+_log_writes_replay_log_entry_range $prev >> $seqres.full 2>&1
+while [ ! -z "$cur" ]; do
+	_log_writes_replay_log_entry_range $cur $prev
+	# Catch the btrfs check output into temp file, as we need to
+	# grep the output to find the cache corruption
+	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV &> $tmp.fsck
+
+	# Cache passed generation,csum and free space check but corrupted
+	# will be reported as error
+	if [ $? -ne 0 ]; then
+		cat $tmp.fsck >> $seqres.full
+		_fail "btrfs check found corruption"
+	fi
+
+	# Mount option has ruled out any possible factors affect space cache
+	# And we are at the FUA writes, no generation related problem should
+	# happen anyway
+	if grep -q -e 'failed to load free space cache' $tmp.fsck; then
+		cat $tmp.fsck >> $seqres.full
+		_fail "btrfs check found invalid space cache"
+	fi
+
+	prev=$cur
+	cur=$(_log_writes_find_next_fua $prev)
+	[ -z $cur ] && break
+
+	# Same as above
+	cur=$(($cur + 1))
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
new file mode 100644
index 00000000..e569e60c
--- /dev/null
+++ b/tests/btrfs/159.out
@@ -0,0 +1,2 @@
+QA output created by 159
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 8007e07e..bc83db94 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -161,3 +161,4 @@
 156 auto quick trim
 157 auto quick raid
 158 auto quick raid scrub
+159 auto
-- 
2.15.1

