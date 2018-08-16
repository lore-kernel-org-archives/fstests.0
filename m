Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731269AbeHPKWL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:22:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7Od7S064336
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:41 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kw1yu5ywd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:40 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:25:40 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 06/16] Fix xfs/139 to work with 64k block size
Date: Thu, 16 Aug 2018 12:56:36 +0530
In-Reply-To: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
References: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180816072646.14490-7-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

For 64k block size, the agsize provided in the test causes mkfs.xfs to
fail due to insufficient log space. Hence this commit computes agsize
based on block size of the filesystem.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/xfs/139     | 12 ++++++------
 tests/xfs/139.out |  8 ++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/xfs/139 b/tests/xfs/139
index 2a26635..faeeada 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -34,17 +34,17 @@ _require_cp_reflink
 
 rm -f $seqres.full
 
+blksz=$(_get_block_size $TEST_DIR)
+
 echo "Format and mount"
-_scratch_mkfs -d agsize=$((32 * 1048576)) > $seqres.full 2>&1
+_scratch_mkfs -d agsize=$((4400 * $blksz)) > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
 mkdir $testdir
-blksz="$(_get_block_size $testdir)"
 
 echo "Create the original files"
-sz=$((48 * 1048576))
-nr=$((sz / blksz))
+sz=$((4800 * $blksz))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _scratch_cycle_mount
@@ -54,8 +54,8 @@ _pwrite_byte 0x62 0 $sz $testdir/file1 >> $seqres.full
 _scratch_cycle_mount
 
 echo "Compare files"
-md5sum $testdir/file1 | _filter_scratch
-md5sum $testdir/file2 | _filter_scratch
+od -t x1 $testdir/file1 | _filter_od
+od -t x1 $testdir/file2 | _filter_od
 #filefrag -v $testdir/file1 $testdir/file2
 
 # success, all done
diff --git a/tests/xfs/139.out b/tests/xfs/139.out
index dc6a31e..55e03d6 100644
--- a/tests/xfs/139.out
+++ b/tests/xfs/139.out
@@ -3,5 +3,9 @@ Format and mount
 Create the original files
 CoW every other block
 Compare files
-673c759fb131ccf3336c4f8c549a497e  SCRATCH_MNT/test-139/file1
-dc802351f6717547cbf4c951b294f952  SCRATCH_MNT/test-139/file2
+0 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62
+*
+11300
+0 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61
+*
+11300
-- 
2.9.5
