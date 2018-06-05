Received: from mail.cn.fujitsu.com ([183.91.158.132]:47102 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751317AbeFECGU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jun 2018 22:06:20 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 77CBA4B40410
        for <fstests@vger.kernel.org>; Tue,  5 Jun 2018 10:06:12 +0800 (CST)
From: Xu Huan <xuhuan.fnst@cn.fujitsu.com>
Subject: [PATCH v2] fix generic 401 on fs without filesystem support
Date: Tue, 5 Jun 2018 10:05:22 +0800
Message-ID: <20180605020522.2697-1-xuhuan.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

notrun the test if the filesystem is not supported.
on unsupported fs ,the test may have different result.
---
 tests/generic/401 | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tests/generic/401 b/tests/generic/401
index 74f2bea5..1c790a33 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -3,9 +3,7 @@
 #
 # Test filetype feature
 #
-# This test does NOT require that file system support the d_type feature.
-# It verifies that either all file types are reported as DT_UNKNOWN
-# or all file types are reported correctly.
+# This test not run if that file system support the d_type feature.
 #
 # For fs for which we know how to test the filetype feature (xfs|ext*)
 # verify getting DT_UNKNOWN IFF feature is disabled.
@@ -83,12 +81,7 @@ if _supports_filetype $SCRATCH_MNT; then
 	# print real file types
 	src/t_dir_type $testdir | grep -vF '.' | sort
 else
-	# print fake dir file type for . and .. if they are DT_UNKNOWN
-	src/t_dir_type $testdir u | grep -F '.' | \
-		awk '{ print $1, "d" }' | sort
-	# list unknown files and print filename as fake file type
-	src/t_dir_type $testdir u | grep -vF '.' | \
-		awk '{ print $1, $1 }' | sort
+	_notrun "test not support on this filesystem"
 fi
 
 status=0
-- 
2.17.0



