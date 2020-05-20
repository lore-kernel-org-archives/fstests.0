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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81852C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3DA20759
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZHWX+Q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgEUAKK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 May 2020 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgEUAKJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 May 2020 20:10:09 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2AC061A0E
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:10:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id o7so4669103oif.2
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSJpz/BCpory8VVIdfXGyKLZg5xLvUcPJlBC87Tdl2k=;
        b=hZHWX+Q1SYRFHkBXtUd7jYsumo7Ft2ypMEWZQxHJA7cOkhTzDd5q9qz4kemrcOtiD+
         vqEMxVjY5pw8YkB8RnYBPlU/GCagKKP8t5CXuo1uKKSHZhahSEq/bsBbn+k0qJhh28Xm
         VojvbOpBb6tCieCJup7crjpNcLi9X+vQVFputvHUi6xhEaTHlY+WHsGz4IQxPJdDW3IP
         76akqpNv6KqtTuQLBQ5f1fwCh1libA019lDLDTRPlyGHMaSVDu+mVaQdzYlUyWO2bbAe
         p2Q03eW/jck9FRBVmoTNuZubN6R4hOMpyolpyfTEDomeBOqvwaUKZe+5YFpuLgnvkYUQ
         8SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSJpz/BCpory8VVIdfXGyKLZg5xLvUcPJlBC87Tdl2k=;
        b=rLDqSf4rdlQ0OkTnyIdpSzxi0Ul4CtqBGx94yK7tglOO7qu+ZjJGStAxtDvmj2TvNk
         fEAIZeGSuD4ioyQgg6pT+jQdjntsHjL1YN/F6XKAv3APiL83jyofc4C6g1d3+atI7cuc
         jNPiHaiw++7cTUOvOKL0HtHezO21o0oCWR07V4W7UVs3UIBJgMcARYNRhB3muop+gWsz
         gRLnB3Ki6Qdv6RGdyhU4XUjofYGp3OwcqNGyIekvXz1AUXgyyEvRqlRS9OD9zeomnvL9
         7nEm2/3GtqRb7nNx1oVknwQ30VOGxHF4qN9UvYSzPWabeZ1hAUE6ha0DwApdHuvi/eKx
         gk2Q==
X-Gm-Message-State: AOAM532JVjM/f9yJJ2vBLOE4iE6ej+9pnOSONZKi7oWC0sPoN1Xr/iZ+
        kkULee6Mbv7vuCjIuIZxqV0fpvDXJ5B4
X-Google-Smtp-Source: ABdhPJyGZJ5QUutfD9M50rmVaG+u5EHvVzfP7JEAF4YZnVG6zSOWx4oLGHYEshr2MtFAsCL0v4o3kQ==
X-Received: by 2002:a05:6808:b07:: with SMTP id s7mr4864128oij.42.1590019807745;
        Wed, 20 May 2020 17:10:07 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id y23sm1151290otk.10.2020.05.20.17.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:10:07 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH 5/6] src/fssum: Allow single file input
Date:   Wed, 20 May 2020 17:21:13 -0400
Message-Id: <91a82230f5929b45a6093576b7c7afd311fde97a.1590006879.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590006879.git.raghavan.arvind@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Allow regular links and symlinks to be passed as input to fssum.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
---
 src/fssum.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/src/fssum.c b/src/fssum.c
index ece0f556..2d1624ca 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -29,6 +29,7 @@
 #include <inttypes.h>
 #include <assert.h>
 #include <endian.h>
+#include <libgen.h>
 
 #define CS_SIZE 16
 #define CHUNKS	128
@@ -884,8 +885,40 @@ main(int argc, char *argv[])
 	if (gen_manifest)
 		fprintf(out_fp, "Flags: %s\n", flagstring);
 
+	struct stat64 path_st;
+	if (fstat64(fd, &path_st)) {
+		perror("fstat");
+		exit(-1);
+	}
+
 	sum_init(&cs);
-	sum(fd, 1, &cs, path, "");
+
+	if (S_ISDIR(path_st.st_mode)) {
+		sum(fd, 1, &cs, path, "");
+	} else if (S_ISREG(path_st.st_mode) || S_ISLNK(path_st.st_mode)) {
+		// Copy because dirname may modify path
+		char* path_copy = alloc(strlen(path));
+		strcpy(path_copy, path);
+
+		char* dir_path = dirname(path);
+		char* name = basename(path_copy);
+
+		int dirfd = open(dir_path, O_RDONLY);
+		if (fd == -1) {
+			fprintf(stderr, "failed to open %s: %s\n", dir_path,
+				strerror(errno));
+			exit(-1);
+		}
+
+		sum_one(dirfd, 1, &cs, dir_path, "", name);
+
+		free(path_copy);
+		close(dirfd);
+	} else {
+		fprintf(stderr, "path must be file or dir: %s", path);
+		exit(-1);
+	}
+
 	sum_fini(&cs);
 
 	close(fd);
-- 
2.20.1

