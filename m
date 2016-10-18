Received: from cn.fujitsu.com ([59.151.112.132]:50010 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933263AbcJRC75 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2016 22:59:57 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs: fix __populate_check_xfs_dir
Date: Tue, 18 Oct 2016 10:59:44 +0800
Message-ID: <1476759584-4150-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

We need to remove unused ${SCRATCH_DEV} when calling __populate_check_xfs_dir
because __populate_check_xfs_dir function has been rewritten by Darrick.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/099 | 2 +-
 tests/xfs/100 | 2 +-
 tests/xfs/101 | 2 +-
 tests/xfs/102 | 2 +-
 tests/xfs/105 | 2 +-
 tests/xfs/112 | 2 +-
 tests/xfs/113 | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/xfs/099 b/tests/xfs/099
index ebc02dd..85193ab 100755
--- a/tests/xfs/099
+++ b/tests/xfs/099
@@ -75,7 +75,7 @@ echo "+ check fs"
 _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
 
 echo "+ check dir"
-__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" block
+__populate_check_xfs_dir "${inode}" block
 
 echo "+ corrupt dir"
 _scratch_xfs_db -x -c "inode ${inode}" -c 'dblock 0' -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
diff --git a/tests/xfs/100 b/tests/xfs/100
index 2412c81..3bfafce 100755
--- a/tests/xfs/100
+++ b/tests/xfs/100
@@ -75,7 +75,7 @@ echo "+ check fs"
 _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
 
 echo "+ check dir"
-__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" leaf
+__populate_check_xfs_dir "${inode}" leaf
 
 echo "+ corrupt dir"
 loff=0
diff --git a/tests/xfs/101 b/tests/xfs/101
index 679940f..d3abd19 100755
--- a/tests/xfs/101
+++ b/tests/xfs/101
@@ -75,7 +75,7 @@ echo "+ check fs"
 _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
 
 echo "+ check dir"
-__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" leaf
+__populate_check_xfs_dir "${inode}" leaf
 
 echo "+ corrupt dir"
 _scratch_xfs_db -x -c "inode ${inode}" -c "dblock ${leaf_lblk}" -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
diff --git a/tests/xfs/102 b/tests/xfs/102
index 8018a9e..cf0d7a6 100755
--- a/tests/xfs/102
+++ b/tests/xfs/102
@@ -75,7 +75,7 @@ echo "+ check fs"
 _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
 
 echo "+ check dir"
-__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" node
+__populate_check_xfs_dir "${inode}" node
 
 echo "+ corrupt dir"
 loff=0
diff --git a/tests/xfs/105 b/tests/xfs/105
index 27ee4b3..07ccf00 100755
--- a/tests/xfs/105
+++ b/tests/xfs/105
@@ -75,7 +75,7 @@ echo "+ check fs"
 _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
 
 echo "+ check dir"
-__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" node
+__populate_check_xfs_dir "${inode}" node
 
 echo "+ corrupt dir"
 loff="${leaf_lblk}"
diff --git a/tests/xfs/112 b/tests/xfs/112
index c237f03..84f1f1d 100755
--- a/tests/xfs/112
+++ b/tests/xfs/112
@@ -75,7 +75,7 @@ echo "+ check fs"
 _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
 
 echo "+ check dir"
-__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" node
+__populate_check_xfs_dir "${inode}" node
 
 echo "+ corrupt dir"
 loff="${node_lblk}"
diff --git a/tests/xfs/113 b/tests/xfs/113
index 6d6e6fd..ec328bc 100755
--- a/tests/xfs/113
+++ b/tests/xfs/113
@@ -75,7 +75,7 @@ echo "+ check fs"
 _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
 
 echo "+ check dir"
-__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" btree
+__populate_check_xfs_dir "${inode}" btree
 
 echo "+ corrupt dir"
 loff=0
-- 
1.8.3.1



