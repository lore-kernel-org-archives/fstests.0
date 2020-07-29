Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECADC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 02:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB192078E
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 02:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xWrfEJ5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgG2Cxq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:53:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58740 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2Cxq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jul 2020 22:53:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06T2q1pE042138;
        Wed, 29 Jul 2020 02:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=WTvmUYAkgrcE9D0171hEpHW+q2iOJzrfF7eABfazrqE=;
 b=xWrfEJ5g9GOGNl1hSVoST5k22lNdFI0l45Q06aVjpq6QPGN6OPrda98uWQZ3fODLvPzf
 THxh9IvgirvMhCfUma1qQEeexT9afpW0WRFE1DIEn0fxzQGWik+/Xkzsbii1pVI55iLx
 a2bm4yxAXTpQlzhUHs1HciDepOYNZhFBfPfP9ne271Sopz755UMlZs/7bSYfELqCiND/
 xe/YCD1w9C62C+D5L6qL2XkwcW+TXiZMKFdqkoMBlh//HSbalHWgj3lI7a8d3+g95IOG
 v2PInBRBB7kiLEUisZkEaS8WkhRPAcl3QR+9ci9NzulQKWMQrXAsUUHh0ko01EOjLpq5 BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32hu1jayjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 02:53:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06T2nMHX162171;
        Wed, 29 Jul 2020 02:51:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32hu5txjnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 02:51:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06T2pgmO024364;
        Wed, 29 Jul 2020 02:51:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 19:51:42 -0700
Date:   Tue, 28 Jul 2020 19:51:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: [PATCH] generic/603: don't run on XFS v4 filesystems
Message-ID: <20200729025141.GW7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=1 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290020
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

XFS filesystems require V5 format to support all three quota types at
the same time, so skip the test if we're testing XFS older than that.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/603 |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/603 b/tests/generic/603
index 54deaf13..fc3df6e5 100755
--- a/tests/generic/603
+++ b/tests/generic/603
@@ -149,6 +149,10 @@ test_grace()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+# xfs requires v5 format to support all three quota types at the same time
+if [ "$FSTYP" = "xfs" ]; then
+	_require_scratch_xfs_crc
+fi
 _require_setquota_project
 _require_quota
 _require_user
