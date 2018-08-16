Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731269AbeHPKV4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:21:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7OamM151110
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:26 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kw1udx8c7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:25 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:25:25 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 02/16] xfs/050: Fix "Push past soft inode limit" case
Date: Thu, 16 Aug 2018 12:56:32 +0530
In-Reply-To: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
References: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180816072646.14490-3-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

The test sets an inode soft limit of four but only three files are
created. This commit creates two more files in order to really push past
the soft inode limit.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/xfs/050     |  2 ++
 tests/xfs/050.out | 36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/tests/xfs/050 b/tests/xfs/050
index dd77971..8569c2c 100755
--- a/tests/xfs/050
+++ b/tests/xfs/050
@@ -143,6 +143,8 @@ _exercise()
 	echo "*** push past the soft inode limit" | tee -a $seqres.full
 	_file_as_id $SCRATCH_MNT/softie1 $id $type 1024 0
 	_file_as_id $SCRATCH_MNT/softie2 $id $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie3 $id $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie4 $id $type 1024 0
 	_qmount
 	xfs_quota -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
diff --git a/tests/xfs/050.out b/tests/xfs/050.out
index 5cb4a10..ff9eb1c 100644
--- a/tests/xfs/050.out
+++ b/tests/xfs/050.out
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
@@ -48,11 +48,11 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
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
@@ -80,19 +80,19 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
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
 *** gqnoenforce
@@ -112,19 +112,19 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
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
 *** pquota
@@ -144,11 +144,11 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
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
@@ -176,18 +176,18 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
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
