Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D5FC33C99
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88169206DA
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 08:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgAGIpL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:45:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49261 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725801AbgAGIpL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 03:45:11 -0500
X-IronPort-AV: E=Sophos;i="5.69,405,1571673600"; 
   d="scan'208";a="81428037"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2020 16:45:08 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id D731C49E9334;
        Tue,  7 Jan 2020 16:36:09 +0800 (CST)
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 7 Jan 2020 16:45:08 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Tue, 7 Jan 2020 16:45:13 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <eguan@linux.alibaba.com>, <amir73il@gmail.com>
CC:     <fstests@vger.kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3 1/2] ltp/fsx.c: Add FALLOC_FL_KEEP_SIZE flag and '-K' option
Date:   Tue, 7 Jan 2020 16:40:52 +0800
Message-ID: <20200107084053.2889-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D731C49E9334.AAB81
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) Add FALLOC_FL_KEEP_SIZE flag for do_zero_range().
2) Add missing '-K' option to the usage of fsx.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 ltp/fsx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 00001117..997d3f37 100644
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
@@ -2223,7 +2223,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dknqxABEFJLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dknqxABEFJKLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -2273,6 +2273,9 @@ usage(void)
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



