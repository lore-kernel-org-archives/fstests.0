Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC167C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FEF22B49
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 16:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDkVEIVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG2QOu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:14:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgG2QOu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jul 2020 12:14:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TGBvN6129909;
        Wed, 29 Jul 2020 16:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=o6vy9ZNQEmgi8TOY3hXrModERsDJ8V7oHI4w3+xO/lQ=;
 b=ZDkVEIVrb2BHOWLVe6J2YQE3CiDF4VD95eWaCvTkUOEYoKk1di0Pyh5pNK7wIhtUH7R7
 FeULXK/BbNAC6jPzREIuthhftB1mhCCVx6d+8TXKqwhpavNZDR9Syqo08vlneEVhVZnm
 ioHBDkVCy6+wLMtdjK7oBEmgOjPJYcyLPCmGudOrOFPqDGT0rwSHQMuK2+xbP0vdQc8m
 nKNdUdMmmgU6ZiEfe+FyRN8PzlgueRXgkfLpAUrZxiT78OhCEV4y+v2wBPnEaINNk0Dv
 n/ns57DwiVgqEEi3HPToFoJtOjMBONYX+dBL4i/o6fNa3j/VGW2cignpK4CMkiVbOXYx 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32hu1jekhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 16:14:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TGDP63063695;
        Wed, 29 Jul 2020 16:14:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32hu5v2udk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 16:14:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06TGEi5a005454;
        Wed, 29 Jul 2020 16:14:44 GMT
Received: from localhost (/10.159.245.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 09:14:44 -0700
Date:   Wed, 29 Jul 2020 09:14:43 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     zlang@redhat.com, fstests <fstests@vger.kernel.org>
Subject: [PATCH v2] xfs/030: repair should actually find the zeroed block
 pointer in the agfl
Message-ID: <20200729161443.GA7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=5 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=5 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290109
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

In xfs/030, we zero the entire AGFL which makes it corrupt because the
AG superblock block is /never/ free.  In commit dcd6c2e1 ("xfs_repair:
convert to libxfs_verify_agbno") we enhanced repair to complain about
zeroed entries in the AGFL, so add that to the golden output.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
v2: point out which commit we're testing
---
 tests/xfs/030.out |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/030.out b/tests/xfs/030.out
index 4a7c4b8b..53299438 100644
--- a/tests/xfs/030.out
+++ b/tests/xfs/030.out
@@ -105,6 +105,7 @@ Phase 1 - find and verify superblock...
 Phase 2 - using <TYPEOF> log
         - zero log...
         - scan filesystem freespace and inode maps...
+bad agbno AGBNO in agfl, agno 0
         - found root inode chunk
 Phase 3 - for each AG...
         - scan and clear agi unlinked lists...
