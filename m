Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1C8C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 06:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiEPGIW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 02:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbiEPGIO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 02:08:14 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC77E21240
        for <fstests@vger.kernel.org>; Sun, 15 May 2022 23:08:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 332E15345AF
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 16:08:11 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqTtp-00CYbF-Ew
        for fstests@vger.kernel.org; Mon, 16 May 2022 16:08:09 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqTtp-005QwF-Dw
        for fstests@vger.kernel.org;
        Mon, 16 May 2022 16:08:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/3] fstests: filter quota warnings
Date:   Mon, 16 May 2022 16:08:05 +1000
Message-Id: <20220516060807.1295102-2-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516060807.1295102-1-david@fromorbit.com>
References: <20220516060807.1295102-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6281ea4b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=kQqIYB2Um9HJNwBhtG8A:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Quota warning code has been removed from the upstream kernel and now
returns -EINVAL errors. Seeing as we can't set warnings anymore and
they have always been non-functional in the kernel, just remove the
calls to set warnings filter those errors out so those tests pass
again.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/050 | 9 ---------
 tests/xfs/153 | 9 ---------
 tests/xfs/299 | 9 ---------
 3 files changed, 27 deletions(-)

diff --git a/tests/xfs/050 b/tests/xfs/050
index 1847611b..2220e470 100755
--- a/tests/xfs/050
+++ b/tests/xfs/050
@@ -84,9 +84,6 @@ _exercise()
 	_qsetup $1
 
 	echo "Using type=$type id=$id" >>$seqres.full
-
-	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
-
 	echo
 	echo "*** report no quota settings" | tee -a $seqres.full
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
@@ -113,7 +110,6 @@ _exercise()
 	_file_as_id $SCRATCH_MNT/softie3 $id $type 1024 0
 	_file_as_id $SCRATCH_MNT/softie4 $id $type 1024 0
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -122,8 +118,6 @@ _exercise()
 	echo "*** push past the soft block limit" | tee -a $seqres.full
 	_file_as_id $SCRATCH_MNT/softie $id $type $bsize 300
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" \
-		-c "warn -b -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -136,8 +130,6 @@ _exercise()
 		_file_as_id $SCRATCH_MNT/hard$i $id $type 1024 0
 	done
 	_qmount
-	$XFS_QUOTA_PROG -x  -c "warn -b -$type 0 $id" \
-		-c "warn -i -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -149,7 +141,6 @@ _exercise()
 	echo "ls -l $SCRATCH_MNT" >>$seqres.full
 	ls -l $SCRATCH_MNT >>$seqres.full
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -b -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_and_check_blks | LC_COLLATE=POSIX sort -ru
diff --git a/tests/xfs/153 b/tests/xfs/153
index 8e1430c0..dbe26b68 100755
--- a/tests/xfs/153
+++ b/tests/xfs/153
@@ -89,9 +89,6 @@ run_tests()
 	_qsetup $1
 
 	echo "Using type=$type id=$id" >>$seqres.full
-
-	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
-
 	echo
 	echo "*** report no quota settings" | tee -a $seqres.full
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
@@ -122,7 +119,6 @@ run_tests()
 	_file_as_id $SCRATCH_MNT/softie4 0 $type 1024 0
 	_scratch_umount_idmapped
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -133,8 +129,6 @@ run_tests()
 	_file_as_id $SCRATCH_MNT/softie 0 $type $bsize 300
 	_scratch_umount_idmapped
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" \
-		-c "warn -b -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -149,8 +143,6 @@ run_tests()
 		_scratch_umount_idmapped
 	done
 	_qmount
-	$XFS_QUOTA_PROG -x  -c "warn -b -$type 0 $id" \
-		-c "warn -i -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -164,7 +156,6 @@ run_tests()
 	echo "ls -l $SCRATCH_MNT" >>$seqres.full
 	ls -l $SCRATCH_MNT >>$seqres.full
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -b -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_and_check_blks | LC_COLLATE=POSIX sort -ru
diff --git a/tests/xfs/299 b/tests/xfs/299
index a3077b0c..4b9df3c6 100755
--- a/tests/xfs/299
+++ b/tests/xfs/299
@@ -70,9 +70,6 @@ _exercise()
 	_qsetup $1
 
 	echo "Using type=$type id=$id" >>$seqres.full
-
-	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
-
 	echo
 	echo "*** report no quota settings" | tee -a $seqres.full
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
@@ -99,7 +96,6 @@ _exercise()
 	_file_as_id $SCRATCH_MNT/softie3 $id $type 1024 0
 	_file_as_id $SCRATCH_MNT/softie4 $id $type 1024 0
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -108,8 +104,6 @@ _exercise()
 	echo "*** push past the soft block limit" | tee -a $seqres.full
 	_file_as_id $SCRATCH_MNT/softie $id $type $bsize 200
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" \
-		-c "warn -b -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -122,8 +116,6 @@ _exercise()
 		_file_as_id $SCRATCH_MNT/hard$i $id $type 1024 0
 	done
 	_qmount
-	$XFS_QUOTA_PROG -x  -c "warn -b -$type 0 $id" \
-		-c "warn -i -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_quota_report | LC_COLLATE=POSIX sort -ru
@@ -135,7 +127,6 @@ _exercise()
 	echo "ls -l $SCRATCH_MNT" >>$seqres.full
 	ls -l $SCRATCH_MNT >>$seqres.full
 	_qmount
-	$XFS_QUOTA_PROG -x -c "warn -b -$type 0 $id" $SCRATCH_DEV
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
 		_filter_and_check_blks | LC_COLLATE=POSIX sort -ru
-- 
2.35.1

