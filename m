Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C1C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 23:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347758AbiDNXow (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 19:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347766AbiDNXov (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 19:44:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF423B3DD4
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 16:42:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r18so7922323ljp.0
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 16:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3RQueuBhWiso2Mbgr1WBpJLlfEZd2TklSlvBfyV3/k=;
        b=KTnqTggkpwHHbB2YWyn0vkE2x4q3+cmLUtlKnTuansVP1prYrl+waqaNikLhU4P2lH
         p+H5xG7cke/EbI0VN4/pHZrYEuYlzvceUWE7Ybq3Ez51PMDiJWyK6yTXOxQ5YtnO1jro
         P9IyExcn/s4wKpYVZHSdu8q8a8wy05MbYrDLhMhczlwKFLsaE19aoRE2zr3dbZFGOg2V
         VhK5lqGWj/z/bWJ+VaSUMcaxqvNrSPQ4Oz8GJcNxRQhaDQD26XW2/LIUe4w2wN8QDSTA
         dpoH4a6e7Ailc5BgsLx+VG7hhNATDSvDJnm0oOuF0MTjEbGtvAERiHiH2Nou9qXNlHs5
         CKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3RQueuBhWiso2Mbgr1WBpJLlfEZd2TklSlvBfyV3/k=;
        b=n7ARX+FWa78HRVFW6IxSg208x5HjCV+tNkic7jpRrBs75z9wq3Fswc6KBYNiTy64Fm
         +GAa+r3pKVpo5STE6Z4rVh7MYtsdVQ90n6r12jekrKQzd5vg6JyuWz3mJaNa34jk8Lxy
         tlEoNNm99kPtzuHYgwybR+ESvLBCWPQuxmXsfz/ojWcL5m0HwyCPSikvDpGKBWspbvBZ
         1XXlSDcbqAF4uuirZ+b7pkBl+CUkUEB4cA6jfLXrcQ491W9JYFZggU3uW3rfk7xo8EK/
         R8BSxfydA2Puw5JUmskA8pBrbqW467rTQ3pUDT9wjOPElMbTaahLs4NNVRePZGt1WK0V
         95+Q==
X-Gm-Message-State: AOAM532vckRRttjw6/kjuzv6USRN0lZpQlI8b3RMHjzyP9oSNW85fP7m
        iDeox5+yxncFUenCiuzSsOU=
X-Google-Smtp-Source: ABdhPJx0oz5LMblIXpYgyXSdHg6MYQ+WPOswCG3d85jeN/wYhlF5MMJg6x5B0nnLzxZ8jQWRSjAGOg==
X-Received: by 2002:a2e:8093:0:b0:24b:495c:412d with SMTP id i19-20020a2e8093000000b0024b495c412dmr2886882ljg.368.1649979742131;
        Thu, 14 Apr 2022 16:42:22 -0700 (PDT)
Received: from 5950x.telewell.oy (dxw3k4yf2tnxwyp6sg02y-3.rev.dnainternet.fi. [2001:14ba:9cae:8c00:9682:e720:334f:2fac])
        by smtp.gmail.com with ESMTPSA id q17-20020a2e8751000000b00244beaacef1sm127548ljj.18.2022.04.14.16.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 16:42:21 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
X-Google-Original-From: Kari Argillander <kari.argillander@fidelix.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        fstests@vger.kernel.org
Subject: [xfstests-bld PATCH 2/2] kernel-configs: add ntfs3 to current 5.15 configs
Date:   Fri, 15 Apr 2022 02:42:20 +0300
Message-Id: <20220414234220.627320-3-kari.argillander@fidelix.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414234220.627320-1-kari.argillander@fidelix.com>
References: <20220414234220.627320-1-kari.argillander@fidelix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Kari Argillander <kari.argillander@gmail.com>

ntfs3  driver was added to version 5.15 so add it for easier usage.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 kernel-configs/x86_64-config-5.15      | 3 +++
 kernel-configs/x86_64-perf-config-5.15 | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel-configs/x86_64-config-5.15 b/kernel-configs/x86_64-config-5.15
index 5bbefbf..a3411a8 100644
--- a/kernel-configs/x86_64-config-5.15
+++ b/kernel-configs/x86_64-config-5.15
@@ -160,6 +160,9 @@ CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_UTF8=y
 CONFIG_NTFS_FS=y
 CONFIG_NTFS_RW=y
+CONFIG_NTFS3_FS=y
+CONFIG_NTFS3_LZX_XPRESS=y
+CONFIG_NTFS3_FS_POSIX_ACL=y
 CONFIG_PROC_KCORE=y
 CONFIG_PROC_CHILDREN=y
 CONFIG_TMPFS=y
diff --git a/kernel-configs/x86_64-perf-config-5.15 b/kernel-configs/x86_64-perf-config-5.15
index 0c33565..a028329 100644
--- a/kernel-configs/x86_64-perf-config-5.15
+++ b/kernel-configs/x86_64-perf-config-5.15
@@ -156,6 +156,9 @@ CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_UTF8=y
 CONFIG_NTFS_FS=y
 CONFIG_NTFS_RW=y
+CONFIG_NTFS3_FS=y
+CONFIG_NTFS3_LZX_XPRESS=y
+CONFIG_NTFS3_FS_POSIX_ACL=y
 CONFIG_PROC_KCORE=y
 CONFIG_PROC_CHILDREN=y
 CONFIG_TMPFS=y
-- 
2.35.1

