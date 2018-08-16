Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389332AbeHPKXX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:23:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7Qehh043883
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:26:53 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kw4679ev3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:26:49 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:25:35 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 05/16] Fix xfs/127 to work with 64k block size
Date: Thu, 16 Aug 2018 12:56:35 +0530
In-Reply-To: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
References: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180816072646.14490-6-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

With reflink feature enabled, we require atleast 500MiB of
disk space to create a filesystem with 64k block size. Hence this commit
sets the size of the scratch filesystem to 512MiB.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/xfs/127 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/127 b/tests/xfs/127
index 41dacd7..6a95026 100755
--- a/tests/xfs/127
+++ b/tests/xfs/127
@@ -34,7 +34,7 @@ _require_no_large_scratch_dev
 _require_cp_reflink
 
 echo "Format and mount"
-_scratch_mkfs_sized $((2 * 4096 * 4096)) > $seqres.full 2>&1
+_scratch_mkfs_sized $((512 * 1024 * 1024)) > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-- 
2.9.5
