Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731269AbeHPKWD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:22:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7OFjr104940
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:33 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kw1v0pe16-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:32 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:25:32 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 04/16] Fix xfs/074 to work with 64k block size
Date: Thu, 16 Aug 2018 12:56:34 +0530
In-Reply-To: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
References: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180816072646.14490-5-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

This commit makes file and extent size calculations to be a function of
the filesystem's block size. It also adds a brief description of the
bug that is being tested.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/xfs/074 | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/074 b/tests/xfs/074
index e5888d5..39b04f4 100755
--- a/tests/xfs/074
+++ b/tests/xfs/074
@@ -7,6 +7,18 @@
 # Check some extent size hint boundary conditions that can result in
 # MAXEXTLEN overflows.
 #
+# In xfs_bmap_extsize_align(), we had,
+# 	if ((temp = (align_alen % extsz))) {
+# 		align_alen += extsz - temp;
+# 	}
+# align_alen had the value of 2097151 (i.e. MAXEXTLEN) blocks. extsz had
+# the value of 4096 blocks.
+#
+# align_alen % extsz will be 4095. so align_alen will end up having
+# 2097151 + (4096 - 4095) = 2097152 i.e. (MAXEXTLEN + 1). Thus the length
+# of the new extent will be larger than MAXEXTLEN. This will later cause
+# the bmbt leaf to have an entry whose length is set to zero block count.
+#
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -40,25 +52,28 @@ _require_xfs_io_command "falloc"
 # without having to care about the underlying device size.
 _require_loop
 
+BLOCK_SIZE=$(_get_block_size $TEST_DIR)
+
 LOOP_FILE=$TEST_DIR/$seq.img
 LOOP_MNT=$TEST_DIR/$seq.mnt
 mkdir -p $LOOP_MNT
 $XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE >> $seqres.full
 LOOP_DEV=`_create_loop_device $LOOP_FILE`
 
-_mkfs_dev -d size=156452m,agcount=4 -l size=32m $LOOP_DEV
+_mkfs_dev -d size=260g,agcount=2 $LOOP_DEV
 _mount $LOOP_DEV $LOOP_MNT
 
 # Corrupt the BMBT by creating extents larger than MAXEXTLEN
+# For 4k blocksize, MAXEXTLEN * 4k = 2097151 * 4k = 8589930496 = ~8GiB
 $XFS_IO_PROG -ft \
-	-c "extsize 16m" \
-	-c "falloc 0 30g" \
+	-c "extsize $(($BLOCK_SIZE * 4096))" \
+	-c "falloc 0 $(($BLOCK_SIZE * 2097152))" \
 	$LOOP_MNT/foo >> $seqres.full
 
 umount $LOOP_MNT
 _check_xfs_filesystem $LOOP_DEV none none
 
-_mkfs_dev -f -l size=32m $LOOP_DEV
+_mkfs_dev -f $LOOP_DEV
 _mount $LOOP_DEV $LOOP_MNT
 
 # check we trim both ends of the extent approproiately; this will fail
-- 
2.9.5
