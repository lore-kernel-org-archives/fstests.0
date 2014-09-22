Return-Path: <fstests-owner@vger.kernel.org>
Received: from nbl-ex10-fe01.nebula.fi ([188.117.32.121]:12189 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753774AbaIVM1P (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Sep 2014 08:27:15 -0400
Message-ID: <1411388623.2869.20.camel@ari-macbook>
Subject: [PATCH 2/4] Change all occurrences of stat --format and stat
 --printf to stat -c.
From: Ari Sundholm <ari@tuxera.com>
Date: Mon, 22 Sep 2014 15:23:43 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Ari Sundholm <ari@tuxera.com>

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 tests/generic/003 | 2 +-
 tests/generic/192 | 2 +-
 tests/generic/215 | 8 ++++----
 tests/generic/286 | 8 ++++----
 tests/xfs/195     | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/generic/003 b/tests/generic/003
index 5c2d383..83d6f90 100755
--- a/tests/generic/003
+++ b/tests/generic/003
@@ -52,7 +52,7 @@ _require_relatime
 rm -f $seqres.full
 
 _stat() {
-	stat --printf="%x;%y;%z" $1
+	stat -c "%x;%y;%z" $1
 }
 
 _compare_stat_times() {
diff --git a/tests/generic/192 b/tests/generic/192
index f630be9..b2da358 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -35,7 +35,7 @@ trap "exit \$status" 0 1 2 3 15
 
 _access_time()
 {
-	stat --format=%X $1
+	stat -c %X $1
 }
 
 is_noatime_set() {
diff --git a/tests/generic/215 b/tests/generic/215
index 6ddd1fc..80df55d 100755
--- a/tests/generic/215
+++ b/tests/generic/215
@@ -53,8 +53,8 @@ echo
 echo "creating test file"
 dd if=/dev/zero of=$testfile count=4096
 
-mtime1=`stat --printf="%Y" $testfile`
-ctime1=`stat --printf="%Z" $testfile`
+mtime1=`stat -c "%Y" $testfile`
+ctime1=`stat -c "%Z" $testfile`
 
 sleep 2
 
@@ -65,8 +65,8 @@ $XFS_IO_PROG -f 		\
 	-c 'mwrite 0 4096'	\
 	$testfile | _filter_xfs_io_unique
 
-mtime2=`stat --printf="%Y" $testfile`
-ctime2=`stat --printf="%Z" $testfile`
+mtime2=`stat -c "%Y" $testfile`
+ctime2=`stat -c "%Z" $testfile`
 
 let mtime_diff=$mtime2-$mtime1
 let ctime_diff=$ctime2-$ctime1
diff --git a/tests/generic/286 b/tests/generic/286
index 94c22c6..f6bf356 100755
--- a/tests/generic/286
+++ b/tests/generic/286
@@ -73,7 +73,7 @@ test01()
 
 	$here/src/seek_copy_test $src $dest
 	
-	test $(stat --printf "%s" $src) = $(stat --printf "%s" $dest) ||
+	test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
 		_fail "TEST01: file size check failed"
 
 	cmp $src $dest || _fail "TEST01: file bytes check failed"
@@ -101,7 +101,7 @@ test02()
 
 	$here/src/seek_copy_test $src $dest
 
-	test $(stat --printf "%s" $src) = $(stat --printf "%s" $dest) ||
+	test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
 		_fail "TEST02: file size check failed"
 
 	cmp $src $dest || _fail "TEST02: file bytes check failed"
@@ -143,7 +143,7 @@ test03()
 	echo >>$seqres.full
 	$here/src/seek_copy_test $src $dest
 
-	test $(stat --printf "%s" $src) = $(stat --printf "%s" $dest) ||
+	test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
 		_fail "TEST03: file size check failed"
 
 	cmp $src $dest || _fail "TEST03: file bytes check failed"
@@ -185,7 +185,7 @@ test04()
 	echo >>$seqres.full
 	$here/src/seek_copy_test $src $dest
 
-	test $(stat --printf "%s" $src) = $(stat --printf "%s" $dest) ||
+	test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
 		_fail "TEST04: file size check failed"
 
 	cmp $src $dest || _fail "TEST04: file bytes check failed"
diff --git a/tests/xfs/195 b/tests/xfs/195
index 6abddbc..c7bc7b8 100755
--- a/tests/xfs/195
+++ b/tests/xfs/195
@@ -69,7 +69,7 @@ _require_user
 echo "Preparing subtree"
 mkdir $TEST_DIR/d
 touch $TEST_DIR/d/t
-inum=`stat --format "%i" $TEST_DIR/d/t`
+inum=`stat -c "%i" $TEST_DIR/d/t`
 
 echo "No dump exclude flag set (should not be skipped)"
 _do_dump
-- 
2.1.0



