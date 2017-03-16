Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52715 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751136AbdCPKch (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Mar 2017 06:32:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2GANmt4057470
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 06:32:35 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0a-001b2d01.pphosted.com with ESMTP id 297mmx511p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 06:32:26 -0400
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <harish@linux.vnet.ibm.com>;
        Thu, 16 Mar 2017 20:32:22 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v2GAWC4V49348614
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 21:32:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v2GAVm5a024469
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 21:31:48 +1100
From: Harish <harish@linux.vnet.ibm.com>
Subject: [PATCH] common/dmthin: Fix grep command for finding exact value
Date: Thu, 16 Mar 2017 16:01:25 +0530
Message-Id: <1489660285-19947-1-git-send-email-harish@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Harish <harish@linux.vnet.ibm.com>
List-ID: <fstests@vger.kernel.org>

Sometimes there are multiple occurances of meta_name, pool_name,
data_name in dmsetup command which causes failures while adding
in next line. This patch greps for names at start of line.

Signed-off-by: Harish <harish@linux.vnet.ibm.com>
---
 common/dmthin | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/dmthin b/common/dmthin
index e774175..baab628 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -178,12 +178,12 @@ _dmthin_grow()
 	local blk_dev_size=`blockdev --getsz $dm_backing_dev`
 
 	# Get current sizes & values
-	local   meta_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_META_NAME | awk '{print $3}'`
-	local meta_dev_offset=`$DMSETUP_PROG table | grep $DMTHIN_META_NAME | awk '{print $6}'`
-	local   data_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_DATA_NAME | awk '{print $3}'`
-	local   pool_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $3}'`
-	local    cluster_size=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $7}'`
-	local       low_water=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $8}'`
+	local   meta_dev_size=`$DMSETUP_PROG table | grep ^$DMTHIN_META_NAME | awk '{print $3}'`
+	local meta_dev_offset=`$DMSETUP_PROG table | grep ^$DMTHIN_META_NAME | awk '{print $6}'`
+	local   data_dev_size=`$DMSETUP_PROG table | grep ^$DMTHIN_DATA_NAME | awk '{print $3}'`
+	local   pool_dev_size=`$DMSETUP_PROG table | grep ^$DMTHIN_POOL_NAME | awk '{print $3}'`
+	local    cluster_size=`$DMSETUP_PROG table | grep ^$DMTHIN_POOL_NAME | awk '{print $7}'`
+	local       low_water=`$DMSETUP_PROG table | grep ^$DMTHIN_POOL_NAME | awk '{print $8}'`
 
 	# default to 25% growth
 	if [ -z "$add_sectors" ]; then
-- 
2.7.4

