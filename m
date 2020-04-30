Return-Path: <SRS0=Qan3=6O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDCBC83004
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Apr 2020 00:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C34C20731
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Apr 2020 00:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkCuSYkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgD3AOZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3AOZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Apr 2020 20:14:25 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09B5C03C1AE
        for <fstests@vger.kernel.org>; Wed, 29 Apr 2020 17:14:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m18so3388983otq.9
        for <fstests@vger.kernel.org>; Wed, 29 Apr 2020 17:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fqn1ZmTjCVku9NFT/dTPI2ntipNxnt3vDo/bc6Xk6QI=;
        b=BkCuSYkOR0qy7AxsoEVxCGl4Cv6DnJa96lsJ9OLrPhbZNJvxwkRf70Ewm1fk0Y6LUt
         uwkD2sg2r49SW9Zqko9dZe0A+6V1A9JeDssI9jY75ToamAhFuO54AlohFpQrHZ5SfqaJ
         4d49XyX9Qvvf87F+RLIEhN51wecXjXLkBgoyraIB+Eu0WgwYujJUzeYQD/83zpfI+yfI
         W+v5p612da7V4GDBQN/Ym5T6o8jBUoRs8VQ3a2RsaDlrTb4dDbkcrfCe51UHpapMEHFf
         /gku5nMWwvGjuxx53KNmcCRB8/Q9VKkXGfHp316MAqMty9xAUNRAQuxXyK/H5yl1NrSC
         wRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fqn1ZmTjCVku9NFT/dTPI2ntipNxnt3vDo/bc6Xk6QI=;
        b=W2HffZ/JWTk07dmyojmcKNABSOLgmNC5/t3E61sd5h/9oeG8GEplcajsF95cNsZ/PO
         fUnKsYMfT5YPfliw+uJYcqe0So6yL6EpI6XI6GnLom6l5WmolAEhttylaKKGJImLNkPP
         KRDQq8rUYm2YhxhwSeajzKZaw2mC/Q3ad8oeWnZUfmoL8JKoJivaddO0pS0bji4TZzN2
         9J81ps6vRn33JmI1IX9Iz9istyT58g7r7eXjMmT9kr/yCkNxvAO7NtKqUxyFO+/R7qIo
         qLK/1uEapOsRlNF5LKOUu4TAXcNaJKAKCpug2iHiVOjtFCsseYsOgwN8OlC1vwk7frRZ
         HX4Q==
X-Gm-Message-State: AGi0PuYHAHY0CXCWBSdrhqfwf6rZ7ZYzchdt4cMeXw48nKTQ36MPIaEi
        NoyrVBZmDLe6epASVCNAXY5srKvl/Q==
X-Google-Smtp-Source: APiQypKhyeCniXv2jr+80Dr1GFZrKsojkVOKoUQ6LC4cdXcD5X/uuPjwj9Vd93e6xhXWbFF+Mabfag==
X-Received: by 2002:a05:6830:120e:: with SMTP id r14mr488996otp.232.1588205664040;
        Wed, 29 Apr 2020 17:14:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id a27sm906536oos.37.2020.04.29.17.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 17:14:23 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Arvind Raghavan <raghavan.arvind@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Subject: [v2] fstests: Fix duplicate CLI arguments in fssum
Date:   Wed, 29 Apr 2020 20:13:54 -0400
Message-Id: <20200430001354.1652-1-raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

fssum currently has a duplicate '-x' flag, which is used for both
excluding paths and including xattrs. As the former is the only one
currently used in xfstests, this patch renames the latter to use '-t'.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
---
 src/fssum.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index a243839a..3d97a70b 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -77,7 +77,7 @@ enum _flags {
 	NUM_FLAGS
 };
 
-const char flchar[] = "ugoamcdxes";
+const char flchar[] = "ugoamcdtes";
 char line[65536];
 
 int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0};
@@ -131,28 +131,27 @@ usage(void)
 {
 	fprintf(stderr, "usage: fssum <options> <path>\n");
 	fprintf(stderr, "  options:\n");
-	fprintf(stderr, "    -f          : write out a full manifest file\n");
-	fprintf(stderr, "    -w <file>   : send output to file\n");
-	fprintf(stderr, "    -v          : verbose mode (debugging only)\n");
-	fprintf(stderr,
-		"    -r <file>   : read checksum or manifest from file\n");
-	fprintf(stderr, "    -[ugoamcdxe]: specify which fields to include in checksum calculation.\n");
-	fprintf(stderr, "         u      : include uid\n");
-	fprintf(stderr, "         g      : include gid\n");
-	fprintf(stderr, "         o      : include mode\n");
-	fprintf(stderr, "         m      : include mtime\n");
-	fprintf(stderr, "         a      : include atime\n");
-	fprintf(stderr, "         c      : include ctime\n");
-	fprintf(stderr, "         d      : include file data\n");
-	fprintf(stderr, "         x      : include xattrs\n");
-	fprintf(stderr, "         e      : include open errors (aborts otherwise)\n");
-	fprintf(stderr, "         s      : include block structure (holes)\n");
-	fprintf(stderr, "    -[UGOAMCDXES]: exclude respective field from calculation\n");
-	fprintf(stderr, "    -n          : reset all flags\n");
-	fprintf(stderr, "    -N          : set all flags\n");
-	fprintf(stderr, "    -x path     : exclude path when building checksum (multiple ok)\n");
-	fprintf(stderr, "    -h          : this help\n\n");
-	fprintf(stderr, "The default field mask is ugoamCdES. If the checksum/manifest is read from a\n");
+	fprintf(stderr, "    -f           : write out a full manifest file\n");
+	fprintf(stderr, "    -w <file>    : send output to file\n");
+	fprintf(stderr, "    -v           : verbose mode (debugging only)\n");
+	fprintf(stderr, "    -r <file>    : read checksum or manifest from file\n");
+	fprintf(stderr, "    -[ugoamcdtes]: specify which fields to include in checksum calculation.\n");
+	fprintf(stderr, "         u       : include uid\n");
+	fprintf(stderr, "         g       : include gid\n");
+	fprintf(stderr, "         o       : include mode\n");
+	fprintf(stderr, "         m       : include mtime\n");
+	fprintf(stderr, "         a       : include atime\n");
+	fprintf(stderr, "         c       : include ctime\n");
+	fprintf(stderr, "         d       : include file data\n");
+	fprintf(stderr, "         t       : include xattrs\n");
+	fprintf(stderr, "         e       : include open errors (aborts otherwise)\n");
+	fprintf(stderr, "         s       : include block structure (holes)\n");
+	fprintf(stderr, "    -[UGOAMCDTES]: exclude respective field from calculation\n");
+	fprintf(stderr, "    -n           : reset all flags\n");
+	fprintf(stderr, "    -N           : set all flags\n");
+	fprintf(stderr, "    -x path      : exclude path when building checksum (multiple ok)\n");
+	fprintf(stderr, "    -h           : this help\n\n");
+	fprintf(stderr, "The default field mask is ugoamCdtES. If the checksum/manifest is read from a\n");
 	fprintf(stderr, "file, the mask is taken from there and the values given on the command line\n");
 	fprintf(stderr, "are ignored.\n");
 	exit(-1);
@@ -713,7 +712,7 @@ main(int argc, char *argv[])
 	int plen;
 	int elen;
 	int n_flags = 0;
-	const char *allopts = "heEfuUgGoOaAmMcCdDsSnNw:r:vx:";
+	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNw:r:vx:";
 
 	out_fp = stdout;
 	while ((c = getopt(argc, argv, allopts)) != EOF) {
@@ -735,6 +734,8 @@ main(int argc, char *argv[])
 		case 'C':
 		case 'd':
 		case 'D':
+		case 'T':
+		case 't':
 		case 'e':
 		case 'E':
 		case 's':
-- 
2.20.1

