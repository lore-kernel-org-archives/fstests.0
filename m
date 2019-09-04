Received: from mx1.redhat.com ([209.132.183.28]:44248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfIDFc5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Sep 2019 01:32:57 -0400
From: "Jianhong.Yin" <yin-jianhong@163.com>
Subject: [PATCH] generic/430: add copy in same file test
Date: Wed,  4 Sep 2019 13:32:46 +0800
Message-Id: <20190904053246.19623-1-yin-jianhong@163.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: fs-qe-dev@redhat.com, "Jianhong.Yin" <yin-jianhong@163.com>
List-ID: <fstests@vger.kernel.org>

to cover this bug:
 copy_file_range return "Invalid argument" when copy in the same file
 https://bugzilla.kernel.org/show_bug.cgi?id=202935

this is a base function test, I don't think we should add a new
test for it like 553 554, so add it in generic/430
what do you think?

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---
 tests/generic/430     | 7 +++++++
 tests/generic/430.out | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/tests/generic/430 b/tests/generic/430
index 1b11f60d..c4b1dd23 100755
--- a/tests/generic/430
+++ b/tests/generic/430
@@ -6,6 +6,7 @@
 #
 # Tests vfs_copy_file_range():
 #   - Copy a file
+#   - Copy in same file
 #   - Copy beginning of original to new file
 #   - Copy middle of original to a new file
 #   - Copy end of original to new file
@@ -52,6 +53,12 @@ cmp $testdir/file $testdir/copy
 echo "Original md5sums:"
 md5sum $testdir/{file,copy} | _filter_test_dir
 
+echo "Copy in same file"
+$XFS_IO_PROG    -c "copy_range -l 1000 $testdir/copy" "$testdir/copy"
+cmp $testdir/file $testdir/copy
+echo "Original md5sums:"
+md5sum $testdir/{file,copy} | _filter_test_dir
+
 echo "Copy beginning of original file"
 $XFS_IO_PROG -f -c "copy_range -l 1000 $testdir/file" "$testdir/beginning"
 cmp -n 1000 $testdir/file $testdir/beginning
diff --git a/tests/generic/430.out b/tests/generic/430.out
index 4b4ca75d..95007853 100644
--- a/tests/generic/430.out
+++ b/tests/generic/430.out
@@ -3,6 +3,10 @@ Create the original file and then copy
 Original md5sums:
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
+Create in same file
+Original md5sums:
+e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
+e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
 Copy beginning of original file
 md5sums after copying beginning:
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
-- 
2.17.2
