Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D57BC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CE46126A
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhKEQrO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhKEQrN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Nov 2021 12:47:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1041C061714
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wURIXmk3AUnC0x0qS0l9Tw9ZxPN51nPPi0fBR2xhYL4=; b=47t+VQ97HZcNq9e2zTP9u1Y+hJ
        64kWIj1NntCG6IGpmUvlsi5IZNA+jkXxjpSqDt1VYdjJJ7CIql89SnFkYkUNNW5hpxTbJeTXRvj1y
        s8mG/nR0TULnsVeuTWZH3wPH/dX1pYR5R8QKVyaiAWAZbnwe1hBsoo9Ym8OVN7FiXxYr37cIJiM/k
        6PvJ47tmnaCQdCNO6rT5oD6RWIvtMBjR/Ao546JoTl7kGYaIfBbLX11R3g4TMYWtjyHC4aCZHnFbF
        BSs7TUTo51TAlk31NLCIVEtNwBqJ0ld9fcLd5lzDbuploz5RK//6j/Z7VqdtD/YF4eD55H8qVXNuC
        l8IBtZIg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2KP-00C0Az-HK; Fri, 05 Nov 2021 16:44:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org, fdmanana@gmail.com, djwong@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: [PATCH v3] fsstress: improve error message on check_cwd() error
Date:   Fri,  5 Nov 2021 09:44:32 -0700
Message-Id: <20211105164432.2860572-1-mcgrof@kernel.org>
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
they know which rabbit hole to go into.

Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Changes on this v3:

 o Minor nitpick on spaces
 o Changed rabbit hole language
 o enhanced stat64() error message to include errno as well
 o cast things as suggested

 ltp/fsstress.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 90ae432e..aab64f33 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -9,6 +9,7 @@
 #include <sys/uio.h>
 #include <stddef.h>
 #include <stdbool.h>
+#include <string.h>
 #include "global.h"
 
 #ifdef HAVE_BTRFSUTIL_H
@@ -943,9 +944,22 @@ check_cwd(void)
 {
 #ifdef DEBUG
 	struct stat64	statbuf;
+	int ret;
+
+	ret = stat64(".", &statbuf);
+	if (ret != 0) {
+		fprintf(stderr, "fsstress: check_cwd stat64() returned %d with errno: %d (%s)\n",
+			ret, errno, strerror(errno));
+		goto out;
+	}
 
-	if (stat64(".", &statbuf) == 0 && statbuf.st_ino == top_ino)
+	if (statbuf.st_ino == top_ino)
 		return;
+
+	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%llu) != top_ino (%llu)\n",
+		(unsigned long long) statbuf.st_ino,
+		(unsigned long long) top_ino);
+out:
 	assert(chdir(homedir) == 0);
 	fprintf(stderr, "fsstress: check_cwd failure\n");
 	abort();
-- 
2.33.0

