Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D4EB64D7
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jun 2023 13:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFRN2h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Jun 2023 09:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFRN2g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Jun 2023 09:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551F619C
        for <fstests@vger.kernel.org>; Sun, 18 Jun 2023 06:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4EBA61237
        for <fstests@vger.kernel.org>; Sun, 18 Jun 2023 13:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AFCC433C8;
        Sun, 18 Jun 2023 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687094911;
        bh=O+fH1O3XAeWyEI1Xz3PAMECej54R8w6gH0s213dHvtI=;
        h=Date:From:To:Subject:From;
        b=GlZD94f8llZPr1tGxqGA3UINRQ9B1VV2JVbR7qVwUx6b65WEPMUYs4obEk8NnJxjF
         hzj2juUI9+QGwiRk3BV2tiRpBAIgO7JI8sBgAu3f9inJFQpxtfTFqo8wkrppuccXaP
         NayxvebJYaAR2GMk5CZwbwKLLFCQtg/dc0+W/k7HzITWo2JwrPZ7CMKakqVsz98pwC
         FmqqaWXWMseh1OtpXmb9U801IWLv/Uh6oWTzRBYYmKu/aMpuovkhKLnplkfj+t9PKk
         36tXE6kPH7I4x0YAcwsKIcUuZJuHIjTUjEl8eBT/KCnSyswc4q7umAvd+BomUI4rjL
         +N/VrdrbUiaLw==
Date:   Sun, 18 Jun 2023 21:28:27 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.06.18
Message-ID: <20230618132827.giolp7aupnhgxomw@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.06.18 release.

Release notes:
1) There're 4 new test cases in this release, include btrfs/288, btrfs/289,
   generic/729 and xfs/569. Generally they won't cause downstream kernel
   crash or hang.
2) The xfs on TEST_DEV will be re-created properly, if RECREATE_TEST_DEV=true.
3) More bug fixes for btrfs, xfs, ceph, etc.

More details refer to below, thanks for all these contribution.

Thanks,
Zorro

The new head of the for-next branch is commit:

87f90a2dae7a common/rc: Enable _test_mkfs to force a mkfs on a xfs filesystem

New commits ([N]ew, [U]pdate):

Anand Jain (1):
[U]      [39bcfc9ab3dd] btrfs/122: fix nodesize option in mfks.btrfs

Andreas Gruenbacher (1):
[N]      [6e9aa61ef386] generic: Add mmap + DIO write test

Carlos Maiolino (1):
[N]      [87f90a2dae7a] common/rc: Enable _test_mkfs to force a mkfs on a xfs filesystem

Chao Yu (1):
[U]      [e8fb7a0217ba] generic/506: fix to call _scratch_enable_pquota()

Darrick J. Wong (6):
[U]      [156a8a107850] xfs/108: allow slightly higher block usage
[U]      [27d202f5c8de] xfs/155: discard stderr when checking for NEEDSREPAIR
[U]      [eef60725c850] xfs/155: improve logging in this test
[U]      [078bb0de7c21] fuzzy: disallow post-test online rebuilds when testing online fsck
[U]      [0adf9e7c0d59] xfs/503: don't rebuild the fs metadata when testing metadump
[U]      [8b88f4ca28ff] common/xfs: compress online repair rebuild output by default

Eric Sandeen (1):
[N]      [3ed1150fd7b8] xfs: test shipped config files work properly with mkfs.xfs

Qu Wenruo (4):
[N]      [685d1dadd526] btrfs: add a test case to verify read-only scrub
[N]      [2702c4208dae] btrfs: add a test case to verify the scrub error reports
[U]      [17c0dedf05fc] btrfs/106: avoid hard coded output to handle different page sizes
[U]      [ab41f0bddb73] common/btrfs: use _scratch_cycle_mount to ensure all page caches are dropped

Xiubo Li (2):
[U]      [2343f7cca021] generic/020: add ceph-fuse support
[U]      [7cef6bf6dc8d] common/rc: skip ceph-fuse when atime is required


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
