Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C8C4332F
	for <linux-fstests@archiver.kernel.org>; Wed, 14 Dec 2022 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLNV7g (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Dec 2022 16:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLNV7f (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Dec 2022 16:59:35 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504A264AF
        for <fstests@vger.kernel.org>; Wed, 14 Dec 2022 13:59:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r18so2901638pgr.12
        for <fstests@vger.kernel.org>; Wed, 14 Dec 2022 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtus4HmyPW00KYIv0SMt8QozDDdtxpMrQQRN+C2cN2I=;
        b=mAkcSMI3uWP4VTJOSo/YgvAHVbU9kOTwWnPG3i9Nx0QwSELm7sIHLR6aIQbxcTWnyW
         ECornH5v9vBDRv1tSUVN+bH10mG5D4xZH1Znu8vKa3G/U1E9ObmtXKuPaJoDNBPRMk7d
         T+pePLKWI/MReiAQ9mn8ZB2yTsfwfgekuoYhiXQkSE8UUDwMoOo4zTxsZVv/cZwbG80y
         8hO2uWN/U1ROSSqhQ6S4+pla7h2H/WE2oVLmcsqq0oywrcOjyXu4hGMM4STNLaBE7j6s
         vET7N35zlUo329tdc+ehtFXT808rVKiC3rya0mApEsbpbGHlp7NahcYP0Zj/IXghcOT0
         Hq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wtus4HmyPW00KYIv0SMt8QozDDdtxpMrQQRN+C2cN2I=;
        b=TGoRa5lGzLPzYorfdd8RZ+PVUcrX1aFz0UuDUITKlJw8x0zTG+v7CdRfuTmd34fnNB
         ZkSytuLMm1J3T1oj0oVlT+bTmnNyRJWKHFyKyCW6LOFM3RQnIEZlqOD4Oa2wCgUh2aNF
         V35nXduuB7qtOzVBAkzW7sRKXg4MEmeHyQUPpQUgJLLHJqtE96X8gRux17Y+CWvsDQaJ
         ilWAuBfPhhaxb75VkbFsWlxp3eLsfVmAcOB3v/OXSMpKw3VEBKU7r7dHw0B8+vRmlC6T
         8SelOF8y/Qjjxbbg0VIQVtM7C/y6VZ5EEfKeGJ6NnsQmOWX94CjW9fN4L1Iie572omJY
         2FFQ==
X-Gm-Message-State: ANoB5pnZ25Z4AKmiJvTn8Ib+Tm/pbOx4+7Fjv9kVv/27toBaKWCxpNF1
        +cpUT1/oFhmK8SWS8g9hEmO8WTiEF7E=
X-Google-Smtp-Source: AA0mqf4Tyrl8F7MYCtCr69aG6jPK5vH6+JXwI7oiRyrUx4v57nGtWjjdPge/+/unBfNFGD4UlYgzRw==
X-Received: by 2002:a62:19c6:0:b0:576:cd93:2b06 with SMTP id 189-20020a6219c6000000b00576cd932b06mr27455946pfz.6.1671055173473;
        Wed, 14 Dec 2022 13:59:33 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:1793:c9f7:912a:ff55])
        by smtp.gmail.com with ESMTPSA id c8-20020aa79528000000b005771f5ea2ebsm320978pfp.135.2022.12.14.13.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:59:32 -0800 (PST)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH] check: wipe tmp.arglist
Date:   Wed, 14 Dec 2022 13:59:26 -0800
Message-Id: <20221214215926.908628-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make sure tmp.arglist is wiped before each run to avoid
accidentally rerunning tests.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index d2e51296..81a30928 100755
--- a/check
+++ b/check
@@ -46,7 +46,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
 
-rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
+rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
 
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
-- 
2.39.0.314.g84b9a713c41-goog

