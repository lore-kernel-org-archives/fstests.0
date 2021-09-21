Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF12DC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Sep 2021 17:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9378611ED
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Sep 2021 17:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhIURwH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Sep 2021 13:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhIURwH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Sep 2021 13:52:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2AC061574
        for <fstests@vger.kernel.org>; Tue, 21 Sep 2021 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RjJC2Oayo+Uod+/AkowZqO1XNSZRvbYtNdT8jnGI5yI=; b=CPnUWwTsa0828UIliz3bQ2vpPp
        eFHm+/SDj+X+1Xi9KVHc6LZKVDP3jwvpHcgA7S5gwQIu5VODk0ou+LYav3/yTkos5X39XzyJvRWGH
        q5wDqTrEUOrofSoKqBlMeN2IRcLGbbbRTddoMVbojmrqosj0xQWWjre6Gw9bLlHbRhhQ2Jt+FhsED
        Q7ze/pkEo37oj/zBE7hm3318a0SW80sJyjUS7g4aTj8zgJ2ulTQHGy7w1byzPWwLLxcgMHLpCfxoQ
        aa15QDngDxNuxRNxsfw35Aer7WzqercxHcA40cXvkEFJDK2UmoZFSfdp2A6HFnSzq2CO94yQDeN33
        +AvW+2Fw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSjug-005OmK-By; Tue, 21 Sep 2021 17:50:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: [PATCH] fsstress: improve error message on check_cwd() error
Date:   Tue, 21 Sep 2021 10:50:35 -0700
Message-Id: <20210921175035.1286786-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I ran into an error with generic/083 with xfs due to check_cwd() but
why it failed is not clear because there are two types of
failures:

  o stat64() failed (likely -ENOMEM is my guess)
  o the inode actually changed

Thow a bone out to developers so that in case en error does happen
they know which rabbit hole to go down on.

Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 ltp/fsstress.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index b4ddf5e2..d2f09901 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -9,6 +9,7 @@
 #include <sys/uio.h>
 #include <stddef.h>
 #include <stdbool.h>
+#include <string.h>
 #include "global.h"
 
 #ifdef HAVE_BTRFSUTIL_H
@@ -943,9 +944,21 @@ check_cwd(void)
 {
 #ifdef DEBUG
 	struct stat64	statbuf;
+	int ret;
+
+	ret = stat64(".", &statbuf);
+	if (ret !=0) {
+		fprintf(stderr, "fsstress: check_cwd stat64 failed with: %d (%s)\n",
+			ret, strerror(ret));
+		goto out;
+	}
 
-	if (stat64(".", &statbuf) == 0 && statbuf.st_ino == top_ino)
+	if (statbuf.st_ino == top_ino)
 		return;
+
+	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%ld) != top_ino (%ld)\n",
+		(long)statbuf.st_ino, (long)top_ino);
+out:
 	assert(chdir(homedir) == 0);
 	fprintf(stderr, "fsstress: check_cwd failure\n");
 	abort();
-- 
2.30.2

