Return-Path: <SRS0=EflN=2H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7FAC43603
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Dec 2019 05:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71421739
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Dec 2019 05:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfLQFU1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:20:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19317 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbfLQFU1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Dec 2019 00:20:27 -0500
X-IronPort-AV: E=Sophos;i="5.69,324,1571673600"; 
   d="scan'208";a="80398604"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Dec 2019 13:20:23 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 8114D4B6EC71;
        Tue, 17 Dec 2019 13:11:40 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 17 Dec 2019 13:20:19 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <jack@suse.cz>, <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/386: get right field in df command
Date:   Tue, 17 Dec 2019 13:20:51 +0800
Message-ID: <1576560051-31851-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 8114D4B6EC71.AD3B2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since xfstests commit 5568077041bb ("generic/386: Fix _filter_quota_rpt"),
this case outputs things. And it fails on ext4 as below:

--------------------------
QA output created by 386
Silence is golden.
hard limit 524283904 bytes, expected 524288000
hard limit 500 bytes, expected 524288000
--------------------------

the df command doesn't get expected output, origial output as below:
--------------------------
for df:
Filesystem           1K-blocks       Used  Available  Use% Pathname
/dev/sda11            20511312      45108   20466204    0% /mnt/xfstests/scratch
/dev/sda11              512000          4     511996    0% /mnt/xfstests/scratch/test
for df -h command:
Filesystem     Size   Used  Avail Use% Pathname
/dev/sda11    19.6G  44.1M  19.5G   0% /mnt/xfstests/scratch
/dev/sda11     500M     4K 500.0M   0% /mnt/xfstests/scratch/test
--------------------------

It fails because ext4 project quota hides on common inode instead of superblock
inode, so it has used 1 block. Also, the "df -h" fails because byte_size() only
can parse integer value correctly. So, I think we can get size/1k-blocks instead
of Avail/Available field in this case.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/386 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/386 b/tests/generic/386
index 0c44c80e..a39621e7 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -63,7 +63,7 @@ _require_scratch
 # interested in contains our project name in the first field.  For "df"
 # it contains our project directory in the last field.
 # But if the device name is too long, the "df" output is broke into two
-# lines, the fourth field is not correct, so take $(NF-2) of "df"
+# lines, the second field is not correct, so take $(NF-4) of "df".
 _filter_quota_rpt() {
 	awk '
 	BEGIN {
@@ -89,7 +89,7 @@ _filter_quota_rpt() {
 			bsize = byte_size($4);
 		} else if ($NF ~ proj_dir) {
 			# this is the "df" output
-			bsize = byte_size($(NF-2));
+			bsize = byte_size($(NF-4));
 		} else {
 			next;
 		}
-- 
2.18.0



