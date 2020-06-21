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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFACAC433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEFC238E5
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agr22y3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgFUXQW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgFUXQW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:16:22 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210DBC061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:16:22 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t6so11617792otk.9
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtDd9bmrFPK5ija6ZpZkUJrq6offDD51j+vqahkOBqI=;
        b=Agr22y3STergN11YyCNlZaclD+pOu08kjQhGNZ+tBV4kev+Y6dJOp51Al1n6+cgWZC
         RuDin2H0jzMA7KcSciQsiu3yQomDQpNhIgH+VroFF2K9Rf/rAb0R05TR0SeVgHkiIHiZ
         4U1m9qwm3ZgSlsI7CoQr2jhV2ZYQsGKOJzqrm9X7vWRJGJ5IjsRnChN9MFJDvxKpoy/J
         k6lmluE5QVIpJl+wONDM38/NmsminmwxV/WFldPGTPz4I69vIACayPP3IAyJDpOYqAsg
         FBXVmr3e9EwROb+vobNwcX//V3AjI8O5iR8DaKNYmJ2yi6EnvA1NEvFM+amYCRThigHE
         /FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtDd9bmrFPK5ija6ZpZkUJrq6offDD51j+vqahkOBqI=;
        b=tEP5sCUIGyP8kaotXX9oYfSz3e+hRQCmwmqe7VtHRcvxv90aEUvQg7YbU8+/W64JG/
         Vi15tQPVDeZC2Epn3liAIU8mGmPR7/+FaNWSUQKC8DlRethH60mAAqoSPrr1raKp4eUg
         UPPvKhf3NwM+W+QK4b4WUfPG0Vuxp0wxZawINaULsGZJCsZaFmNx3bJFGsUUboi1NzTc
         6zlg14gZ7asv08zjVFvsZlMMQOJN49q9dJmt5pMwx+sWKrwjnoAqtCt+cnVDgMdpzgEC
         ESCIMCXB99jtQx0ytsMUCNkFwwaKEeYXEzJbVUxcVvI+ZNSbebZNifJsgJMPNg2LRZym
         RaTQ==
X-Gm-Message-State: AOAM532Zs5eyxMIL8mhF9AFLlTPrMdQvJLUoHWARDRwzSHFHCfGjeqBa
        zqdkyWJnqFwvYzQQIYL8qI/fzP54Sw==
X-Google-Smtp-Source: ABdhPJzdAzehfeXl4+pfSVkJ9gj2F/I0G0AL6hcVj//kj92CcYVa2KjQq4rjo134HyN3M+RwhRyv1Q==
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr11313070oto.246.1592781381297;
        Sun, 21 Jun 2020 16:16:21 -0700 (PDT)
Received: from localhost.localdomain (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id c23sm2906811otd.7.2020.06.21.16.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:16:20 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH v2 4/7] src/fssum: Add flag -R for non-recursive mode
Date:   Sun, 21 Jun 2020 19:16:16 -0400
Message-Id: <f87044fadd8f872dea2ab4cbd6f715bf1f1b7eb5.1592779555.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1592779555.git.raghavan.arvind@gmail.com>
References: <cover.1592779555.git.raghavan.arvind@gmail.com>
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
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 src/fssum.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 506ca7fe..3667ec2f 100644
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
@@ -641,7 +643,7 @@ sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
 			}
 		}
 	}
-	if (S_ISDIR(st.st_mode)) {
+	if (S_ISDIR(st.st_mode) && recursive) {
 		fd = open_one(dirfd, name);
 		if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
 			sum_add_u64(&meta, errno);
@@ -734,7 +736,7 @@ main(int argc, char *argv[])
 	int plen;
 	int elen;
 	int n_flags = 0;
-	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNw:r:vx:";
+	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNRw:r:vx:";
 
 	out_fp = stdout;
 	while ((c = getopt(argc, argv, allopts)) != EOF) {
@@ -742,6 +744,9 @@ main(int argc, char *argv[])
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

