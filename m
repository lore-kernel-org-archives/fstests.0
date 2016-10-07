Received: from cn.fujitsu.com ([222.73.24.84]:36649 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbcJGHGg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Oct 2016 03:06:36 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] generic: make 17[1-4] work well when btrfs compression is enabled
Date: Fri,  7 Oct 2016 15:00:42 +0800
Message-Id: <20161007070042.12258-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When enabling btrfs compression, original codes can not fill fs
correctly, fix this.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/generic/171 | 4 +---
 tests/generic/172 | 2 +-
 tests/generic/173 | 4 +---
 tests/generic/174 | 4 +---
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/tests/generic/171 b/tests/generic/171
index f391685..d2ae8e4 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -75,9 +75,7 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+dd if=/dev/zero of=$testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
diff --git a/tests/generic/172 b/tests/generic/172
index 8192290..3bb8687 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -73,7 +73,7 @@ sync
 
 echo "Allocate the rest of the space"
 touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $fs_size $testdir/eat_my_space >> $seqres.full 2>&1
+dd if=/dev/zero of=$testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
diff --git a/tests/generic/173 b/tests/generic/173
index c5fac9e..38bc951 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -75,9 +75,7 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+dd if=/dev/zero of=$testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "mmap CoW the big file"
diff --git a/tests/generic/174 b/tests/generic/174
index 8077d76..a55be38 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -76,9 +76,7 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+dd if=/dev/zero of=$testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
-- 
2.9.0



