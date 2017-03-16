Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45623 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750909AbdCPEtv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Mar 2017 00:49:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2G4nPpZ073227
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 00:49:50 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2971kuh4rw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 00:49:50 -0400
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <harish@linux.vnet.ibm.com>;
        Thu, 16 Mar 2017 14:49:44 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v2G4nXfA23855156
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 15:49:41 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v2G4n8iD006577
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 15:49:08 +1100
From: Harish <harish@linux.vnet.ibm.com>
Subject: [PATCH] common/dmthin: Fix grep command for finding exact value
Date: Thu, 16 Mar 2017 10:18:50 +0530
Message-Id: <1489639730-15004-1-git-send-email-harish@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Harish <harish@linux.vnet.ibm.com>
List-ID: <fstests@vger.kernel.org>

Sometimes there are multiple occurences of pool_name and data_name in
dmsetup command which causes failures while adding in next line.
This patch greps for pool_name at start of line.

Signed-off-by: Harish <harish@linux.vnet.ibm.com>
---
 common/dmthin | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/dmthin b/common/dmthin
index e774175..fe48eef 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -180,8 +180,8 @@ _dmthin_grow()
 	# Get current sizes & values
 	local   meta_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_META_NAME | awk '{print $3}'`
 	local meta_dev_offset=`$DMSETUP_PROG table | grep $DMTHIN_META_NAME | awk '{print $6}'`
-	local   data_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_DATA_NAME | awk '{print $3}'`
-	local   pool_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $3}'`
+	local   data_dev_size=`$DMSETUP_PROG table | grep ^$DMTHIN_DATA_NAME | awk '{print $3}'`
+	local   pool_dev_size=`$DMSETUP_PROG table | grep ^$DMTHIN_POOL_NAME | awk '{print $3}'`
 	local    cluster_size=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $7}'`
 	local       low_water=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $8}'`
 
-- 
2.7.4

