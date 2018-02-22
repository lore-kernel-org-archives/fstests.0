Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752455AbeBVF5a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Feb 2018 00:57:30 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1M5tRMT047903
        for <fstests@vger.kernel.org>; Thu, 22 Feb 2018 00:57:30 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g9pnv2mc0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 22 Feb 2018 00:57:30 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 22 Feb 2018 00:57:28 -0500
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH] Fix fcollapse require code to work with 64k block size
Date: Thu, 22 Feb 2018 11:28:55 +0530
Message-Id: <20180222055855.3008-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

For 64k block size, the require code fails because the block range [4k,
12k] would cause the fcollapse syscall to return -EINVAL. Hence the
tests using them are not executed.

This commit fixes the issue by calculating file offset ranges based on
the block size of the underlying filesystem.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 common/rc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index a6caca9..04a2187 100644
--- a/common/rc
+++ b/common/rc
@@ -2106,8 +2106,10 @@ _require_xfs_io_command()
 		param_checked=1
 		;;
 	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" | "funshare")
-		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
-			-c "$command 4k 8k" $testfile 2>&1`
+		blocksize=$(_get_block_size $TEST_DIR/)
+		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 $((5 * $blocksize))" \
+			-c "fsync" -c "$command $blocksize $((2 * $blocksize))" \
+			$testfile 2>&1`
 		;;
 	"fiemap")
 		# If 'ranged' is passed as argument then we check to see if fiemap supports
-- 
2.9.5

