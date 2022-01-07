Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA68C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jan 2022 14:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiAGOoy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 09:44:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41670 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347793AbiAGOox (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 09:44:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAEEAB82659
        for <fstests@vger.kernel.org>; Fri,  7 Jan 2022 14:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C763DC36AE5;
        Fri,  7 Jan 2022 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641566691;
        bh=fogR077sG3Lc2j2QONsMgfRRejDc1qABhL30nNE/MMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQSImyfNA0BSYm7rb3V1YeDNIl0v1mWl7Dk0MAUTGxosaEd/wqZvyH2Q3Qxs44vA4
         eJZQ1LkeHOy2FN4wBH0XRO3+z5n1mfrRjMRzU1ZJSbwyhWEjxuvRXbYzpAx+0JrRDV
         X4IbyG+n/ePvc4xVEkP7J5gOh9GCi1SMtAABgfIEaEF4GZdnQmknTd1t/L4nQni8sp
         t2zkaqnl5M72zC7yQN40ate8FPW1gM2heYZgELVqMHOkN+Y65fCy9bPRzStwai/38h
         v8e++0M6PccTj/PJI1EpVsJLM1g1NP7PC4HFSbFiBK6STpC31jZZYGCfM1mRpRYOFr
         mfGh7TOsAsJKg==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH 2/3] idmapped-mounts: add more explanations to setgid tests
Date:   Fri,  7 Jan 2022 15:44:35 +0100
Message-Id: <20220107144436.332389-2-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220107144436.332389-1-brauner@kernel.org>
References: <20220107144436.332389-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; h=from:subject; bh=IiZHEqRKjAUBu+B0IkVdkhhq9ET1SHb/rELVE2lp2yo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTeCHRJs5P3SBQMtHdU+uRcweiX1cVxMn1hwFS1i8edM5Tu dVZ0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCR7HiPDnZ1vP9c0bTGNmaJ8PFWEY2 PCvhVmS70fPFFTeHl8S2DzJoZ/uvfvnhHaaNE077J6jqbb2YcXa11/L9u2ZsNUS7E7X/9wcwEA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The explanations before were a bit thin and people not familiar with
setgid inheritance might get confused. Make it easier to understand the
tests.

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
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

