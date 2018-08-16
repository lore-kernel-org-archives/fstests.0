Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbeHPKWV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:22:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7P7W8072042
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kvynwjes1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:50 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:25:49 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 09/16] Fix xfs/299 to work with 64k block size
Date: Thu, 16 Aug 2018 12:56:39 +0530
In-Reply-To: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
References: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180816072646.14490-10-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

This commit changes the test to calculate quota limits based on the
block size of the underlying filesystem. Also, the sizes of the test
files are now made to be a multiple of the filesystem block size.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/xfs/299     | 23 +++++++++++++--------
 tests/xfs/299.out | 60 +++++++++++++++++++++++++++----------------------------
 2 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/tests/xfs/299 b/tests/xfs/299
index f0012ff..99e1567 100755
--- a/tests/xfs/299
+++ b/tests/xfs/299
@@ -41,8 +41,10 @@ _require_xfs_quota
 _require_xfs_mkfs_crc
 _require_xfs_crc
 
-bsoft=100
-bhard=500
+bsize=$(_get_block_size $TEST_DIR)
+
+bsoft=$(( 25 * $bsize ))
+bhard=$(( 125 * $bsize ))
 isoft=4
 ihard=10
 
@@ -58,7 +60,9 @@ _filter_report()
 		if ($ENV{'LARGE_SCRATCH_DEV'}) {
 			$val = $ENV{'NUM_SPACE_FILES'};
 		}
-		s/(^\[ROOT\] \S+ \S+ \S+ \S+ \[--------\] )(\S+)/$1@{[$2 - $val]}/g'
+		s/(^\[ROOT\] \S+ \S+ \S+ \S+ \[--------\] )(\S+)/$1@{[$2 - $val]}/g' |
+	perl -npe '
+		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
 }
 
 # The actual point at which limit enforcement takes place for the
@@ -73,9 +77,10 @@ _filter_and_check_blks()
 		if (/^\#'$id'\s+(\d+)/ && '$enforce') {
 			$maximum = '$bhard';
 			$minimum = '$bhard' * 85/100;
-			if (($1 < $minimum || $1 > $maximum) && '$noextsz') {
+			$used = $1 * 1024;
+			if (($used < $minimum || $used > $maximum) && '$noextsz') {
 				printf(" URK %d: %d is out of range! [%d,%d]\n",
-					'$id', $1, $minimum, $maximum);
+					'$id', $used, $minimum, $maximum);
 			}
 			s/^(\#'$id'\s+)(\d+)/\1 =OK=/g;
 		}
@@ -128,7 +133,7 @@ _exercise()
 	echo "ls -l $SCRATCH_MNT" >>$seqres.full
 	ls -l $SCRATCH_MNT >>$seqres.full
 	xfs_quota -D $tmp.projects -P $tmp.projid -x \
-		-c "limit -$type bsoft=${bsoft}k bhard=${bhard}k $id" \
+		-c "limit -$type bsoft=${bsoft} bhard=${bhard} $id" \
 		-c "limit -$type isoft=$isoft ihard=$ihard $id" \
 		$SCRATCH_DEV
 	xfs_quota -D $tmp.projects -P $tmp.projid -x \
@@ -139,6 +144,8 @@ _exercise()
 	echo "*** push past the soft inode limit" | tee -a $seqres.full
 	_file_as_id $SCRATCH_MNT/softie1 $id $type 1024 0
 	_file_as_id $SCRATCH_MNT/softie2 $id $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie3 $id $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie4 $id $type 1024 0
 	_qmount
 	xfs_quota -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
@@ -146,7 +153,7 @@ _exercise()
 
 	echo
 	echo "*** push past the soft block limit" | tee -a $seqres.full
-	_file_as_id $SCRATCH_MNT/softie $id $type 1024 140
+	_file_as_id $SCRATCH_MNT/softie $id $type $bsize 35
 	_qmount
 	xfs_quota -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
@@ -167,7 +174,7 @@ _exercise()
 	echo
 	# Note: for quota accounting (not enforcement), EDQUOT is not expected
 	echo "*** push past the hard block limit (expect EDQUOT)" | tee -a $seqres.full
-	_file_as_id $SCRATCH_MNT/softie $id $type 1024 540
+	_file_as_id $SCRATCH_MNT/softie $id $type $bsize 135
 	echo "ls -l $SCRATCH_MNT" >>$seqres.full
 	ls -l $SCRATCH_MNT >>$seqres.full
 	_qmount
diff --git a/tests/xfs/299.out b/tests/xfs/299.out
index d13c7da..93e89a9 100644
--- a/tests/xfs/299.out
+++ b/tests/xfs/299.out
@@ -12,23 +12,23 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** report initial settings
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] =OK= 100 500 00 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
+[NAME] =OK= 25 125 0 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
 
 
 *** report no quota settings
@@ -36,23 +36,23 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** report initial settings
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] =OK= 100 500 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+[NAME] =OK= 25 125 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
 
 
 *** report no quota settings
@@ -60,23 +60,23 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** report initial settings
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] =OK= 100 500 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+[NAME] =OK= 25 125 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** unmount
 meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
@@ -92,23 +92,23 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** report initial settings
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 540 100 500 00 [--none--] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 135 25 125 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 
 *** report no quota settings
@@ -116,23 +116,23 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** report initial settings
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 540 100 500 00 [--none--] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 135 25 125 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 
 *** report no quota settings
@@ -140,22 +140,22 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** report initial settings
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 25 125 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 540 100 500 00 [--none--] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 135 25 125 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 *** unmount
-- 
2.9.5
