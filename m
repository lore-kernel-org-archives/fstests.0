Return-Path: <SRS0=xPHB=6M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0E6C83000
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Apr 2020 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8D6206D6
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Apr 2020 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky6Z/GXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgD1S2a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729197AbgD1S23 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Apr 2020 14:28:29 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2D7C03C1AB
        for <fstests@vger.kernel.org>; Tue, 28 Apr 2020 11:28:29 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g14so34340725otg.10
        for <fstests@vger.kernel.org>; Tue, 28 Apr 2020 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWbzFtxzcktocv5LWay92lZrwx2g3gDzJ2HfujHijEc=;
        b=Ky6Z/GXYdO45qvdFg1/wcFgWAOLIW6/VW3aJI3Y2eSjEpJoNr+pRGpaGMOWIH6OiX7
         ElOKduZuS9mb0vaKnRkQn3DrI92Lp2iATZrylv6c7fu5PBe6D7OnzYn3AWg4F0vnZezo
         VCHEgUtcvrrh7sL0pKV0y5L4nvq1Ql/DISYOY55I2bxj6BgPWRC/dYOfbj+V8uTWEJ+X
         I/iS/PSzX/T7aQ3SUL9D3xUW8y5TCma7fPv2k7qUkKU1nEChbctGZMoBJkveCZasFwB5
         vb4725/y5YoGBmrqqzqh9VUNvU4DLZ0QJHJJaad4oS8IyI4ft0pOPRjjVJVQxEMvc/EL
         Zyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWbzFtxzcktocv5LWay92lZrwx2g3gDzJ2HfujHijEc=;
        b=M+pnqK7D4YcgvZHwKgnYjLSddi9Rdrrsh9zWtYJOrFFD+CCzp+tYZKa7uRy5RXRWZI
         F2Jk1+u69Th2JBd6G500My4oWbTWWwalBpIXK6LBv8/GMWetarTEfzWQR/CruAfip7w5
         2Nipokuh1+d9+lA2BWe+bMOqCzB0SIIP/sFNqXxaUqwoAxdMQRW7ftYmdEHS4WZVUo2a
         mIM0SU7U2Gr86fTv7BrN87qaMHBlbiSUPDhr6dS/jEWJo8BoR3QhYoMtLMMq36rQLpQg
         kpXFlMifiPkq3zsq6sWI4zXmrBPtX4q0ygYcJQwgXvxiS8GNZs4wce3PaOPPISttJeyk
         uQVA==
X-Gm-Message-State: AGi0PuZ0aMim1vskCAOOUohrtvZ4X3OyM2O38YwH8w+NZTy7UCG35pMs
        d6UOrhMBvaXOVutkPynzJdigsLWCtQ+B
X-Google-Smtp-Source: APiQypLlI2ocTnDNiKR51nV49QKB9KKk1b00tX4WgIb1j6/lgbF4TtaBtUgv5s7rVOCnfK6L4oTf7g==
X-Received: by 2002:a9d:39a5:: with SMTP id y34mr6506148otb.69.1588098508508;
        Tue, 28 Apr 2020 11:28:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id w6sm5140390ooa.6.2020.04.28.11.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:28:27 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Arvind Raghavan <raghavan.arvind@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Subject: [PATCH] fstests: Fix duplicate CLI arguments in fssum
Date:   Tue, 28 Apr 2020 03:53:00 -0400
Message-Id: <20200428075300.3037-1-raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

fssum currently has a duplicate '-x' flag. This patch renames one of the
duplicate flags and makes the appropriate doc changes.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
---
 src/fssum.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index a243839a..b49ba59b 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -150,9 +150,9 @@ usage(void)
 	fprintf(stderr, "    -[UGOAMCDXES]: exclude respective field from calculation\n");
 	fprintf(stderr, "    -n          : reset all flags\n");
 	fprintf(stderr, "    -N          : set all flags\n");
-	fprintf(stderr, "    -x path     : exclude path when building checksum (multiple ok)\n");
+	fprintf(stderr, "    -i path     : ignore path when building checksum (multiple ok)\n");
 	fprintf(stderr, "    -h          : this help\n\n");
-	fprintf(stderr, "The default field mask is ugoamCdES. If the checksum/manifest is read from a\n");
+	fprintf(stderr, "The default field mask is ugoamCdxES. If the checksum/manifest is read from a\n");
 	fprintf(stderr, "file, the mask is taken from there and the values given on the command line\n");
 	fprintf(stderr, "are ignored.\n");
 	exit(-1);
@@ -713,7 +713,7 @@ main(int argc, char *argv[])
 	int plen;
 	int elen;
 	int n_flags = 0;
-	const char *allopts = "heEfuUgGoOaAmMcCdDsSnNw:r:vx:";
+	const char *allopts = "heEfuUgGoOaAmMcCdDxXsSnNw:r:vi:";
 
 	out_fp = stdout;
 	while ((c = getopt(argc, argv, allopts)) != EOF) {
@@ -735,6 +735,8 @@ main(int argc, char *argv[])
 		case 'C':
 		case 'd':
 		case 'D':
+		case 'x':
+		case 'X':
 		case 'e':
 		case 'E':
 		case 's':
@@ -768,7 +770,7 @@ main(int argc, char *argv[])
 				exit(-1);
 			}
 			break;
-		case 'x':
+		case 'i':
 			++n_excludes;
 			excludes = realloc(excludes,
 					   sizeof(*excludes) * n_excludes);
-- 
2.20.1

