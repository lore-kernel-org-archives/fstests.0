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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F4C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A18320759
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RELFVBde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgEUAI5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 May 2020 20:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgEUAI5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 May 2020 20:08:57 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6914DC061A0E
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:08:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 63so4085995oto.8
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rI0Icw+VnuJC/Qol7KHCN6YioFV2txdGMBz8Ka5MxP4=;
        b=RELFVBdeufQd8eZ4HU48/janF/T8v5+N8FfJNu3IN7d0734Fqf5TNF5q+h/zYQpKNI
         GqA8ad1D1ukKhlepUdCTioasFtoYahyBdH86RYsKIljujcgbnla6kdlxmgsiw4KjFhuD
         ClVuOCGA/jrvz58hwRKguavckRGX59NeqqOX9GvgOq9gRjfjvk5LgvqTBtjjDjmISgSV
         2wQpV1bYvz3njuPbv28zy3j7cYYBc5DOxG5LGuT11lkGp2dxYH+SaAlqcPMaPEM7MVWB
         y5Swx2ZNgjIw9YGl0mhCvwjkSH3nZF3v6S42G5v9jroe+YWq0DjSx2cFn1ClWZTB0aXH
         Tytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rI0Icw+VnuJC/Qol7KHCN6YioFV2txdGMBz8Ka5MxP4=;
        b=V09dpFahbXCUmHmOYVMtv3swoh8FWgnBZSyz9usO4avsnhApYKShLyEIdp51Xt3THC
         dNebOGHf9MWcf/MvWSdSX0Kv1xnsu9ZxEL+NUaRUI8X/wPXx1MtnGEl+QCQNZddrwbhG
         eqEvl4ZIFdoBIsh3rxEWBTzcQfsd99OoPYikWBGCZ/WgecFo+DGf02W4PNoSNUH99SsB
         iLHgfplblJ74udu2mREWXatRGLfc/NmaHmu/qo7cLRCmycDVniiyKcQfc3B/Mkd8/M6O
         jFN1AexEa8MYJZlNN9+OTEPK7WNkydMfSR6drd9t9T/sc9jJKjr99B5RulQzZZJj7JH7
         /KIg==
X-Gm-Message-State: AOAM532A0TAwG4QHzIOeAfHWa/m0HE1EcxB2sAnsP8XQpQFOHKQiqLKE
        CRDnOZWTJQhhp8gKlBPjaZPSXSxvx5wg
X-Google-Smtp-Source: ABdhPJyUQRGTedj/pc5lMTm15v9zZmuSH07B3R921WwT/cl9Y6uSwH/KLy32dn6v35Z2bg/NxyRfrw==
X-Received: by 2002:a05:6830:1e39:: with SMTP id t25mr5085235otr.114.1590019736546;
        Wed, 20 May 2020 17:08:56 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id a8sm1137307otp.65.2020.05.20.17.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:08:56 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH 3/6] src/fssum: Add flag -R for non-recursive mode
Date:   Wed, 20 May 2020 17:19:57 -0400
Message-Id: <eb38e3787260cdc7871eba58455edd57f1ba679b.1590006879.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590006879.git.raghavan.arvind@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

By default, fssum walks the input directory recursively. This patch adds
a non-recursive mode which is useful because POSIX standards dictate
that fsyncing a directory only guarantees its immediate dirents are
synced.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
---
 src/fssum.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 81e5cf5d..018ad4a6 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -56,6 +56,7 @@ typedef int (*sum_file_data_t)(int fd, sum_t *dst);
 
 int gen_manifest = 0;
 int in_manifest = 0;
+int recursive = 1;
 char *checksum = NULL;
 struct excludes *excludes;
 int n_excludes = 0;
@@ -151,6 +152,7 @@ usage(void)
 	fprintf(stderr, "    -n           : reset all flags\n");
 	fprintf(stderr, "    -N           : set all flags\n");
 	fprintf(stderr, "    -x path      : exclude path when building checksum (multiple ok)\n");
+	fprintf(stderr, "    -R           : traverse dirs non-recursively (recursive is default)\n");
 	fprintf(stderr, "    -h           : this help\n\n");
 	fprintf(stderr, "The default field mask is ugoamCdtES. If the checksum/manifest is read from a\n");
 	fprintf(stderr, "file, the mask is taken from there and the values given on the command line\n");
@@ -634,7 +636,7 @@ sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
 			}
 		}
 	}
-	if (S_ISDIR(st.st_mode)) {
+	if (S_ISDIR(st.st_mode) && recursive) {
 		fd = openat(dirfd, name, 0);
 		if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
 			sum_add_u64(&meta, errno);
@@ -728,7 +730,7 @@ main(int argc, char *argv[])
 	int plen;
 	int elen;
 	int n_flags = 0;
-	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNw:r:vx:";
+	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNRw:r:vx:";
 
 	out_fp = stdout;
 	while ((c = getopt(argc, argv, allopts)) != EOF) {
@@ -736,6 +738,9 @@ main(int argc, char *argv[])
 		case 'f':
 			gen_manifest = 1;
 			break;
+		case 'R':
+			recursive = 0;
+			break;
 		case 'u':
 		case 'U':
 		case 'g':
-- 
2.20.1

