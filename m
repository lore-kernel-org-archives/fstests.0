Received: from mx1.redhat.com ([209.132.183.28]:51438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfIPGVy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Sep 2019 02:21:54 -0400
From: "Jianhong.Yin" <yin-jianhong@163.com>
Subject: [PATCH v4] generic/430: add copy in same file test
Date: Mon, 16 Sep 2019 14:21:46 +0800
Message-Id: <20190916062146.3577-1-yin-jianhong@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, jiyin@redhat.com, "Jianhong.Yin" <yin-jianhong@163.com>
List-ID: <fstests@vger.kernel.org>

now xfstests has not cover the senario that copy in same file
related bug:
 copy_file_range return "Invalid argument" when copy in the same file
 https://bugzilla.kernel.org/show_bug.cgi?id=202935

step1:
 copy whole file to end of itself, and compare the two halves with the original file
step2:
 recover from original file.

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---
 tests/generic/430     | 10 ++++++++++
 tests/generic/430.out |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/tests/generic/430 b/tests/generic/430
index 1b11f60d..2c06c96f 100755
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
@@ -52,6 +53,15 @@ cmp $testdir/file $testdir/copy
 echo "Original md5sums:"
 md5sum $testdir/{file,copy} | _filter_test_dir
 
+fsize=$(stat -c %s $testdir/copy)
+echo "Copy in same file"
+$XFS_IO_PROG    -c "copy_range -l $fsize -d $fsize $testdir/copy" "$testdir/copy"
+cmp -n $fsize $testdir/file $testdir/copy
+cmp -i 0:$fsize $testdir/file $testdir/copy
+$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
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
