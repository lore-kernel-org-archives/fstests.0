Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BF1C433E0
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Feb 2021 16:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E628F64E6F
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Feb 2021 16:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhBIQAF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:00:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:52808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232506AbhBIP74 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 9 Feb 2021 10:59:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612886354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8wvX21gjlXIZTHmoSpcR4jYGG/XGuPFzJ/ICbFodf18=;
        b=HwZOP11E2OGM4qbesxI7K5KUsb2bs3EPppfasyo13LGnOxGSbZOGRzVOX21sa6pmY4gQvF
        9wVkmkOoQeB6VYucmzMzofeSHn00lH3bSYfyRiq+ieTnRPWv2DHyNBs1UahaMIdb2PT3iP
        sw/Xgi5v87YRr6UGsZLxtYOIhwyhvBU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A15BAD3E;
        Tue,  9 Feb 2021 15:59:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF2F9DA7C8; Tue,  9 Feb 2021 16:57:20 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     fstests@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] src/splice-test.c: use memalign instead of aligned_alloc
Date:   Tue,  9 Feb 2021 16:57:15 +0100
Message-Id: <20210209155715.28804-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The build fails on SLE11 as the function aligned_alloc is not available
there. Replace it by memalign that has the same semantics and is
commonly used in fstests code base. aligned_alloc has additional
requirements on the alignment and buffer size but that is ok as the
buffer is defined in multiples of the alignment.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 src/splice-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/splice-test.c b/src/splice-test.c
index 11fb11fa8cc3..2f1ba2baaff0 100644
--- a/src/splice-test.c
+++ b/src/splice-test.c
@@ -17,6 +17,7 @@
 #include <stdbool.h>
 #include <string.h>
 #include <errno.h>
+#include <malloc.h>
 
 #define SECTOR_SIZE 512
 #define BUFFER_SIZE (150 * SECTOR_SIZE)
@@ -143,9 +144,9 @@ int main(int argc, char *argv[])
 		   do_splice == do_splice1 ? "sequential" : "concurrent",
 		   (open_flags & O_DIRECT) ? "with" : "without");
 
-	buffer = aligned_alloc(SECTOR_SIZE, BUFFER_SIZE);
+	buffer = memalign(SECTOR_SIZE, BUFFER_SIZE);
 	if (buffer == NULL)
-		err(1, "aligned_alloc");
+		err(1, "memalign");
 
 	fd = open(filename, open_flags, 0666);
 	if (fd == -1)
-- 
2.29.2

