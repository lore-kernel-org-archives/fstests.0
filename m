Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64388C6FD19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 19:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCMTEA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCMTD7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 15:03:59 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925181F916
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 12:03:57 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Mon, 13 Mar 2023 19:03:56 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v3 5/9] vfs: Make switch_userns set PR_SET_DUMPABLE
Date:   Mon, 13 Mar 2023 20:03:26 +0100
Message-Id: <20230313190330.94229-6-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
References: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
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

