Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0B2C001B0
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Aug 2023 14:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHFOl2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Aug 2023 10:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHFOl1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Aug 2023 10:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3937B3
        for <fstests@vger.kernel.org>; Sun,  6 Aug 2023 07:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67ACD61186
        for <fstests@vger.kernel.org>; Sun,  6 Aug 2023 14:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22C3C433C7;
        Sun,  6 Aug 2023 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691332882;
        bh=g/L1q+uSRRbFCAWvkOo23XOXEqBNl7F6eEzpIMvP2IU=;
        h=Date:From:To:Subject:From;
        b=LSxDGGo+8+BYXd93D/jGQMvQFqC1bsoWAtXrudSrcyg8j3fvnze4oLg4sFiCKTkHc
         ANPSAmqsuqGwFCeF4v83H7mMXAHWjMfIcZDHJsbZ2WEivWhlygllap3OtNHVqR3xqq
         LVABRrfs/hkgmJtoylIjOEO1DdvYPjnnBaseOxZVzuDhMwIkelFr6LzXfPuaqhmc2h
         W+qTpzEnRsUzpfW317uDdGELsIsJDATcxeFlyURZaSh0UkBvy0mk8u+w4D6tEP3qav
         KD4cJQD38M4KF23EzN2ar3zANOvtxj8qvRWGMbwMvapCAQWBJmKTiOu7ZIcPOVm0+u
         An5T/7SWyT1QQ==
Date:   Sun, 6 Aug 2023 22:41:18 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.07.23 onto master branch
Message-ID: <20230806144118.3pnyk3nbm4fl7ywr@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.07.23 version.

Thanks,
Zorro

The new head of the master branch is commit:

8de535c53887 btrfs: add a test case to verify that per-fs features directory gets updated

New commits:

Alexander Larsson (1):
      [f2c9af189a76] overlay: Add test coverage for fs-verity support

Amir Goldstein (3):
      [23f643a0c3e4] overlay: add helper for mounting rdonly overlay
      [5f8c60fe8140] overlay/060: add test cases of follow to lowerdata
      [019122400875] overlay: Add test for follow of lowerdata in data-only layers

Darrick J. Wong (2):
      [1cd6b612992a] xfs: add a couple more tests for ascii-ci problems
      [d28912bad3c0] generic/558: avoid forkbombs on filesystems with many free inodes

Luís Henriques (1):
      [05574f3cfc49] common/rc: cleanup old .kmemleak files

Qu Wenruo (3):
      [6ca154c1b239] btrfs: add a test case to verify the write behavior of large RAID5 data chunks
      [9b84d93f225f] btrfs: add a test case to check btrfs won't crash on certain corruption
      [8de535c53887] btrfs: add a test case to verify that per-fs features directory gets updated


Code Diffstat:

 common/overlay        |  35 +++++-
 common/rc             |   4 +
 common/verity         |  16 ++-
 tests/btrfs/294       |  72 +++++++++++
 tests/btrfs/294.out   |   2 +
 tests/btrfs/295       |  38 ++++++
 tests/btrfs/295.out   |   2 +
 tests/btrfs/296       |  66 ++++++++++
 tests/btrfs/296.out   |   2 +
 tests/generic/558     |  27 +++--
 tests/overlay/060     |  43 ++++++-
 tests/overlay/060.out |  18 +++
 tests/overlay/079     | 325 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/079.out |  42 +++++++
 tests/overlay/080     | 326 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/080.out |   7 ++
 tests/xfs/597         |  56 +++++++++
 tests/xfs/597.out     |  24 ++++
 tests/xfs/598         | 101 ++++++++++++++++
 tests/xfs/598.out     |   9 ++
 tests/xfs/599         |  91 ++++++++++++++
 tests/xfs/599.out     |   2 +
 22 files changed, 1287 insertions(+), 21 deletions(-)
--
Zorro Lang
zlang@kernel.org
