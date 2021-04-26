Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE5C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 05:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC724611AB
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 05:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhDZFXb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 01:23:31 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:42979 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231575AbhDZFXb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 01:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1619414569; i=@fujitsu.com;
        bh=xi/WKijGeJ1hyRZN7TMhtETqm8aoqzVYnAEnAXUIDO4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=WS2gSLzM3U0w9v/pAab1aEj/GTPMpuy+7zJM985p+Inqdq2x1i/iGJ1Lm/4UsMDuU
         8d2+sM5ddkCEgnmdubvsmwoLxsJBYvtPkOSUl+1dN/pLRSsk3mALmi1k7fDf+2dY/Z
         BLX4ZN8WiMp/cGCBEfxQ+cbqaDvfUI0sKuybziWJOUOivCBS9E3JGTE6u3teL9GV1G
         wxVG/fA0thVZBHO/4DWJpZOr+E0cwbqzqXgC84U/LyEL3AAMMG2Tmt+xnSVosykt8B
         t57MxIY8ATTUVnTwM375R4ivPjex7Go1nc7JENTxAAuuhHCAy+z/d81G/8kRIXkNhU
         JY9fvn4U5yuSA==
Received: from [100.113.6.193] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 6C/FE-23163-92E46806; Mon, 26 Apr 2021 05:22:49 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRWlGSWpSXmKPExsViZ8MxRVfDry3
  BYOZXHYvTLXvZHRg9Pm+SC2CMYs3MS8qvSGDNmPSrla3gYU3Fh+WzGRsYt2Z2MXJyCAl0Mkks
  fxTZxcgFZO9mlFg//RULSIJNQFPiWecCZhBbREBW4v+M1UwgNrOAusTySb/AbGEBH4lLC/vAb
  BYBVYmVb9awgdi8Ap4S5/q6WEFsCQEFiSkP34PN4RTwkmg5u5gNYrGnxKtJe5kh6gUlTs58wg
  IxX0Li4IsXzBC9ihKXOr4xQtiVEp3rFzBOYOSfhaRlFpKWBYxMqxgtk4oy0zNKchMzc3QNDQx
  0DQ2NdU11jUwM9RKrdJP0Ukt1k1PzSooSgbJ6ieXFesWVuck5KXp5qSWbGIHhmFLI+nEH46HX
  H/QOMUpyMCmJ8jYwtiYI8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuC95NOWICRYlJqeWpGWmQOMD
  Zi0BAePkgjvI1egNG9xQWJucWY6ROoUo6KUOO92X6CEAEgiozQPrg0Wj5cYZaWEeRkZGBiEeA
  pSi3IzS1DlXzGKczAqCfO2g2znycwrgZv+CmgxE9BivrpWkMUliQgpqQYmef+mTSysJ0pZthU
  lccz1ERPnVeFKzJ5Q3/uP5/LMfs3762s21SmdemfusFJripvZS/kIAXVJ0clh/y257/6/Lc6h
  d5erL6/6+u7G98rVNt3sE9f0ij7uCjYtq9rR1NOSlFjT/2yaSMQLz/vazsemC/a5m83tUdZaF
  3S+T5XtW+CxeN7NPlUcrOyLNs+c4hTN+2IT/9WF0+7xfWbjK/m58sKBhdcer/KcLHVnZ9C/b/
  piGdfl8wS/7Ml5El//8ouu0L3SlUdT1nJXqV7wPpvOWGm0g3E/88em9Yu9rp5YceiO+f0uXrV
  wBr3s1/5b9W6kv/vI5Z8Y45sxedW2o3o3vz+3fqMYs+1toJvNLBclluKMREMt5qLiRADCemWp
  QgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-248.messagelabs.com!1619414568!822294!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15492 invoked from network); 26 Apr 2021 05:22:48 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-13.tower-248.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2021 05:22:48 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13Q5Mgwt016133
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 06:22:47 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 06:22:43 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 2/3] idmapped-mounts.c: Use renameat instead of renameat2
Date:   Mon, 26 Apr 2021 14:23:06 +0800
Message-ID: <1619418187-19951-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We don't add fallback for renameat2, so it build failed on old kernel.
Also, renameat2() man-pages said as below:
"renameat2() has an additional flags argument.  A renameat2() call with
a zero flags argument is equivalent to renameat()."

In this src file, it uses zero flag for all renameat2 call. So we can use
renameat directly.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 222 +++++++++++++-------------
 1 file changed, 111 insertions(+), 111 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 870a8fe7..1a02953d 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -874,8 +874,8 @@ static int fsids_unmapped(void)
 	}
 
 	/* try to rename a file */
-	if (!renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0)) {
-		log_stderr("failure: renameat2");
+	if (!renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME)) {
+		log_stderr("failure: renameat");
 		goto out;
 	}
 	if (errno != EOVERFLOW) {
@@ -884,8 +884,8 @@ static int fsids_unmapped(void)
 	}
 
 	/* try to rename a directory */
-	if (!renameat2(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME, 0)) {
-		log_stderr("failure: renameat2");
+	if (!renameat(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME)) {
+		log_stderr("failure: renameat");
 		goto out;
 	}
 	if (errno != EOVERFLOW) {
@@ -1048,11 +1048,11 @@ static int fsids_mapped(void)
 			die("failure: create hardlink");
 
 		/* try to rename a file */
-		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+		if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
 			die("failure: rename");
 
 		/* try to rename a directory */
-		if (renameat2(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME, 0))
+		if (renameat(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME))
 			die("failure: rename");
 
 		/* remove file */
@@ -1183,14 +1183,14 @@ static int create_in_userns(void)
 			die("failure: check ownership");
 
 		/* try to rename a file */
-		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+		if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
 			die("failure: create");
 
 		if (!expected_uid_gid(open_tree_fd, FILE1_RENAME, 0, 0, 0))
 			die("failure: check ownership");
 
 		/* try to rename a file */
-		if (renameat2(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME, 0))
+		if (renameat(open_tree_fd, DIR1, open_tree_fd, DIR1_RENAME))
 			die("failure: create");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1_RENAME, 0, 0, 0))
@@ -1558,8 +1558,8 @@ static int rename_crossing_mounts(void)
 	 * interested in making sure we're not introducing an accidental way to
 	 * violate that restriction or that suddenly this becomes possible.
 	 */
-	if (!renameat2(open_tree_fd, FILE1, t_dir1_fd, FILE1_RENAME, 0)) {
-		log_stderr("failure: renameat2");
+	if (!renameat(open_tree_fd, FILE1, t_dir1_fd, FILE1_RENAME)) {
+		log_stderr("failure: renameat");
 		goto out;
 	}
 	if (errno != EXDEV) {
@@ -1654,8 +1654,8 @@ static int rename_crossing_idmapped_mounts(void)
 	 * interested in making sure we're not introducing an accidental way to
 	 * violate that restriction or that suddenly this becomes possible.
 	 */
-	if (!renameat2(open_tree_fd1, FILE1, open_tree_fd2, FILE1_RENAME, 0)) {
-		log_stderr("failure: renameat2");
+	if (!renameat(open_tree_fd1, FILE1, open_tree_fd2, FILE1_RENAME)) {
+		log_stderr("failure: renameat");
 		goto out;
 	}
 	if (errno != EXDEV) {
@@ -1726,8 +1726,8 @@ static int rename_from_idmapped_mount(void)
 	}
 
 	/* We're not crossing a mountpoint so this must succeed. */
-	if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0)) {
-		log_stderr("failure: renameat2");
+	if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME)) {
+		log_stderr("failure: renameat");
 		goto out;
 	}
 
@@ -1794,7 +1794,7 @@ static int rename_from_idmapped_mount_in_userns(void)
 			die("failure: check ownership");
 
 		/* We're not crossing a mountpoint so this must succeed. */
-		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
+		if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
 			die("failure: create");
 
 		if (!expected_uid_gid(open_tree_fd, FILE1_RENAME, 0, 0, 0))
@@ -5157,17 +5157,17 @@ static int sticky_bit_rename(void)
 		if (!switch_ids(1000, 1000))
 			die("failure: switch_ids");
 
-		if (renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE1, dir_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE2, dir_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE1_RENAME, dir_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE2_RENAME, dir_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
@@ -5200,13 +5200,13 @@ static int sticky_bit_rename(void)
 		if (!switch_ids(1000, 1000))
 			die("failure: switch_ids");
 
-		if (!renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(dir_fd, FILE1, dir_fd, FILE1_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
-		if (!renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(dir_fd, FILE2, dir_fd, FILE2_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
@@ -5239,17 +5239,17 @@ static int sticky_bit_rename(void)
 		if (!switch_ids(1000, 1000))
 			die("failure: switch_ids");
 
-		if (renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE1, dir_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE2, dir_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE1_RENAME, dir_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE2_RENAME, dir_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
@@ -5286,17 +5286,17 @@ static int sticky_bit_rename(void)
 		if (!switch_ids(1000, 1000))
 			die("failure: switch_ids");
 
-		if (renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE1, dir_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE2, dir_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE1_RENAME, dir_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE2_RENAME, dir_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
@@ -5410,17 +5410,17 @@ static int sticky_bit_rename_idmapped_mounts(void)
 		if (!switch_ids(1000, 1000))
 			die("failure: switch_ids");
 
-		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
@@ -5453,13 +5453,13 @@ static int sticky_bit_rename_idmapped_mounts(void)
 		if (!switch_ids(1000, 1000))
 			die("failure: switch_ids");
 
-		if (!renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
-		if (!renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
@@ -5492,17 +5492,17 @@ static int sticky_bit_rename_idmapped_mounts(void)
 		if (!switch_ids(1000, 1000))
 			die("failure: switch_ids");
 
-		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
@@ -5538,17 +5538,17 @@ static int sticky_bit_rename_idmapped_mounts(void)
 		if (!switch_ids(1000, 1000))
 			die("failure: switch_ids");
 
-		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
@@ -5670,17 +5670,17 @@ static int sticky_bit_rename_idmapped_mounts_in_userns(void)
 		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
 			die("failure: switch_userns");
 
-		if (renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE1, dir_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE2, dir_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE1_RENAME, dir_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(dir_fd, FILE2_RENAME, dir_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
@@ -5718,23 +5718,23 @@ static int sticky_bit_rename_idmapped_mounts_in_userns(void)
 		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
 			die("failure: switch_userns");
 
-		if (!renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(dir_fd, FILE1, dir_fd, FILE1_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
-		if (!renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(dir_fd, FILE2, dir_fd, FILE2_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
-		if (!renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
-		if (!renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
@@ -5772,27 +5772,27 @@ static int sticky_bit_rename_idmapped_mounts_in_userns(void)
 		if (!switch_userns(attr.userns_fd, 1000, 1000, true))
 			die("failure: switch_userns");
 
-		if (!renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(dir_fd, FILE1, dir_fd, FILE1_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
-		if (!renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(dir_fd, FILE2, dir_fd, FILE2_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
-		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
@@ -5834,28 +5834,28 @@ static int sticky_bit_rename_idmapped_mounts_in_userns(void)
 			die("failure: switch_userns");
 
 		/* we don't own the directory from the original mount */
-		if (!renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(dir_fd, FILE1, dir_fd, FILE1_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
-		if (!renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (!renameat(dir_fd, FILE2, dir_fd, FILE2_RENAME))
+			die("failure: renameat");
 		if (errno != EPERM)
 			die("failure: errno");
 
 		/* we own the file from the idmapped mount */
-		if (renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1))
+			die("failure: renameat");
 
-		if (renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0))
-			die("failure: renameat2");
+		if (renameat(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2))
+			die("failure: renameat");
 
 		exit(EXIT_SUCCESS);
 	}
-- 
2.23.0

