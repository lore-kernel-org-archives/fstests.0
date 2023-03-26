Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC0BC6FD1C
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Mar 2023 15:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjCZPZB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Mar 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZPZB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Mar 2023 11:25:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7211992
        for <fstests@vger.kernel.org>; Sun, 26 Mar 2023 08:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB911B80B72
        for <fstests@vger.kernel.org>; Sun, 26 Mar 2023 15:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99CCC433D2;
        Sun, 26 Mar 2023 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679844297;
        bh=TLdjKxXpTK2uX9XYvX6Ey2LDUjm69fL/rkXuEWj/fgI=;
        h=Date:From:To:Subject:From;
        b=ddX9HbURqaQf3Haw2rdsrRl1SgitCIoKbmMxVe9g8anpr9QUpSfh20vKwbmriMfMd
         iBBQXoFhaVf0gsNtBLSdn5e+fjFEEPlZMi/CZwBK+jfN6Cai1UcKaiuZ1Iu9v79CbY
         JrldJQCGhaan3HVaG2XiJkL/kw0cghuPef74CmaVzgXRq2hE2aSGxUD7w/xyh6RRAD
         m1sSXRDeKVKRNJJ762DOLxzFBc9oVew3oZQR4ZiEl8QNFXNGRdiDog5iZDxMuVcv3i
         BarLxdVmQ9jIRb/SMDiPK/10oR8EoySX6DYXFqY7Yi0eVQyMMrBq/pwdYRiTZ3pPda
         1DXhaGxrnQt7A==
Date:   Sun, 26 Mar 2023 23:24:53 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.03.19 onto master branch
Message-ID: <20230326152452.mnkkbdqatilmjt5g@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.03.19 version.

Thanks,
Zorro

The new head of the master branch is commit:

02200cb8853d xfs: stress test cycling parent pointers with online repair

New commits:

Darrick J. Wong (1):
      [02200cb8853d] xfs: stress test cycling parent pointers with online repair

Filipe Manana (2):
      [c7cc038e0a4d] btrfs/284: list a couple btrfs-progs git commits
      [caac10c77786] btrfs/286: add missing calls to _scratch_dev_pool_put and _spare_dev_put

Rodrigo Campos (9):
      [7f1135469db7] vfs: Don't open-code safe_close()
      [2f94417630d5] vfs: Fix documentation typo
      [e4332ec809d0] vfs: Use tabs to indent, not spaces
      [f4f0038d5c48] vfs: Fix race condition on get_userns_fd()
      [60de82ed2d23] vfs: Make switch_userns set PR_SET_DUMPABLE
      [dd7d35111432] vfs: Prepare tests in &s_idmapped_mounts to be reused inside a userns
      [6e230a617c67] vfs: Make idmapped core tests public
      [4dd193b59b25] vfs: Export test_setup() and test_cleanup()
      [3f96d37e3942] vfs: Add tmpfs tests for idmap mounts


Code Diffstat:

 common/fuzzy                    |  15 ++
 src/vfs/Makefile                |   4 +-
 src/vfs/idmapped-mounts.c       | 140 +++++++++---------
 src/vfs/idmapped-mounts.h       |  38 +++++
 src/vfs/tmpfs-idmapped-mounts.c | 305 ++++++++++++++++++++++++++++++++++++++++
 src/vfs/tmpfs-idmapped-mounts.h |  14 ++
 src/vfs/utils.c                 |  19 ++-
 src/vfs/utils.h                 |   4 +-
 src/vfs/vfstest.c               |  19 ++-
 src/vfs/vfstest.h               |  10 ++
 tests/btrfs/284                 |   5 +
 tests/btrfs/286                 |   3 +
 tests/tmpfs/001                 |  27 ++++
 tests/tmpfs/001.out             |   2 +
 tests/tmpfs/Makefile            |  24 ++++
 tests/xfs/799                   |  38 +++++
 tests/xfs/799.out               |   2 +
 tests/xfs/800                   |  38 +++++
 tests/xfs/800.out               |   2 +
 19 files changed, 622 insertions(+), 87 deletions(-)
--
Zorro Lang
zlang@kernel.org
