Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:30658 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbaHPNNg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Aug 2014 09:13:36 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 6/6] ext4/308: add new defrag compact test case
Date: Sat, 16 Aug 2014 17:13:11 +0400
Message-Id: <1408194791-1797-6-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

Check data integrity and layout stability during defrag compacting
EXT4_IOC_MOVE_EXT swap extents between target and donor inode.
If ioctl was performed twice then inode's layout should not change.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 tests/ext4/308     |  103 ++++++++
 tests/ext4/308.out |  681 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/group   |    3 +-
 3 files changed, 786 insertions(+), 1 deletions(-)
 create mode 100755 tests/ext4/308
 create mode 100644 tests/ext4/308.out

diff --git a/tests/ext4/308 b/tests/ext4/308
new file mode 100755
index 0000000..846ef12
--- /dev/null
+++ b/tests/ext4/308
@@ -0,0 +1,103 @@
+#! /bin/bash
+# FSQA Test No. 308
+#
+# Check data integrity and layout stability during defrag compacting
+# EXT4_IOC_MOVE_EXT simply swap extents between target and donor inode.
+# So if ioctl was performed twice then inode's layout should not change.
+#
+#-----------------------------------------------------------------------
+# (c) 2014 Dmitry Monakhov
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
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+PIDS=""
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/defrag
+
+# real QA test starts here
+_supported_os Linux
+_need_to_be_root
+_require_scratch
+_require_defrag
+
+rm -f $seqres.full
+
+_workout()
+{
+	nr=$1
+	echo "Create file with $nr * 2 fragments"
+	# Create sparse file
+	for ((i=0;i<nr;i++))
+	do
+		$XFS_IO_PROG -f -c "falloc $((409600*i)) 4k"  \
+			$SCRATCH_MNT/test.$nr >> $seqres.full 2>&1
+	done
+	# Fill holes for half of range , as result file will contain nr*1.5 fragments
+	$XFS_IO_PROG -c "falloc 0 $((204800*nr))"  \
+	    $SCRATCH_MNT/test.$nr | _filter_xfs_io
+	# Data wrilte will convert extetns to inialized ones
+	for ((i=0;i<nr;i++))
+	do
+		patt=`printf "0x%x" $i`
+		$XFS_IO_PROG -c "pwrite -S $patt $((i*123400)) 1234" \
+			$SCRATCH_MNT/test.$nr | _filter_xfs_io
+	done
+	md5sum $SCRATCH_MNT/test.*
+	$XFS_IO_PROG -c "fiemap" -f $SCRATCH_MNT/test.* > $tmp.fiemap.before
+
+	echo "Perform compacting"
+	$XFS_IO_PROG -c "falloc 0 246M" -f $SCRATCH_MNT/donor | _filter_xfs_io
+	ls $SCRATCH_MNT/test.* | run_check $here/src/e4compact \
+		 -v -i -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
+	md5sum $SCRATCH_MNT/test.*
+	$XFS_IO_PROG -c "fiemap" -f $SCRATCH_MNT/test.* > $tmp.fiemap.pass1
+	diff $tmp.fiemap.before $tmp.fiemap.pass1 > /dev/null && \
+	    _fail "Pass1: Extent's layout not changed"
+
+	echo "Perform compacting, second pass"
+	# Second pass should restore original layout
+	ls $SCRATCH_MNT/test.* | run_check $here/src/e4compact \
+		 -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
+	md5sum $SCRATCH_MNT/test.*
+	$XFS_IO_PROG -c "fiemap" -f $SCRATCH_MNT/test.* > $tmp.fiemap.pass2
+	diff -up $tmp.fiemap.before $tmp.fiemap.pass2 || \
+	    _fail "Pass2: Extent's layout changed."
+	unlink $SCRATCH_MNT/donor
+}
+
+# Actual testing starting from here
+_scratch_mkfs  >> $seqres.full 2>&1
+_scratch_mount
+_workout 10
+_workout 20
+_workout 40
+_workout 80
+_workout 160
+status=0
\ No newline at end of file
diff --git a/tests/ext4/308.out b/tests/ext4/308.out
new file mode 100644
index 0000000..4d361a1
--- /dev/null
+++ b/tests/ext4/308.out
@@ -0,0 +1,681 @@
+QA output created by 308
+Create file with 10 * 2 fragments
+wrote 1234/1234 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 123400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 246800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 370200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 493600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 617000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 740400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 863800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 987200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1110600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+Perform compacting
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+Perform compacting, second pass
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+Create file with 20 * 2 fragments
+wrote 1234/1234 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 123400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 246800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 370200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 493600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 617000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 740400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 863800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 987200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1110600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1234000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1357400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1480800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1604200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1727600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1851000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1974400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2097800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2221200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2344600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+Perform compacting
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+Perform compacting, second pass
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+Create file with 40 * 2 fragments
+wrote 1234/1234 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 123400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 246800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 370200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 493600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 617000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 740400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 863800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 987200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1110600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1234000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1357400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1480800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1604200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1727600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1851000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1974400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2097800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2221200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2344600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2468000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2591400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2714800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2838200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2961600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3085000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3208400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3331800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3455200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3578600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3702000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3825400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3948800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4072200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4195600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4319000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4442400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4565800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4689200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4812600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+Perform compacting
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+Perform compacting, second pass
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+Create file with 80 * 2 fragments
+wrote 1234/1234 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 123400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 246800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 370200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 493600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 617000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 740400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 863800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 987200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1110600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1234000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1357400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1480800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1604200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1727600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1851000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1974400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2097800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2221200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2344600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2468000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2591400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2714800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2838200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2961600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3085000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3208400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3331800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3455200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3578600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3702000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3825400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3948800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4072200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4195600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4319000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4442400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4565800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4689200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4812600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4936000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5059400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5182800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5306200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5429600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5553000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5676400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5799800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5923200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6046600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6170000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6293400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6416800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6540200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6663600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6787000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6910400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7033800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7157200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7280600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7404000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7527400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7650800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7774200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7897600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8021000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8144400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8267800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8391200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8514600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8638000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8761400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8884800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9008200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9131600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9255000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9378400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9501800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9625200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9748600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+96a65e624734a046b2fd52448f71074d  /mnt_scratch/test.80
+Perform compacting
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+96a65e624734a046b2fd52448f71074d  /mnt_scratch/test.80
+Perform compacting, second pass
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+96a65e624734a046b2fd52448f71074d  /mnt_scratch/test.80
+Create file with 160 * 2 fragments
+wrote 1234/1234 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 123400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 246800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 370200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 493600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 617000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 740400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 863800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 987200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1110600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1234000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1357400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1480800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1604200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1727600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1851000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 1974400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2097800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2221200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2344600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2468000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2591400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2714800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2838200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 2961600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3085000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3208400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3331800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3455200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3578600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3702000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3825400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 3948800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4072200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4195600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4319000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4442400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4565800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4689200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4812600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 4936000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5059400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5182800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5306200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5429600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5553000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5676400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5799800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 5923200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6046600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6170000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6293400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6416800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6540200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6663600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6787000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 6910400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7033800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7157200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7280600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7404000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7527400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7650800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7774200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 7897600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8021000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8144400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8267800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8391200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8514600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8638000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8761400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 8884800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9008200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9131600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9255000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9378400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9501800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9625200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9748600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9872000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 9995400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 10118800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 10242200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 10365600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 10489000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 10612400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 10735800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 10859200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 10982600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 11106000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 11229400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 11352800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 11476200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 11599600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 11723000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 11846400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 11969800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 12093200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 12216600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 12340000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 12463400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 12586800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 12710200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 12833600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 12957000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 13080400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 13203800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 13327200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 13450600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 13574000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 13697400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 13820800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 13944200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 14067600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 14191000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 14314400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 14437800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 14561200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 14684600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 14808000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 14931400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 15054800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 15178200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 15301600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 15425000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 15548400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 15671800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 15795200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 15918600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 16042000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 16165400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 16288800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 16412200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 16535600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 16659000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 16782400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 16905800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 17029200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 17152600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 17276000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 17399400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 17522800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 17646200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 17769600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 17893000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 18016400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 18139800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 18263200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 18386600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 18510000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 18633400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 18756800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 18880200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 19003600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 19127000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 19250400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 19373800
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 19497200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1234/1234 bytes at offset 19620600
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+aff33ee70cfca814d5afc93c589a991d  /mnt_scratch/test.160
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+96a65e624734a046b2fd52448f71074d  /mnt_scratch/test.80
+Perform compacting
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+aff33ee70cfca814d5afc93c589a991d  /mnt_scratch/test.160
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+96a65e624734a046b2fd52448f71074d  /mnt_scratch/test.80
+Perform compacting, second pass
+50f924a5dc9b03609a4577f9f961414b  /mnt_scratch/test.10
+aff33ee70cfca814d5afc93c589a991d  /mnt_scratch/test.160
+6f9881a10aa775535623786328412d3d  /mnt_scratch/test.20
+f968580511a76bdf4ac521291a901ba0  /mnt_scratch/test.40
+96a65e624734a046b2fd52448f71074d  /mnt_scratch/test.80
diff --git a/tests/ext4/group b/tests/ext4/group
index b384981..aa6a53b 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -13,4 +13,5 @@
 304 aio dangerous ioctl rw stress
 305 auto
 306 auto rw resize quick
-307 auto ioctl rw
\ No newline at end of file
+307 auto ioctl rw
+308 auto ioctl rw prealloc quick
\ No newline at end of file
-- 
1.7.1

