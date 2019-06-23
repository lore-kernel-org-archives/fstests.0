Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57191 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbfFXBnE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jun 2019 21:43:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/5] shared,ext4: move ext[234]-specific tests out of shared/
Date: Sun, 23 Jun 2019 19:09:54 -0400
Message-Id: <20190623230956.24670-3-tytso@mit.edu>
In-Reply-To: <20190623230956.24670-1-tytso@mit.edu>
References: <20190623230956.24670-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Move the following tests:

	shared/005 --> ext4/040
	shared/007 --> ext4/041
	shared/289 --> ext4/042

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/{shared/005 => ext4/040}         | 2 +-
 tests/{shared/007.out => ext4/040.out} | 2 +-
 tests/{shared/007 => ext4/041}         | 2 +-
 tests/{shared/005.out => ext4/041.out} | 2 +-
 tests/{shared/289 => ext4/042}         | 2 +-
 tests/{shared/289.out => ext4/042.out} | 2 +-
 tests/ext4/group                       | 3 +++
 tests/shared/group                     | 3 ---
 8 files changed, 9 insertions(+), 9 deletions(-)
 rename tests/{shared/005 => ext4/040} (97%)
 rename tests/{shared/007.out => ext4/040.out} (77%)
 rename tests/{shared/007 => ext4/041} (97%)
 rename tests/{shared/005.out => ext4/041.out} (77%)
 rename tests/{shared/289 => ext4/042} (98%)
 rename tests/{shared/289.out => ext4/042.out} (67%)

diff --git a/tests/shared/005 b/tests/ext4/040
similarity index 97%
rename from tests/shared/005
rename to tests/ext4/040
index 67940dd0..3e475f7d 100755
--- a/tests/shared/005
+++ b/tests/ext4/040
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2017 Oracle, Inc.  All Rights Reserved.
 #
-# FSQA Test No. 005
+# FSQA Test No. ext4/040 (was shared/005)
 #
 # Since loff_t is a signed type, it is invalid for a filesystem to load
 # an inode with i_size = -1ULL.  Unfortunately, nobody checks this,
diff --git a/tests/shared/007.out b/tests/ext4/040.out
similarity index 77%
rename from tests/shared/007.out
rename to tests/ext4/040.out
index 3afba59a..dbccb495 100644
--- a/tests/shared/007.out
+++ b/tests/ext4/040.out
@@ -1,4 +1,4 @@
-QA output created by 007
+QA output created by 040
 Format and mount
 Corrupt filesystem
 Remount, try to append
diff --git a/tests/shared/007 b/tests/ext4/041
similarity index 97%
rename from tests/shared/007
rename to tests/ext4/041
index 65cb5273..5c9c0713 100755
--- a/tests/shared/007
+++ b/tests/ext4/041
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2017 Oracle, Inc.  All Rights Reserved.
 #
-# FSQA Test No. 007
+# FSQA Test No. ext4/041 (was shared/007)
 #
 # Since loff_t is a signed type, it is invalid for a filesystem to load
 # an inode with i_size = -1ULL.  Unfortunately, nobody checks this,
diff --git a/tests/shared/005.out b/tests/ext4/041.out
similarity index 77%
rename from tests/shared/005.out
rename to tests/ext4/041.out
index 06e3fcdc..97480072 100644
--- a/tests/shared/005.out
+++ b/tests/ext4/041.out
@@ -1,4 +1,4 @@
-QA output created by 005
+QA output created by 041
 Format and mount
 Corrupt filesystem
 Remount, try to append
diff --git a/tests/shared/289 b/tests/ext4/042
similarity index 98%
rename from tests/shared/289
rename to tests/ext4/042
index 94b64430..17d482a1 100755
--- a/tests/shared/289
+++ b/tests/ext4/042
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2012 Red Hat, Inc.  All Rights Reserved.
 #
-# FS QA Test No. 289
+# FS QA Test No. ext4/042 (was shared/289)
 #
 # Test overhead & df output for extN filesystems
 #
diff --git a/tests/shared/289.out b/tests/ext4/042.out
similarity index 67%
rename from tests/shared/289.out
rename to tests/ext4/042.out
index a4de760a..1bd6f82a 100644
--- a/tests/shared/289.out
+++ b/tests/ext4/042.out
@@ -1,3 +1,3 @@
-QA output created by 289
+QA output created by 042
 minix f_blocks is in range
 bsd f_blocks is in range
diff --git a/tests/ext4/group b/tests/ext4/group
index 6418d82d..9dfc0d35 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -42,6 +42,9 @@
 037 auto quick
 038 auto quick
 039 auto enospc rw
+040 dangerous_fuzzers
+041 dangerous_fuzzers
+042 auto quick
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
diff --git a/tests/shared/group b/tests/shared/group
index 6f184946..3507d7d4 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -4,13 +4,10 @@
 # - comment line before each group is "new" description
 #
 002 auto metadata quick log
-005 dangerous_fuzzers
 006 auto enospc
-007 dangerous_fuzzers
 008 auto stress dedupe
 009 auto stress dedupe
 010 auto stress dedupe
 011 auto quick
 032 mkfs auto quick
-289 auto quick
 298 auto trim
-- 
2.22.0
