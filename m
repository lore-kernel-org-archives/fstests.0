Received: from cn.fujitsu.com ([222.73.24.84]:25939 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbcJJIMM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Oct 2016 04:12:12 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH v2] generic: make 17[1-4] work well when btrfs compression is enabled
Date: Mon, 10 Oct 2016 16:06:17 +0800
Message-Id: <20161010080617.10139-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When enabling btrfs compression, original codes can not fill fs
correctly, fix this.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
V2: In common/, I did't find an existing function suitable for
    these 4 test cases to fill fs, so I still use _pwrite_byte() with
    a big enough file length fo fill fs. Note, for btrfs, metadata space
    still is not full, only data space is full, but it's OK for these
    4 test cases.

    All these 4 cases pass in xfs and btrfs(without compression), if
    btrfs has compression enabled, these 4 cases will fail for false
    enospc error, I have sent kernel patches to fix this bug.
---
 tests/generic/171 | 7 ++++---
 tests/generic/172 | 6 ++++--
 tests/generic/173 | 7 ++++---
 tests/generic/174 | 7 ++++---
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/tests/generic/171 b/tests/generic/171
index f391685..2d7f683 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -75,9 +75,10 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+# here we try to write big enough data in case some fs support
+# compression, such as btrfs.
+len=$((2 ** 36))
+_pwrite_byte 0x61 0 $len $testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
diff --git a/tests/generic/172 b/tests/generic/172
index 8192290..63637bd 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -72,8 +72,10 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $fs_size $testdir/eat_my_space >> $seqres.full 2>&1
+# here we try to write big enough data in case some fs support
+# compression, such as btrfs.
+len=$((2 ** 36))
+_pwrite_byte 0x61 0 $len $testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
diff --git a/tests/generic/173 b/tests/generic/173
index c5fac9e..c8525c1 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -75,9 +75,10 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+# here we try to write big enough data in case some fs support
+# compression, such as btrfs.
+len=$((2 ** 36))
+_pwrite_byte 0x61 0 $len $testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "mmap CoW the big file"
diff --git a/tests/generic/174 b/tests/generic/174
index 8077d76..7fca339 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -76,9 +76,10 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+# here we try to write big enough data in case some fs support
+# compression, such as btrfs.
+len=$((2 ** 36))
+_pwrite_byte 0x61 0 $len $testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
-- 
2.9.0



