Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56243 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbbD0PvM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Apr 2015 11:51:12 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] shared/289: do not special-case ext3
Date: Mon, 27 Apr 2015 23:51:00 +0800
Message-Id: <1430149860-27321-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1430134449-16060-1-git-send-email-eguan@redhat.com>
References: <1430134449-16060-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Commit "3574531 xfstests: count journal size in test 289" makes ext3 a
special case, but now it's not the case anymore after kernel commit

2046fd1 ext3: Count journal as bsddf overhead in ext3_statfs

So just remove the special case, now test passes on both ext3 and ext4,
also ext3 driven by ext4 module.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- point to right kernel commit id in commit message

 tests/shared/289 | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tests/shared/289 b/tests/shared/289
index c53d38c..96c949d 100755
--- a/tests/shared/289
+++ b/tests/shared/289
@@ -58,18 +58,7 @@ TOTAL_BLOCKS=`dumpe2fs -h $SCRATCH_DEV 2>/dev/null \
 FREE_BLOCKS=`dumpe2fs -h $SCRATCH_DEV 2>/dev/null \
 		| awk '/Free blocks:/{print $3}'`
 
-# ext3 doesn't count journal blocks as overhead, ext4 does.
-if [ $FSTYP = "ext3" ]; then
-	JOURNAL_SIZE=`dumpe2fs -h $SCRATCH_DEV 2>/dev/null \
-		| awk '/Journal size:/{print $3}' | _filter_size_to_bytes`
-	BLOCK_SIZE=`dumpe2fs -h $SCRATCH_DEV 2>/dev/null \
-		| awk '/Block size:/{print $3}'`
-	JOURNAL_BLOCKS=$(($JOURNAL_SIZE/$BLOCK_SIZE))
-else
-	JOURNAL_BLOCKS=0
-fi
-
-OVERHEAD=$(($TOTAL_BLOCKS-$FREE_BLOCKS-$JOURNAL_BLOCKS))
+OVERHEAD=$(($TOTAL_BLOCKS-$FREE_BLOCKS))
 
 #  bsddf|minixdf
 #         Set the behaviour  for  the  statfs  system  call.  The  minixdf
-- 
2.1.0

