Return-Path: <SRS0=4lTT=4F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4B1C35242
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 07:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4196420679
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 07:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgBQHCA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:02:00 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9052 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbgBQHB7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Feb 2020 02:01:59 -0500
X-IronPort-AV: E=Sophos;i="5.70,451,1574092800"; 
   d="scan'208";a="83433974"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Feb 2020 15:01:53 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id EBCD949DF142
        for <fstests@vger.kernel.org>; Mon, 17 Feb 2020 14:52:17 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 17 Feb 2020 15:01:55 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 17 Feb 2020 15:01:54 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/029: filter out "extended-header: cycle: 1" from output
Date:   Mon, 17 Feb 2020 15:02:20 +0800
Message-ID: <1581922940-14074-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: EBCD949DF142.AF537
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I test this case under GPT disklabel type, this case will fail,
as below:
cycle: 1        version: 2              lsn: 1,0        tail_lsn: 1,0
length of Log Record: 258048    prev offset: -1         num ops: 1

...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extended-header: cycle: 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
...

my mkfs information as below:
meta-data=/dev/sda7              isize=512    agcount=16, agsize=327680 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1
data     =                       bsize=4096   blocks=5242880, imaxpct=25
         =                       sunit=64     swidth=64 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=5184, version=2
         =                       sectsz=512   sunit=64 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

It reports this info because xfs_logprint only read 32k header every time, so it
needs to read more times. We can filter this useless info.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/xfs/029 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/029 b/tests/xfs/029
index f532a21b..99742792 100755
--- a/tests/xfs/029
+++ b/tests/xfs/029
@@ -45,7 +45,7 @@ echo
 _scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
 
 echo
-_scratch_xfs_logprint | _filter_logprint
+_scratch_xfs_logprint | _filter_logprint | sed -e "/^~~~/d" -e "/extended-header/d"
 
 status=0
 exit
-- 
2.18.0



