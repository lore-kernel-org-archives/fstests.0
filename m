Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:42777 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753887AbaIQBmQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Sep 2014 21:42:16 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XU4Fo-0003ka-9r
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XU4Fo-0006OO-93
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 4/5] generic: add mmap write vs truncate/remap test
Date: Wed, 17 Sep 2014 11:41:52 +1000
Message-Id: <1410918113-23516-5-git-send-email-david@fromorbit.com>
In-Reply-To: <1410918113-23516-1-git-send-email-david@fromorbit.com>
References: <1410918113-23516-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test exposed a problem with mapped writes to the tail page of a
file in XFS and potentially ext4. Eric did all the hard work of
taking the bug report and generating the reproducable test case
on ext4, but I haven't been able to reproduce then problem on ext4.

Regardless, make it a generic test so that we can ensure that all
filesystems handle the case correctly.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/030     | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/030.out |  53 ++++++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 202 insertions(+)
 create mode 100644 tests/generic/030
 create mode 100644 tests/generic/030.out

diff --git a/tests/generic/030 b/tests/generic/030
new file mode 100644
index 0000000..9947b96
--- /dev/null
+++ b/tests/generic/030
@@ -0,0 +1,148 @@
+#! /bin/bash
+# FS QA Test No. generic/030
+#
+# Test mapped writes against remap+truncate down/up to ensure we get the data
+# correctly written. This can expose data corruption bugs on filesystems where
+# the block size is smaller than the page size.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
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
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os IRIX Linux
+_require_scratch
+_require_xfs_io_command "mremap"
+
+testfile=$SCRATCH_MNT/testfile
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# first case is just truncate down/truncate up to check that the mapped
+# write after the truncate up is correctly handled.
+$XFS_IO_PROG -t -f \
+-c "truncate 5017k"             `# truncate     |       |` \
+-c "pwrite -S 0x58 0 5017k"     `# write        |X...XXX|` \
+-c "mmap -rw 0 5017k"           `# mmap         |       |` \
+-c "truncate 5020k"             `# truncate up  |                        |` \
+-c "mremap -m 5020k"            `# mremap up    |                        |` \
+-c "mwrite -S 0x57 5017k 3k"    `# mwrite       |        WWWWWWWWWWWWWWWW|` \
+-c "mremap 5017k "              `# mremap dn    |       |` \
+-c "truncate 5017k"             `# mremap dn    |       |` \
+-c "truncate 5020k"             `# truncate up  |                        |` \
+-c "mremap -m 5020k"            `# mremap up    |                        |` \
+-c "mwrite -S 0x59 5017k 3k"    `# mwrite       |        YYYYYYYYYYYYYYYY|` \
+-c "close"      \
+$testfile | _filter_xfs_io
+
+echo "==== Pre-Remount ==="
+hexdump -C $testfile
+_scratch_remount
+echo "==== Post-Remount =="
+hexdump -C $testfile
+
+rm -f $testfile
+sync
+
+# second case is to do a mwrite between the truncate to a block on the
+# same page we are truncating within the EOF. This checks that a mapped
+# write between truncate down and truncate up a further mapped
+# write to the same page into the new space doesn't result in data being lost.
+$XFS_IO_PROG -t -f \
+-c "truncate 5017k"             `# truncate     |       |` \
+-c "pwrite -S 0x58 0 5017k"     `# write        |X...XXX|` \
+-c "mmap -rw 0 5017k"           `# mmap         |       |` \
+-c "truncate 5020k"             `# truncate up  |                        |` \
+-c "mremap -m 5020k"            `# mremap up    |                        |` \
+-c "mwrite -S 0x57 5017k 3k"    `# mwrite       |        WWWWWWWWWWWWWWWW|` \
+-c "mremap 5017k "              `# mremap dn    |       |` \
+-c "truncate 5017k"             `# mremap dn    |       |` \
+-c "mwrite -S 0x5a 5016k 1k"    `# mwrite       |    ZZZ                 |` \
+-c "truncate 5020k"             `# truncate up  |                        |` \
+-c "mremap -m 5020k"            `# mremap up    |                        |` \
+-c "mwrite -S 0x59 5017k 3k"    `# mwrite       |        YYYYYYYYYYYYYYYY|` \
+-c "close"      \
+$testfile | _filter_xfs_io
+
+echo "==== Pre-Remount ==="
+hexdump -C $testfile
+_scratch_remount
+echo "==== Post-Remount =="
+hexdump -C $testfile
+
+# third case is the same as the first, but this time on unaligned byte
+# boundaries rather than block boundaries. This mimics the exact mmap write
+# patterns of the application that exposed the bug in the first place, and
+# so is somewhat more complex and has repeated operations in it. 
+$XFS_IO_PROG -t -f \
+-c "truncate 5136912" \
+-c "pwrite -S 0x58 0 5136912" \
+-c "mmap -rw 0 5136912" \
+-c "mremap 5136912" \
+-c "truncate 5136912" \
+-c "truncate 5139720" \
+-c "mremap -m 5139720" \
+-c "mwrite -S 0 5136912 2808" \
+-c "mwrite -S 0 5136912 2808" \
+-c "mwrite -S 0 5136912 2808" \
+-c "mremap 5136912 " \
+-c "truncate 5136912" \
+-c "truncate 5139720" \
+-c "mremap -m 5139720" \
+-c "mwrite -S 0 5136912 2808" \
+-c "mwrite -S 0 5136912 2808" \
+-c "mwrite -S 0x59 5136912 2808" \
+-c "truncate 5140480" \
+-c "mremap 5140480" \
+-c "msync -s 0 5140480" \
+-c "mremap 5139720" \
+-c "munmap" \
+-c "close" \
+$testfile | _filter_xfs_io
+
+echo "==== Pre-Remount ==="
+hexdump -C $testfile
+_scratch_remount
+echo "==== Post-Remount =="
+hexdump -C $testfile
+
+status=0
+exit
+
diff --git a/tests/generic/030.out b/tests/generic/030.out
new file mode 100644
index 0000000..20f6561
--- /dev/null
+++ b/tests/generic/030.out
@@ -0,0 +1,53 @@
+QA output created by 030
+wrote 5137408/5137408 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== Pre-Remount ===
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+*
+004e7000
+==== Post-Remount ==
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+*
+004e7000
+wrote 5137408/5137408 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== Pre-Remount ===
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+004e6000  5a 5a 5a 5a 5a 5a 5a 5a  5a 5a 5a 5a 5a 5a 5a 5a  |ZZZZZZZZZZZZZZZZ|
+*
+004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+*
+004e7000
+==== Post-Remount ==
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+004e6000  5a 5a 5a 5a 5a 5a 5a 5a  5a 5a 5a 5a 5a 5a 5a 5a  |ZZZZZZZZZZZZZZZZ|
+*
+004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+*
+004e7000
+wrote 5136912/5136912 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== Pre-Remount ===
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+004e6210  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+*
+004e6d00  59 59 59 59 59 59 59 59  00 00 00 00 00 00 00 00  |YYYYYYYY........|
+004e6d10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+004e7000
+==== Post-Remount ==
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+004e6210  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+*
+004e6d00  59 59 59 59 59 59 59 59  00 00 00 00 00 00 00 00  |YYYYYYYY........|
+004e6d10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+004e7000
diff --git a/tests/generic/group b/tests/generic/group
index 18c94de..ba1c913 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -32,6 +32,7 @@
 027 auto enospc
 028 auto quick
 029 auto quick rw
+030 auto quick rw
 053 acl repair auto quick
 062 attr udf auto quick
 068 other auto freeze dangerous stress
-- 
2.0.0

