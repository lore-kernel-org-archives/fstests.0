Return-Path: <SRS0=97QR=4I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D78BC11D02
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 07:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEDE24656
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 07:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgBTH6m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:58:42 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45684 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbgBTH6m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Feb 2020 02:58:42 -0500
X-IronPort-AV: E=Sophos;i="5.70,463,1574092800"; 
   d="scan'208";a="83614305"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Feb 2020 15:58:39 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 6ECBF50A997A;
        Thu, 20 Feb 2020 15:48:58 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 20 Feb 2020 15:58:37 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 20 Feb 2020 15:58:35 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2 2/2] xfs/044: Remove useless _filter_logprint
Date:   Thu, 20 Feb 2020 15:58:48 +0800
Message-ID: <1582185528-8173-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582185528-8173-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200219220935.GD9511@magnolia>
 <1582185528-8173-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 6ECBF50A997A.AFAEF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs/044 has customized  _filter_logprint function, but it was never
used. So remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/xfs/044 | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tests/xfs/044 b/tests/xfs/044
index 4a476985..0c6a421d 100755
--- a/tests/xfs/044
+++ b/tests/xfs/044
@@ -25,18 +25,6 @@ _supported_os Linux
 
 _require_logdev
 
-_filter_logprint()
-{
-	perl -ne '
-	    s/data device: ([\w|\/.-]+)/data device: DDEV/;
-	    s/log device: ([\w|\/.-]+) daddr: (\d+) length: (\d+)/log device: LDEV daddr: XXX length: XXX/;
-	    s/log file: "([\w|\/.-]+)" daddr: (\d+) length: (\d+)/log device: LDEV daddr: XXX length: XXX/;
-	    s/uuid: ([abcdef\d-]+)\s+format: (.+)/uuid: UUID format: FORMAT/;
-	    s/skipped (\w+) zeroed blocks/skipped XXX zeroed blocks/;
-	    print;
-	'
-}
-
 _check_mount()
 {
     echo "    *** mount (expect success)"
-- 
2.18.0



