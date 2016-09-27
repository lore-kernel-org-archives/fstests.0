Received: from mx1.redhat.com ([209.132.183.28]:45666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933854AbcI0PXj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Sep 2016 11:23:39 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8344785547
        for <fstests@vger.kernel.org>; Tue, 27 Sep 2016 15:23:38 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/032: avoid making a 512b block size V5 xfs
Date: Tue, 27 Sep 2016 23:23:35 +0800
Message-Id: <1474989815-8202-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

If test on a 512b sector size device, xfs/032 will try to do:

  mkfs.xfs -s size=512 -b size=512 ...

The 512b block size is not acceptable for V5 XFS. So I change the
minimum block size to 1024 if (crc = 1 && sector size < 1024).

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/032 | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/032 b/tests/xfs/032
index 6216379..487dbd9 100755
--- a/tests/xfs/032
+++ b/tests/xfs/032
@@ -34,6 +34,7 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
+. ./common/filter
 
 # real QA test starts here
 _supported_fs xfs
@@ -50,11 +51,22 @@ rm -f $seqres.full
 SECTORSIZE=`blockdev --getss $SCRATCH_DEV`
 PAGESIZE=`src/feature -s`
 IMGFILE=$TEST_DIR/${seq}_copy.img
+MIN_BLKSIZE=$SECTORSIZE
+
+if [ $MIN_BLKSIZE -lt 1024 ]; then
+	_scratch_mkfs_sized $((512 * 1024 * 1024)) | _filter_mkfs \
+						2>$tmp.mkfs >/dev/null
+	. $tmp.mkfs
+	if [ $_fs_has_crcs -eq 1 ]; then
+		MIN_BLKSIZE=1024
+	fi
+	rm -f $tmp.mkfs
+fi
 
 echo "Silence is golden."
 
 while [ $SECTORSIZE -le $PAGESIZE ]; do
-	BLOCKSIZE=$SECTORSIZE;
+	BLOCKSIZE=$MIN_BLKSIZE;
 
 	while [ $BLOCKSIZE -le $PAGESIZE ]; do
 
-- 
2.7.4

