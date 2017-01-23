Received: from cn.fujitsu.com ([59.151.112.132]:36232 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750711AbdAWDsg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Jan 2017 22:48:36 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 4091B47B1502
        for <fstests@vger.kernel.org>; Mon, 23 Jan 2017 11:48:20 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] fstests: fix wrong seq number in test
Date: Mon, 23 Jan 2017 11:48:15 +0800
Message-ID: <1485143295-16049-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/381 | 2 +-
 tests/generic/382 | 2 +-
 tests/generic/383 | 2 +-
 tests/generic/400 | 2 +-
 tests/shared/005  | 2 +-
 tests/shared/007  | 2 +-
 tests/xfs/133     | 2 +-
 tests/xfs/134     | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/generic/381 b/tests/generic/381
index 6b6a12f..006f0d8 100755
--- a/tests/generic/381
+++ b/tests/generic/381
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test 138
+# FS QA Test 381
 #
 # Test xfs_quota when user or names beginning with digits.
 # For example, create a 'limit' for a user or group named
diff --git a/tests/generic/382 b/tests/generic/382
index a2bc3ce..33326ff 100755
--- a/tests/generic/382
+++ b/tests/generic/382
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test 260
+# FS QA Test 382
 #
 # When default quota is set, all different quota types inherits the
 # same default value, include group quota. So if a user quota limit
diff --git a/tests/generic/383 b/tests/generic/383
index be5b19b..183221e 100755
--- a/tests/generic/383
+++ b/tests/generic/383
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test 133
+# FS QA Test 383
 #
 # Test xfs_quota when project names beginning with digits.
 #
diff --git a/tests/generic/400 b/tests/generic/400
index 36eb99b..3ad3020 100755
--- a/tests/generic/400
+++ b/tests/generic/400
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test 394
+# FS QA Test 400
 #
 # test out high quota ids retrieved by Q_GETNEXTQUOTA
 # Request for next ID near 2^32 should not wrap to 0
diff --git a/tests/shared/005 b/tests/shared/005
index 2fca911..296de17 100755
--- a/tests/shared/005
+++ b/tests/shared/005
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 400
+# FSQA Test No. 005
 #
 # Since loff_t is a signed type, it is invalid for a filesystem to load
 # an inode with i_size = -1ULL.  Unfortunately, nobody checks this,
diff --git a/tests/shared/007 b/tests/shared/007
index c6f2520..0729ab8 100755
--- a/tests/shared/007
+++ b/tests/shared/007
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 401
+# FSQA Test No. 007
 #
 # Since loff_t is a signed type, it is invalid for a filesystem to load
 # an inode with i_size = -1ULL.  Unfortunately, nobody checks this,
diff --git a/tests/xfs/133 b/tests/xfs/133
index fcaaa39..d756d2e 100755
--- a/tests/xfs/133
+++ b/tests/xfs/133
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 400
+# FSQA Test No. 133
 #
 # Since loff_t is a signed type, it is invalid for a filesystem to load
 # an inode with i_size = -1ULL.  Unfortunately, nobody checks this,
diff --git a/tests/xfs/134 b/tests/xfs/134
index d299080..09466cd 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 401
+# FSQA Test No. 134
 #
 # Since loff_t is a signed type, it is invalid for a filesystem to load
 # an inode with i_size = -1ULL.  Unfortunately, nobody checks this,
-- 
1.8.3.1



