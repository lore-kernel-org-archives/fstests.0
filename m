Return-Path: <SRS0=ndeD=ZM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F31C432C0
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Nov 2019 08:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A248223B0
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Nov 2019 08:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SggGLWeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKTIRa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:17:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37371 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKTIRa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Nov 2019 03:17:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id b10so4434311pgd.4
        for <fstests@vger.kernel.org>; Wed, 20 Nov 2019 00:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HvA7JmwUwHZwFW3EHjprtW+bx/bsb0bTSHktS7NyTKo=;
        b=SggGLWeu1zPtyG1TQToElqkfDkZ3yPWgD1uSz4H06F2zjKxdhJR6VC6bwvy0M4UGUg
         KZrAiMX6WETHDUpWpyagUsVv7dAeQqA+mRRpWTwk9njJvX8n3fA82ywGHcVpn23H4z/G
         cVPFqBFffoEqwqetwsBlOJFAMRyR+BG0leudlfyF3mTJXHXDo/gZLBefDdMPEZRQIWAY
         iubq4VIzsNSUjiquVo+yvXX66FKZJ3+svYlIjMemDbgUqwwdqiJJZeEeSJVXlQjyQEI5
         1V7a7YbhF3DXhZzEefwvqnKrdpR2yi9X5z7NA+UvBCo5eCnfh/s6O79f8LTNjWrxGSz0
         XXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HvA7JmwUwHZwFW3EHjprtW+bx/bsb0bTSHktS7NyTKo=;
        b=W1pZnR12AZxX/hYX5SClmOcB+vPxZfzGFl8WMNV5saTDQm299EcNryzp2J1OiQEsYy
         ydlxgO5PUvXLNybOtYl7101/G3iGjmd4SjB6wlrUEG/E40OKxkvF/0RzLIlXNb6U85fw
         qmMVMAQrFO701eo7L9yaYyval0Bb+S0uUCwCpUtRa34xf3xa0TfVOJJySiVNsVW7nEx9
         p+6OHS4tQOl0qRsEsl6q50jzW532MqYygsrBssn6oJoal2MO47GyIoiBXB8s5XQSgwQX
         9sZ9U6PtIPscZR/A3WihRZ0ihB2Gm5cFDm6NptFPqJlZy7Bp/WsPfhCPJVxMSFJJz/vC
         eLeQ==
X-Gm-Message-State: APjAAAVwGnFwoOli/KKe3ilJBvaFz+ShBdCuGkwiAXwSoytynNGYzaVg
        QBYr8jXcKgV0v7ZwWY39zU01gj2MF0k=
X-Google-Smtp-Source: APXvYqztuz2qoHnMK74oTpIB3NRlJK8M0WWIsqSeXmX122Lu5T2q9/bRCTPZ0iqd/qtM6pFL/vylsA==
X-Received: by 2002:a63:da13:: with SMTP id c19mr1732074pgh.435.1574237849410;
        Wed, 20 Nov 2019 00:17:29 -0800 (PST)
Received: from lbh-vm.xmfducmkfhgejfckffvf135llh.hx.internal.cloudapp.net ([52.175.53.118])
        by smtp.gmail.com with ESMTPSA id i2sm27254270pgt.34.2019.11.20.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 00:17:28 -0800 (PST)
From:   Baihua Lu <lubaihua0331@gmail.com>
To:     fstests@vger.kernel.org
Cc:     balu@microsoft.com, Lili.Deng@microsoft.com,
        Baihua Lu <lubaihua0331@gmail.com>
Subject: [PATCH] xfs/191-input-validation:Fix issue that the test takes too long
Date:   Wed, 20 Nov 2019 08:17:24 +0000
Message-Id: <20191120081724.113792-1-lubaihua0331@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When test is passed, _check_filesystems will execute. If there is no
mkfs a new XFS filesystem $SCRATCH_DEV in this test, in the check
filesystems stage, xfs_logprint will be failed for having dirty log and
xfs_repaire will take a long time.

Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>
---
 tests/xfs/191-input-validation | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
index b6658015..fd239dbb 100755
--- a/tests/xfs/191-input-validation
+++ b/tests/xfs/191-input-validation
@@ -34,7 +34,7 @@ _supported_os Linux
 _require_scratch
 _require_xfs_mkfs_validation
 
-
+_scratch_mkfs >/dev/null 2>&1
 
 rm -f $seqres.full
 echo silence is golden
-- 
2.17.1

