Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF9EC43217
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 11:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiCaLVP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiCaLVO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 07:21:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D116E231
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:19:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E56E21F37D;
        Thu, 31 Mar 2022 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648725565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIbee/mY0y2IEyHSMgMho13k3WMsuuXALLmNvyIn5+I=;
        b=SLZRKtRey6oEtwR86k7C99sXk089Xwv9tsk4nf4mXGUuxuFDKN1Rj0M4U3fUB+CDQUURzt
        +1UsYMECd5BpPK8mo0dq+weykWAcGwOTSpBq6zKAYN2bhDP4IfG2stEOwujOmGmb3ghX/q
        RMLKsY1pgE1+s/4WChsekMJn8ZW2jJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648725565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIbee/mY0y2IEyHSMgMho13k3WMsuuXALLmNvyIn5+I=;
        b=WADs8CIjaIbFvJfzh/BhUPhHOiYlRN4PjR1O52PiVOvjmy8//x7BfTbG/rfJIdlXkYVuvl
        kVUHB6sDRKXWrNAg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D854AA3B93;
        Thu, 31 Mar 2022 11:19:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8E18FA0618; Thu, 31 Mar 2022 13:19:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] generic/633: Avoid failure without CONFIG_USER_NS
Date:   Thu, 31 Mar 2022 13:19:20 +0200
Message-Id: <20220331111920.8377-3-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220331111920.8377-1-jack@suse.cz>
References: <20220331111920.8377-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some tests in idmapped_mounts fail without CONFIG_USER_NS because they
have implicit dependence on user namespaces and these tests are run
despite idmapped mount support not being detected. Detect whether at
least user namespaces are supported and skip tests needing them when
they are not.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/idmapped-mounts/idmapped-mounts.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index d3b27da6c085..93c44510348e 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -127,6 +127,8 @@ char t_buf[PATH_MAX];
 
 /* whether the underlying filesystem supports idmapped mounts */
 bool t_fs_allow_idmap;
+/* whether the system supports user namespaces */
+bool t_has_userns;
 
 static void stash_overflowuid(void)
 {
@@ -13831,6 +13833,7 @@ static const struct option longopts[] = {
 
 /* Flags for which functionality is required by the test */
 #define T_REQUIRE_IDMAPPED_MOUNTS (1U << 0)
+#define T_REQUIRE_USERNS (1U << 1)
 
 struct t_idmapped_mounts {
 	int (*test)(void);
@@ -13841,7 +13844,7 @@ struct t_idmapped_mounts {
 	{ create_in_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"create operations in user namespace",								},
 	{ device_node_in_userns,					T_REQUIRE_IDMAPPED_MOUNTS,	"device node in user namespace",								},
 	{ expected_uid_gid_idmapped_mounts,				T_REQUIRE_IDMAPPED_MOUNTS,	"expected ownership on idmapped mounts",							},
-	{ fscaps,							0,				"fscaps on regular mounts",									},
+	{ fscaps,							T_REQUIRE_USERNS,		"fscaps on regular mounts",									},
 	{ fscaps_idmapped_mounts,					T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts",									},
 	{ fscaps_idmapped_mounts_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts in user namespace",							},
 	{ fscaps_idmapped_mounts_in_userns_separate_userns,		T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
@@ -13853,7 +13856,7 @@ struct t_idmapped_mounts {
 	{ hardlink_from_idmapped_mount_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"hardlinks from idmapped mounts in user namespace",						},
 #ifdef HAVE_LIBURING_H
 	{ io_uring,							0,				"io_uring",											},
-	{ io_uring_userns,						0,				"io_uring in user namespace",									},
+	{ io_uring_userns,						T_REQUIRE_USERNS,		"io_uring in user namespace",									},
 	{ io_uring_idmapped,						T_REQUIRE_IDMAPPED_MOUNTS,	"io_uring from idmapped mounts",								},
 	{ io_uring_idmapped_userns,					T_REQUIRE_IDMAPPED_MOUNTS,	"io_uring from idmapped mounts in user namespace",						},
 	{ io_uring_idmapped_unmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"io_uring from idmapped mounts with unmapped ids",						},
@@ -13939,8 +13942,9 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 		 * If the underlying filesystems does not support idmapped
 		 * mounts only run vfs generic tests.
 		 */
-		if (t->support_flags & T_REQUIRE_IDMAPPED_MOUNTS &&
-		    !t_fs_allow_idmap) {
+		if ((t->support_flags & T_REQUIRE_IDMAPPED_MOUNTS &&
+		    !t_fs_allow_idmap) ||
+		    (t->support_flags & T_REQUIRE_USERNS && !t_has_userns)) {
 			log_debug("Skipping test %s", t->description);
 			continue;
 		}
@@ -13998,6 +14002,16 @@ static bool fs_allow_idmap(void)
 	return ret == 0;
 }
 
+static bool sys_has_userns(void)
+{
+	int fd = get_userns_fd(0, 1000, 1);
+
+	if (fd < 0)
+		return false;
+	close(fd);
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
 	int fret, ret;
@@ -14084,6 +14098,7 @@ int main(int argc, char *argv[])
 
 		exit(EXIT_SUCCESS);
 	}
+	t_has_userns = sys_has_userns();
 
 	stash_overflowuid();
 	stash_overflowgid();
-- 
2.34.1

