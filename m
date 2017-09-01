Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:48868 "EHLO
        mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdIAFlZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Sep 2017 01:41:25 -0400
Subject: [PATCH 2/2] Use common filter function in several tests
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
References: <5f6cd84d-6e12-2b23-09fc-c0f744d1d2f2@jp.fujitsu.com>
Message-ID: <e24c061f-7342-83fd-b08a-767c669a01ef@jp.fujitsu.com>
Date: Fri, 1 Sep 2017 14:41:14 +0900
MIME-Version: 1.0
In-Reply-To: <5f6cd84d-6e12-2b23-09fc-c0f744d1d2f2@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Use newly introduced common function to filter both $TEST_DIR and
$SCRATCH_MNT.

Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
---
 common/filter     |  2 +-
 tests/btrfs/029   | 11 +++--------
 tests/generic/409 |  3 +--
 tests/generic/410 |  3 +--
 tests/generic/411 |  3 +--
 5 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/common/filter b/common/filter
index 75570f9..5d50f61 100644
--- a/common/filter
+++ b/common/filter
@@ -322,7 +322,7 @@ _filter_quota()
 {
 	# Long dev name might be split onto its own line; last
 	# seds remove that newline if present
-	_filter_scratch | _filter_test_dir | _filter_spaces | \
+	_filter_testdir_and_scratch | _filter_spaces | \
 	sed -e 'N;s/SCRATCH_DEV\n/SCRATCH_DEV/g' | \
 	sed -e 'N;s/TEST_DEV\n/TEST_DEV/g'
 }
diff --git a/tests/btrfs/029 b/tests/btrfs/029
index c390c95..b6e2dbb 100755
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
+    md5sum $1 | _filter_testdir_and_scratch
+    md5sum $2 | _filter_testdir_and_scratch
 
     # always reflink, should fail outright
     rm -rf $2
@@ -86,7 +81,7 @@ _create_reflinks()
     cp --reflink=always $1 $2 >> $seqres.full 2>&1 || echo "cp reflink failed"
 
     # The failed target actually gets created by cp:
-    ls $2 | _filter_testdirs
+    ls $2 | _filter_testdir_and_scratch
 }
 
 echo "test reflinks across different devices"
diff --git a/tests/generic/409 b/tests/generic/409
index 22af44c..3ad65c9 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -104,8 +104,7 @@ find_mnt()
 		    -e "s;$mpB;mpB;g" \
 		    -e "s;$mpC;mpC;g" \
 		    -e "s;$mpD;mpD;g" | \
-		_filter_spaces | _filter_scratch | \
-		_filter_test_dir | sort
+		_filter_spaces | _filter_testdir_and_scratch | sort
 	echo "======"
 }
 
diff --git a/tests/generic/410 b/tests/generic/410
index 18cb0c1..63ab716 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -110,8 +110,7 @@ find_mnt()
 		sed -e "s;$mpA;mpA;g" \
 		    -e "s;$mpB;mpB;g" \
 		    -e "s;$mpC;mpC;g" | \
-		_filter_spaces | _filter_scratch | \
-		_filter_test_dir | sort
+		_filter_spaces | _filter_testdir_and_scratch | sort
 	echo "======"
 }
 
diff --git a/tests/generic/411 b/tests/generic/411
index 5db49a4..83f6d26 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -93,8 +93,7 @@ find_mnt()
 		sed -e "s;$mpA;mpA;g" \
 		    -e "s;$mpB;mpB;g" \
 		    -e "s;$mpC;mpC;g" | \
-		_filter_spaces | _filter_scratch | \
-		_filter_test_dir | sort
+		_filter_spaces | _filter_testdir_and_scratch | sort
 	echo "======"
 }
 
-- 
2.9.5

