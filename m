Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC9C433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBED60ED5
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 15:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhKAP6f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Nov 2021 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhKAP6e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Nov 2021 11:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29CCC061714
        for <fstests@vger.kernel.org>; Mon,  1 Nov 2021 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8ymHimWRYgQ7BH16nBqxE3Komaoj9Xhq70vOeceCAX8=; b=WP/CJpksgijmACNWMkmznrGJSG
        SuehJc6h05Hnetj0OtUKygdfof51Tyb9hSfEnUsN65+nKpz1iNC5I7CMfjtFTKXsP4S6ebWq7jzJ/
        ZgVYAW7ThXGPtPFcmM1j8pFThKI+HvvF8lIZbGGx4J72a4+6jeC62TyuEoyU8Ta/c5/PR4R8c3+3j
        xisvS8LEn0UpQKWbG4upT5Ek4VHevb/B4KLavxxBKXgKX7ScLnhMk9FDFBtkg04JQdSeopXjy7vPC
        gXlruYsn43TKKQwHW3jDd2UFGN/ApP9Fo7s8esn7gtMNUSMsWd2HVBP/+BJY61lci7svLYk5tSSOf
        S7At04lg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhZfF-00Gjbh-BC; Mon, 01 Nov 2021 15:56:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     fdmanana@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: [PATCH] fsstress: improve error message on check_cwd() error
Date:   Mon,  1 Nov 2021 08:55:59 -0700
Message-Id: <20211101155559.3988492-1-mcgrof@kernel.org>
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

Throw a bone out to developers so that in case en error does happen
they know which rabbit hole to go down on.

Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 ltp/fsstress.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 90ae432e..a576afea 100644
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
+	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%lu) != top_ino (%lu)\n",
+		statbuf.st_ino, top_ino);
+out:
 	assert(chdir(homedir) == 0);
 	fprintf(stderr, "fsstress: check_cwd failure\n");
 	abort();
-- 
2.33.0

