Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57191 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbfFXBnB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jun 2019 21:43:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/5] shared,generic: move shared/006 to generic/
Date: Sun, 23 Jun 2019 19:09:55 -0400
Message-Id: <20190623230956.24670-4-tytso@mit.edu>
In-Reply-To: <20190623230956.24670-1-tytso@mit.edu>
References: <20190623230956.24670-1-tytso@mit.edu>
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
 tests/{shared/006 => generic/558} | 4 +---
 tests/generic/558.out             | 2 ++
 tests/generic/group               | 1 +
 tests/shared/006.out              | 2 --
 tests/shared/group                | 1 -
 5 files changed, 4 insertions(+), 6 deletions(-)
 rename tests/{shared/006 => generic/558} (96%)
 create mode 100644 tests/generic/558.out
 delete mode 100644 tests/shared/006.out

diff --git a/tests/shared/006 b/tests/generic/558
similarity index 96%
rename from tests/shared/006
rename to tests/generic/558
index aa65e9a2..8bfc65fa 100755
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
@@ -42,9 +42,7 @@ create_file()
 . ./common/filter
 
 # real QA test starts here
-_supported_fs ext4 ext3 ext2 xfs
 _supported_os Linux
-
 _require_scratch
 
 rm -f $seqres.full
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
