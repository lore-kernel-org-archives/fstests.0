Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEF7C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiBIWSx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:18:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiBIWSv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:18:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDAC1DC5C6
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rUFlLx/XoXG7etYfjYGzpR75JZOkIMQuhIW5+RifPGc=; b=mglxgUQ1blPtzFhFlKkbKfZwFK
        L0As875Bxm49HQOELstAAGBJCVwEHhhAYwyw9y4y957DV0UAM6DW4DlmEgRD3ideIwz9KXIhx7FOu
        KlCWAg2Qnfh5GBNCgceSqwN2pipb7FRrFP5yNuBEVtiDuqz+2xQZH5SuI4TyEkvVvszviU3Ev230y
        A7UxrA9gwH6KHAyZD+DBwr4eoF78Zd4aHIjzmZ1TUGz3kQFHHsXQGgephvAGF0VO1b5op3y5faw93
        f1n1apTBWBkgEvj5exqKSCdB2J7aJedg1VopAARHbNUJ9A3Jx9aQ+UWsdi59vSJvfPj1zJMTBunTE
        46Truhvg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvIa-001p4t-Gn; Wed, 09 Feb 2022 22:18:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/4] Check if parent is alive once per loadfile processed
Date:   Wed,  9 Feb 2022 14:18:49 -0800
Message-Id: <20220209221849.434616-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209221849.434616-1-mcgrof@kernel.org>
References: <20220209221849.434616-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

strace reports that a high percentage of time is spent calling kill()
with 12,000,000 calls in 3 minutes. Check if the parent is alive once per
load file processed. With later versions of apparmor, kill() is permission
checked which is very expensive in itself and unnecessary.  Instead use
the ligher getppid() call and check against the cached value.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 child.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/child.c b/child.c
index 828295d..7abb238 100644
--- a/child.c
+++ b/child.c
@@ -371,6 +371,10 @@ again:
 		nb_time_reset(child);
 	}
 
+	if (getppid() != parent) {
+		exit(1);
+	}
+
 	gettimeofday(&start, NULL);
 
 	while (gzgets(gzf, line, sizeof(line)-1)) {
@@ -384,10 +388,6 @@ again:
 
 		params = sparams;
 
-		if (kill(parent, 0) == -1) {
-			exit(1);
-		}
-
 loop_again:
 		/* if this is a "LOOP <xxx>" line, 
 		 * remember the current file position and move to the next line
-- 
2.34.1

