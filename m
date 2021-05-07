Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5899C43460
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2556145E
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbhEGPCR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 May 2021 11:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhEGPCR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 May 2021 11:02:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF67861456;
        Fri,  7 May 2021 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620399677;
        bh=H+6MzNUtrN83BCHR1jewpUl8a/cC//ACu97+3Za8q0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ry/+JaD3igzri0t6dc3ztbHzspurC+Y2kZdXGewgc87TLRSQ2WSBcwHwSjX1hy+ED
         l+gDfhvqUbVY6lU/yfchFmrZ8dkbpz3ya004fbzLgxvA9rQKAlpEWvfrcrbg5exECm
         2Ey6hubixRd/BrWNVCfJjauOui9IiWf9CS9cFh/oOPk3t5eyqQDT/C7YKonC/y9u0x
         acujGQMGOGgnB2+DzLaNW5HYNrExcTyZ6W9KHwcFoo5H5Ua5iCgkDhZLgVaMH52wJh
         PwjN4LGytvQvCCU2jcWLMF7Y98QNUW8rcLbnBYOJnggFqtmtVVa5qNOn1F95hoFVAI
         +u8SPE3Sf5Wyw==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/7] idmapped-mounts: remove unused set_cloexec() helper
Date:   Fri,  7 May 2021 17:00:54 +0200
Message-Id: <20210507150100.968659-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210507150100.968659-1-brauner@kernel.org>
References: <20210507150100.968659-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=hiHOddqtCcQXlSPDY8SveY5GGlaMvcepRMRcWnPYkHE=; m=n9LDYBRRvluV4y4F+NbSLhCsfMMLo/OBv8QIm7HhcP0=; p=Rt+BVCU7X9Hm7sQjZEteG1pjdlfW32srgONjL3Lsg0A=; g=87f8cb1d65b23c7a95b4dfc8995c820b7ca1b6de
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJVWGQAKCRCRxhvAZXjcolU+AQDG3ou 3l2Ri1HUa58kMSTCNJD7wDWLedjm3h/GqlaaGzwEA88/+2p+GV+Po+E57VCcO1VjMgRkqH1XWVfqE xRz9eA8=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

This function has never been used so remove it.

Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 870a8fe7..66bdd817 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -371,11 +371,6 @@ static bool is_sticky(int dfd, const char *path, int flags)
 	return (st.st_mode & S_ISVTX) > 0;
 }
 
-static inline int set_cloexec(int fd)
-{
-	return fcntl(fd, F_SETFD, FD_CLOEXEC);
-}
-
 static inline bool switch_fsids(uid_t fsuid, gid_t fsgid)
 {
 	if (setfsgid(fsgid))
-- 
2.27.0

