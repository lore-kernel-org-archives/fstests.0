Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC0DC43217
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiBIW0U (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiBIW0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC3E015276
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=5c4WMMaE1CjFxfPzbcBwAAjzftUEERYnZfov2f61cSw=; b=vBDRvcC//PcsQ70X/3PVCQd/3t
        Egg1GQ7Z2NX6pdPQU96UXuYUKcTWP2skd8gpWnVu7ReRuBs3TaeUmsYjkUhsJQKwccEaPxs94Kkqc
        Fn/4Q8XUKsrh2oiiqKPse1ApGIxtdTmJxQ4nQ2GFcm97mvIFd3O5g1LNpnCTGzEZWaVQbYPjX50KB
        GY5ITjOQSA3a2YgWrTKO8mNVYh/pJv1g0kXSANb+SBnqnKCXy1jcQsBL01oom6IgeUDAn4PoZOo/O
        9uKgmXlhIZ+p4HxO344sjRnfQe+owNEP1Wf9ga1SrL+beZslHwfmZiMvv7MNK6VNwo9S9QJDrt0Fm
        fVSlgQRg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q6L-Tn; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 12/25] child: be expicit about string truncation goal
Date:   Wed,  9 Feb 2022 14:25:57 -0800
Message-Id: <20220209222610.438470-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Fix this compilation warning:

child.c:260:9: warning: ‘strncpy’ specified bound 256 equals destination
size [-Wstringop-truncation]
  260 |         strncpy(str, pstart, sizeof(str));

We do this by being explicit about our goal to truncate or use
the smaller string passed.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 child.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/child.c b/child.c
index d340860..2545e4c 100644
--- a/child.c
+++ b/child.c
@@ -251,13 +251,17 @@ static int parse_randomstring(char *line)
 	char *pstart, *pend, rndc[2];
 	unsigned int idx;
 	char str[256];
+	size_t min_len;
 
 again:
 	pstart = index(line, '[');
 	if (pstart == NULL) {
 		goto finished;
 	}
-	strncpy(str, pstart, sizeof(str));
+
+	/* Truncate or use the smaller size passed */
+	min_len = strlen(line) < sizeof(str) ? strlen(line) : sizeof(str);
+	strncpy(str, pstart, min_len);
 
 	pend = index(str, ']');
 	if (pstart == NULL) {
-- 
2.34.1

