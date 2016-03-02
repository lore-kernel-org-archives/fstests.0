Received: from mx1.redhat.com ([209.132.183.28]:47098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbcCBQwP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 2 Mar 2016 11:52:15 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/259: disable CRC if testing with 512 bytes block size
Date: Thu,  3 Mar 2016 00:51:58 +0800
Message-Id: <1456937518-20505-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

With CRCs being the default, TEST_DEV can still be created with
"-m crc=0" option explicitly, then 512 bytes block size is picked up by
the test, which causes mkfs failure in later mkfs tests.

Fix it by adding "-m crc=0" mkfs option in this case.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/259 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/259 b/tests/xfs/259
index 16c1935..b5681fe 100755
--- a/tests/xfs/259
+++ b/tests/xfs/259
@@ -62,6 +62,12 @@ else
 	sizes_to_check="512 1024 2048 4096"
 fi
 
+# If XFS mounted at $TEST_DIR is created with crc disabled explicitly, option
+# "-m crc=0" should be added to mkfs option as blocksize is 512
+mkfs_opts="-l size=32m -b size=$blocksize"
+if [ $_fs_has_crcs -ne 1 -a "$XFS_MKFS_HAS_NO_META_SUPPORT" == "" ]; then
+	mkfs_opts="$mkfs_opts -m crc=0"
+fi
 four_TB=$(_math "2^42")
 for del in $sizes_to_check; do
 	ddseek=$(_math "$four_TB - $del")
@@ -71,8 +77,7 @@ for del in $sizes_to_check; do
 					>/dev/null 2>&1 || echo "dd failed"
 	lofile=$(losetup -f)
 	losetup $lofile "$testfile"
-	"$MKFS_XFS_PROG" -l size=32m -b size=$blocksize $lofile \
-					>/dev/null || echo "mkfs failed!"
+	"$MKFS_XFS_PROG" $mkfs_opts $lofile >/dev/null || echo "mkfs failed!"
 	sync
 	losetup -d $lofile
 done
-- 
2.5.0

