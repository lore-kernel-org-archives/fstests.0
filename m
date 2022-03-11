Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AD4C4332F
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Mar 2022 16:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349987AbiCKQWA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350091AbiCKQWA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Mar 2022 11:22:00 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF94A1D1782
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 08:20:56 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k125so1955465qkf.0
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 08:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1U6cxj19V0y/acZIupyr6W2BLXrx0wsZqg4ciH/ZeeU=;
        b=S0YGyLRTVYu5qTDTStdqki0Kgy4+1uzDpDgulRWdkF6zGGhxecRR+jjFuM+UdvNnRn
         blDPP6cRqqcSGnn4yQUqf2V0V0ZmidD5tsBXRyd2NVy1i08sl0orC81fkxzI+Tp6L2Vz
         5rh4CPoIEK/I9VGfzB7weaqk2JFfd4CRYJjfo5gyJLmjHlTNexp10BpN6yFmWQVpfctJ
         E6HNGaYgR9AeflHYXi5nc9fZVjfAtGBuToP42BFPodMKEOiczPjsrrdydqB4B40kObLl
         0Fr34n67IHo9xOpcN9SY4MtVNNj2NsgJRqZRJ6aWiSNRUu658I3sSpw3IRVZ6IMRDXcT
         EbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1U6cxj19V0y/acZIupyr6W2BLXrx0wsZqg4ciH/ZeeU=;
        b=ReqqZt5idOAcR+OHx2kanuTNc4PFP9yrCzFUv/Zd0AoUt4hwqNeIMOwqdxJfcoultU
         UWIYq4JTXp4y8YfAXgR+T1fYrYQjiiTMdyuYwst42usAPGXJJyyQfafmclDG9QcIW2DA
         PCpbDxGtAIegK4i/w4rYMFjYauavPrlWzioBqb1jbeRENpo23oEURfWA0+NFLHgoaEIk
         27praxwgHCbMkjc6o0p0gHiJTSsX6L97uYeTJOAPFBbKr9qHzIVOXMOi6412z2nbch3R
         rb9GKImAPdyK/XV8hqsdQY1SVg+BNRGmNzE8/xLdFPRIem+kjJOKi2uYGt7hQBSr7vye
         z85A==
X-Gm-Message-State: AOAM5339Ge1DBoyAQlQdVZZGgtbhfLgl8QR/a61Q/IE79QSvFVJUM+Uc
        2HfxlTDljPSZwxaXefVX+dkcq8BvemhkSWNF
X-Google-Smtp-Source: ABdhPJyo8gzBcEEYKSjY2H8InSbfLnYL29weuX8HXPSPxhqazHmityZ+hdD1G91ZwyDCuuu5TRbM1w==
X-Received: by 2002:a37:9346:0:b0:67b:128f:4696 with SMTP id v67-20020a379346000000b0067b128f4696mr6865313qkd.442.1647015655668;
        Fri, 11 Mar 2022 08:20:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b128-20020a378086000000b0067c65e0897fsm4105105qkd.59.2022.03.11.08.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:20:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fstests: test adjustments for the reflink behavior change
Date:   Fri, 11 Mar 2022 11:20:52 -0500
Message-Id: <cover.1647015560.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

The cross-vfsmount reflink restriction is being lifted, and as such these tests
are no longer valid.  I've had these patches in the btrfs staging branch for a
few weeks so they've been thoroughly tested.  Thanks,

Josef

Josef Bacik (2):
  fstests: delete the cross-vfsmount reflink tests
  fstests: btrfs/029: delete the cross vfsmount checks

 tests/btrfs/029       |  9 +-----
 tests/btrfs/029.out   |  6 ----
 tests/generic/373     | 70 -------------------------------------------
 tests/generic/373.out |  9 ------
 tests/generic/374     | 68 -----------------------------------------
 tests/generic/374.out | 10 -------
 6 files changed, 1 insertion(+), 171 deletions(-)
 delete mode 100755 tests/generic/373
 delete mode 100644 tests/generic/373.out
 delete mode 100755 tests/generic/374
 delete mode 100644 tests/generic/374.out

-- 
2.26.3

