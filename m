Received: from mail-pg1-f180.google.com ([209.85.215.180]:44147 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfIRLru (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Sep 2019 07:47:50 -0400
From: kaixuxia <xiakaixu1987@gmail.com>
Subject: [PATCH v3 1/2] common: check if a given rename flag is supported in
 _requires_renameat2
Message-ID: <7d4b6a1d-98a1-1fcb-5ccf-991e537df77c@gmail.com>
Date: Wed, 18 Sep 2019 19:47:47 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, newtongao@tencent.com, jasperwang@tencent.com
List-ID: <fstests@vger.kernel.org>

Some testcases may require a special rename flag, such as RENAME_WHITEOUT,
so add support check for if a given rename flag is supported in
_requires_renameat2.

Signed-off-by: kaixuxia <kaixuxia@tencent.com>
---
 common/renameat2  | 30 +++++++++++++++++++++++++++++-
 tests/generic/024 | 13 +++----------
 tests/generic/025 | 13 +++----------
 tests/generic/078 | 13 +++----------
 4 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/common/renameat2 b/common/renameat2
index f8d6d4f..9625d8c 100644
--- a/common/renameat2
+++ b/common/renameat2
@@ -103,10 +103,38 @@ _rename_tests()
 #
 _requires_renameat2()
 {
+	local flags=$1
+	local rename_dir=$TEST_DIR/$$
+	local cmd=""
+
 	if test ! -x src/renameat2; then
 		_notrun "renameat2 binary not found"
 	fi
-	if ! src/renameat2 -t; then
+
+	mkdir $rename_dir
+	touch $rename_dir/foo
+	case $flags in
+	"noreplace")
+		cmd="-n $rename_dir/foo $rename_dir/bar"
+		;;
+	"exchange")
+		touch $rename_dir/bar
+		cmd="-x $rename_dir/foo $rename_dir/bar"
+		;;
+	"whiteout")
+		touch $rename_dir/bar
+		cmd="-w $rename_dir/foo $rename_dir/bar"
+		;;
+	"")
+		;;
+	*)
+		rm -rf $rename_dir
+		_notrun "only support noreplace,exchange,whiteout rename flags, please check."
+		;;
+	esac
+	if ! src/renameat2 -t $cmd; then
+		rm -rf $rename_dir
 		_notrun "kernel doesn't support renameat2 syscall"
 	fi
+	rm -rf $rename_dir
 }
diff --git a/tests/generic/024 b/tests/generic/024
index 2888c66..9c1161a 100755
--- a/tests/generic/024
+++ b/tests/generic/024
@@ -29,20 +29,13 @@ _supported_fs generic
 _supported_os Linux
 
 _require_test
-_requires_renameat2
+_requires_renameat2 noreplace
 _require_test_symlinks
 
-rename_dir=$TEST_DIR/$$
-mkdir $rename_dir
-touch $rename_dir/foo
-if ! src/renameat2 -t -n $rename_dir/foo $rename_dir/bar; then
-    rm -f $rename_dir/foo $rename_dir/bar; rmdir $rename_dir
-    _notrun "fs doesn't support RENAME_NOREPLACE"
-fi
-rm -f $rename_dir/foo $rename_dir/bar
-
 # real QA test starts here
 
+rename_dir=$TEST_DIR/$$
+mkdir $rename_dir
 _rename_tests $rename_dir -n
 rmdir $rename_dir
 
diff --git a/tests/generic/025 b/tests/generic/025
index 0310efa..1ee9ad6 100755
--- a/tests/generic/025
+++ b/tests/generic/025
@@ -29,20 +29,13 @@ _supported_fs generic
 _supported_os Linux
 
 _require_test
-_requires_renameat2
+_requires_renameat2 exchange
 _require_test_symlinks
 
-rename_dir=$TEST_DIR/$$
-mkdir $rename_dir
-touch $rename_dir/foo $rename_dir/bar
-if ! src/renameat2 -t -x $rename_dir/foo $rename_dir/bar; then
-    rm -f $rename_dir/foo $rename_dir/bar; rmdir $rename_dir
-    _notrun "fs doesn't support RENAME_EXCHANGE"
-fi
-rm -f $rename_dir/foo $rename_dir/bar
-
 # real QA test starts here
 
+rename_dir=$TEST_DIR/$$
+mkdir $rename_dir
 _rename_tests $rename_dir -x
 rmdir $rename_dir
 
diff --git a/tests/generic/078 b/tests/generic/078
index 9608574..37f3201 100755
--- a/tests/generic/078
+++ b/tests/generic/078
@@ -29,20 +29,13 @@ _supported_fs generic
 _supported_os Linux
 
 _require_test
-_requires_renameat2
+_requires_renameat2 whiteout
 _require_test_symlinks
 
-rename_dir=$TEST_DIR/$$
-mkdir $rename_dir
-touch $rename_dir/foo $rename_dir/bar
-if ! src/renameat2 -t -w $rename_dir/foo $rename_dir/bar; then
-    rm -f $rename_dir/foo $rename_dir/bar; rmdir $rename_dir
-    _notrun "fs doesn't support RENAME_WHITEOUT"
-fi
-rm -f $rename_dir/foo $rename_dir/bar
-
 # real QA test starts here
 
+rename_dir=$TEST_DIR/$$
+mkdir $rename_dir
 _rename_tests $rename_dir -w
 rmdir $rename_dir
 
-- 
1.8.3.1

-- 
kaixuxia
