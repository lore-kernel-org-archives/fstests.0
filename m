Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E31C678D5
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Mar 2023 11:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCHLOR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCHLOM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2023 06:14:12 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF7867F4
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2023 03:14:07 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Wed, 08 Mar 2023 11:14:04 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v2 5/9] vfs: Make switch_userns set PR_SET_DUMPABLE
Date:   Wed,  8 Mar 2023 12:13:39 +0100
Message-Id: <20230308111343.510970-6-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We need PR_SET_DUMPABLE in order to write the mapping files when
creating a userns. From prctl(2) PR_SET_DUMPABLE is reset when the
process's effective user or group ID is changed.

As we are changing the EUID here, we also reset it to allow creating
nested userns with subsequent switch_users() calls.

This was not causing any issues because we weren't using switch_users()
to create nested userns. Nested userns were created with
userns_fd_cb()/create_userns_hierarchy() that set PR_SET_DUMPABLE.

Future patches will rely on switch_users() to create nested userns. So
this patch fixes that.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/utils.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git src/vfs/utils.c src/vfs/utils.c
index 2331a3b7..9e67ac37 100644
--- src/vfs/utils.c
+++ src/vfs/utils.c
@@ -286,6 +286,10 @@ bool switch_ids(uid_t uid, gid_t gid)
 	if (setresuid(uid, uid, uid))
 		return syserror("failure: setresuid");
 
+	/* Ensure we can access proc files from processes we can ptrace. */
+	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+		return syserror("failure: make dumpable");
+
 	return true;
 }
 
@@ -303,11 +307,6 @@ static int userns_fd_cb(void *data)
 	if (c == '1') {
 		if (!switch_ids(0, 0))
 			return syserror("failure: switch ids to 0");
-
-		/* Ensure we can access proc files from processes we can ptrace. */
-		ret = prctl(PR_SET_DUMPABLE, 1, 0, 0, 0);
-		if (ret < 0)
-			return syserror("failure: make dumpable");
 	}
 
 	ret = write_nointr(h->fd_event, "1", 1);
-- 
2.39.2

