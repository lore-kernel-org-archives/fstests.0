Received: from mx1.redhat.com ([209.132.183.28]:35446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfIDM63 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Sep 2019 08:58:29 -0400
From: "Jianhong.Yin" <yin-jianhong@163.com>
Subject: [PATCH v2] generic/430: add copy in same file test
Date: Wed,  4 Sep 2019 20:58:21 +0800
Message-Id: <20190904125821.7736-1-yin-jianhong@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: jiyin@redhat.com, "Jianhong.Yin" <yin-jianhong@163.com>
List-ID: <fstests@vger.kernel.org>

now xfstests has not cover the senario that copy in same file
related bug:
 copy_file_range return "Invalid argument" when copy in the same file
 https://bugzilla.kernel.org/show_bug.cgi?id=202935

step1:
 copy whole file to itself, and compare with original file.
step2:
 copy whole file to end of itself, and compare the two halves with the original file
step3:
 recover from original file.

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---

this is a base function test, I don't think we should add a new
test for it like 553 554, so add it in generic/430
what do you think?

 tests/generic/430     | 12 ++++++++++++
 tests/generic/430.out |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/tests/generic/430 b/tests/generic/430
index 1b11f60d..4ce0ee26 100755
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
@@ -52,6 +53,17 @@ cmp $testdir/file $testdir/copy
 echo "Original md5sums:"
 md5sum $testdir/{file,copy} | _filter_test_dir
 
+fsize=$(stat -c %s $testdir/copy)
+echo "Copy in same file"
+$XFS_IO_PROG    -c "copy_range -l $fsize $testdir/copy" "$testdir/copy"
+cmp $testdir/file $testdir/copy
+$XFS_IO_PROG    -c "copy_range -l $fsize -d $fsize $testdir/copy" "$testdir/copy"
+cmp -n $fsize $testdir/file $testdir/copy
+cmp -i $fsize:0 $testdir/file $testdir/copy
+$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
+echo "md5sums after copying in same file and recover:"
+md5sum $testdir/{file,copy} | _filter_test_dir
+
 echo "Copy beginning of original file"
 $XFS_IO_PROG -f -c "copy_range -l 1000 $testdir/file" "$testdir/beginning"
 cmp -n 1000 $testdir/file $testdir/beginning
diff --git a/tests/generic/430.out b/tests/generic/430.out
index 4b4ca75d..57584957 100644
--- a/tests/generic/430.out
+++ b/tests/generic/430.out
@@ -3,6 +3,10 @@ Create the original file and then copy
 Original md5sums:
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
+Copy in same file
+md5sums after copying in same file and recover:
+e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
+e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
 Copy beginning of original file
 md5sums after copying beginning:
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
-- 
2.21.0
