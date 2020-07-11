Return-Path: <SRS0=Xm4W=AW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F459C433E0
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Jul 2020 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49D220725
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Jul 2020 09:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgGKJXc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 11 Jul 2020 05:23:32 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:58760 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgGKJXc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 11 Jul 2020 05:23:32 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06B9NSQq042579;
        Sat, 11 Jul 2020 12:23:28 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 32713u88r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 11 Jul 2020 12:23:28 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Jul
 2020 12:23:27 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] generic: reorder output to stderr and stdout from _scratch_mkfs
Date:   Sat, 11 Jul 2020 12:23:19 +0300
Message-ID: <20200711092319.14441-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-11_06:2020-07-10,2020-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 mlxlogscore=986 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007110071
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The change fixes false positives from generic/554 and generic/565 tests,
when supplementary output of an mkfs utility to stderr apprears to be mixed
into the test output, which results into non-empty diff with the expected
output found in *.out files.

The change unifies _scratch_mkfs redirections among all generic tests, these
two modified tests are the only ones with the swapped order of output
redirections.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/554 | 2 +-
 tests/generic/565 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/554 b/tests/generic/554
index eaf1f45a8d15..9a23c0eb729f 100755
--- a/tests/generic/554
+++ b/tests/generic/554
@@ -38,7 +38,7 @@ _require_scratch
 _require_xfs_io_command "copy_range"
 _require_scratch_swapfile
 
-_scratch_mkfs 2>&1 >> $seqres.full
+_scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
 rm -f $seqres.full
diff --git a/tests/generic/565 b/tests/generic/565
index 41d85b919553..e23e97b763f8 100755
--- a/tests/generic/565
+++ b/tests/generic/565
@@ -38,7 +38,7 @@ _require_test
 _require_scratch
 _require_xfs_io_command "copy_range"
 
-_scratch_mkfs 2>&1 >> $seqres.full
+_scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
 
-- 
2.25.1

