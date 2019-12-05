Return-Path: <SRS0=B3p8=Z3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C44C43603
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Dec 2019 04:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3290521835
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Dec 2019 04:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MftU66WV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfLEECk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Dec 2019 23:02:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35744 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfLEECk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Dec 2019 23:02:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so666370plp.2
        for <fstests@vger.kernel.org>; Wed, 04 Dec 2019 20:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2+kjqgjWTxXNFnKczhqhIuGonnYKnT4vmYdZvw6yRgo=;
        b=MftU66WVEXCJFxRAT4E8zTJZcNliwSm1U1ExiI4CIneTeV4uO34by0LQrd9ai0e4Up
         5njde1ukCVeOeb2TQmUoD87oXxYiD5FKyReNVE0vBT4pWTBGJDqN6C2/K8xeNAi7nU2I
         HSetpjzzlQS6GWV9LRyog4wHQ2518CppxZz7wpErI7zxeJwUUaMzJTddALbI3alERsWN
         hAmIQfejHGQifLDJnC4eFsgF9mZ3OPtQw5Rk6v0BaWH1ao9P65nM1qQ0e49qPUiSFtwS
         aX2H40MMSIXIhLeTsnlv1x6jCnDJscIDupQTPS8Zxucr6c/7YBM6jodAKjI8rdZUmGfr
         wmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2+kjqgjWTxXNFnKczhqhIuGonnYKnT4vmYdZvw6yRgo=;
        b=RXU86/3Dof8rFh114plMLvk5G94BmjKP3nhs4pfiiGR0GPQRdRD+QNV8Jv2H6je5nZ
         nD8uiuMtl573ST9E9pvTmMpXFBFqYo6DYR6Oihlm2aCZNfx04L2udQPEmLg5+OzJXs5v
         RwMZ91VZuTXd6bq9pka5iEwMCrISD/m1K9mmh8+cF0AKUYb1E5CASgo3Y5q4FyElKnF8
         gQ+WYL9Vgk3h28RSRestwvKHDMnCc9IxBGxvDDkhfYlgQjA84fdDXOe33YofrDrLGsNp
         PjMYj9YCiIhn3UYcEI3HBUFEyZSmk3WMmqZ7nBKpMc56d1eOoYczxLItK/uaqB/Sjy+E
         XOEQ==
X-Gm-Message-State: APjAAAUftOEa0F4i6EpNbAqlOz+SbviVbPOAg6RmNQhDIHJ6P77FVErG
        7In0XD6m4wJ9YHE/03jVPVWU6YC90bAxGyrY
X-Google-Smtp-Source: APXvYqyoMi9aVaMVO0znnHse/2NJVDhY1gSpFKRxnBQd69cvk7wlCL4gRB+jtJANsq4mVsf2YGSk4Q==
X-Received: by 2002:a17:90a:9bc2:: with SMTP id b2mr7033794pjw.64.1575518559576;
        Wed, 04 Dec 2019 20:02:39 -0800 (PST)
Received: from microsoft.corp.microsoft.com ([2001:4898:80e8:1:f953:5dff:fe00:1089])
        by smtp.gmail.com with ESMTPSA id s11sm9176275pgo.85.2019.12.04.20.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 20:02:38 -0800 (PST)
From:   Baihua Lu <lubaihua0331@gmail.com>
To:     fstests@vger.kernel.org
Cc:     guaneryu@gmail.com, balu@microsoft.com, Lili.Deng@microsoft.com,
        Baihua Lu <lubaihua0331@gmail.com>
Subject: [PATCH] xfs/191-input-validation:The "verion=1 -m crc=1" option is valid
Date:   Thu,  5 Dec 2019 04:02:36 +0000
Message-Id: <20191205040236.26066-1-lubaihua0331@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The "version=1 -m crc=1" option is valid, so the test should be passed.

Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>
---
 tests/xfs/191-input-validation | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
index db427349..b5611c5b 100755
--- a/tests/xfs/191-input-validation
+++ b/tests/xfs/191-input-validation
@@ -217,6 +217,7 @@ do_mkfs_pass -l lazy-count=1 -m crc=0 $SCRATCH_DEV
 do_mkfs_pass -l version=1 -m crc=0 $SCRATCH_DEV
 do_mkfs_pass -l version=2 -m crc=0 $SCRATCH_DEV
 do_mkfs_pass -l version=2 $SCRATCH_DEV
+do_mkfs_pass -l version=1 -m crc=1 $SCRATCH_DEV
 
 # log section, should fail
 do_mkfs_fail -l size=${fssize}b $SCRATCH_DEV
@@ -239,7 +240,6 @@ do_mkfs_fail -l internal=1,logdev=$fsimg $SCRATCH_DEV
 do_mkfs_fail -l lazy-count=1garbage $SCRATCH_DEV
 do_mkfs_fail -l lazy-count=2 $SCRATCH_DEV
 do_mkfs_fail -l lazy-count=0 -m crc=1 $SCRATCH_DEV
-do_mkfs_fail -l version=1 -m crc=1 $SCRATCH_DEV
 do_mkfs_fail -l version=0  $SCRATCH_DEV
 
 
-- 
2.17.1

