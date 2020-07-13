Return-Path: <SRS0=IIXw=AY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD52AC433E5
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jul 2020 12:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A397E20738
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jul 2020 12:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgGMM0l (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:26:41 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:39752 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgGMM0k (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Jul 2020 08:26:40 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06DCNd8O049646;
        Mon, 13 Jul 2020 15:26:36 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 32713ua1fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 15:26:36 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Jul
 2020 15:26:36 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] generic: assign a number of tests to attr group
Date:   Mon, 13 Jul 2020 15:26:28 +0300
Message-ID: <20200713122628.16781-1-vladimir@tuxera.com>
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

A few generic tests have a _require_attrs runtime check for support
of extended file attributes by a tested filesystem, review shows that
the tests listed below are definitely using extended file attributes,
thus this implies that the tested filesystem should provide support of
the feature in general.

Adding the tests explicitly to attr group of tests allows to get a better
granularity of selecting or deselecting tests by groups in accordance to
extended file attributes feature given by a filesystem, the change affects
the next list of tests:

  * generic/037
  * generic/066
  * generic/103
  * generic/337
  * generic/449

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/group | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index 3d7effe6d72a..a09c81a09abc 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -39,7 +39,7 @@
 034 auto quick metadata log
 035 auto quick
 036 auto aio rw stress
-037 metadata auto quick
+037 auto quick attr metadata
 038 auto stress
 039 metadata auto quick log
 040 metadata auto quick log
@@ -68,7 +68,7 @@
 063 auto quick prealloc punch insert
 064 auto quick prealloc collapse insert
 065 metadata auto quick log
-066 metadata auto quick log
+066 auto quick attr metadata log
 067 auto quick mount
 068 other auto freeze stress
 069 rw udf auto quick
@@ -105,7 +105,7 @@
 100 udf auto
 101 auto quick metadata log
 102 auto rw
-103 auto enospc quick
+103 auto quick attr enospc
 104 auto quick metadata log
 105 acl auto quick
 106 auto quick metadata log
@@ -339,7 +339,7 @@
 334 auto clone
 335 auto quick metadata log
 336 auto quick metadata log
-337 auto quick metadata
+337 auto quick attr metadata
 338 auto quick rw eio
 339 auto dir
 340 auto
@@ -451,7 +451,7 @@
 446 auto quick rw punch
 447 auto clone
 448 auto quick rw seek
-449 auto quick acl enospc
+449 auto quick acl attr enospc
 450 auto quick rw
 451 auto quick rw aio
 452 auto quick dax
-- 
2.25.1

