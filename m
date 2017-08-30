Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:35996 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdH3Hid (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Aug 2017 03:38:33 -0400
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH] btrfs/029: fix wrong usage of name filter
Message-ID: <2a13313b-d8f5-b6fd-58cb-72e05f5925c9@jp.fujitsu.com>
Date: Wed, 30 Aug 2017 16:38:16 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

btrfs/029 uses _filter_testdirs() to filter the name of $TEST_DIR and
$SCRATCH_MNT directory.

In this function, it calls both _filter_test_dir and _filter_scratch
concatenated by pipe. Therefore if $TEST_DIR is a prefix of
$SCRATCH_MNT, this filter function gives wrong filtered name for
$SCRATCH_MNT and the test fails.

Fix this by calling _filter_test_dir and _filter_scratch directly.

Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
---
 tests/btrfs/029 | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/029 b/tests/btrfs/029
index c390c95..74fded7 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -66,19 +66,14 @@ _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 $XFS_IO_PROG -f -c 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/original >> $seqres.full
 
-_filter_testdirs()
-{
-    _filter_test_dir | _filter_scratch
-}
-
 _create_reflinks()
 {
     # auto reflink, should fall back to non-reflink
     rm -rf $2
     echo "reflink=auto:"
     cp --reflink=auto $1 $2
-    md5sum $1 | _filter_testdirs
-    md5sum $2 | _filter_testdirs
+    md5sum $1 | _filter_scratch
+    md5sum $2 | _filter_test_dir
 
     # always reflink, should fail outright
     rm -rf $2
@@ -86,7 +81,7 @@ _create_reflinks()
     cp --reflink=always $1 $2 >> $seqres.full 2>&1 || echo "cp reflink failed"
 
     # The failed target actually gets created by cp:
-    ls $2 | _filter_testdirs
+    ls $2 | _filter_test_dir
 }
 
 echo "test reflinks across different devices"
-- 
2.9.5

