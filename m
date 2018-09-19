Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731530AbeISRhc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Sep 2018 13:37:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JBx1ad007861
        for <fstests@vger.kernel.org>; Wed, 19 Sep 2018 07:59:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mkkc9xx18-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Wed, 19 Sep 2018 07:59:55 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Wed, 19 Sep 2018 07:59:54 -0400
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V4 19/20] Fix generic/018 to work with 64k block size
Date: Wed, 19 Sep 2018 17:30:52 +0530
In-Reply-To: <20180919120053.7339-1-chandan@linux.vnet.ibm.com>
References: <20180919120053.7339-1-chandan@linux.vnet.ibm.com>
Message-Id: <20180919120053.7339-20-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, guaneryu@gmail.com, darrick.wong@oracle.com, zlang@redhat.com, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This commit replaces the hard coded bsize variable with the block size
obtained from the underlying filesystem.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/generic/018 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/018 b/tests/generic/018
index 43610ef..d1386a7 100755
--- a/tests/generic/018
+++ b/tests/generic/018
@@ -42,7 +42,7 @@ fragfile=$SCRATCH_MNT/fragfile.$$
 rm -f $fragfile
 
 # Craft some fragmented files, defrag them, check the result.
-bsize=4096
+bsize=$(_get_file_block_size $SCRATCH_MNT)
 
 echo "zero-length file:" | tee -a $seqres.full
 touch $fragfile
-- 
2.9.5
