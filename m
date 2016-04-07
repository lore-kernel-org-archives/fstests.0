Received: from mx1.redhat.com ([209.132.183.28]:56191 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384AbcDGLGs (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 7 Apr 2016 07:06:48 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/259: handle minimum block size more precisely
Date: Thu,  7 Apr 2016 19:05:55 +0800
Message-Id: <1460027155-4222-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Currently xfs/259 checks $TEST_DIR for CRC support status to determine
if 512 block size should be tested. But this doesn't always work. For
example, when TEST_DEV is mkfs'ed with "-m crc=0" mkfs option, using
mkfs.xfs binary with CRC being the default.

What should be really checked is whether mkfs.xfs creates CRC enabled
XFS by default. So introduce a new flag XFS_MKFS_CRC_DEFAULT for this
purpose, and do the check based on it in xfs/259.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

This is actually the second attempt to fix this issue, because Christoph was
not satisfied with the first attempt, and me either (after thinking about it
more :-)). Hope it works this time.

 common/config | 8 ++++++++
 tests/xfs/259 | 4 +---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/config b/common/config
index cacd815..13bd307 100644
--- a/common/config
+++ b/common/config
@@ -270,8 +270,16 @@ $MKFS_XFS_PROG -N -d file,name=/tmp/crc_check.img,size=32m -m crc=0 \
 if [ $? -ne 0 ]; then
 	XFS_MKFS_HAS_NO_META_SUPPORT=true
 fi
+# check if v5 xfs is default
+XFS_MKFS_CRC_DEFAULT=0
+$MKFS_XFS_PROG -N -d file,name=/tmp/crc_check.img,size=32m 2>&1 | grep -q crc=1
+if [ $? -eq 0 ]; then
+	XFS_MKFS_CRC_DEFAULT=1
+fi
 rm -f /tmp/crc_check.img
+
 export XFS_MKFS_HAS_NO_META_SUPPORT
+export XFS_MKFS_CRC_DEFAULT
 
 # new doesn't need config file parsed, we can stop here
 if [ "$iam" == "new" ]; then
diff --git a/tests/xfs/259 b/tests/xfs/259
index 16c1935..3150ff3 100755
--- a/tests/xfs/259
+++ b/tests/xfs/259
@@ -51,9 +51,7 @@ testfile=$TEST_DIR/259.image
 # Test various sizes slightly less than 4 TB. Need to handle different
 # minimum block sizes for CRC enabled filesystems, but use a small log so we
 # don't write lots of zeros unnecessarily.
-xfs_info $TEST_DIR | _filter_mkfs 2> $tmp.mkfs > /dev/null
-. $tmp.mkfs
-if [ $_fs_has_crcs -eq 1 ]; then
+if [ $XFS_MKFS_CRC_DEFAULT -eq 1 ]; then
 	blocksize=1024
 	sizes_to_check="1024 2048 4096"
 	echo "Trying to make (4 TB - 512) B long xfs fs image"
-- 
2.5.5

