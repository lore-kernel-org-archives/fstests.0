Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99216C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 10:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiE2KzO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiE2KzN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 06:55:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CD62BFF
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 03:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 484ABB808BC
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F95EC385A9
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653821708;
        bh=TmyrHPV3Rf0zN/N87eXYzZkU1HWCYB3FbuyCefk9M2Y=;
        h=From:To:Subject:Date:From;
        b=Cz5Wm7zK4q21zdQLl+1JNCVWJ40TpYla8znGa7Ev0+PL4Dn6YBNDrMcw0lkQbCm8j
         n7uyIGKCqualspeM+gMvMRIARgjPkTHy9NXse4OUGHXNrcH6w+zzb2u/M5+kqHzPPx
         kCuGMP548yWjBnxdRW2w24adWikjsWGZeBxzTm0rn2pwJtTD4VCSArjQJZlnCVZcvM
         kDZrkXvQVU6MAbC6b01Ie6lCQJInf4bYObEeb5HLfbcjzYQ/ExPeAjGwNBze3ErsvI
         bWwsRgd9a2RJDiZ7kuCk9nxJZNhX9HLjaLcpXkuev97HiTu+G/c9tTRhk8ZyfajvY4
         l2bCpsxhvIDMA==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/5] random fixes for fstests
Date:   Sun, 29 May 2022 18:55:00 +0800
Message-Id: <20220529105505.667891-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

These 5 patches are random fixes, except patch 4/5 bases on 3/5.

 - [PATCH 1/5] generic/139: require 512 bytes to be the minimum dio size
I tried to help it support 4096 sector size, but it's not simple, especially
the golden image broken. So I'm thinking how about limit it in 512 bytes dio
testing.

 - [PATCH 2/5] generic/506: call _require_quota before _qmount
As subject

 - [PATCH 3/5] generic/591: remove redundant output from golden image
I think I found where's the issue from, but I'm not sure if it's the best
way to fix it. So welcome suggestions :)

 - [PATCH 4/5] generic/591: use proper sector size
Help splice-test to support a sector size option

 - [PATCH 5/5] generic/623: add overlay into the blacklist
I think it's simple to exclude overlay from this test directly, or we have to
check if $FSTYP=overlay, then think about how to deal with OVL_BASE_SCRATCH_DEV
things.

Thanks,
Zorro
