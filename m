Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145AAC43216
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41CC61139
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 12:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbhIAMpu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:45:50 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:55673 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345382AbhIAMoL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Sep 2021 08:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1630500193; i=@fujitsu.com;
        bh=Yx5DF4YGDi7GHKTl+nj08huotXTgNPVIvZNDMLDbKGI=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=oUCoi6E/K8luFe/xCialtC6QQsf6D9ckUkgg8njHF1j+JPHX1ZGcot4DkBheUmVz5
         ahRtdp6vJiCJtuCBCmN7QyLUmXGtkstdipBXnqwjVE6qtg8ea7VijWrJsTCzlDB9QF
         ad2OGPtje7xD3PrsZ1PockjqGhuIHQzhp+EdZdSZGQaypr2dEmsUYNDJlqA0xDat+N
         ogFCPsjWduZXSd6WvKXbddRxKqvk9eU4M9Jw2OEiKja2V84m2Hw0he3ixJvYpQUO8u
         bSMD4ng/pRQ9w8z/keUuvELj0LApRWbCFikGNe8RUfEffE2IgRMtGItSvtAxUUryZp
         AhM3ki8Gf4HIQ==
Received: from [100.113.7.47] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id F9/95-15923-1657F216; Wed, 01 Sep 2021 12:43:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRWlGSWpSXmKPExsViZ8MRqptYqp9
  ocOW9vMXplr3sDowenzfJBTBGsWbmJeVXJLBmXJr/hb2gWahi9aG3bA2MvfxdjFwcQgIdTBI3
  dv5ng3B2M0rs7XzL2MXIycEmoCnxrHMBM4gtIiAr8X/GaiYQm1lAXWL5pF9gtrBAgkTr22NgN
  SwCKhJ7b+1gBbF5BTwlNr6/zAJiSwgoSEx5+B6shlPAS+L3qktgcSGgmolv/zJB1AtKnJz5hA
  VivoTEwRcvmCF6FSUudXxjhLArJGbNamOawMg/C0nLLCQtCxiZVjFaJhVlpmeU5CZm5ugaGhj
  oGhoa65rpGlqY6SVW6SbppZbqJqfmlRQlAmX1EsuL9Yorc5NzUvTyUks2MQIDMqWQbdcOxs+v
  P+gdYpTkYFIS5WWJ1E8U4kvKT6nMSCzOiC8qzUktPsQow8GhJMG7KwMoJ1iUmp5akZaZA4wOm
  LQEB4+SCO+SQqA0b3FBYm5xZjpE6hSjopQ477oSoIQASCKjNA+uDRaRlxhlpYR5GRkYGIR4Cl
  KLcjNLUOVfMYpzMCoJ884uBprCk5lXAjf9FdBiJqDFPD90QBaXJCKkpBqY8p4uVxbZqbDJxLb
  8Dvf89kdXU5pfTZAoWJ8qlZf8W0H/8reweTtvmL7s+HqDUfWEqfoEl3jBBz8mnnwiJ5W6oMs4
  d7OaGePmBeW+jI0WeeejgreE68a9LhOy+PGjefvs1+1vFmg4eWf92qixQJfp8z7WVW+PGgsHb
  fm5b57ExkM+U+z3z1QWPPo92HzS8T91vNtWb4o/omd1nFdU3Kh3G5f1VnGPrUWOtQXL/56JSe
  bt94xX2/5r9+dj7+J+HT3oY7hIe8XzjLu1f64f4RUvjP+98PK5lgXsU917pPXW27CcD6o+r3k
  hrvu5hiVrReFlx9oezxCxDUzTLh1U/p7gL75oY3TZ+eRtNz5Vc3c9UWIpzkg01GIuKk4EAJ2g
  j11DAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-238.messagelabs.com!1630500193!163502!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28062 invoked from network); 1 Sep 2021 12:43:13 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-10.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Sep 2021 12:43:13 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 181ChAfS006407
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Wed, 1 Sep 2021 13:43:13 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 1 Sep 2021 13:43:08 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 3/4] src/idmapped-mounts/idmapped-mounts.c: Use renameat instead of renameat2
Date:   Wed, 1 Sep 2021 20:43:25 +0800
Message-ID: <1630500206-15545-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630500206-15545-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1630500206-15545-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We don't add fallback for renameat2, so it build failed on old
kernel. So use renameat instead.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index e83f8b04..4230cb48 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -10433,9 +10433,9 @@ static int btrfs_subvolumes_fsids_unmapped(void)
 	}
 
 	/* try to rename a subvolume */
-	if (!renameat2(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
-		       BTRFS_SUBVOLUME1_RENAME, 0)) {
-		log_stderr("failure: renameat2");
+	if (!renameat(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
+		       BTRFS_SUBVOLUME1_RENAME)) {
+		log_stderr("failure: renameat");
 		goto out;
 	}
 	if (errno != EOVERFLOW) {
@@ -10552,9 +10552,9 @@ static int btrfs_subvolumes_fsids_unmapped_userns(void)
 			die("failure: errno");
 
 		/* try to rename a subvolume */
-		if (!renameat2(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
-					BTRFS_SUBVOLUME1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
+					BTRFS_SUBVOLUME1_RENAME))
+			die("failure: renameat");
 		if (errno != EOVERFLOW)
 			die("failure: errno");
 
@@ -10993,9 +10993,9 @@ static int btrfs_snapshots_fsids_unmapped(void)
 			die("failure: errno");
 
 		/* try to rename a directory */
-		if (!renameat2(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
-			       BTRFS_SUBVOLUME1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
+			       BTRFS_SUBVOLUME1_RENAME))
+			die("failure: renameat");
 		if (errno != EOVERFLOW)
 			die("failure: errno");
 
@@ -11174,9 +11174,9 @@ static int btrfs_snapshots_fsids_unmapped_userns(void)
 			die("failure: errno");
 
 		/* try to rename a directory */
-		if (!renameat2(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
-			       BTRFS_SUBVOLUME1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(open_tree_fd, BTRFS_SUBVOLUME1, open_tree_fd,
+			       BTRFS_SUBVOLUME1_RENAME))
+			die("failure: renameat");
 		if (errno != EOVERFLOW)
 			die("failure: errno");
 
-- 
2.23.0

