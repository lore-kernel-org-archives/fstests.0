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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5F5C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4729C20874
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pms5QA5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgEUAKs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 May 2020 20:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgEUAKr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 May 2020 20:10:47 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976EC061A0E
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:10:47 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x23so4677320oic.3
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPDlGmyiYqsvdEGsWrVCI90bkobs+xrgoN57mPnCe8s=;
        b=pms5QA5CRTSwctoDDWZkIMOEuOnKDTWJ99TI6V4jNoQdwzsmAqRTYF6MQBmVpNsb/G
         reLetvXdMaWLUm3TXtdNMzMFGxUt5VKdpADiC9EirX/++GKRTQevQDuvlu37XghQY1PQ
         w5/qRuB45KZtz7cLWHcsbKCmmuHXVYuMEB3W2rEunIHN/LUhOQggKAT8wtB5hJ63u8Uh
         SmqbZhE8wMywasI6YtoHh5L/6HG1cz6ONHi8mvPAod5Fh4SZKK1t9ZOXXrn6HLouhZ4L
         7VE38x3VHrwZOrUNQO5nSNvtcN5RV0FJb+cI6U++ILMHAI89ZpoPnvUajcUJgeWdruAa
         o3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPDlGmyiYqsvdEGsWrVCI90bkobs+xrgoN57mPnCe8s=;
        b=Zfk6u+7/BjEzxmen0tuDFm/LYRdNOKTHfpPalvvFK/+KVWhQv0Wp5B0TR8AifnfRN+
         QofIlD+lpYi3cRYMxISy/ySnGV0NbbhIOfYaCjNnm2XQj2pxVxlmUlgN/x9EruuW+TQ+
         Xo2jCy+3eCXCU/Xg8TvN303d11Xt/YyF+rvWsWSxeKYx3TzkMxfjjDoedn9J/qXKhlaI
         ZBWUk/Llyit0LlbsMpNgJWbb3iJu2euf+PPy7Q+MOxFeSlgJNnzm4jYQ7G7zTZsId6AT
         pm2qQJaqpX6oOiixeFOcmrAx64OIE819VFuRu3baTY7hI5AmWyWTVISWdaUWKDbKsqpq
         D4Xw==
X-Gm-Message-State: AOAM533Bj4SNcEz2SLc3+ZgymHvqu6JobVLKwz/5Qnt3ZxctRzCFFQa4
        jr/FdE5kAT3gTL7Qc5q1M3NByW7KI8va
X-Google-Smtp-Source: ABdhPJxxVZ8j8LTjeTCxMTxJLKBTVNwbk2h7VphUe0eZyTpqJOy0jw4AZoLPTv7N0lrtKOOwC1z6Ng==
X-Received: by 2002:aca:dc44:: with SMTP id t65mr4749811oig.41.1590019846056;
        Wed, 20 May 2020 17:10:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id z12sm1137359otk.11.2020.05.20.17.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:10:45 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH 6/6] src/fssum: Fix whitespace in usage
Date:   Wed, 20 May 2020 17:21:52 -0400
Message-Id: <487128b8169a1979658948dfc950d1e0fc02a371.1590006879.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590006879.git.raghavan.arvind@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
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
---
 src/fssum.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 2d1624ca..eac2a492 100644
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

