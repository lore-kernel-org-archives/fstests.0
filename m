Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727882AbeHPKWk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:22:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7OXt6084384
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:26:10 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kw2y2m9cy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:26:10 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:26:09 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 15/16] Fix generic/230 to work with 64k block size
Date: Thu, 16 Aug 2018 12:56:45 +0530
In-Reply-To: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
References: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180816072646.14490-16-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

This commit changes the test to work on file offsets that are aligned
with the block size of the underlying filesystem.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/generic/230     | 24 ++++++++++++++----------
 tests/generic/230.out | 16 ++++++++--------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/tests/generic/230 b/tests/generic/230
index bc8c1ad..0add028 100755
--- a/tests/generic/230
+++ b/tests/generic/230
@@ -28,6 +28,8 @@ _require_scratch
 _require_quota
 _require_user
 
+BLOCK_SIZE=$(_get_block_size $TEST_DIR)
+
 test_files()
 {
 	echo; echo "### create files, setting up ownership (type=$type)"
@@ -42,27 +44,27 @@ test_enforcement()
 	echo "### some buffered IO (type=$type)"
 	echo "--- initiating IO..." >>$seqres.full
 	# Firstly fit below block soft limit
-	echo "Write 900k..."
-	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 900k' -c fsync \
+	echo "Write 225 blocks..."
+	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 $((225 * $BLOCK_SIZE))' -c fsync \
 		$SCRATCH_MNT/file1" 2>&1 >>$seqres.full | \
 		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
 	# Secondly overcome block soft limit
-	echo "Rewrite 1001k..."
-	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 1001k' -c fsync \
+	echo "Rewrite 250 blocks plus 1 byte..."
+	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 $((250 * $BLOCK_SIZE + 1))' -c fsync \
 		$SCRATCH_MNT/file1" 2>&1 >>$seqres.full | \
 		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
 	# Now try to overcome block hardlimit
-	echo "Write 1000k..."
-	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 1000k' -c fsync \
+	echo "Write 250 blocks..."
+	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 $((250 * $BLOCK_SIZE))' -c fsync \
 		$SCRATCH_MNT/file2" 2>&1 >>$seqres.full | \
 		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
 	# Now sleep for grace time and check that softlimit got enforced
 	sleep $((grace+1))
-	echo "Write 4096..."
-	su $qa_user -c "$XFS_IO_PROG -c 'truncate 0' -c 'pwrite 0 4096' \
+	echo "Write 1 block..."
+	su $qa_user -c "$XFS_IO_PROG -c 'truncate 0' -c 'pwrite 0 $BLOCK_SIZE' \
 		$SCRATCH_MNT/file2" 2>&1 >>$seqres.full | \
 		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
@@ -103,9 +105,11 @@ _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
 quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon $SCRATCH_MNT 2>/dev/null
-setquota -u $qa_user 1000 2000 3 5 $SCRATCH_MNT
+setquota -u $qa_user $((250 * $BLOCK_SIZE / 1024)) \
+	 $((500 * $BLOCK_SIZE / 1024)) 3 5 $SCRATCH_MNT
 setquota -u -t $grace $grace $SCRATCH_MNT
-setquota -g $qa_user 1000 2000 3 5 $SCRATCH_MNT
+setquota -g $qa_user $((250 * $BLOCK_SIZE / 1024)) \
+	 $((500 * $BLOCK_SIZE / 1024)) 3 5 $SCRATCH_MNT
 setquota -g -t $grace $grace $SCRATCH_MNT
 _scratch_unmount
 
diff --git a/tests/generic/230.out b/tests/generic/230.out
index fcbacf2..9e89a47 100644
--- a/tests/generic/230.out
+++ b/tests/generic/230.out
@@ -4,11 +4,11 @@ QA output created by 230
 
 ### create files, setting up ownership (type=u)
 ### some buffered IO (type=u)
-Write 900k...
-Rewrite 1001k...
-Write 1000k...
+Write 225 blocks...
+Rewrite 250 blocks plus 1 byte...
+Write 250 blocks...
 pwrite: Disk quota exceeded
-Write 4096...
+Write 1 block...
 pwrite: Disk quota exceeded
 Touch 3+4
 Touch 5+6
@@ -20,11 +20,11 @@ touch: cannot touch 'SCRATCH_MNT/file5': Disk quota exceeded
 
 ### create files, setting up ownership (type=g)
 ### some buffered IO (type=g)
-Write 900k...
-Rewrite 1001k...
-Write 1000k...
+Write 225 blocks...
+Rewrite 250 blocks plus 1 byte...
+Write 250 blocks...
 pwrite: Disk quota exceeded
-Write 4096...
+Write 1 block...
 pwrite: Disk quota exceeded
 Touch 3+4
 Touch 5+6
-- 
2.9.5
