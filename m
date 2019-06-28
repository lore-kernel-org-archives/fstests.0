Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40638 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726864AbfF1W7T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jun 2019 18:59:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 1/5] shared,ext4: move ext4-specific tests out of shared/
Date: Fri, 28 Jun 2019 18:59:06 -0400
Message-Id: <20190628225910.17018-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The tests shared/{001,003,004,272} test behaviour around the ext4's
journal.  As such, they are pointless to run on ext2, and ext3 no
longer is in kernels newer than 4.3.  (And most enterprise
distributions have been using ext4 to support the ext3 file system;
that capability has been around since 2.6.33.)  So we can move these
tests out of shared and into the ext4 class of tests:

	shared/001 --> ext4/036
	shared/003 --> ext4/037
	shared/004 --> ext4/038
	shared/272 --> ext4/039

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
Changes since v1:
   - Adjusted _supported_fs lines

 tests/{shared/001 => ext4/036}         | 6 +++---
 tests/ext4/036.out                     | 2 ++
 tests/{shared/003 => ext4/037}         | 6 ++----
 tests/ext4/037.out                     | 2 ++
 tests/{shared/004 => ext4/038}         | 4 ++--
 tests/ext4/038.out                     | 2 ++
 tests/{shared/272 => ext4/039}         | 2 +-
 tests/{shared/272.out => ext4/039.out} | 2 +-
 tests/ext4/group                       | 4 ++++
 tests/shared/001.out                   | 2 --
 tests/shared/003.out                   | 2 --
 tests/shared/004.out                   | 2 --
 tests/shared/group                     | 4 ----
 13 files changed, 19 insertions(+), 21 deletions(-)
 rename tests/{shared/001 => ext4/036} (90%)
 create mode 100644 tests/ext4/036.out
 rename tests/{shared/003 => ext4/037} (93%)
 create mode 100644 tests/ext4/037.out
 rename tests/{shared/004 => ext4/038} (94%)
 create mode 100644 tests/ext4/038.out
 rename tests/{shared/272 => ext4/039} (97%)
 rename tests/{shared/272.out => ext4/039.out} (72%)
 delete mode 100644 tests/shared/001.out
 delete mode 100644 tests/shared/003.out
 delete mode 100644 tests/shared/004.out

diff --git a/tests/shared/001 b/tests/ext4/036
similarity index 90%
rename from tests/shared/001
rename to tests/ext4/036
index bde6e198..08a5e64e 100755
--- a/tests/shared/001
+++ b/tests/ext4/036
@@ -2,9 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test No. 001
+# FS QA Test No. ext4/036 (was shared/001)
 #
-# Test truncate orphan inodes when mounting extN.
+# Test truncate orphan inodes when mounting ext4
 # ext4 used to hit WARNING, this commit fixed the issue
 #
 # 721e3eb ext4: lock i_mutex when truncating orphan inodes
@@ -29,7 +29,7 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_supported_fs ext2 ext3 ext4
+_supported_fs ext3 ext4
 _supported_os Linux
 _require_scratch
 
diff --git a/tests/ext4/036.out b/tests/ext4/036.out
new file mode 100644
index 00000000..ed460d98
--- /dev/null
+++ b/tests/ext4/036.out
@@ -0,0 +1,2 @@
+QA output created by 036
+Silence is golden
diff --git a/tests/shared/003 b/tests/ext4/037
similarity index 93%
rename from tests/shared/003
rename to tests/ext4/037
index 761b9691..33c46e13 100755
--- a/tests/shared/003
+++ b/tests/ext4/037
@@ -2,15 +2,13 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test 003
+# FS QA Test ext4/037 (was shared/003)
 #
 # Test mount a needs_recovery partition with noload option.
 # ext4 used to Oops until part of this commit:
 #
 # 744692d ext4: use ext4_get_block_write in buffer write
 #
-# Also test on ext2/3.
-#
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -31,7 +29,7 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_supported_fs ext2 ext3 ext4
+_supported_fs ext3 ext4
 _supported_os Linux
 
 # nofsck as we modify sb via debugfs
diff --git a/tests/ext4/037.out b/tests/ext4/037.out
new file mode 100644
index 00000000..5c3a30a4
--- /dev/null
+++ b/tests/ext4/037.out
@@ -0,0 +1,2 @@
+QA output created by 037
+Silence is golden
diff --git a/tests/shared/004 b/tests/ext4/038
similarity index 94%
rename from tests/shared/004
rename to tests/ext4/038
index 3021c85d..b8f52b5a 100755
--- a/tests/shared/004
+++ b/tests/ext4/038
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2016 Fujitsu.  All Rights Reserved.
 #
-# FS QA Test 004
+# FS QA Test ext4/038 (was shared/004)
 #
 # Regression test for commit:
 # c9eb13a ext4: fix hang when processing corrupted orphaned inode list
@@ -25,7 +25,7 @@ _cleanup()
 . ./common/rc
 
 # real QA test starts here
-_supported_fs ext2 ext3 ext4
+_supported_fs ext3 ext4
 _supported_os Linux
 _require_scratch
 _require_command "$DEBUGFS_PROG" debugfs
diff --git a/tests/ext4/038.out b/tests/ext4/038.out
new file mode 100644
index 00000000..5e0f13ec
--- /dev/null
+++ b/tests/ext4/038.out
@@ -0,0 +1,2 @@
+QA output created by 038
+Silence is golden
diff --git a/tests/shared/272 b/tests/ext4/039
similarity index 97%
rename from tests/shared/272
rename to tests/ext4/039
index b94dfc3c..28db308d 100755
--- a/tests/shared/272
+++ b/tests/ext4/039
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
 #
-# FSQA Test No. 272
+# FSQA Test No. ext4/039 (was shared/272)
 #
 # Test data journaling flag switch for a single file  
 #
diff --git a/tests/shared/272.out b/tests/ext4/039.out
similarity index 72%
rename from tests/shared/272.out
rename to tests/ext4/039.out
index a9eaf84c..2c8aabad 100644
--- a/tests/shared/272.out
+++ b/tests/ext4/039.out
@@ -1,3 +1,3 @@
-QA output created by 272
+QA output created by 039
 Switch data journalling mode. Silence is golden.
 Check filesystem
diff --git a/tests/ext4/group b/tests/ext4/group
index d27ec893..6418d82d 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -38,6 +38,10 @@
 033 auto ioctl resize
 034 auto quick quota
 035 auto quick resize
+036 auto quick
+037 auto quick
+038 auto quick
+039 auto enospc rw
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
diff --git a/tests/shared/001.out b/tests/shared/001.out
deleted file mode 100644
index 88678b8e..00000000
--- a/tests/shared/001.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 001
-Silence is golden
diff --git a/tests/shared/003.out b/tests/shared/003.out
deleted file mode 100644
index 6895fc80..00000000
--- a/tests/shared/003.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 003
-Silence is golden
diff --git a/tests/shared/004.out b/tests/shared/004.out
deleted file mode 100644
index af8614ae..00000000
--- a/tests/shared/004.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 004
-Silence is golden
diff --git a/tests/shared/group b/tests/shared/group
index b091d911..6f184946 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -3,10 +3,7 @@
 # - do not start group names with a digit
 # - comment line before each group is "new" description
 #
-001 auto quick
 002 auto metadata quick log
-003 auto quick
-004 auto quick
 005 dangerous_fuzzers
 006 auto enospc
 007 dangerous_fuzzers
@@ -15,6 +12,5 @@
 010 auto stress dedupe
 011 auto quick
 032 mkfs auto quick
-272 auto enospc rw
 289 auto quick
 298 auto trim
-- 
2.22.0
