Return-Path: <SRS0=uevG=2D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAAEC43603
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Dec 2019 05:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBC422527
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Dec 2019 05:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfLMFpa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:45:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59984 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732085AbfLMFpa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Dec 2019 00:45:30 -0500
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="80196223"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Dec 2019 13:45:26 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id AAA504CE1C91
        for <fstests@vger.kernel.org>; Fri, 13 Dec 2019 13:36:47 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 13 Dec 2019 13:45:23 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/520: use fsync instead of sync during clean_dir
Date:   Fri, 13 Dec 2019 13:45:41 +0800
Message-ID: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: AAA504CE1C91.AD9E5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I test this case on xfs, it may fail as below:
--------------------------------------------
 === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
+umount: /mnt/xfstests/scratch: target is busy.
+        (In some cases useful info about processes that use
+         the device is found by lsof(8) or fuser(1))
---------------------------------------------

I think we don't need to sync all fs and fsync SCRATCH_MNT is enough.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/520 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/520 b/tests/generic/520
index 167d7077..a16467ca 100755
--- a/tests/generic/520
+++ b/tests/generic/520
@@ -58,7 +58,7 @@ clean_dir()
 {
 	_mount_flakey
 	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
-	sync
+	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT
 	_unmount_flakey
 }
 
-- 
2.18.0



