Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A57C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiBIW0O (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiBIW0M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC567E00ED40
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jw0CnlHgRPOcSDTLVKhoZLeeIUUCmIjnPrFoJD8FL9E=; b=O1melj/+7y+P3ev5inVFkYk4cx
        XW4cbP/f0c1VIIE55hA2JiI8wnVeXVRIgREl05x7kQqM/4Opvtt2ftztwKEeETErKYoyxxescvKYL
        JE+W6o9IE77QHCafrw4G8S2vksC3uWH1Xx9NycgbkjQ9hRHrMK6vwpLylbmTWjr8oXxhDw2MUO6x7
        /lG9zcMDJr9+IMaALhczhtzjWRSKXrqrCW5gIdkjf1iuwfHkSb+TST0BH9tvK+e4bUZqY8E4djbNI
        kZoCnZkNF7qu3PvswHCGdrJSicB7CI+WgJz6hMUheF5sBHk1fKjXpG2jzSLjTDgxbHXYrpp8DAaOh
        ANBs82cQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q5b-HM; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 01/25] dbench: simplify open_loadfile() as check_loadfile_ok()
Date:   Wed,  9 Feb 2022 14:25:46 -0800
Message-Id: <20220209222610.438470-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

open_loadfile() just checks to see if the file.gz exists
and is present. Note that if the file is not in the gzip format,
gzopen and gzread will not produce an error but just read it
without doing any uncompressing. So just rename it to
check_loadfile_ok().

While at it fix the incorrect use of gzFile as a pointer.
Using it as a pointer works just because the file descriptor
can cast to the pointer, but this generates compilation warnings.
Fix that as well.

And lastly, just use gzclose(f) for correctness;

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 dbench.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/dbench.c b/dbench.c
index 178a175..c8f2fee 100644
--- a/dbench.c
+++ b/dbench.c
@@ -25,6 +25,7 @@
 #include "dbench.h"
 #include "popt.h"
 #include <sys/sem.h>
+#include <stdbool.h>
 #include <zlib.h>
 
 struct options options = {
@@ -60,18 +61,25 @@ static double throughput;
 struct nb_operations *nb_ops;
 int global_random;
 
-static gzFile *open_loadfile(void)
+/*
+ * Note that if the file is not in the gzip format, gzopen and gzread will not
+ * produce an error but just read it without doing any uncompressing.
+ */
+static bool check_loadfile_ok(void)
 {
-	gzFile		*f;
+	gzFile f;
 
-	if ((f = gzopen(options.loadfile, "rt")) != NULL)
-		return f;
+	f = gzopen(options.loadfile, "rt");
+	if (f) {
+		gzclose(f);
+		return true;
+	}
 
 	fprintf(stderr,
 		"dbench: error opening '%s': %s\n", options.loadfile,
 		strerror(errno));
 
-	return NULL;
+	return false;
 }
 
 
@@ -253,14 +261,11 @@ static void create_procs(int nprocs, void (*fn)(struct child_struct *, const cha
 	int i, status;
 	int synccount;
 	struct timeval tv;
-	gzFile *load;
 	struct sembuf sbuf;
 	double t;
 
-	load = open_loadfile();
-	if (load == NULL) {
+	if (!check_loadfile_ok())
 		exit(1);
-	}
 
 	if (nprocs < 1) {
 		fprintf(stderr,
-- 
2.34.1

