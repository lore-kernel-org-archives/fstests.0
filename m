Received: from mx1.redhat.com ([209.132.183.28]:43856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfIEBja (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Sep 2019 21:39:30 -0400
From: "Jianhong.Yin" <yin-jianhong@163.com>
Subject: [PATCH] generic/43{0,1,2,3}: add -t option when create $testdir/copy file
Date: Thu,  5 Sep 2019 09:39:21 +0800
Message-Id: <20190905013921.13396-1-yin-jianhong@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, jiyin@redhat.com, "Jianhong.Yin" <yin-jianhong@163.com>
List-ID: <fstests@vger.kernel.org>

to avoid there's already a copy file before run test,
it might break test.

I know now in xfs_io->copy_range there's a hidden truncate action
to do that, but we are taking about remove it, see:
 https://www.spinics.net/lists/linux-xfs/msg31292.html
 https://www.spinics.net/lists/linux-xfs/msg31327.html

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---
 tests/generic/430 | 2 +-
 tests/generic/431 | 2 +-
 tests/generic/432 | 2 +-
 tests/generic/433 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/430 b/tests/generic/430
index 1b11f60d..71c6d438 100755
--- a/tests/generic/430
+++ b/tests/generic/430
@@ -47,7 +47,7 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x62 1000 1000' $testdir/file >> $seqres.full 2>&1
 $XFS_IO_PROG -f -c 'pwrite -S 0x63 2000 1000' $testdir/file >> $seqres.full 2>&1
 $XFS_IO_PROG -f -c 'pwrite -S 0x64 3000 1000' $testdir/file >> $seqres.full 2>&1
 $XFS_IO_PROG -f -c 'pwrite -S 0x65 4000 1000' $testdir/file >> $seqres.full 2>&1
-$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
+$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
 cmp $testdir/file $testdir/copy
 echo "Original md5sums:"
 md5sum $testdir/{file,copy} | _filter_test_dir
diff --git a/tests/generic/431 b/tests/generic/431
index f04ae215..4b22a8ff 100755
--- a/tests/generic/431
+++ b/tests/generic/431
@@ -40,7 +40,7 @@ rm -f $seqres.full
 
 echo "Create the original file and then copy"
 echo -n "abcde" > $testdir/file
-$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
+$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
 echo -n "abcde" | cmp $testdir/copy
 echo "Original md5sums:"
 md5sum $testdir/{file,copy} | _filter_test_dir
diff --git a/tests/generic/432 b/tests/generic/432
index 6200af86..a2fecf37 100755
--- a/tests/generic/432
+++ b/tests/generic/432
@@ -46,7 +46,7 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x62 1000 1000' $testdir/file >> $seqres.full 2>&1
 $XFS_IO_PROG -f -c 'pwrite -S 0x63 2000 1000' $testdir/file >> $seqres.full 2>&1
 $XFS_IO_PROG -f -c 'pwrite -S 0x64 3000 1000' $testdir/file >> $seqres.full 2>&1
 $XFS_IO_PROG -f -c 'pwrite -S 0x65 4000 1000' $testdir/file >> $seqres.full 2>&1
-$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
+$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
 cmp $testdir/file  $testdir/copy
 echo "Original md5sums:"
 md5sum $testdir/{file,copy} | _filter_test_dir
diff --git a/tests/generic/433 b/tests/generic/433
index 1238419a..6204f339 100755
--- a/tests/generic/433
+++ b/tests/generic/433
@@ -42,7 +42,7 @@ rm -f $seqres.full
 
 echo "Create the original file and then copy"
 echo -n "abcde" > $testdir/file
-$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
+$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
 cmp $testdir/file $testdir/copy
 echo "Original md5sums:"
 md5sum $testdir/{file,copy} | _filter_test_dir
-- 
2.21.0
