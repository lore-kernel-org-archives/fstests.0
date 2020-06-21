Return-Path: <SRS0=f9yW=AC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B20C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DCA23E1D
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1aM84tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFUXQh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgFUXQh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:16:37 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D4C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:16:37 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d4so11656151otk.2
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HpEtLB5l5Mgb1DlbwNHE1wYEa/xeh1TVt3ZPwuII80=;
        b=k1aM84tITGRtdGfa7Z9lwQuB29CeC8TSPEBVlnMrnEPr2K2I+RWMhfoVHSztKvD3Bx
         Q/obVFe2HXO4SyDNtw6KDSeo+AX5UXInXHPV1Har0QArY7xwzE/KI0qtPu2cc7Kg5kL+
         j+C5DdEk+RYD062l+J7jtl/G0VUmto3K57TvjK84wAPmBtZdS0+2BpErh+Fwxz//1H4y
         rum8QGu1VCp5rb7DzDXwIGetyKuV09wbVJ2w9qx+JJs1kKx+4G67C/PyU4OAkMemH9t1
         nu8CZ+bjqYFjrOMHIJoF3ZRqd2qeADtoJ7KvGBErckMuT1FVAJ4drO7OpMbZ/i4TAYWX
         Xxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HpEtLB5l5Mgb1DlbwNHE1wYEa/xeh1TVt3ZPwuII80=;
        b=tXoiM1FzEQqbyPZBe8vEJ+0ptEQWtpv7qfYJB3CpLrKjvlZOrdVxs4qDlXc/XUfOUB
         waf50g+HXABTbRTsGSt5HE4m6S+pwsvUp413s2DO0/JtbD0vx8wPoQgEWNGA/JzYr579
         1x3Xqa3t3oZ58gLWyWjAsI8c27OZy2EEtGnYj7PtfbfWp0Vev9oskMDng+LFu+Xiobdu
         6NLFuxH0OkIbFY5bVY6l62T3yzAqy8XpMTbBw2Pvk100nzzo1EQb7e7xV7Z5qCxf9LbR
         NFvfitlBbaptNioaVyuDRsD+m9+VKG4QNEKsV25EMSz5EB4ZmnsW8wQ2tticNBHuFiO7
         Jtww==
X-Gm-Message-State: AOAM531/7xZoQR2cOXSFhFaqJU+Fls+MgrNfPLTfOaYt1qCP02hv31fU
        r3Exf2CxRmz36fXoeq1CW6npfgi4pA==
X-Google-Smtp-Source: ABdhPJwDkzpVj0wBze09Q22+/IRMWAENbgY3oFzGH93DUu+4O0c2m/GSJItt0DYBzqW84/BN6x3l9w==
X-Received: by 2002:a9d:69c7:: with SMTP id v7mr11484721oto.344.1592781396377;
        Sun, 21 Jun 2020 16:16:36 -0700 (PDT)
Received: from localhost.localdomain (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id o16sm422976ooo.7.2020.06.21.16.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:16:35 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH v2 5/7] src/fssum: Add a flag for including file size in checksum
Date:   Sun, 21 Jun 2020 19:16:31 -0400
Message-Id: <da0cea4f8106cf67525045d04f0435d945ecf989.1592779555.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1592779555.git.raghavan.arvind@gmail.com>
References: <cover.1592779555.git.raghavan.arvind@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

File size is currently included by default. It is useful to ignore file
sizes when testing the fsync of a directory, as the data in children is
not guaranteed to be persisted.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 src/fssum.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 3667ec2f..26b0096c 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -76,13 +76,14 @@ enum _flags {
 	FLAG_XATTRS,
 	FLAG_OPEN_ERROR,
 	FLAG_STRUCTURE,
+	FLAG_SIZE,
 	NUM_FLAGS
 };
 
-const char flchar[] = "ugoamcdtes";
+const char flchar[] = "ugoamcdtesz";
 char line[65536];
 
-int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0};
+int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1};
 
 char *
 getln(char *buf, int size, FILE *fp)
@@ -137,7 +138,7 @@ usage(void)
 	fprintf(stderr, "    -w <file>    : send output to file\n");
 	fprintf(stderr, "    -v           : verbose mode (debugging only)\n");
 	fprintf(stderr, "    -r <file>    : read checksum or manifest from file\n");
-	fprintf(stderr, "    -[ugoamcdtes]: specify which fields to include in checksum calculation.\n");
+	fprintf(stderr, "    -[ugoamcdtesz]: specify which fields to include in checksum calculation.\n");
 	fprintf(stderr, "         u       : include uid\n");
 	fprintf(stderr, "         g       : include gid\n");
 	fprintf(stderr, "         o       : include mode\n");
@@ -148,13 +149,14 @@ usage(void)
 	fprintf(stderr, "         t       : include xattrs\n");
 	fprintf(stderr, "         e       : include open errors (aborts otherwise)\n");
 	fprintf(stderr, "         s       : include block structure (holes)\n");
-	fprintf(stderr, "    -[UGOAMCDTES]: exclude respective field from calculation\n");
+	fprintf(stderr, "         z       : include file size\n");
+	fprintf(stderr, "    -[UGOAMCDTESZ]: exclude respective field from calculation\n");
 	fprintf(stderr, "    -n           : reset all flags\n");
 	fprintf(stderr, "    -N           : set all flags\n");
 	fprintf(stderr, "    -x path      : exclude path when building checksum (multiple ok)\n");
 	fprintf(stderr, "    -R           : traverse dirs non-recursively (recursive is default)\n");
 	fprintf(stderr, "    -h           : this help\n\n");
-	fprintf(stderr, "The default field mask is ugoamCdtES. If the checksum/manifest is read from a\n");
+	fprintf(stderr, "The default field mask is ugoamCdtESz. If the checksum/manifest is read from a\n");
 	fprintf(stderr, "file, the mask is taken from there and the values given on the command line\n");
 	fprintf(stderr, "are ignored.\n");
 	exit(-1);
@@ -656,7 +658,8 @@ sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
 			close(fd);
 		}
 	} else if (S_ISREG(st.st_mode)) {
-		sum_add_u64(&meta, st.st_size);
+		if (flags[FLAG_SIZE])
+			sum_add_u64(&meta, st.st_size);
 		if (flags[FLAG_DATA]) {
 			if (verbose)
 				fprintf(stderr, "file %s\n",
@@ -736,7 +739,7 @@ main(int argc, char *argv[])
 	int plen;
 	int elen;
 	int n_flags = 0;
-	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNRw:r:vx:";
+	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSzZnNRw:r:vx:";
 
 	out_fp = stdout;
 	while ((c = getopt(argc, argv, allopts)) != EOF) {
@@ -767,6 +770,8 @@ main(int argc, char *argv[])
 		case 'E':
 		case 's':
 		case 'S':
+		case 'z':
+		case 'Z':
 			++n_flags;
 			parse_flag(c);
 			break;
-- 
2.20.1

