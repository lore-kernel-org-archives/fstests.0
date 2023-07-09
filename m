Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1EAEB64DD
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Jul 2023 13:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGINST (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Jul 2023 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGINSS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jul 2023 09:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E3ACE
        for <fstests@vger.kernel.org>; Sun,  9 Jul 2023 06:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 385F260BC4
        for <fstests@vger.kernel.org>; Sun,  9 Jul 2023 13:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA59C433C7;
        Sun,  9 Jul 2023 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688908696;
        bh=czKRNmEC2/w0IwxntOy9g50Mpwn3+PxCkCyMkjKbAaA=;
        h=Date:From:To:Subject:From;
        b=VGVuDFrHH2EA0Oy8syHoD0AvNCizdvhg2Jg9yo9M79cIWgBcV7O3SMSeGT28YARqI
         1LCKsB8tvVaC+jpr1GRzao+hqckH6rke56Vw6son3/qH9l4IC3u4hrjq61K3xxhvNe
         2e92O9VMb5myuyYfB6rDc8+HLm81xBbQ5sb/w81vMlFsgGJkoYi1W7ksKOyxs5RBCe
         zuArmqG2L/72LE7vK2Z1ZN2W2EDZ5SL3OV5wPeJe7Dn7BS4dcLyPj3MmPyCFKg2Y0v
         eu7LyT3m/g0DrWP5OFnLS1gLrWlTj+hLVR3PCerbbuBRIKApcmJLQ6wzIj6UYJQ2If
         njTu7Ct3+6++g==
Date:   Sun, 9 Jul 2023 21:18:12 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.06.18 onto master branch
Message-ID: <20230709131812.7tsakif3kojyempl@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.06.18 version.

Thanks,
Zorro

The new head of the master branch is commit:

87f90a2dae7a common/rc: Enable _test_mkfs to force a mkfs on a xfs filesystem

New commits:

Anand Jain (1):
      [39bcfc9ab3dd] btrfs/122: fix nodesize option in mfks.btrfs

Andreas Gruenbacher (1):
      [6e9aa61ef386] generic: Add mmap + DIO write test

Carlos Maiolino (1):
      [87f90a2dae7a] common/rc: Enable _test_mkfs to force a mkfs on a xfs filesystem

Chao Yu (1):
      [e8fb7a0217ba] generic/506: fix to call _scratch_enable_pquota()

Darrick J. Wong (6):
      [156a8a107850] xfs/108: allow slightly higher block usage
      [27d202f5c8de] xfs/155: discard stderr when checking for NEEDSREPAIR
      [eef60725c850] xfs/155: improve logging in this test
      [078bb0de7c21] fuzzy: disallow post-test online rebuilds when testing online fsck
      [0adf9e7c0d59] xfs/503: don't rebuild the fs metadata when testing metadump
      [8b88f4ca28ff] common/xfs: compress online repair rebuild output by default

Eric Sandeen (1):
      [3ed1150fd7b8] xfs: test shipped config files work properly with mkfs.xfs

Qu Wenruo (4):
      [685d1dadd526] btrfs: add a test case to verify read-only scrub
      [2702c4208dae] btrfs: add a test case to verify the scrub error reports
      [17c0dedf05fc] btrfs/106: avoid hard coded output to handle different page sizes
      [ab41f0bddb73] common/btrfs: use _scratch_cycle_mount to ensure all page caches are dropped

Xiubo Li (2):
      [2343f7cca021] generic/020: add ceph-fuse support
      [7cef6bf6dc8d] common/rc: skip ceph-fuse when atime is required


Code Diffstat:

 common/btrfs          |  6 ++++-
 common/fuzzy          |  7 +++++-
 common/rc             |  7 ++++--
 common/xfs            | 31 ++++++++++++++++-------
 src/mmap-rw-fault.c   | 33 +++++++++++++++++++++---
 tests/btrfs/106       | 15 ++++++++---
 tests/btrfs/106.out   | 18 ++-----------
 tests/btrfs/122       |  4 +--
 tests/btrfs/288       | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/288.out   |  9 +++++++
 tests/btrfs/289       | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/289.out   |  2 ++
 tests/generic/020     |  2 +-
 tests/generic/506     |  1 +
 tests/generic/729     | 42 +++++++++++++++++++++++++++++++
 tests/generic/729.out |  2 ++
 tests/xfs/108         | 14 ++++++++---
 tests/xfs/155         |  7 +++---
 tests/xfs/503         |  2 ++
 tests/xfs/569         | 32 +++++++++++++++++++++++
 tests/xfs/569.out     |  2 ++
 21 files changed, 329 insertions(+), 46 deletions(-)
--
Zorro Lang
zlang@kernel.org
