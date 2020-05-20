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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1CBC433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BC0207C4
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3J+BXzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgEUAH3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 May 2020 20:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgEUAH3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 May 2020 20:07:29 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D2C061A0E
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:07:27 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id p67so1072128ooa.11
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WypzZbuCujfwPPjdAC8hwDJ0ZJW0ZWPmMmSfqaoLcmE=;
        b=E3J+BXzy1Nir3sH4MKX4Km2LjYczgl4WE2LwGi/797nkPVg/NFZbrsc36JO5TVTNrf
         X1/NVIOZdeZ/SKW60mA+HadTE0ljDTTL8lETl/NF3erMpS0T2HIsfwBjZb9/weyNgp6D
         aQm8cr8T/LVu1JUnjrCd62E8rR2OjYNFQtFlmQOI3nY7U7GREHGz0ZYtqLoKaCDbaGsN
         tPl72zfoLTFQQbKqv+77KZsIrKlYw40PvDt1DihAJ7tKYYssgi2RopRlaDfj3BokxWLy
         IGGJtwqT7gViHP1Zo9p3oxEPlX9jq/7zvPRHwr3Z/TJxuTjaNFO26uTTI8CgpB5TisK5
         qs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WypzZbuCujfwPPjdAC8hwDJ0ZJW0ZWPmMmSfqaoLcmE=;
        b=OcSvYCfg1h1iR17vtjDSELWnmH10aQ0u5p3Q3BXVg3BijjsrxXUwoDJg2vIFS1sxiY
         VGdzN4ZL/CRxTEc1mq0Np/4G0TYPrS+dOqmxsfZFihOJs91G1HxxYWzYVo/ISf2QaoAR
         XnWJuzo99nYMTvG6whJefbmkHau+qsEjHWbgPRzn0Cd5+3fOZG3grX4QIEDUhtY+DcSG
         /hAQP2xuIz5HeS1g5QqTCgN3lxLVYQY/E71nqOfxUM+OpXLF4KNbtkVxt9xZOSG78jy3
         J58JMEQrtNA7AlC2uRfD4hCDlZS4TFzpXUQ/6PdeQpluz1+JiNU+4qbOpANeASMVh+a4
         5TcQ==
X-Gm-Message-State: AOAM531WPMo6jBtcc/F+EYuCy/eW5YybRYjl9yjaSdVfoDPJ1LFfl4H3
        Qd21uvxmEyVNDszzgAAN/gnegG9byhte
X-Google-Smtp-Source: ABdhPJwsguUfhj9wEF1Ov8sJVQoOB0StAp59VFjjrMO+ZRPDhNlEXmisMrm4s2nB+cFobWkn9F28Fg==
X-Received: by 2002:a4a:86cd:: with SMTP id y13mr5346153ooh.87.1590019647042;
        Wed, 20 May 2020 17:07:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id f14sm1137112otl.62.2020.05.20.17.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:07:26 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH 1/6] src/fssum: Make sum_file_data global
Date:   Wed, 20 May 2020 17:18:23 -0400
Message-Id: <f034d8223c7bde109380914d6e4036bbe5d18d41.1590006879.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590006879.git.raghavan.arvind@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
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
---
Moved into separate patch as per Amir's suggestion.

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

