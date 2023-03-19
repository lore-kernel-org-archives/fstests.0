Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C7AC7618A
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Mar 2023 11:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCSLky (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Mar 2023 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSLkx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Mar 2023 07:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAAC6E9B
        for <fstests@vger.kernel.org>; Sun, 19 Mar 2023 04:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F2560FC5
        for <fstests@vger.kernel.org>; Sun, 19 Mar 2023 11:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFBDC433D2;
        Sun, 19 Mar 2023 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679226051;
        bh=vTnUttGAc6av1gWNbQrVo7TOKqNaNqGly0Mp7z9zbXY=;
        h=Date:From:To:Subject:From;
        b=uG+qYk4Wj5Rq/r/bs7YJSioZ0dKPG/uIrH+kEYnj+DNJRl6utu17QKF3zA/RrlSDa
         YSTnYH2spvsPDgdYjYUV/oQM82/TJa82v+t1ycPGoNR0hdSopwtwDbIsG2GhlbgO4H
         PPloGYC1I7zC5t9eXUegKCPmagK+7lmKns/xHi2m4f8tbMkWuNyeJq3n/L0RLn30Mw
         5qYZFZwYTb+wLTOeuXrG+pt64x4EqnqIW2tlOXM7qo4iYlOb8iwD0agpacPU/ItBdI
         Y+YbXWJCFsNmKVt8CqBxPa6vkRLXHZWwQd0f5oX2Cpbpj17uU2p14uvIz/vQw9jZiX
         wXzZbZhX5JnsQ==
Date:   Sun, 19 Mar 2023 19:40:46 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.03.05 onto master branch
Message-ID: <20230319114046.bcvhu453hsshtazy@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.03.05 version.

Thanks,
Zorro

The new head of the master branch is commit:

f7765774a1b5 generic/020: fix really long attr test failure for ceph

New commits:

Darrick J. Wong (12):
      [e19c99400cfe] xfs/122: fix for swapext log items
      [5d2aea2b1f6d] generic: test old xfs extent swapping ioctl
      [815ea9365230] generic: test new vfs swapext ioctl
      [81cbafc4597a] generic, xfs: test scatter-gather atomic file updates
      [f02d41a7b5ca] generic: test that file privilege gets dropped with FIEXCHANGE_RANGE
      [bf183828b8f4] fsx: support FIEXCHANGE_RANGE
      [ae5ac04996c5] fsstress: update for FIEXCHANGE_RANGE
      [d8cf497797b0] xfs: race fsstress with online repair of realtime summary files
      [a199f989b6f1] xfs: race fsstress with online repair of extended attribute data
      [249f5a78d309] xfs: ensure that online directory repairs don't hit EDQUOT
      [0999380268ab] xfs: race fsstress with online repair of dirs and parent pointers
      [fc0a397e3ec4] xfs: test xfs_scrub dry run, preen, and repair mode

Johannes Thumshirn (1):
      [b3096c996a48] common/rc: don't clear superblock for zoned scratch pools

Xiubo Li (1):
      [f7765774a1b5] generic/020: fix really long attr test failure for ceph


Code Diffstat:

 common/rc             |  36 ++++++++++-
 common/reflink        |  33 ++++++++++
 common/xfs            |  19 ++++++
 configure.ac          |   1 +
 doc/group-names.txt   |   2 +
 include/builddefs.in  |   1 +
 ltp/Makefile          |   4 ++
 ltp/fsstress.c        | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++
 ltp/fsx.c             | 160 ++++++++++++++++++++++++++++++++++++++++++++++-
 m4/package_libcdev.m4 |  20 ++++++
 src/fiexchange.h      | 101 ++++++++++++++++++++++++++++++
 src/global.h          |   6 ++
 tests/generic/020     |   6 +-
 tests/generic/709     |  55 +++++++++++++++++
 tests/generic/709.out |   3 +
 tests/generic/710     |  53 ++++++++++++++++
 tests/generic/710.out |   4 ++
 tests/generic/711     |  47 ++++++++++++++
 tests/generic/711.out |   2 +
 tests/generic/712     |  58 +++++++++++++++++
 tests/generic/712.out |   2 +
 tests/generic/713     | 100 ++++++++++++++++++++++++++++++
 tests/generic/713.out |  86 ++++++++++++++++++++++++++
 tests/generic/714     | 116 ++++++++++++++++++++++++++++++++++
 tests/generic/714.out |  90 +++++++++++++++++++++++++++
 tests/generic/715     |  76 +++++++++++++++++++++++
 tests/generic/715.out |  32 ++++++++++
 tests/generic/716     | 122 ++++++++++++++++++++++++++++++++++++
 tests/generic/716.out |  48 +++++++++++++++
 tests/generic/717     | 101 ++++++++++++++++++++++++++++++
 tests/generic/717.out |  33 ++++++++++
 tests/generic/718     |  48 +++++++++++++++
 tests/generic/718.out |   6 ++
 tests/generic/719     | 105 +++++++++++++++++++++++++++++++
 tests/generic/719.out |  40 ++++++++++++
 tests/generic/720     |  58 +++++++++++++++++
 tests/generic/720.out |   2 +
 tests/generic/721     | 126 +++++++++++++++++++++++++++++++++++++
 tests/generic/721.out |  48 +++++++++++++++
 tests/generic/722     |  63 +++++++++++++++++++
 tests/generic/722.out |   2 +
 tests/generic/723     |  70 +++++++++++++++++++++
 tests/generic/723.out |   2 +
 tests/generic/724     |  53 ++++++++++++++++
 tests/generic/724.out |   6 ++
 tests/generic/725     |  56 +++++++++++++++++
 tests/generic/725.out |   4 ++
 tests/generic/726     | 115 ++++++++++++++++++++++++++++++++++
 tests/generic/726.out |  49 +++++++++++++++
 tests/generic/727     |  83 +++++++++++++++++++++++++
 tests/generic/727.out |  17 +++++
 tests/xfs/122.out     |   3 +
 tests/xfs/537         |   2 +-
 tests/xfs/789         |  59 ++++++++++++++++++
 tests/xfs/789.out     |  12 ++++
 tests/xfs/790         |  62 +++++++++++++++++++
 tests/xfs/790.out     |  10 +++
 tests/xfs/791         |  59 ++++++++++++++++++
 tests/xfs/791.out     |   7 +++
 tests/xfs/792         |  61 ++++++++++++++++++
 tests/xfs/792.out     |   5 ++
 tests/xfs/793         |  48 +++++++++++++++
 tests/xfs/793.out     |   2 +
 tests/xfs/794         |  40 ++++++++++++
 tests/xfs/794.out     |   2 +
 tests/xfs/795         |  77 +++++++++++++++++++++++
 tests/xfs/795.out     |   3 +
 tests/xfs/796         |  37 +++++++++++
 tests/xfs/796.out     |   2 +
 tests/xfs/797         |  38 ++++++++++++
 tests/xfs/797.out     |   2 +
 tests/xfs/798         | 105 +++++++++++++++++++++++++++++++
 tests/xfs/798.out     |  32 ++++++++++
 73 files changed, 3198 insertions(+), 8 deletions(-)
--
Zorro Lang
zlang@kernel.org
