Return-Path: <SRS0=A77W=2N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8993FC2D0C0
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D49C206B7
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 10:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLWKVE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:21:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1998 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726664AbfLWKVE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Dec 2019 05:21:04 -0500
X-IronPort-AV: E=Sophos;i="5.69,347,1571673600"; 
   d="scan'208";a="80639727"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Dec 2019 18:21:01 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id E04974CE1C97;
        Mon, 23 Dec 2019 18:12:13 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 23 Dec 2019 18:21:01 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fdmanana@gmail.com>
CC:     <darrick.wong@oracle.com>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2] generic/520: Remove sync in clean_dir
Date:   Mon, 23 Dec 2019 18:21:39 +0800
Message-ID: <1577096499-23471-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: E04974CE1C97.AE529
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

It fails because somethings is still using the fs when we call sync and then
try to unmount it. We can simply remove sync as the unmount is supposed to
persist the file/directory removals.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/520 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/520 b/tests/generic/520
index 167d7077..d4457370 100755
--- a/tests/generic/520
+++ b/tests/generic/520
@@ -58,7 +58,6 @@ clean_dir()
 {
 	_mount_flakey
 	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
-	sync
 	_unmount_flakey
 }
 
-- 
2.18.0



