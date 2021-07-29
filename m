Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64744C4320A
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Jul 2021 20:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F2760560
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Jul 2021 20:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhG2UgA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Jul 2021 16:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhG2UgA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Jul 2021 16:36:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED404C0613C1
        for <fstests@vger.kernel.org>; Thu, 29 Jul 2021 13:35:55 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a19so4886480qtx.1
        for <fstests@vger.kernel.org>; Thu, 29 Jul 2021 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oob2WOCi4H1WuxZs/osv6sou92YJN1qr7ACpeG7n1uY=;
        b=YxmheqJK75c/ngXFeVzFVQARtpUvP/VezLAKuees2RiBRxR1N5lcrDW7zFDvwBXIUz
         Oj86HtR5KaJ7x5QhC2RnczzJFsUorQeHqg1ALYF7+L3dVVihTjVinbLrBMcYtIjBJKoJ
         RhziwUisIO/yuLX0rUdUhXBnHGMkY784b1Y4b9urD7p0cPz9B4euUM8c6pfIvAR6PkqT
         +0haSoQT2Wiubsl2G/jGOPeAG2GpI6YnVInuhKxLmz3AqvrHEgmVwCjCzGsDyfAHxNsm
         cNq2bbwKy1eOAGppNpgayiTd8t3DT6Fbh50ZCK9TPfJAziU42EmpO2CvhQFd3/SDJ+d1
         XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oob2WOCi4H1WuxZs/osv6sou92YJN1qr7ACpeG7n1uY=;
        b=uPVTPJbBEOCQO3nOqYScUoN4fE0eIVVh3qv+73XaaOWuRBYiNQearobL4V1U4XNd4a
         T6uXN4yQlu9QASHro35rL66aS8VmFl5vU0X917bA2F5pHhusG83ThKdAtDsnOvrZzvfW
         FPMK4g1TYC1rb+duFtB4o3tPASMCLugO2gT8EItOIfiJyukEFsMf2Ge7XoIQ8ZHepPn7
         U0/CZB8VU1EJ8kB3ZNrAw6UP+4Sxx7LOBuP1ZzBCd+Y1LlmmiF2nmqevIo8Z5YMe+2OL
         o3WH4JTL3q7a1u4k1qkopsOARLrliWUIlayDHTtmfsMY4oy8cg+W5COfUrtLx1kJPYpD
         c+eA==
X-Gm-Message-State: AOAM5309nx7xWbMuxCGT325ukAAJeUZqAuzacV7YIoeIjCvXqxlAXmoO
        fI6V0373SATmUp0NsvYspemdnkCvCihAQFKR
X-Google-Smtp-Source: ABdhPJz0cl3S9KQ0ZxUxDHATFJxWAnmptvw9mG/nUHCYaWUMR2QnCpFB88CGuOOAMNK7X4832TL5bA==
X-Received: by 2002:a05:622a:134f:: with SMTP id w15mr5932476qtk.24.1627590954856;
        Thu, 29 Jul 2021 13:35:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f24sm1666817qtq.82.2021.07.29.13.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:35:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: generic/204: fail if the mkfs fails
Date:   Thu, 29 Jul 2021 16:35:53 -0400
Message-Id: <fe1cd52ce8954e5aee1fc0a4baf5c75ef7d2635a.1627590942.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

My nightly fstests runs on my Raspberry Pi got stuck trying to run
generic/204.  This boiled down to mkfs failing to make the scratch
device that small with the subpage blocksize support, and thus trying to
fill a 1tib drive with tiny files.  On one hand I'd like to make
_scratch_mkfs failures automatically fail the test, but I worry about
cases where a test may be checking for an option and need to do
something different with failures, so for now simply fail if we can't
make our tiny-fs in generic/204.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/204 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/204 b/tests/generic/204
index a3dabb71..b5deb443 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -35,7 +35,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
 
 SIZE=`expr 115 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
+_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
+	|| _fail "mkfs failed"
 cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
 _scratch_mount
 
-- 
2.26.3

