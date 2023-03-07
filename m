Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B42BC6FD1B
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 12:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjCGMF1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCGMF1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 07:05:27 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCAE32CD9
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 04:05:25 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 11:45:40 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 04/11] vfs: Make switch_userns set PR_SET_DUMPABLE
Date:   Tue,  7 Mar 2023 12:45:00 +0100
Message-Id: <20230307114507.332309-5-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
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
---
 src/vfs/utils.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git src/vfs/utils.c src/vfs/utils.c
index 67779e83..ab92c743 100644
--- src/vfs/utils.c
+++ src/vfs/utils.c
@@ -285,6 +285,10 @@ bool switch_ids(uid_t uid, gid_t gid)
 	if (setresuid(uid, uid, uid))
 		return syserror("failure: setresuid");
 
+	/* Ensure we can access proc files from processes we can ptrace. */
+	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+		return syserror("failure: make dumpable");
+
 	return true;
 }
 
@@ -302,11 +306,6 @@ static int userns_fd_cb(void *data)
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

