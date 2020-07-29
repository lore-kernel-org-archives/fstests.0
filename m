Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D5C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 02:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385912078E
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 02:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FY2i2EJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgG2CxY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:53:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2CxX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jul 2020 22:53:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06T2r9D9155015;
        Wed, 29 Jul 2020 02:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=bwpwppJ6MCHr8UIDcXo7CRskRVcGoCRzf9rbcyDACHI=;
 b=FY2i2EJOaalAiJ2JcklE6vu8c6pm9obgo9L9I5WLUQ7UqSZR3i6qBLzhpJyH9DRX8QPT
 bCWc44zRHok44K/wpJi2W/on7aL/YdWUG7Ezv5lERRIc+LJHeAoveclzjcSXpkZ4WhTO
 yQskljiHEq4fk8JIk5INqSSd2LtuCnx0tnqfqdA3FeF5BwNmpgMWwNE4Uq2PmVSE9H4q
 KhaXKdU8w0He6GM0FUNI7ADH+sbbfjeZveV9m5K/e2tq60OKR/ETxJK/ZauGoKZAtXCS
 meVLP9l8HZcHoef/SnhKpmZQdkn5rPeI676rGugDoaZRnkCI1avwYJvZWcVRL2bUx5QA Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1jb05c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 02:53:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06T2mZQC002234;
        Wed, 29 Jul 2020 02:51:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32hu5txw1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 02:51:21 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06T2pKgW005437;
        Wed, 29 Jul 2020 02:51:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 19:51:20 -0700
Date:   Tue, 28 Jul 2020 19:51:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: [PATCH] xfs/010,030: filter AG header CRC error warnings
Message-ID: <20200729025119.GV7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290020
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Filter out the new AG header CRC verification warnings in xfs_repair
since these tests were built before that existed.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/010 |    7 ++++++-
 tests/xfs/030 |    2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/010 b/tests/xfs/010
index e220a651..b65dd3ba 100755
--- a/tests/xfs/010
+++ b/tests/xfs/010
@@ -113,7 +113,12 @@ _check_scratch_fs
 # nuke the finobt root, repair will have to regenerate from the inobt
 _corrupt_finobt_root $SCRATCH_DEV
 
-_scratch_xfs_repair 2>&1 | _filter_repair_lostblocks
+filter_finobt_repair() {
+	sed -e '/^agi has bad CRC/d' | \
+		_filter_repair_lostblocks
+}
+
+_scratch_xfs_repair 2>&1 | filter_finobt_repair
 
 status=0
 exit
diff --git a/tests/xfs/030 b/tests/xfs/030
index efdb6a18..ebe4c92a 100755
--- a/tests/xfs/030
+++ b/tests/xfs/030
@@ -42,6 +42,8 @@ _check_ag()
 			    -e '/^bad agbno AGBNO for finobt/d' \
 			    -e '/^bad agbno AGBNO for rmapbt/d' \
 			    -e '/^bad agbno AGBNO for refcntbt/d' \
+			    -e '/^agf has bad CRC/d' \
+			    -e '/^agi has bad CRC/d' \
 			    -e '/^Missing reverse-mapping record.*/d' \
 			    -e '/^unknown block state, ag AGNO, block.*/d'
 	done
