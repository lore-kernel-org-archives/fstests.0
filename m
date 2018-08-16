Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731269AbeHPKWN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:22:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7OD34104800
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:43 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kw1v0peaa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:43 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:25:42 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 07/16] Fix xfs/140 to work with 64k block size
Date: Thu, 16 Aug 2018 12:56:37 +0530
In-Reply-To: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
References: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180816072646.14490-8-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

For 64k block size, the agsize provided in the test causes mkfs.xfs to
fail due to insufficient log space. Hence this commit computes agsize
based on block size of the filesystem.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/xfs/140 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/140 b/tests/xfs/140
index 6e89fe3..a5d16ce 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -34,17 +34,18 @@ _require_cp_reflink
 
 rm -f $seqres.full
 
+blksz=$(_get_block_size $TEST_DIR)
+
 echo "Format and mount"
-_scratch_mkfs -d agsize=$((32 * 1048576)) > $seqres.full 2>&1
+_scratch_mkfs -d agsize=$((4400 * $blksz)) > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
 mkdir $testdir
-blksz=$(_get_block_size $testdir)
 
 echo "Create the original files"
-sz=$((48 * 1048576))
-nr=$((sz / blksz))
+nr=4800
+sz=$(($nr * $blksz))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $sz $testdir/file2.chk >> $seqres.full
-- 
2.9.5
