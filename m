Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C034FC678D4
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 12:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCGMFi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCGMFc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 07:05:32 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E0A32530
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 04:05:30 -0800 (PST)
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
Subject: [PATCH 03/11] vfs: Fix race condition on get_userns_fd()
Date:   Tue,  7 Mar 2023 12:44:59 +0100
Message-Id: <20230307114507.332309-4-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Talking with Christian Brauner about a different problem, he mentioned
that technically this race condition exists and we should fix it.

The race is that when we clone, we call a function that just returns
while at the same time we try to get the userns via /proc/pid/ns/user.
The thing is that, while the pid needs to be reaped, Christian said that
the userns file cease to exist as soon as the program finishes.

So, let's make the function never return, so we always can get the
userns. We are already sending a SIGKILL to this pid, so nothing else
remaining to not leak the process.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 src/vfs/utils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git src/vfs/utils.c src/vfs/utils.c
index ea7536c1..67779e83 100644
--- src/vfs/utils.c
+++ src/vfs/utils.c
@@ -58,9 +58,10 @@ pid_t do_clone(int (*fn)(void *), void *arg, int flags)
 #endif
 }
 
-static int get_userns_fd_cb(void *data)
+__attribute__((noreturn)) static int get_userns_fd_cb(void *data)
 {
-	return 0;
+	for (;;)
+		pause();
 }
 
 int wait_for_pid(pid_t pid)
-- 
2.39.2

