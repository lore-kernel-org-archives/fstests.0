Received: from mail-wm0-f67.google.com ([74.125.82.67]:36844 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932520AbdA0KkC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Jan 2017 05:40:02 -0500
Received: by mail-wm0-f67.google.com with SMTP id r126so57272925wmr.3
        for <fstests@vger.kernel.org>; Fri, 27 Jan 2017 02:40:01 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] fstests: cleanup $TEST_DIR/$seq* files
Date: Fri, 27 Jan 2017 12:39:49 +0200
Message-Id: <1485513589-7416-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test generic/007 was failing after running test overlay/007,
because the latter left behind a directory named 007 in test dir
and the former failed to mkdir a directory with the same name.

Greping the tests for the pattern $TEST_DIR/$seq* found some more
files/dirs of this sort that were not being cleaned up.

Clean those files/dir on _cleanup trap to fix the 007 tests collision
and avoid similar collisions in future tests.

Left the directories $TEST_DIR/$seq.mnt in tact, because they are
always empty and created with mkdir -p.

There are more files left behind as can be seen in any aged test dir.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/012              | 2 +-
 tests/generic/016              | 2 +-
 tests/generic/021              | 2 +-
 tests/generic/022              | 2 +-
 tests/generic/058              | 2 +-
 tests/generic/060              | 2 +-
 tests/generic/061              | 2 +-
 tests/generic/063              | 2 +-
 tests/generic/310              | 2 +-
 tests/generic/314              | 1 +
 tests/generic/316              | 2 +-
 tests/generic/355              | 2 +-
 tests/generic/360              | 2 +-
 tests/generic/394              | 1 +
 tests/overlay/007              | 1 +
 tests/xfs/077                  | 2 +-
 tests/xfs/078                  | 1 +
 tests/xfs/191-input-validation | 2 +-
 18 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tests/generic/012 b/tests/generic/012
index 6b1e20b..f87ca9b 100755
--- a/tests/generic/012
+++ b/tests/generic/012
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/016 b/tests/generic/016
index b994775..267ce4a 100755
--- a/tests/generic/016
+++ b/tests/generic/016
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/021 b/tests/generic/021
index 4729400..5c115e3 100755
--- a/tests/generic/021
+++ b/tests/generic/021
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/022 b/tests/generic/022
index 1228e51..83f2913 100755
--- a/tests/generic/022
+++ b/tests/generic/022
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/058 b/tests/generic/058
index 4a39a05..2e6c7bc 100755
--- a/tests/generic/058
+++ b/tests/generic/058
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/060 b/tests/generic/060
index 4493ba2..4a0b6d1 100755
--- a/tests/generic/060
+++ b/tests/generic/060
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/061 b/tests/generic/061
index f5e5076..8e6630d 100755
--- a/tests/generic/061
+++ b/tests/generic/061
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/063 b/tests/generic/063
index 9b72f69..b3c4ab6 100755
--- a/tests/generic/063
+++ b/tests/generic/063
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/310 b/tests/generic/310
index 895481c..550272d 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -46,7 +46,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-	rm -rf $TEST_DIR/tmp
+	rm -rf $TEST_DIR/tmp $SEQ_DIR
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/314 b/tests/generic/314
index 49b03e4..4d4dd5f 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -34,6 +34,7 @@ _cleanup()
 {
     cd /
     rm -f $tmp.*
+    rm -rf $TEST_DIR/$seq-dir
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/316 b/tests/generic/316
index 0ccf01f..74cec26 100755
--- a/tests/generic/316
+++ b/tests/generic/316
@@ -33,7 +33,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
     cd /
-    rm -f $tmp.*
+    rm -f $tmp.* $testfile
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/355 b/tests/generic/355
index 97e2320..1c1a112 100755
--- a/tests/generic/355
+++ b/tests/generic/355
@@ -33,7 +33,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	cd /
-	rm -f $tmp.*
+	rm -f $tmp.* $testfile
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/360 b/tests/generic/360
index 86e554b..8f76985 100755
--- a/tests/generic/360
+++ b/tests/generic/360
@@ -33,7 +33,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	cd /
-	rm -f $tmp.*
+	rm -f $tmp.* $linkfile
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/394 b/tests/generic/394
index ae9a7b4..2b1a32b 100755
--- a/tests/generic/394
+++ b/tests/generic/394
@@ -35,6 +35,7 @@ _cleanup()
 	cd /
 	ulimit -f unlimited
 	rm -f $tmp.*
+	rm -f $TEST_DIR/$seq.$$*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/overlay/007 b/tests/overlay/007
index ccf2b75..ed7914b 100755
--- a/tests/overlay/007
+++ b/tests/overlay/007
@@ -37,6 +37,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	rm -rf $TEST_DIR/$seq
 }
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/077 b/tests/xfs/077
index eba4f08..17af5dd 100755
--- a/tests/xfs/077
+++ b/tests/xfs/077
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	cd /
-	rm -f $tmp.*
+	rm -f $tmp.* $IMGFILE
 }
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/078 b/tests/xfs/078
index 0d6eb55..f7b9cc8 100755
--- a/tests/xfs/078
+++ b/tests/xfs/078
@@ -38,6 +38,7 @@ _cleanup()
     rm -f $tmp.*
     umount $LOOP_MNT 2>/dev/null
     [ -n "$LOOP_DEV" ] && losetup -d $LOOP_DEV
+    rm -f $LOOP_IMG
     rmdir $LOOP_MNT
 }
 
diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
index cff3efa..d302c0e 100755
--- a/tests/xfs/191-input-validation
+++ b/tests/xfs/191-input-validation
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	cd /
-	rm -f $tmp.*
+	rm -f $tmp.* $fsimg
 }
 
 # get standard environment, filters and checks
-- 
2.7.4

