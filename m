Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A7DC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jan 2022 14:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiAGO6g (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 09:58:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45738 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347934AbiAGO6c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 09:58:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6BDDB8265C
        for <fstests@vger.kernel.org>; Fri,  7 Jan 2022 14:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208B5C36AEB;
        Fri,  7 Jan 2022 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641567510;
        bh=+im/UKgTLrAy3fEKhG0H6CyKiWB0+pSbQcE1/3MDqpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpHuTm+3AwtJP8Jl7BaYntWTBUmX894Y1MifU4mr6L349Ibxb/3KI2HzqSwk/Jea1
         n6r48cr1nV43eNVMkrVTN9c8nO5Axtl3+V5G+gD144wQchrSU9mS/AB9QXKE8nD4ad
         NdJkfm/ygNCgFPxPgF5eR2m6kMPuEos3KPh8CFNUqN7/ISJKoUDi7j89Wqj1Uathfj
         ufNPHHQWuf9uIKKp5leUL7yp3ofUqXmkrAkjR+ld9Hd2ke25pRdVhbhAlTUT2ay5Rj
         AwhOzqyaW1H4syggirsEWsPjHtbduwDAzSvylyn3gWyoTnHjP1eMwUFEB73QQSs0Yt
         ubL/8CXBi/+ug==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH 2/3] idmapped-mounts: add more explanations to setgid tests
Date:   Fri,  7 Jan 2022 15:58:17 +0100
Message-Id: <20220107145818.336126-2-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220107145818.336126-1-brauner@kernel.org>
References: <20220107145818.336126-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305; h=from:subject; bh=+im/UKgTLrAy3fEKhG0H6CyKiWB0+pSbQcE1/3MDqpQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTeCGV22sR0YOXSdeuT42O/Rx+1n5ZpmMys2HzL3/hi1JQT CVkfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby7DMjw4Lvqzef6fV/tLkznyXws4 er/j+N36lbFvE/WdbVN9ePLYrhf3KaYvB63h0f/Lmrrr7/uarqyW+FEusMOSFpjZf8Qv8msQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The explanations before were a bit thin and people not familiar with
setgid inheritance might get confused. Make it easier to understand the
tests.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <brauner@kernel.org>:
  - fix Seth's mail address in commit message
---
 src/idmapped-mounts/idmapped-mounts.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 56b26b0c..c53e1942 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8128,6 +8128,14 @@ static int setgid_create_idmapped_in_userns(void)
 	if (wait_for_pid(pid))
 		goto out;
 
+	/*
+	 * Below we verify that setgid inheritance for a newly created file or
+	 * directory works correctly. As part of this we need to verify that
+	 * newly created files or directories inherit their gid from their
+	 * parent directory. So we change the parent directorie's gid to 1000
+	 * and create a file with fs{g,u}id 0 and verify that the newly created
+	 * file and directory inherit gid 1000, not 0.
+	 */
 	if (fchownat(t_dir1_fd, "", -1, 1000, AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) {
 		log_stderr("failure: fchownat");
 		goto out;
@@ -8172,12 +8180,19 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
-		/* Files and directories created in setgid directories inherit
-		 * the i_gid of the parent directory.
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 1000, not by gid 0.
 		 */
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 1000))
 			die("failure: check ownership");
 
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 1000, not by gid 0.
+		 */
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
 			die("failure: check ownership");
 
-- 
2.32.0

