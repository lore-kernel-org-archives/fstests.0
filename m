Return-Path: <SRS0=01xi=X5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122DBC4360C
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Oct 2019 04:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AFB2133F
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Oct 2019 04:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfJDEEW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Oct 2019 00:04:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34883 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfJDEEW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Oct 2019 00:04:22 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1iGEpI-0006l3-7X
        for fstests@vger.kernel.org; Fri, 04 Oct 2019 04:04:20 +0000
Received: by mail-pl1-f199.google.com with SMTP id g11so3101853plm.22
        for <fstests@vger.kernel.org>; Thu, 03 Oct 2019 21:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=pQcBC/Gwn7dlZ8/B4EyzioFNbtVn0xu/u6+nRD0C5UM=;
        b=N37HoACzBr9r/ES8GH5W1SILgDfTzfX0Bs3eTsY1GCTstv2RDUm42QbyedZLMf0R/L
         XWF2/OE7Wactyf8cvOb04bzWIyoadNq0zol0cGOt5+bJZRNgZ6aC9i5IgrJv5MENlU4j
         eaajThX7yOa1IVY8skylagQ+ScDCVud1P/8RSbrTUkhZZqFAFAQXkxZDvJ+IZMsMf3Vu
         MaXQ7/UUAjgjgDZPqJOIrnN0w7/vXoSDyXV4ObGxa0weJ7Nw6qzM6svCcmQiijUmr+yp
         T75DhZYYoru5db/gABrAhrEhipM3WS/rxx0q8goj9KIuvr2jGo7DACcLhg9sqaOWFdJo
         rP+w==
X-Gm-Message-State: APjAAAUMx82TlGoS4eJ/MB/pzsoybAz6sdH+kpvCQbW+JPviWr6Hs8Tm
        X3whNF+fhf/2gBHg5KF3Ut3muoh8ZTXV5x7rvts5Nf1S/NbyY2vRHeeM30G6HGke1OxGkEeoyIt
        mkm+iHq8EIYkQN7WdV7/epQ8a5RXl50zIVw==
X-Received: by 2002:a17:90a:f8f:: with SMTP id 15mr14890657pjz.58.1570161858494;
        Thu, 03 Oct 2019 21:04:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyFmlPI70bmStDMbZecemnWKWW4gfeqdqiVWdxTxnGacV6tCpm/zQYrzbPNExYeFjPKbiVgYw==
X-Received: by 2002:a17:90a:f8f:: with SMTP id 15mr14890607pjz.58.1570161857942;
        Thu, 03 Oct 2019 21:04:17 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id d14sm6307501pfh.36.2019.10.03.21.04.16
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 21:04:17 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] check: convert spaces to tabs in help msg
Date:   Fri,  4 Oct 2019 12:04:10 +0800
Message-Id: <20191004040410.18509-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There are some mix use of spaces and tabs in the help message:
$ ./check --help
Usage: ./check [options] [testlist]

check options
    -nfs                test NFS
    -glusterfs                test GlusterFS
    -cifs               test CIFS
    -9p			test 9p
    -overlay		test overlay
    -pvfs2          test PVFS2
    -tmpfs              test TMPFS
    -ubifs              test ubifs

unify them with tabs.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 check | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/check b/check
index 3d6a64cd..c7f1dc5e 100755
--- a/check
+++ b/check
@@ -52,14 +52,14 @@ usage()
     echo "Usage: $0 [options] [testlist]"'
 
 check options
-    -nfs                test NFS
-    -glusterfs                test GlusterFS
-    -cifs               test CIFS
+    -nfs		test NFS
+    -glusterfs		test GlusterFS
+    -cifs		test CIFS
     -9p			test 9p
     -overlay		test overlay
-    -pvfs2          test PVFS2
-    -tmpfs              test TMPFS
-    -ubifs              test ubifs
+    -pvfs2		test PVFS2
+    -tmpfs		test TMPFS
+    -ubifs		test ubifs
     -l			line mode diff
     -udiff		show unified diff (default)
     -n			show me, do not run tests
-- 
2.17.1

