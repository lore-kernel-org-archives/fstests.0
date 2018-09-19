Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731466AbeISRgn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Sep 2018 13:36:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JBx2rb007988
        for <fstests@vger.kernel.org>; Wed, 19 Sep 2018 07:59:06 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mkkc9xw10-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Wed, 19 Sep 2018 07:59:06 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Wed, 19 Sep 2018 07:59:05 -0400
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V4 06/20] Fix xfs/139 to work with 64k block size
Date: Wed, 19 Sep 2018 17:30:39 +0530
In-Reply-To: <20180919120053.7339-1-chandan@linux.vnet.ibm.com>
References: <20180919120053.7339-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180919120053.7339-7-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, guaneryu@gmail.com, darrick.wong@oracle.com, zlang@redhat.com, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

For 64k block size, the agsize provided in the test causes mkfs.xfs to
fail due to insufficient log space. Hence this commit computes agsize
based on block size of the filesystem.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/xfs/139     | 15 +++++++++------
 tests/xfs/139.out |  8 ++++++--
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tests/xfs/139 b/tests/xfs/139
index 2a26635..c074273 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -34,17 +34,20 @@ _require_cp_reflink
 
 rm -f $seqres.full
 
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+blksz=$(_get_file_block_size $SCRATCH_MNT)
+_scratch_unmount
+
 echo "Format and mount"
-_scratch_mkfs -d agsize=$((32 * 1048576)) > $seqres.full 2>&1
+_scratch_mkfs -d agsize=$((8192 * $blksz)) > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
 mkdir $testdir
-blksz="$(_get_block_size $testdir)"
 
 echo "Create the original files"
-sz=$((48 * 1048576))
-nr=$((sz / blksz))
+sz=$((12288 * $blksz))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _scratch_cycle_mount
@@ -54,8 +57,8 @@ _pwrite_byte 0x62 0 $sz $testdir/file1 >> $seqres.full
 _scratch_cycle_mount
 
 echo "Compare files"
-md5sum $testdir/file1 | _filter_scratch
-md5sum $testdir/file2 | _filter_scratch
+od -t x1 $testdir/file1 | _filter_od
+od -t x1 $testdir/file2 | _filter_od
 #filefrag -v $testdir/file1 $testdir/file2
 
 # success, all done
diff --git a/tests/xfs/139.out b/tests/xfs/139.out
index dc6a31e..72909bc 100644
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
+30000
+0 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61
+*
+30000
-- 
2.9.5
