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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46ABC433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BE32528C
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFxbTJ/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgFUXRH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgFUXRG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:17:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C9C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:17:06 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 97so11650887otg.3
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8QM55PMj9BVY56BuuDkwXo4qKZn1YSluY4d9Iktd4E=;
        b=gFxbTJ/jPsRyDHhV4v8RtcGOvxj7SVME5KzOLvC+0dxdMdtQgmfv4Ksio7kGRqI06n
         98vWvni0bHYB3tfIy27wXLWWJ4OnFnoanbDpCjafFnr8IemvJL5jTQs/IjEt6UJPdJUW
         PYmXkjQtIKZHU+cM8munqdVyUytskxdFV76EdGFD+q9GWhedb9GYZ3KckVC3yuXod1SR
         5oHCFzhDra0k0oIHQ6q12cx1EvzmrNbut08+92QcOiuJyZnwL5u6syk+0pOweh3CdSGW
         vnLEPBr/92l19U68MmmGbOOWikMMLw85BaaNJ45L9+5GIlAqaXMmwxsH7xm6IUBE36vN
         l+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8QM55PMj9BVY56BuuDkwXo4qKZn1YSluY4d9Iktd4E=;
        b=qIDJmSypLUZZaFbHfyJRr3KeGNVlDFLCJkuOLdWJBtM6fzFRWhYvyu1lgKQuGdjsZ+
         6yw03v6OdDsTfXIUvcMOLSaqy7xsTbnBojsOfKIHTpdEwutSYoXsWi4K70l9TThORsPB
         mkPcetwpxB/ScDyNEHgvZ6lr+KB8VsBrkAdrtE7ZbADjIbDP77gKlNa+MQ6wnV3sPIm/
         wNeLr/3mn3pRY81ivCaDGzMIsqWh2eqb+OEBkdwedAsX53mrBrBKSPPzNZnwHHk5laTV
         WXCLCxJD0c7FgFKK1X8n68IGCJl0gQ7bGwG51jGdCnG+VfPTbNmELMX5Xlf21wWJnDqd
         DTxQ==
X-Gm-Message-State: AOAM533OzdbS+CGeOaT7NBLdse4yDg8gvZVRhOjFiSqmP/aCoNRlp4P4
        B9xBAFHpZHV56jgHHvTLCu70aQtLNg==
X-Google-Smtp-Source: ABdhPJzsu2CE4A1ZuaUvWzHM00reUocsJxt+pg9SSEJMvdiDZR3LrvuOL3vKpXxXI45Sx+AwEMx5/w==
X-Received: by 2002:a9d:6:: with SMTP id 6mr12030429ota.140.1592781425409;
        Sun, 21 Jun 2020 16:17:05 -0700 (PDT)
Received: from localhost.localdomain (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id h36sm2886581oth.37.2020.06.21.16.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:17:05 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH v2 7/7] src/fssum: Fix whitespace in usage
Date:   Sun, 21 Jun 2020 19:17:00 -0400
Message-Id: <c40449827b049d1298972cb52641441d56e4faa3.1592779555.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1592779555.git.raghavan.arvind@gmail.com>
References: <cover.1592779555.git.raghavan.arvind@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Aligns the usage whitespace properly.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 src/fssum.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index c5c27486..4c20162c 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -135,28 +135,28 @@ usage(void)
 {
 	fprintf(stderr, "usage: fssum <options> <path>\n");
 	fprintf(stderr, "  options:\n");
-	fprintf(stderr, "    -f           : write out a full manifest file\n");
-	fprintf(stderr, "    -w <file>    : send output to file\n");
-	fprintf(stderr, "    -v           : verbose mode (debugging only)\n");
-	fprintf(stderr, "    -r <file>    : read checksum or manifest from file\n");
+	fprintf(stderr, "    -f            : write out a full manifest file\n");
+	fprintf(stderr, "    -w <file>     : send output to file\n");
+	fprintf(stderr, "    -v            : verbose mode (debugging only)\n");
+	fprintf(stderr, "    -r <file>     : read checksum or manifest from file\n");
 	fprintf(stderr, "    -[ugoamcdtesz]: specify which fields to include in checksum calculation.\n");
-	fprintf(stderr, "         u       : include uid\n");
-	fprintf(stderr, "         g       : include gid\n");
-	fprintf(stderr, "         o       : include mode\n");
-	fprintf(stderr, "         m       : include mtime\n");
-	fprintf(stderr, "         a       : include atime\n");
-	fprintf(stderr, "         c       : include ctime\n");
-	fprintf(stderr, "         d       : include file data\n");
-	fprintf(stderr, "         t       : include xattrs\n");
-	fprintf(stderr, "         e       : include open errors (aborts otherwise)\n");
-	fprintf(stderr, "         s       : include block structure (holes)\n");
-	fprintf(stderr, "         z       : include file size\n");
+	fprintf(stderr, "         u        : include uid\n");
+	fprintf(stderr, "         g        : include gid\n");
+	fprintf(stderr, "         o        : include mode\n");
+	fprintf(stderr, "         m        : include mtime\n");
+	fprintf(stderr, "         a        : include atime\n");
+	fprintf(stderr, "         c        : include ctime\n");
+	fprintf(stderr, "         d        : include file data\n");
+	fprintf(stderr, "         t        : include xattrs\n");
+	fprintf(stderr, "         e        : include open errors (aborts otherwise)\n");
+	fprintf(stderr, "         s        : include block structure (holes)\n");
+	fprintf(stderr, "         z        : include file size\n");
 	fprintf(stderr, "    -[UGOAMCDTESZ]: exclude respective field from calculation\n");
-	fprintf(stderr, "    -n           : reset all flags\n");
-	fprintf(stderr, "    -N           : set all flags\n");
-	fprintf(stderr, "    -x path      : exclude path when building checksum (multiple ok)\n");
-	fprintf(stderr, "    -R           : traverse dirs non-recursively (recursive is default)\n");
-	fprintf(stderr, "    -h           : this help\n\n");
+	fprintf(stderr, "    -n            : reset all flags\n");
+	fprintf(stderr, "    -N            : set all flags\n");
+	fprintf(stderr, "    -x path       : exclude path when building checksum (multiple ok)\n");
+	fprintf(stderr, "    -R            : traverse dirs non-recursively (recursive is default)\n");
+	fprintf(stderr, "    -h            : this help\n\n");
 	fprintf(stderr, "The default field mask is ugoamCdtESz. If the checksum/manifest is read from a\n");
 	fprintf(stderr, "file, the mask is taken from there and the values given on the command line\n");
 	fprintf(stderr, "are ignored.\n");
-- 
2.20.1

