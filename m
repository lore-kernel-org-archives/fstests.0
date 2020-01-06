Return-Path: <SRS0=Klg3=23=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6085AC32771
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 06:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0A221775
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 06:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgAFG46 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:56:58 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55510 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726294AbgAFG46 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jan 2020 01:56:58 -0500
X-IronPort-AV: E=Sophos;i="5.69,401,1571673600"; 
   d="scan'208";a="81351642"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Jan 2020 14:56:56 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 97F8E49E932A;
        Mon,  6 Jan 2020 14:47:58 +0800 (CST)
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 6 Jan 2020 14:56:55 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Mon, 6 Jan 2020 14:57:07 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <eguan@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 1/2] ltp/fsx.c: Add FALLOC_FL_KEEP_SIZE flag and '-K' option
Date:   Mon, 6 Jan 2020 14:52:37 +0800
Message-ID: <20200106065238.12884-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 97F8E49E932A.ABE83
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) Add FALLOC_FL_KEEP_SIZE flag for do_zero_range().
2) Add '-K' option to the usage of fsx.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 ltp/fsx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 06d08e4e..11465e62 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1197,7 +1197,7 @@ void
 do_zero_range(unsigned offset, unsigned length, int keep_size)
 {
 	unsigned end_offset;
-	int mode = FALLOC_FL_ZERO_RANGE;
+	int mode = keep_size ? FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE : FALLOC_FL_ZERO_RANGE;
 
 	if (length == 0) {
 		if (!quiet && testcalls > simulatedopcount)
@@ -2215,7 +2215,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dknqxABEFJLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dknqxABEFJKLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -2265,6 +2265,9 @@ usage(void)
 #ifdef HAVE_COPY_FILE_RANGE
 "	-E: Do not use copy range calls\n"
 #endif
+#ifdef FALLOC_FL_KEEP_SIZE
+"	-K: Do not use keep size calls\n"
+#endif
 "	-L: fsxLite - no file creations & no file size changes\n\
 	-N numops: total # operations to do (default infinity)\n\
 	-O: use oplen (see -o flag) for every op (default random)\n\
-- 
2.21.0



