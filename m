Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729413AbeIXVU7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Sep 2018 17:20:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OFEfO8090698
        for <fstests@vger.kernel.org>; Mon, 24 Sep 2018 11:18:18 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mq1bskevv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 24 Sep 2018 11:18:18 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Mon, 24 Sep 2018 09:18:17 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V5 09/20] xfs/299: Fix "Push past soft inode limit" case
Date: Mon, 24 Sep 2018 20:49:31 +0530
In-Reply-To: <20180924151942.8220-1-chandan@linux.vnet.ibm.com>
References: <20180924151942.8220-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180924151942.8220-10-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, guaneryu@gmail.com, darrick.wong@oracle.com, zlang@redhat.com, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The test sets an inode soft limit of four but only three files are
created. This commit creates two more files in order to really push past
the soft inode limit.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/xfs/299     |  2 ++
 tests/xfs/299.out | 36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/tests/xfs/299 b/tests/xfs/299
index f0012ff..bbf7f61 100755
--- a/tests/xfs/299
+++ b/tests/xfs/299
@@ -139,6 +139,8 @@ _exercise()
 	echo "*** push past the soft inode limit" | tee -a $seqres.full
 	_file_as_id $SCRATCH_MNT/softie1 $id $type 1024 0
 	_file_as_id $SCRATCH_MNT/softie2 $id $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie3 $id $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie4 $id $type 1024 0
 	_qmount
 	xfs_quota -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
diff --git a/tests/xfs/299.out b/tests/xfs/299.out
index d13c7da..f1a1e48 100644
--- a/tests/xfs/299.out
+++ b/tests/xfs/299.out
@@ -16,11 +16,11 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 100 500 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
@@ -40,11 +40,11 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 100 500 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
@@ -64,11 +64,11 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 100 500 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [7 days] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
@@ -96,19 +96,19 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 100 500 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 540 100 500 00 [--none--] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 540 100 500 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 
 *** report no quota settings
@@ -120,19 +120,19 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 100 500 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 540 100 500 00 [--none--] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 540 100 500 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 
 *** report no quota settings
@@ -144,18 +144,18 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 *** push past the soft inode limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 0 100 500 00 [--------] 3 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 100 500 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the soft block limit
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 4 4 10 00 [--------] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
 
 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 140 100 500 00 [--------] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 140 100 500 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 540 100 500 00 [--none--] 16 4 10 00 [--none--] 0 0 0 00 [--------]
+[NAME] 540 100 500 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
 
 *** unmount
-- 
2.9.5
