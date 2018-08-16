Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727882AbeHPKW3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:22:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7OTmm084076
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:59 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kw2y2m8xn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:59 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:25:58 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 12/16] Fix generic/172 to work with 64k block size
Date: Thu, 16 Aug 2018 12:56:42 +0530
In-Reply-To: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
References: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180816072646.14490-13-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

For 64k block size, With 256MiB as the XFS filesystem size and 168 MiB
as the size of the clone source file, we end up hitting ENOSPC when
cloning the source file. This happens due to lack of space for housing
the corresponding metadata. This scenario also occurs when using a
512MiB XFS filesystem and 300MiB clone source file.

Hence this commit increases the size of the test filesystem to 1 GiB and
the size of the clone source file to 768MiB.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/generic/172 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/172 b/tests/generic/172
index 5d6f295..08d2789 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -47,8 +47,8 @@ echo "Reformat with appropriate size"
 blksz="$(_get_block_size $testdir)"
 umount $SCRATCH_MNT
 
-file_size=$((168 * 1024 * 1024))
-fs_size=$((256 * 1024 * 1024))
+file_size=$((768 * 1024 * 1024))
+fs_size=$((1024 * 1024 * 1024))
 _scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
-- 
2.9.5
