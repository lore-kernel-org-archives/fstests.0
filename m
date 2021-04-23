Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43AFC433ED
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A097661464
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbhDWLQa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 07:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhDWLQa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Apr 2021 07:16:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B0AB61409;
        Fri, 23 Apr 2021 11:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619176554;
        bh=DB50ijycIwtc7lEHDPD7CMgnGYlwOR2vmEbAQ3dOvAc=;
        h=From:To:Cc:Subject:Date:From;
        b=pontJRAFnkmQZcUqoEu6g39dx1R4ii+zpqfss5PUrgIoMpTL/r8ZtlHVaXHcNUjeg
         7niDh/uXkGNAxcxijyR5Rm7MhuDVbxf4nePOmhCZkyK2EalHYsPFHFpBrPTPvpP9Fl
         uxFvFTdyplIgOH6r5jopm00Sn8ErQ/iZvWOShk9VHJQ6xIxn4900ATJQGOLjXmDaHb
         HOjLwAkv7NjAnt8aBFG7fGyGvpVhUJ5Exv81VEyPCQzJWThfwklWo+9+wuglY6aaEu
         1YPzg6W3cWzSza8z1G+j4SqsTk0Gc/Uv8RB0xudVKq4MwoTWAd/f07kb0WT7SacXF7
         xgxBDw7oyM03w==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] generic: extend fscaps test
Date:   Fri, 23 Apr 2021 13:15:39 +0200
Message-Id: <20210423111539.3591487-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=Q4hz1QAj5g0TE2KsomJ7XZV8yN9DsdlDjS3ZArL1Tkk=; m=j/odPcRidGEQZAEkiENyOY8sH1St1ZZe505UhvfePsU=; p=HBINO88hWRczvVLGLcsGFVoS9pYzubAikPur2rEK06U=; g=d154592e97fd182c151c1ee7720dca6725fbae9c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYIKsUQAKCRCRxhvAZXjcoglUAQDrufk AN1Go5wuL85RDgHqPoYoe7G64PT1VJrDpWTAXhQD/TV4C6k45MujsS+Smj/MuPUt9sRaNk+0JFXWI GUIBkw4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Add a test to verify that setting a v3 fscap that is valid in an
ancestor user namespace works.

Cc: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 56 +++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 870a8fe7..4e3252ca 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -3193,6 +3193,62 @@ static int fscaps_idmapped_mounts_in_userns(void)
 		goto out;
 	}
 
+	/*
+	 * Verify we can set an v3 fscap for real root this was regressed at
+	 * some point. Make sure this doesn't happen again!
+	 */
+	if (fremovexattr(file1_fd, "security.capability")) {
+		log_stderr("failure: fremovexattr");
+		goto out;
+	}
+	if (expected_dummy_vfs_caps_uid(file1_fd, -1)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+	if (errno != ENODATA) {
+		log_stderr("failure: errno");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (expected_dummy_vfs_caps_uid(file1_fd2, -1))
+			die("failure: expected_dummy_vfs_caps_uid");
+		if (errno != ENODATA)
+			die("failure: errno");
+
+		if (set_dummy_vfs_caps(file1_fd2, 0, 0))
+			die("failure: set_dummy_vfs_caps");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd2, 0))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd, 0) && errno != EOVERFLOW)
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd2, 10000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 0)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
 	fret = 0;
 	log_debug("Ran test");
 out:

base-commit: 15510d3a208187e234333f7974580786d54d52dc
-- 
2.27.0

