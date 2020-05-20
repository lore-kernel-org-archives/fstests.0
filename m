Return-Path: <SRS0=XlT/=7D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAF3C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B6420759
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ+AdWzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgEUAJ0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 May 2020 20:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgEUAJ0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 May 2020 20:09:26 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74CC061A0E
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:09:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l6so4645907oic.9
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UA0sai5P2RiBDkt7NdTIgRH/bLsn4FesyiFmXgvBu/Q=;
        b=VQ+AdWzHUO0n3esbHXWjDXH6d5tJpST+WlsrQX2N3ilO4C2DU+0AVGuwUYy9wF1RJQ
         470zzXg7jZcBeziK6U7Z2fDHI0jArZ79qKQrnAI350986Ago6zL4p4hFC5hfdaxcA03m
         i4K0nsR84NhdzflG6luZiCUBiq4HpjENvpjTObK5/f3rOt1WtjRpjPbFvS8+qRf62xfw
         g4mtmmg0xHAE9pKT4r+l5T2wUlTzXVVaQVGka3el/QjwHjDG+7dTwZ79Ow+b4Qz/oFsj
         OKmotjx1cCtTv/zzRCVljqXRTY9TrrYZ6+x98KCyegYbcmxqLgPquwtHcK8HbAAH65+2
         DdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UA0sai5P2RiBDkt7NdTIgRH/bLsn4FesyiFmXgvBu/Q=;
        b=Gyv7FSHpvRhqg4DZ8WaNL/9quKvKK93FnqkGOYuzRrzInHxIYiIB6aluL0j0K4Sf4M
         SVHNepk+m1oLqLrnB6y7Zx1RWWLqsRV2m1Ge6j7UqD66Xw8LhHOeWORyS3mAe5HnWFPc
         DgMx16632VC4oW5CziIMfAtveCozuy05qCx9+7JncFmf5bUkF2KWXAhQKNud3unfpaR6
         NcJ4kEGPdLVG43vzLnPN+LoUvlfu37Upc/TeUQuVSNaATM0V/asr8FqibmG6+0OSjoXt
         wuzvol3KEOkMRs4aJCh6q9kW58ZU7ML6hQjdfLQ3+NrvYNXzSA+7l7RPIASVx7g5r7B4
         yawg==
X-Gm-Message-State: AOAM532W4oyTuD2HdnIbzUTOUciJ8BGZ9SHlzoumvJGR416DuQzDRym6
        bhMZVkUtQenYpBRBm8cOk7/XWUPRs+Q3
X-Google-Smtp-Source: ABdhPJyXn28g5b8MSyMbjTFrQC3DO9+floA1ZgL946bW12cKFdzWNqYOusrkoiax5Pw0snaTmunDyA==
X-Received: by 2002:aca:4b89:: with SMTP id y131mr5065842oia.59.1590019763235;
        Wed, 20 May 2020 17:09:23 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id d11sm1154101otc.5.2020.05.20.17.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:09:22 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH 4/6] src/fssum: Add a flag for including file size in checksum
Date:   Wed, 20 May 2020 17:20:31 -0400
Message-Id: <97c1cbd8461d2d9a5d8ff625ed07c557575ad515.1590006879.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590006879.git.raghavan.arvind@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
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
---
 src/fssum.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 018ad4a6..ece0f556 100644
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
@@ -649,7 +651,8 @@ sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
 			close(fd);
 		}
 	} else if (S_ISREG(st.st_mode)) {
-		sum_add_u64(&meta, st.st_size);
+		if (flags[FLAG_SIZE])
+			sum_add_u64(&meta, st.st_size);
 		if (flags[FLAG_DATA]) {
 			if (verbose)
 				fprintf(stderr, "file %s\n",
@@ -730,7 +733,7 @@ main(int argc, char *argv[])
 	int plen;
 	int elen;
 	int n_flags = 0;
-	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNRw:r:vx:";
+	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSzZnNRw:r:vx:";
 
 	out_fp = stdout;
 	while ((c = getopt(argc, argv, allopts)) != EOF) {
@@ -761,6 +764,8 @@ main(int argc, char *argv[])
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

