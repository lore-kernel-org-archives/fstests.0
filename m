Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB1BC47080
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 05:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD0B61205
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 05:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhEWFEr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 May 2021 01:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhEWFEq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 May 2021 01:04:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193AC061574;
        Sat, 22 May 2021 22:03:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e22so1882170pgv.10;
        Sat, 22 May 2021 22:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjoyRwfR4HzDsa3R5xoCql22XqVJsKcofCTHgClE8hs=;
        b=DMk2MumxrpJ2XuaZNe04enjwr/dDKoc8ntttHdlZYe0yD+X8nNvwE7zdf0j1vNBYZ6
         CtBFakEBaNrIp0e6eIGDWoWBr3vJUtr4G7wchDOGWs6wh5SjPVR7J1+FpowU5lTSPGy5
         f9cLkkIpp74V87N6htPTjffZC1m9n8hafg2/QHr9aDviIwqWfJqE9JHMiSW9+oRfEYuf
         VfoFXuE939hlB/w95v49LMqcDy0LjrpRYiRtmfKrIHdLLHw+FONNeOtYq53WX2jSVCfQ
         EuDaQ/uKERpHtHFBoHjgId4VkVVyoIOju8KJxQ8nnzZLymCt8c0jvuwxSjhx4b1/Xzzt
         Sm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjoyRwfR4HzDsa3R5xoCql22XqVJsKcofCTHgClE8hs=;
        b=myQiL5SgChWdlsIk8HrhcW4nIoIBKZwmkoxvYHI/3bWzLGYsmEbT1qL/MByc5pCC1z
         XqoVd8T+pGoEnHrM862mkHC4T93l3k+dLqsl5Gh3fLWsCggDdp0v5WRDqdj7qg1ask4v
         q2Vc2gz7k0nV3CULqbIXK31Majj0bcG9tV2LPrTPJXFkLkjNu+faUsvOUQx2dsMXwTcL
         vBWlqrLaQ9jaUiM73HGsxiSgpqCF8eCwyOwaKpBmsQVv68LtNp+XGHfObRqi5shakwbI
         Y+8aQoA9V7y3QHjzZtVbv+9Fr6ss4sxQuanutfp3uxU1D/dKGT6wB1NgFeDjlZPyAGO4
         W/lw==
X-Gm-Message-State: AOAM533pxvB9InPPampBz7cst7VqXQ+Q92VmFG9uDAellFYCxwF3lx65
        DJf05+x+zdB1tnMzTMAT1v4JwyYGfGyxSEUv
X-Google-Smtp-Source: ABdhPJx5cwT3pyOHhSnFUQtlQTgC+9MUNm1MwrGqu+2DZu7fSFoCHe4vqfkmZQv0fFFE37QhdRXdWQ==
X-Received: by 2002:aa7:8882:0:b029:2d5:fd51:6417 with SMTP id z2-20020aa788820000b02902d5fd516417mr18485617pfe.54.1621746198739;
        Sat, 22 May 2021 22:03:18 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n23sm5161621pgv.76.2021.05.22.22.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 22:03:18 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     inux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs/012: check free size of scratch device before copying files
Date:   Sun, 23 May 2021 05:03:10 +0000
Message-Id: <20210523050310.1329372-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test failed when scratch device don't have enough space for copying
files. This patch gets size of files by du command and checks if there
is enough space in the device.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 tests/btrfs/012 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index fd43da53..6979d862 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -42,6 +42,8 @@ _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
 _require_command "$MKFS_EXT4_PROG" mkfs.ext4
 _require_command "$E2FSCK_PROG" e2fsck
 
+_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | awk '{print $1}')
+
 rm -f $seqres.full
 
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
-- 
2.25.1

