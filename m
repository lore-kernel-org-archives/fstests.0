Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D9C83F11
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Aug 2023 14:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjH0OPL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Aug 2023 10:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjH0OOa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Aug 2023 10:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F318011B
        for <fstests@vger.kernel.org>; Sun, 27 Aug 2023 07:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A6F620BB
        for <fstests@vger.kernel.org>; Sun, 27 Aug 2023 14:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D04C433C7;
        Sun, 27 Aug 2023 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693145666;
        bh=nqbAW1VzZ/zZg3Sny4Q3i/0TzMJz/8IWgiBvmuUBQVc=;
        h=Date:From:To:Subject:From;
        b=ogXRAdawaJrf/p3g/dJDp4wFemAXLD5FMRTq2FXf7calKfx3f69ecHc7K4VW0gVQ/
         xZ7mpIOGEHNpqlwC/dTQBnzM8slu1CbeYqpWmdy8MARWVTUhrpTPfLob3qSxofTKUi
         RCA7XLFH9r6/IoL8+2iZrtEUMNele+BmTNH+E1dZjm0CMUZG6O8fSxtuQQbbRUrAG9
         41sI8AdT4baSAEaQZ2wm4V1G2d76CnKvTjpOqHTWi3AVH3Dq6+nHl5dfnex9MdxzN4
         W2e6dawM5w7O6qoVKM3gT5pmgnvghp/iK/VITdTwFlrG4BQec3B8oD8v7PEDt9Wabq
         S0BFnCi118xgQ==
Date:   Sun, 27 Aug 2023 22:14:21 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.08.27
Message-ID: <20230827141421.kvxewenzjccfouxw@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.08.27 release.

Release Notes:
1) There's a new test case (btrfs/300) in this release, meanwhile an invalid
   test case (generic/471) is removed.
2) A new helper _random_file() helps to improve the performance to get a random
   file name in a directory.

More bug fixes or improvement refer to below. Thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

fd94fc408b3e generic/471: Remove this broken case

New commits ([N]ew, [U]pdate, [D]elete):

Amir Goldstein (2):
[U]      [6d63f23987a6] check: fix parsing expunge file with comments
[U]      [9caf3ee07d0d] generic/{175,297,298}: fix use of uninitialized var

David Disseldorp (1):
[U]      [515adab889b9] common/rc: drop 'fsck -f' parameter from _repair_test_fs

Filipe Manana (1):
[U]      [4a78fc26ab16] btrfs/213: fix failure due to misspelled function name

Lee Trager (1):
[N]      [eccdeae8fc41] fstests: Verify dir permissions when creating a stub subvolume

Naohiro Aota (4):
[U]      [697988c94e87] btrfs/220: do not run async discard test on zoned device
[U]      [778364fffb35] common/rc: introduce _random_file() helper
[U]      [4dd2822ae01a] fstests/btrfs: use _random_file() helper
[U]      [a0c6958c0e36] btrfs/004: use shuf to shuffle the file lines

Qu Wenruo (1):
[U]      [79d409ce9e39] fstests: fsstress: wait interrupted aio to finish

Shiyang Ruan (1):
[U]      [d9b0c584e25b] fsx: tidy options usage and format

Stas Sergeev (2):
[U]      [857c18868a0e] t_ofd_locks: fix stalled semaphore handling
[U]      [ae154c192b95] t_ofd_locks: fix sem initialization sequence

Yang Xu (1):
[D]      [fd94fc408b3e] generic/471: Remove this broken case


Code Diffstat:

 check                 |   4 +-
 common/rc             |  14 +++++-
 ltp/fsstress.c        |  20 ++++++++-
 ltp/fsx.c             |  29 +++++++-----
 src/t_ofd_locks.c     | 121 +++++++++++++++++++++-----------------------------
 tests/btrfs/004       |   2 +-
 tests/btrfs/179       |   9 ++--
 tests/btrfs/192       |  14 ++----
 tests/btrfs/213       |   2 +-
 tests/btrfs/220       |   4 +-
 tests/btrfs/300       |  52 ++++++++++++++++++++++
 tests/btrfs/300.out   |  18 ++++++++
 tests/generic/175     |   1 -
 tests/generic/297     |   1 -
 tests/generic/298     |   1 -
 tests/generic/471     |  67 ----------------------------
 tests/generic/471.out |  13 ------
 tests/generic/478     |  37 +++++++++++++--
 tests/overlay/020     |   7 +--
 19 files changed, 219 insertions(+), 197 deletions(-)
--
Zorro Lang
zlang@kernel.org
