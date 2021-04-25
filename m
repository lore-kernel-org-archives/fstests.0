Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1972EC433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E092C6113D
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 09:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDYJDh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Apr 2021 05:03:37 -0400
Received: from mail3.bemta25.messagelabs.com ([195.245.230.83]:11491 "EHLO
        mail3.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhDYJDg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Apr 2021 05:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1619341376; i=@fujitsu.com;
        bh=JC4J5QdKpx83bSqvjxKNQxDcgd3A71MVQyEhTIciRIE=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=N0dm2QjoBxWeplnSL3YgFP5EDexohj68hpGuMVNpQYjFnZjYRJPeOmmlQmgkHxZWJ
         xfaEyGUglG/iL8iH1SeN7SiT2aubBoK6mU3T4KnS+QPqBsZ3TH29FgdXKxhWc/4LKO
         npDVk48jOF9XaU7l9j5Fa+DSL+0Oqynzn5S/mNSg96+hopNKyFYM3rZRo3jRQxruG7
         GocuFMm3pZ3HQ1z00DXWrZEXX0TIYiiTYq/FfBUBQHQgzsfu0VHl+yudG7ldoJ1kn6
         dfGl91Tdo8wru0zikxyCNdYcNcaUb3xzf/GaI5um4VkRhDWSYJUMEE3N2q4WM0xto1
         UFAQ5I1LiR2mQ==
Received: from [100.112.199.60] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id C4/7C-55620-04035806; Sun, 25 Apr 2021 09:02:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRWlGSWpSXmKPExsViZ8MxRdfeoDX
  BYNNrU4vTLXvZHRg9Pm+SC2CMYs3MS8qvSGDN+LnmBGvBnZqKSStesjcwbszsYuTiEBLoZJJo
  /3KIHcLZzSgxaekG1i5GTg42AU2JZ50LmEFsEQFZif8zVjOB2MwC6hLLJ/0Cs4UFPCU2PZ4BZ
  rMIqErM2LKVBcTmFfCQaLn7hR3ElhBQkJjy8D3YHE6g+h/PtoHNFwKqWTbzPxNEvaDEyZlPWC
  DmS0gcfPGCGaJXUeJSxzdGCLtSonP9AsYJjPyzkLTMQtKygJFpFaN5UlFmekZJbmJmjq6hgYG
  uoaGRrqGlma6ZiV5ilW6SXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZGYDCmFBxx2MF4//UH
  vUOMkhxMSqK8DYytCUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeG30gXKCRanpqRVpmTnAyIBJS
  3DwKInwvtMDSvMWFyTmFmemQ6ROMSpKifNeB0kIgCQySvPg2mDReIlRVkqYl5GBgUGIpyC1KD
  ezBFX+FaM4B6OSMK8lyHaezLwSuOmvgBYzAS3e3dkIsrgkESEl1cBkGiEh1/eCd3aNSvrc9VI
  qE6ripMtdftzTjjwsEyNXGvhU0czbk3l9WrgGG0P9d2HZSRmTYiev+anIteePkuWnWTFi09mF
  /703/MvP5RP8ZaZOgKMauyT7FI6FaTc+eG67wmqlmnZo+/uJUx/MXt/ylWOJ81LxBYKd5j8j/
  218Na93+7RVNudP/VniL87gvHXuV8vK92LKn+993sdQoLNf+9fkQzKRB90tRWyu8IccjVu58/
  W1468P3Mnh+j7VzuJuz+qNeSr6Qe83Cx//yLZPhXG7sk/XjtAiaS0tz+tezV9viu8QE6zqO2B
  6V3mB7/otaWt2LrU4UCNRwnSTN+5/4g05/bm/5l+a26vGdTRFiaU4I9FQi7moOBEAgqVjS0ED
  AAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-18.tower-285.messagelabs.com!1619341375!1859441!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1624 invoked from network); 25 Apr 2021 09:02:55 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-18.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2021 09:02:55 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13P92l8J019512
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Sun, 25 Apr 2021 10:02:55 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sun, 25 Apr 2021 10:02:50 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 2/2] idmapped-mounts.c: Use renameat instead of renameat2
Date:   Sun, 25 Apr 2021 18:02:39 +0800
Message-ID: <1619344959-3672-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619344959-3672-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1619344959-3672-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

In this src file, we use zero flag for all renameat2 call. So we use
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

