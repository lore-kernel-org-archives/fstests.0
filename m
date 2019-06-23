Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57209 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727112AbfFXBnE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jun 2019 21:43:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 5/5] shared,generic: move tests using duperemove to generic/
Date: Sun, 23 Jun 2019 19:09:56 -0400
Message-Id: <20190623230956.24670-5-tytso@mit.edu>
In-Reply-To: <20190623230956.24670-1-tytso@mit.edu>
References: <20190623230956.24670-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Add _require_scratch_duperemove which validates that the file system
supports duperemove.  This allows us to move three tests from shared/
to generic/.  This means these tests will automatically adapt when
duperemove supports other file systems.  Tests moved are:

	shared/008 --> generic/559
	shared/009 --> generic/560
	shared/010 --> generic/561

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/reflink                            | 18 ++++++++++++++++++
 tests/{shared/008 => generic/559}         |  9 +++------
 tests/{shared/008.out => generic/559.out} |  2 +-
 tests/{shared/009 => generic/560}         |  9 ++-------
 tests/{shared/009.out => generic/560.out} |  2 +-
 tests/{shared/010 => generic/561}         |  9 ++-------
 tests/generic/561.out                     |  2 ++
 tests/generic/group                       |  3 +++
 tests/shared/010.out                      |  2 --
 tests/shared/group                        |  3 ---
 10 files changed, 32 insertions(+), 27 deletions(-)
 rename tests/{shared/008 => generic/559} (85%)
 rename tests/{shared/008.out => generic/559.out} (64%)
 rename tests/{shared/009 => generic/560} (91%)
 rename tests/{shared/009.out => generic/560.out} (74%)
 rename tests/{shared/010 => generic/561} (89%)
 create mode 100644 tests/generic/561.out
 delete mode 100644 tests/shared/010.out

diff --git a/common/reflink b/common/reflink
index 598f0877..ee60398e 100644
--- a/common/reflink
+++ b/common/reflink
@@ -75,6 +75,24 @@ _require_scratch_reflink()
 	_scratch_unmount
 }
 
+# this test requires duperemove working for the file system
+_require_scratch_duperemove()
+{
+	_require_scratch
+	_require_command "$DUPEREMOVE_PROG" duperemove
+
+	_scratch_mkfs > /dev/null
+	_scratch_mount
+	dd if=/dev/zero of="$SCRATCH_MNT/file1" bs=128k count=1 >& /dev/null
+	dd if=/dev/zero of="$SCRATCH_MNT/file2" bs=128k count=1 >& /dev/null
+	if ! "$DUPEREMOVE_PROG" -d "$SCRATCH_MNT/file1" \
+	    "$SCRATCH_MNT/file2" >& /dev/null ; then
+		_scratch_unmount
+		_notrun "duperemove does not support file system type: $FSTYP"
+	fi
+	_scratch_unmount
+}
+
 # this test requires scratch fs to report explicit SHARED flag
 # e.g.
 #   0         4K         8K
diff --git a/tests/shared/008 b/tests/generic/559
similarity index 85%
rename from tests/shared/008
rename to tests/generic/559
index a7d76083..4a8a3dd8 100755
--- a/tests/shared/008
+++ b/tests/generic/559
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test 008
+# FS QA Test generic/559 (was shared/008)
 #
 # Dedupe a single big file and verify integrity
 #
@@ -29,12 +29,9 @@ _cleanup()
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-# duperemove only supports btrfs and xfs (with reflink feature).
-# Add other filesystems if it supports more later.
-_supported_fs xfs btrfs
+# real QA test starts here
 _supported_os Linux
-_require_scratch_dedupe
-_require_command "$DUPEREMOVE_PROG" duperemove
+_require_scratch_duperemove
 
 fssize=$((2 * 1024 * 1024 * 1024))
 _scratch_mkfs_sized $fssize > $seqres.full 2>&1
diff --git a/tests/shared/008.out b/tests/generic/559.out
similarity index 64%
rename from tests/shared/008.out
rename to tests/generic/559.out
index f29d478f..a558ada3 100644
--- a/tests/shared/008.out
+++ b/tests/generic/559.out
@@ -1,3 +1,3 @@
-QA output created by 008
+QA output created by 559
 = before cycle mount =
 = after cycle mount =
diff --git a/tests/shared/009 b/tests/generic/560
similarity index 91%
rename from tests/shared/009
rename to tests/generic/560
index 933d3098..d28c019f 100755
--- a/tests/shared/009
+++ b/tests/generic/560
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test 009
+# FS QA Test generic/560 (was shared/009)
 #
 # Iterate dedupe integrity test. Copy an original data0 several
 # times (d0 -> d1, d1 -> d2, ... dn-1 -> dn), dedupe dataN everytime
@@ -32,13 +32,8 @@ _cleanup()
 rm -f $seqres.full
 
 # real QA test starts here
-
-# duperemove only supports btrfs and xfs (with reflink feature).
-# Add other filesystems if it supports more later.
-_supported_fs xfs btrfs
 _supported_os Linux
-_require_scratch_dedupe
-_require_command "$DUPEREMOVE_PROG" duperemove
+_require_scratch_duperemove
 
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
diff --git a/tests/shared/009.out b/tests/generic/560.out
similarity index 74%
rename from tests/shared/009.out
rename to tests/generic/560.out
index 44a78ba3..10ae7edd 100644
--- a/tests/shared/009.out
+++ b/tests/generic/560.out
@@ -1,4 +1,4 @@
-QA output created by 009
+QA output created by 560
 = Do dedup and verify =
 = Backwords verify =
 = Verify after cycle mount =
diff --git a/tests/shared/010 b/tests/generic/561
similarity index 89%
rename from tests/shared/010
rename to tests/generic/561
index 04f55890..76538080 100755
--- a/tests/shared/010
+++ b/tests/generic/561
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test 010
+# FS QA Test generic/561 (was shared/010)
 #
 # Dedup & random I/O race test, do multi-threads fsstress and dedupe on
 # same directory/files
@@ -32,13 +32,8 @@ _cleanup()
 rm -f $seqres.full
 
 # real QA test starts here
-
-# duperemove only supports btrfs and xfs (with reflink feature).
-# Add other filesystems if it supports more later.
-_supported_fs xfs btrfs
 _supported_os Linux
-_require_scratch_dedupe
-_require_command "$DUPEREMOVE_PROG" duperemove
+_require_scratch_duperemove
 _require_command "$KILLALL_PROG" killall
 
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/561.out b/tests/generic/561.out
new file mode 100644
index 00000000..5e46f61f
--- /dev/null
+++ b/tests/generic/561.out
@@ -0,0 +1,2 @@
+QA output created by 561
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 8fc85b63..c30d18e0 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -561,3 +561,6 @@
 556 auto quick casefold
 557 auto quick log
 558 auto enospc
+559 auto stress dedupe
+560 auto stress dedupe
+561 auto stress dedupe
diff --git a/tests/shared/010.out b/tests/shared/010.out
deleted file mode 100644
index 1d83a8d6..00000000
--- a/tests/shared/010.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 010
-Silence is golden
diff --git a/tests/shared/group b/tests/shared/group
index 2cf910bd..6112c8dd 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -4,9 +4,6 @@
 # - comment line before each group is "new" description
 #
 002 auto metadata quick log
-008 auto stress dedupe
-009 auto stress dedupe
-010 auto stress dedupe
 011 auto quick
 032 mkfs auto quick
 298 auto trim
-- 
2.22.0
