Received: from mx1.redhat.com ([209.132.183.28]:52589 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbbHRRwI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 18 Aug 2015 13:52:08 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/201: use min_dio_alignment size to replace 512b
Date: Wed, 19 Aug 2015 01:52:05 +0800
Message-Id: <1439920325-9723-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hch@lst.de, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

This case use hard-code 512, but in 4k sector size device,
it will fail.

So I call _min_dio_alignment() to get the sector size, then
replace `512`.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/201 | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/xfs/201 b/tests/xfs/201
index 88829d3..921d2a3 100755
--- a/tests/xfs/201
+++ b/tests/xfs/201
@@ -32,15 +32,6 @@ here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
 
-do_pwrite()
-{
-	offset=`expr $1 \* 512`
-	end=`expr $2 \* 512`
-	length=`expr $end - $offset`
-
-	xfs_io -d -f $file -c "pwrite $offset $length" >/dev/null
-}
-
 _cleanup()
 {
 	umount $SCRATCH_MNT
@@ -57,6 +48,17 @@ _supported_os Linux
 
 file=$SCRATCH_MNT/f
 
+min_align=`_min_dio_alignment $SCRATCH_DEV`
+
+do_pwrite()
+{
+	offset=`expr $1 \* $min_align`
+	end=`expr $2 \* $min_align`
+	length=`expr $end - $offset`
+
+	xfs_io -d -f $file -c "pwrite $offset $length" >/dev/null
+}
+
 _require_scratch
 
 _scratch_mkfs_xfs >/dev/null 2>&1
-- 
1.9.3

