Return-Path: <SRS0=2U3A=AF=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F13C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Jun 2020 03:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8462070E
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Jun 2020 03:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wmgpX3y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbgFXDxA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:53:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59752 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbgFXDw7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jun 2020 23:52:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O3loYO152284;
        Wed, 24 Jun 2020 03:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=v8Tf/Ajp50K6OYfKwzSZd0S7DB2kFZIS5kuL17mjDZ8=;
 b=wmgpX3y/UMFPS6LZHXUqX1UqImYMZfHVcM92+s/2aM4Xfy9hFQYDjoj6xyMBMANBVgYy
 bT1uzATKOTY8ionefWrVohp4D2xRJ1VQlLACgS6dvQnFjvF43805iwkZkau2C2IM3sBU
 V/2qjsqemEX5bQtn+LXy18DQY6qi1qBcFkiMjkbrQBCphofrV8L1GODhx/V3hvcwp5hc
 iAeiopDYi10wiUcm3HwuIar97PuMQaLXHkRw8xMOCD0z8A14WmqofhUkza52quqjU5Ys
 exPG8ieuLh1u8Ia+PnKwFBAOFef5+uLUlg1KVCwQCHDi9dGehHg5P2W3MVF7zExdz4t0 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31uustrgv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 03:52:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O3mAM8144659;
        Wed, 24 Jun 2020 03:52:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31uur6py40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 03:52:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05O3quIp026345;
        Wed, 24 Jun 2020 03:52:56 GMT
Received: from localhost (/10.159.232.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 03:52:55 +0000
Date:   Tue, 23 Jun 2020 20:52:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: [PATCH] generic/361: disable xfs metadata io error retries
Message-ID: <20200624035254.GC7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240026
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

This test examines the behavior of xfs when the underlying filesystem is
a sparse image on the scratch filesystem when the scratch fs is about to
run out of space.  Unfortunately, the test assumes that the scratch fs
will ENOSPC on the large data write.  It's possible that metadata
writeback will hit ENOSPC instead, and if we do, the test will hang
forever while xfs retries the write.  Make sure we're set up to fail
fast so that we don't hang the test appliance.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/361 |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/361 b/tests/generic/361
index e28aaf46..403bbe41 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -54,6 +54,11 @@ mkdir -p $fs_mnt
 loop_dev=$(_create_loop_device $fs_img)
 _mkfs_dev $loop_dev
 _mount $loop_dev $fs_mnt
+if [ "$FSTYP" = "xfs" ]; then
+	# Turn off all XFS metadata IO error retries
+	dname=$(_short_dev $loop_dev)
+	echo 0 | tee /sys/fs/xfs/$dname/error/*/*/* > /dev/null
+fi
 $XFS_IO_PROG -fc "pwrite 0 520m" $fs_mnt/testfile >>$seqres.full 2>&1
 
 # remount should not hang
