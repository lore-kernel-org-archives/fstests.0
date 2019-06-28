Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40636 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726775AbfF1W7S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jun 2019 18:59:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 4/5] shared,generic: move shared/006 to generic/
Date: Fri, 28 Jun 2019 18:59:09 -0400
Message-Id: <20190628225910.17018-4-tytso@mit.edu>
In-Reply-To: <20190628225910.17018-1-tytso@mit.edu>
References: <20190628225910.17018-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The shared/006 uses _scratch_mkfs_sized to create a limited size file
system, and then creates inodes until it gets ENOSPC, and then checks
to make sure the file system is consistent.  It then remounts the file
system, removes all of the files, and makes sure the file system is
consistent afterwards.

This test was marked as only being supported on ext[234] and xfs, and
so it was in shared.  However, I've tested and this test works just
fine on btrfs, ubifs, tmpfs, and should work on all file systems that
support _scratch_mkfs_sized, since even if there isn't a fixed inode
table, the file system will eventually run out of disk space.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
Changes since v1:
   - added a new _require_scratch_inode_limits and use it for generic/558
   - added missing "_supported_fs generic" line

 common/rc                         | 11 +++++++++++
 tests/{shared/006 => generic/558} |  7 +++----
 tests/generic/558.out             |  2 ++
 tests/generic/group               |  1 +
 tests/shared/006.out              |  2 --
 tests/shared/group                |  1 -
 6 files changed, 17 insertions(+), 7 deletions(-)
 rename tests/{shared/006 => generic/558} (95%)
 create mode 100644 tests/generic/558.out
 delete mode 100644 tests/shared/006.out

diff --git a/common/rc b/common/rc
index 9165a6f2..8e024f04 100644
--- a/common/rc
+++ b/common/rc
@@ -4147,6 +4147,17 @@ _require_scratch_btime()
 	_scratch_unmount
 }
 
+_require_scratch_inode_limits()
+{
+	_require_scratch
+	_scratch_mkfs > /dev/null 2>&1
+	_scratch_mount
+	if [ $(_get_free_inode $SCRATCH_MNT) -eq 0 ]; then
+		_notrun "$FSTYP does not have a fixed number of inodes available"
+	fi
+	_scratch_unmount
+}
+
 _require_filefrag_options()
 {
 	_require_command "$FILEFRAG_PROG" filefrag
diff --git a/tests/shared/006 b/tests/generic/558
similarity index 95%
rename from tests/shared/006
rename to tests/generic/558
index aa65e9a2..5807dba3 100755
--- a/tests/shared/006
+++ b/tests/generic/558
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2014 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test No. shared/006
+# FS QA Test No. generic/558
 #
 # Stress test fs by using up all inodes and check fs.
 #
@@ -42,10 +42,9 @@ create_file()
 . ./common/filter
 
 # real QA test starts here
-_supported_fs ext4 ext3 ext2 xfs
+_supported_fs generic
 _supported_os Linux
-
-_require_scratch
+_require_scratch_inode_limits
 
 rm -f $seqres.full
 echo "Silence is golden"
diff --git a/tests/generic/558.out b/tests/generic/558.out
new file mode 100644
index 00000000..9a6c4e79
--- /dev/null
+++ b/tests/generic/558.out
@@ -0,0 +1,2 @@
+QA output created by 558
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 543c0627..8fc85b63 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -560,3 +560,4 @@
 555 auto quick cap
 556 auto quick casefold
 557 auto quick log
+558 auto enospc
diff --git a/tests/shared/006.out b/tests/shared/006.out
deleted file mode 100644
index 675c1b7c..00000000
--- a/tests/shared/006.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 006
-Silence is golden
diff --git a/tests/shared/group b/tests/shared/group
index 3507d7d4..2cf910bd 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -4,7 +4,6 @@
 # - comment line before each group is "new" description
 #
 002 auto metadata quick log
-006 auto enospc
 008 auto stress dedupe
 009 auto stress dedupe
 010 auto stress dedupe
-- 
2.22.0
