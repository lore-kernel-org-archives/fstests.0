Return-Path: <SRS0=IIXw=AY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE70C433E3
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jul 2020 12:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B5720738
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jul 2020 12:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgGMM06 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:26:58 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:39770 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbgGMM05 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Jul 2020 08:26:57 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06DCNd2v049641;
        Mon, 13 Jul 2020 15:26:55 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 32713ua1g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 15:26:54 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Jul
 2020 15:26:54 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] generic/079: remove assignment of the test to acl and attr groups
Date:   Mon, 13 Jul 2020 15:26:48 +0300
Message-ID: <20200713122648.16837-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_11:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130092
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test does not belong to acl group of tests, and expectedly the test
is supposed to pass on a filesystem which supports file attributes but
not ACLs.

In addition the test should be removed from attr group of tests, because
the attr group specifies tests which operate over extended file attributes,
this test does not fall into this category.

The change is intended to improve the assignment of tests to groups
to get better testing coverage, if a list of run tests is selected by
test group attributes.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index d9ab9a31f2ed..3d7effe6d72a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -81,7 +81,7 @@
 076 metadata rw udf auto quick stress
 077 acl attr auto enospc
 078 auto quick metadata
-079 acl attr ioctl metadata auto quick
+079 auto quick ioctl metadata
 080 auto quick
 081 auto quick
 082 auto quick quota
-- 
2.25.1

