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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9965C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB96920C56
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6Oa8M9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgFUXPg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgFUXPg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:15:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FE2C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:15:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a21so14003024oic.8
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48Pynuy9Mx9WwL5TrNAO2CrX4wasaOGbGbfKh6bKPyM=;
        b=p6Oa8M9ywp/udVvo4G0A7yHvBfsRSHz1iIcjhQq8X4m2qlauRb9qLDkk6MNw3K0Fsw
         zGc+J4A6J/YXnINCuPVRiuWa2GDJhoHrtJfoMkFg+nfB0ILUTO9xSLWMrmY3LWWVro9w
         PQ4HKOi7tpePHWPZJEX93gL92ftgTY51tTtkcgqxIA3tYWgHalq5BZrI7k+jXR7Ul5mT
         9az4DQQ4QM5lI3uaJQCB1K3trKIuzpz8wnA8kQj0C6aWZRumkgqem866VJBa5m7Zyf16
         twqPqQj5ms7b/jnV/+G/Pvsduj43mc8nFfMXmbPTTrpRyQdCnZNCJ9jI2+ZqSbj4h8Yp
         h3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48Pynuy9Mx9WwL5TrNAO2CrX4wasaOGbGbfKh6bKPyM=;
        b=Vfu+Qr9fzPnxPVlPAjaJ0iF8P7g6Nchde3uKapmi6nLUxBsSo8hUA6WD1KP3hGHerU
         tPKf5E2rlXiLyaK4rZLPb11sgmHE8RhOmqp3Nvrduo+k7I+RXXlzysenO10Hebvxgjmk
         wd+JIdyFFOG+7/ALz/MB0bYgfKhrtALjK1FbjcD0uPBO5abQSx72TE0IJp/BnRHwyLz9
         kLwq3SuIee4RKYWeZR/eez2jZ/phTzYLFracfObX7xdApee9L8XNmQyE/GcFUEqWzSaq
         cg8+c1GM6z18NliT/wjJL1fq0QWOBiRsckwKSDjGZ38iJq9PM9q0dF2YxehiRI4qmr4/
         1nHw==
X-Gm-Message-State: AOAM530+zQoSagGoeUgXU+jvTlDATNL7FSJd6CI5IIPnq+n+6eGFZAAE
        z8G/yZ8LJecx9dRgqo6Bk5t5OkeZdA==
X-Google-Smtp-Source: ABdhPJz6m9WaYo+8CD6CrpED60+8N7RLqzzAHrvsg07jmSU+dnjLrGAQCjEk+76FuOniivRntB3BGg==
X-Received: by 2002:aca:a814:: with SMTP id r20mr10631139oie.91.1592781333551;
        Sun, 21 Jun 2020 16:15:33 -0700 (PDT)
Received: from localhost.localdomain (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id x6sm2929830ooe.5.2020.06.21.16.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:15:33 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH v2 1/7] src/fssum: Make sum_file_data global
Date:   Sun, 21 Jun 2020 19:15:16 -0400
Message-Id: <5611ae66baaf35f24090bb7441cd90c5e17727db.1592779555.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1592779555.git.raghavan.arvind@gmail.com>
References: <cover.1592779555.git.raghavan.arvind@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Makes deciding which function to use for summing file data happen once
in main instead of for each file.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 src/fssum.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 3d97a70b..30f456c2 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -62,6 +62,7 @@ int n_excludes = 0;
 int verbose = 0;
 FILE *out_fp;
 FILE *in_fp;
+sum_file_data_t sum_file_data;
 
 enum _flags {
 	FLAG_UID,
@@ -514,8 +515,6 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 	int ret;
 	int fd;
 	int excl;
-	sum_file_data_t sum_file_data = flags[FLAG_STRUCTURE] ?
-			sum_file_data_strict : sum_file_data_permissive;
 	struct stat64 dir_st;
 
 	if (fstat64(dirfd, &dir_st)) {
@@ -824,6 +823,9 @@ main(int argc, char *argv[])
 			flagstring[i] -= 'a' - 'A';
 	}
 
+	sum_file_data = flags[FLAG_STRUCTURE] ?
+			sum_file_data_strict : sum_file_data_permissive;
+
 	path = argv[optind];
 	plen = strlen(path);
 	if (path[plen - 1] == '/') {
-- 
2.20.1

