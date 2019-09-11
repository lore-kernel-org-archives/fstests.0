Received: from mail-pg1-f171.google.com ([209.85.215.171]:46360 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbfIKNPX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Sep 2019 09:15:23 -0400
From: kaixuxia <xiakaixu1987@gmail.com>
Subject: [PATCH 1/2] common: check if a given rename flag is supported in
 _requires_renameat2
Message-ID: <719f7bb3-96db-7563-56d8-56ed765fabc4@gmail.com>
Date: Wed, 11 Sep 2019 21:15:16 +0800
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
 common/renameat2  | 41 +++++++++++++++++++++++++++++++++++++++--
 tests/generic/024 | 13 +++----------
 tests/generic/025 | 13 +++----------
 tests/generic/078 | 13 +++----------
 4 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/common/renameat2 b/common/renameat2
index f8d6d4f..7bb81e0 100644
--- a/common/renameat2
+++ b/common/renameat2
@@ -103,10 +103,47 @@ _rename_tests()
 #
 _requires_renameat2()
 {
+	local flags=$1
+	local rename_dir=$TEST_DIR/$$
+
 	if test ! -x src/renameat2; then
 		_notrun "renameat2 binary not found"
 	fi
-	if ! src/renameat2 -t; then
-		_notrun "kernel doesn't support renameat2 syscall"
+
+	if test -z "$flags"; then
+		src/renameat2 -t
+		[ $? -eq 0 ] || _notrun "kernel doesn't support renameat2 syscall"
+		return
 	fi
+
+	case $flags in
+	"noreplace")
+		mkdir $rename_dir
+		touch $rename_dir/foo
+		if ! src/renameat2 -t -n $rename_dir/foo $rename_dir/bar; then
+			rm -f $rename_dir/foo $rename_dir/bar; rmdir $rename_dir
+			_notrun "fs doesn't support RENAME_NOREPLACE"
+		fi
+		;;
+	"exchange")
+		mkdir $rename_dir
+		touch $rename_dir/foo $rename_dir/bar
+		if ! src/renameat2 -t -x $rename_dir/foo $rename_dir/bar; then
+			rm -f $rename_dir/foo $rename_dir/bar; rmdir $rename_dir
+			_notrun "fs doesn't support RENAME_EXCHANGE"
+		fi
+		;;
+	"whiteout")
+		mkdir $rename_dir
+		touch $rename_dir/foo $rename_dir/bar
+		if ! src/renameat2 -t -w $rename_dir/foo $rename_dir/bar; then
+			rm -f $rename_dir/foo $rename_dir/bar; rmdir $rename_dir
+			_notrun "fs doesn't support RENAME_WHITEOUT"
+		fi
+		;;
+	*)
+		_notrun "only support noreplace,exchange,whiteout rename flags, please check."
+		;;
+	esac
+	rm -fr $rename_dir
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
