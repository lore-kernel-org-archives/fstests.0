Return-Path: <SRS0=vVM5=AU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61945C433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3201A20720
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 15:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xo7Et9K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGIPhD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:37:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgGIPhC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jul 2020 11:37:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069FWSdP098269;
        Thu, 9 Jul 2020 15:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ZgaHThoeXWZWGxOFXXr2/oeS2uoXk8zvy7H3dcQkR5k=;
 b=Xo7Et9K6YI3RK95qxpHPmpk4Yshc3gDUmCQaXTDBVAo5x/U7kat71+H+MFdyaPUA4Kic
 mSf0QSULPselwIlkR2FNWUhOu9ud/K9YJSh5C5NqhnIjSSrSh0CkQMxA7PFQFCCECw6F
 QEpeU+sp9cZtp2vg9+GTsS4oQynI1sb4MZXAQBqmwSTN14Py+aVDmksxItNAO4O96riO
 12BVGMmXdGNrn07+sndJIGuk6d1pkdWR9o7nbgk/DNBl2efWfLqaIRiZ3gMiuCLcbIOY
 Bhe2iMbf5pqeeauGO5fQR0iMZqVqbHPusg31T44xOUikrDwoZC/J/1wNF/FFhAs6snn+ bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 325y0ajcuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 15:36:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069FJKRZ053883;
        Thu, 9 Jul 2020 15:36:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 325k3h4g97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 15:36:58 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 069Favkd026136;
        Thu, 9 Jul 2020 15:36:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 08:36:56 -0700
Date:   Thu, 9 Jul 2020 08:36:55 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>,
        "Bill O'Donnell" <billodo@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: [PATCH] xfs/518: require scratch device
Message-ID: <20200709153655.GG7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=1 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090113
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

This test requires the scratch device, so we need to test for it.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/518 |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/518 b/tests/xfs/518
index 14457978..da39d8dc 100755
--- a/tests/xfs/518
+++ b/tests/xfs/518
@@ -30,6 +30,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs xfs
 _supported_os Linux
+_require_scratch
 _require_quota
 
 rm -f $seqres.full
