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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45757C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D02F24802
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7uil+Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgFUXQw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgFUXQw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:16:52 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76407C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:16:52 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id k7so2980660ooo.12
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aL1ry8A1QJFB6a2J9DFgxMZx48CcSZ+XMDTil8XQeFA=;
        b=m7uil+Y2MQq3nOv1p94ucjXVpdLS/iIgs+jJjaSW8UukAbjuo/0RQQ8Ar8+DKPdSdi
         vPBQ8lizatjyMHaCe/dqlj/gN2vCrA8tK4eW3p87Zl6Ke/SQTNDmks9ZxNf8EIhTs704
         cJJdeBtAEODEKaQZbAbKDiGX4taLXFyr29U8ng7k0XSLC2+TzGXLHfcRjA+1cSW0JjC8
         CTo5Wmuc578cIn0owIiNaZMayGYPzyizjmriFDv5Nqe0oiQb5qBPnJU3thJecz7sM4dS
         fhV+wtLJ4bwYDjP9I4MDwWP2G3CzgUWo19FZwVwnbaXiitK7Zpdw2CyemILyCuaGzOZ6
         OJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aL1ry8A1QJFB6a2J9DFgxMZx48CcSZ+XMDTil8XQeFA=;
        b=E6kUAwgiQPPUkcA0q/mJ1Nw0mGdRlPxtjSzcS53g3uyqDS80oRGOebHukWBhBV6N23
         JPMZhiwj09RzIGNDt9TwpTL738cgwSeHYkbpnJxSIbifKIZxZGYhsEmw+yF+ZPWWmYKD
         fA8A3WcIWHpoyvC5SDS3XLfI+sbOpqqOLvoacB+HUxVXcC1TsZfQpCmSj1EaRfrhl2BX
         tboQF9gL0K7goc0Tt4DZ9TmyYLnTl5nvGJdNp3TboyJ7/bys1/ic9+aXxrfJlL+WP1B5
         rhGOou6McK3wSXv32IEio8B4k3ociK6ERt3cHtN8OCuHkK9eK8bZ/Gj92JDgk7LONrWk
         n/ow==
X-Gm-Message-State: AOAM530q6tnnF/7Mcz7uGfS3kFn5i7At3lozxGUADuf3CgVAf7fX6LjF
        Aik3ZbdG4PxZbcVeTeS5m3m/C+sl/g==
X-Google-Smtp-Source: ABdhPJwgyBSBnSXvmgTOf5Kwg84Xjdsa+uVIdJMP5+k33DcdOAGgoY1nd/pSZpCvuQ06fHH6W8eNhw==
X-Received: by 2002:a4a:5744:: with SMTP id u65mr11970201ooa.1.1592781411671;
        Sun, 21 Jun 2020 16:16:51 -0700 (PDT)
Received: from localhost.localdomain (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id 10sm2882568otq.52.2020.06.21.16.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:16:51 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH v2 6/7] src/fssum: Allow single file input
Date:   Sun, 21 Jun 2020 19:16:46 -0400
Message-Id: <4d2fa44b88c5f4f7aa53074220abba7beafa4fe8.1592779555.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1592779555.git.raghavan.arvind@gmail.com>
References: <cover.1592779555.git.raghavan.arvind@gmail.com>
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
Since v1:
	- Simplified logic by using sum_one
 src/fssum.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 26b0096c..c5c27486 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -29,6 +29,7 @@
 #include <inttypes.h>
 #include <assert.h>
 #include <endian.h>
+#include <libgen.h>
 
 #define CS_SIZE 16
 #define CHUNKS	128
@@ -600,7 +601,8 @@ sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
 			goto out;
 	}
 
-	ret = fstatat64(dirfd, name, &st, AT_SYMLINK_NOFOLLOW);
+	ret = fstatat64(dirfd, name, &st, AT_SYMLINK_NOFOLLOW |
+			AT_EMPTY_PATH);
 	if (ret) {
 		fprintf(stderr, "stat failed for %s/%s: %s\n",
 			path_prefix, path, strerror(errno));
@@ -890,8 +892,23 @@ main(int argc, char *argv[])
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
+		sum_one(fd, 1, &cs, path, "", "");
+	} else {
+		fprintf(stderr, "path must be file or dir: %s", path);
+		exit(-1);
+	}
+
 	sum_fini(&cs);
 
 	close(fd);
-- 
2.20.1

