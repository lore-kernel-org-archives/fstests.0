Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D9C6FD1D
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Mar 2023 11:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjCNLqO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCNLqN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2023 07:46:13 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB7187D80
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 04:45:38 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 14 Mar 2023 11:45:37 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v4 4/9] vfs: Fix race condition on get_userns_fd()
Date:   Tue, 14 Mar 2023 12:45:06 +0100
Message-Id: <20230314114511.128207-5-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314114511.128207-1-rodrigo@sdfg.com.ar>
References: <20230314114511.128207-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There is a race when we clone: we call a function that just returns
while at the same time we try to get the userns via /proc/pid/ns/user.
The thing is that when the function returns, in the kernel do_exit()
from kernel/exit.c is called, which calls exit_task_namespaces() to destroy
the namespaces.

So, let's wait indefinitely there and add an _exit() call to avoid
warnings. We are already sending a SIGKILL to this pid, so nothing else
remaining to not leak the process.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git src/vfs/utils.c src/vfs/utils.c
index ea7536c1..2331a3b7 100644
--- src/vfs/utils.c
+++ src/vfs/utils.c
@@ -60,7 +60,9 @@ pid_t do_clone(int (*fn)(void *), void *arg, int flags)
 
 static int get_userns_fd_cb(void *data)
 {
-	return 0;
+	for (;;)
+		pause();
+	_exit(0);
 }
 
 int wait_for_pid(pid_t pid)
-- 
2.39.2

