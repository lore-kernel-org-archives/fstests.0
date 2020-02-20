Return-Path: <SRS0=97QR=4I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93108C11D00
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 07:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642BC24656
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 07:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgBTH6U (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:58:20 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45673 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbgBTH6U (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Feb 2020 02:58:20 -0500
X-IronPort-AV: E=Sophos;i="5.70,463,1574092800"; 
   d="scan'208";a="83614279"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Feb 2020 15:58:14 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 11A3150A997E;
        Thu, 20 Feb 2020 15:48:36 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 20 Feb 2020 15:58:14 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 20 Feb 2020 15:58:12 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2 1/2] xfs/029: filter out "extended-header: cycle: 1" from output
Date:   Thu, 20 Feb 2020 15:58:47 +0800
Message-ID: <1582185528-8173-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20200219220935.GD9511@magnolia>
References: <20200219220935.GD9511@magnolia>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 11A3150A997E.AD6ED
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I test this case(default lsunit 256k), this case will fail,
as below:
cycle: 1        version: 2              lsn: 1,0        tail_lsn: 1,0
length of Log Record: 258048    prev offset: -1         num ops: 1

...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extended-header: cycle: 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
...

It reports this info because xfs_logprint only read 32k header every time, so it
needs to read more times. We can filter this useless info.

common/log also has _filter_logprint function. only library function is
prefixed with "_", remove '_'.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/xfs/029 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/029 b/tests/xfs/029
index f532a21b..dbe700ab 100755
--- a/tests/xfs/029
+++ b/tests/xfs/029
@@ -19,7 +19,7 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 . ./common/rc
 . ./common/filter
 
-_filter_logprint()
+filter_logprint()
 {
 	perl -ne '
 	    s/data device: ([\w|\/.-]+)/data device: DDEV/;
@@ -31,6 +31,8 @@ _filter_logprint()
             s/(length of Log Record:) \d+/$1 <LEN>/;
             s/version: \d/version: <VERN>/;
 	    s/h_size: \d+/h_size: <H_SIZE>/;
+	    s/^~+[\r|\n]+$//;
+	    s/extended-header: cycle: 1[\r|\n]+$//;
 	    print;
 	'
 }
@@ -45,7 +47,7 @@ echo
 _scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
 
 echo
-_scratch_xfs_logprint | _filter_logprint
+_scratch_xfs_logprint | filter_logprint
 
 status=0
 exit
-- 
2.18.0



