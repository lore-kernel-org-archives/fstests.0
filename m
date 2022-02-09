Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339E6C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiBIW0N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiBIW0M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4254E00E26B
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=I8glpmN//v5XGqBsPEnUKmyaOZmkoQtAQABel6ffXxY=; b=brxbO4yPBOgdS7d1BK58vAyvNl
        qD0nuVIujZerlsN1TMu2XUHzNtytB2yb7AzBW0sVXHt0dY2Lq6T4D8alSa9qjnAabjoTjirHJmZIT
        YUtH0hLIvJ3Q4rql6g3l5yByR/mc0OIuXL9TEg71HTElrkEf0QLY8g9J/Sg+tp9fsNlTaiOsg4yMo
        v04lAdWwIjMxBZSgwpACeKLVW05HXvWq/mFGsDwTxAi4TSus3KNNsrRiUvdXU27yz/k5tPttt/jD3
        LUHiDv9wO5AT7TnAsAai673rXzh7yOynWgyB3ivyVa3yPekXa0cFajuDDTpfHy8CgoSwfT6T7s+9L
        70flgfWA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q5d-IS; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 02/25] child: fix usage of gzFile and gzopen()
Date:   Wed,  9 Feb 2022 14:25:47 -0800
Message-Id: <20220209222610.438470-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The code uses gzFile as a pointer, but it is not the
intended design. This works as a pointer works just
as well as the stupid file descriptor. Fix this usage
to shut up gcc compilation warnings and make proper use
of the API.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 child.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/child.c b/child.c
index 7abb238..04bc474 100644
--- a/child.c
+++ b/child.c
@@ -329,7 +329,7 @@ void child_run(struct child_struct *child0, const char *loadfile)
 	char **sparams, **params;
 	char *p;
 	const char *status;
-	gzFile *gzf;
+	gzFile gzf;
 	pid_t parent = getppid();
 	double targett;
 	struct child_struct *child;
@@ -348,7 +348,7 @@ void child_run(struct child_struct *child0, const char *loadfile)
 	}
 
 	gzf = gzopen(loadfile, "r");
-	if (gzf == NULL) {
+	if (!gzf) {
 		perror(loadfile);
 		exit(1);
 	}
-- 
2.34.1

