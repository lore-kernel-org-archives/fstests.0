Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44062C433B4
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1730F6145D
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhEGPCX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 May 2021 11:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhEGPCU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 May 2021 11:02:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85FA1613F1;
        Fri,  7 May 2021 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620399680;
        bh=TChMHz3f4VhRizYR7kPbAmL0/J5ymmJJ5F69tzDIux4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGxPFJkv0LaHrHzDYgxGaBPU997eQRsCw5CLi7rU+g518COZfCGjxOww23Eg5O0qn
         nX1dkmXCSnduvtTMClk43Tv2t5zYvby9EbajEkeX2buWVfJ7tjtDzdSvYyX3vVztKo
         VZ+E/6iMa3ivEjq9jR6y3avh4cPheuJ5VOPHmAMM6AizbvRlqYLpYM0YMRLKjVdOWa
         kvxY3AaPgHmuDK7sHp8KLBOFtqlf+qZGzDLtBSxXXImeDw/Vn8PkAEEsmAEzo6Gcx1
         7cPfzk2AO5AXnJWJchZdW/MYOYpi20fWSOol52UTdtxwMDajPWLWdXuvcU5+AowC4a
         Iync2Rp2Mfa8g==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/7] idmapped-mounts: split out run_test() function
Date:   Fri,  7 May 2021 17:00:56 +0200
Message-Id: <20210507150100.968659-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210507150100.968659-1-brauner@kernel.org>
References: <20210507150100.968659-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=Q4DcEVc7A/XYHsNeiTZcC/3O1jIqMcceygN/o9mWeog=; m=sEmLOEJ9oZNN4XQf6DmR0kO1EiPJUU0dyNnxRMvKI0s=; p=XKsa0D6pDWE60PbXZvHQkCKz1XM6x1AySnfvntpfxjo=; g=060cb7b5eedd82ba01dcb9643b742e2e692ac5b8
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJVWGgAKCRCRxhvAZXjcogBNAP9PMK7 Jy0gK81CVg8uNenjnGk1ruA5ItreLsMNu/RvClAD/WOq0Edt6a4QiGfkbWDzsEW4cLURmDt/4cT6u sENALAE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

to make it easier to run subsets of tests.

Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 70 ++++++++++++++++-----------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 59a3daa8..4d93b721 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -82,6 +82,8 @@
 
 #define die(format, ...) die_errno(errno, format, ##__VA_ARGS__)
 
+#define ARRAY_SIZE(A) (sizeof(A) / sizeof((A)[0]))
+
 uid_t t_overflowuid = 65534;
 gid_t t_overflowgid = 65534;
 
@@ -8735,7 +8737,7 @@ static const struct option longopts[] = {
 struct t_idmapped_mounts {
 	int (*test)(void);
 	const char *description;
-} t_idmapped_mounts[] = {
+} basic_suite[] = {
 	{ acls,								"posix acls on regular mounts",									},
 	{ create_in_userns,						"create operations in user namespace",								},
 	{ device_node_in_userns,					"device node in user namespace",								},
@@ -8787,9 +8789,44 @@ struct t_idmapped_mounts {
 	{ threaded_idmapped_mount_interactions,				"threaded operations on idmapped mounts",							},
 };
 
+static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
+{
+	int i;
+
+	for (i = 0; i < suite_size; i++) {
+		struct t_idmapped_mounts *t = &suite[i];
+		int ret;
+		pid_t pid;
+
+		test_setup();
+
+		pid = fork();
+		if (pid < 0)
+			return false;
+
+		if (pid == 0) {
+			ret = t->test();
+			if (ret) {
+				fprintf(stderr, "failure: %s\n", t->description);
+				exit(EXIT_FAILURE);
+			}
+
+			exit(EXIT_SUCCESS);
+		}
+
+		ret = wait_for_pid(pid);
+		test_cleanup();
+
+		if (ret)
+			return false;
+	}
+
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
-	int i, fret, ret;
+	int fret, ret;
 	int index = 0;
 	bool supported = false;
 
@@ -8876,33 +8913,8 @@ int main(int argc, char *argv[])
 
 	fret = EXIT_FAILURE;
 
-	/* Proper test suite run. */
-	for (i = 0; i < (sizeof(t_idmapped_mounts) / sizeof(t_idmapped_mounts[0])); i++) {
-		struct t_idmapped_mounts *t = &t_idmapped_mounts[i];
-		pid_t pid;
-
-		test_setup();
-
-		pid = fork();
-		if (pid < 0)
-			goto out;
-
-		if (pid == 0) {
-			ret = t->test();
-			if (ret) {
-				fprintf(stderr, "failure: %s\n", t->description);
-				exit(EXIT_FAILURE);
-			}
-
-			exit(EXIT_SUCCESS);
-		}
-
-		ret = wait_for_pid(pid);
-		test_cleanup();
-
-		if (ret)
-			goto out;
-	}
+	if (!run_test(basic_suite, ARRAY_SIZE(basic_suite)))
+		goto out;
 
 	fret = EXIT_SUCCESS;
 
-- 
2.27.0

