Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA7DC4332F
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Jan 2023 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjAAN7Z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Jan 2023 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAN7Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Jan 2023 08:59:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0816A270F
        for <fstests@vger.kernel.org>; Sun,  1 Jan 2023 05:59:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73EFFB80B30
        for <fstests@vger.kernel.org>; Sun,  1 Jan 2023 13:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64591C433D2;
        Sun,  1 Jan 2023 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672581560;
        bh=Ywf8hcA8p18RXt2oXBzez37ZXL0C6oSZJfbR5uuLnKg=;
        h=Date:From:To:Subject:From;
        b=p5UKPHXylkGe7uIYV8f/G1Rd9KqSKggONaNWg2tBkUsywsVEkQgCv4mCJsTFPaFOv
         QcSDYXAtBA5RCdA7qTuKvd6D2cl88B/vBC9KfkTwIKV4LC+hAF2mtyatojFfNIZpnx
         GDH8/7FOIiwk6U3DdXTMboaHR4a39dw2EAZGnZ5foRBUZmSTmYxKoV7y1rp/1NqnHZ
         p4x8sqBEFuCSoqRsqsaDWLYMALzg+X6KQekdm/S/O7/kvGr4qLElMJCJyzxNNWFKLZ
         hfX07h0Ud1R3CxUogQry50Eu6sOUayJCfG5GaVkIiIYlJHPJDE/lM9Qjxl5b1rRV1p
         Y7XkS5ETlxDfQ==
Date:   Sun, 1 Jan 2023 21:59:16 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.01.01
Message-ID: <20230101135916.kaln7fkimsqk3r5m@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.01.01 release.

Release Notes:
I think most of people are enjoying holiday this week, so there're not big
changes this week, except an improvement about fs-verify tests.

Thanks for all your contribution in the past year, and with my best wishes
for a happy New Year! Good luck, good health and good cheer!

Thanks,
Zorro

The new head of the for-next branch is commit:

fbd489798b31 generic/575: test 1K Merkle tree block size

New commits:

Eric Biggers (10):
      [d60bd999f580] common/verity: add and use _fsv_can_enable()
      [d206c4d04b6a] common/verity: set FSV_BLOCK_SIZE to an appropriate value
      [5fadb20865e6] common/verity: use FSV_BLOCK_SIZE by default
      [658d8d249e97] common/verity: add _filter_fsverity_digest()
      [3f15400a5fab] generic/572: support non-4K Merkle tree block size
      [abe649bd4776] generic/573: support non-4K Merkle tree block size
      [e25ea6825c08] generic/577: support non-4K Merkle tree block size
      [a89062a98d07] generic/574: test multiple Merkle tree block sizes
      [772a394868c9] generic/624: test multiple Merkle tree block sizes
      [fbd489798b31] generic/575: test 1K Merkle tree block size

Code Diffstat:

 common/verity         |  84 ++++++++++++++-----
 tests/generic/572     |  21 ++---
 tests/generic/572.out |  10 +--
 tests/generic/573     |   8 +-
 tests/generic/574     | 219 ++++++++++++++++++++++++++++++--------------------
 tests/generic/574.out |  83 ++-----------------
 tests/generic/575     |  57 +++++++++----
 tests/generic/575.out |   8 +-
 tests/generic/577     |  24 +++---
 tests/generic/577.out |  10 +--
 tests/generic/624     | 119 +++++++++++++++++++--------
 tests/generic/624.out |  15 ++--
 12 files changed, 370 insertions(+), 288 deletions(-)
--
Zorro Lang
zlang@kernel.org
