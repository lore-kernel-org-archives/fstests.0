Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A815C4708E
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Jan 2023 13:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjAANyZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Jan 2023 08:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAANyY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Jan 2023 08:54:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235C525EB
        for <fstests@vger.kernel.org>; Sun,  1 Jan 2023 05:54:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A181360D3E
        for <fstests@vger.kernel.org>; Sun,  1 Jan 2023 13:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BB2C433EF
        for <fstests@vger.kernel.org>; Sun,  1 Jan 2023 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672581263;
        bh=it/4MJ2XGM1/qsKnSfVDwq1cFc3W/+pWOoBTp8Vp5g0=;
        h=Date:From:To:Subject:From;
        b=cKEdg+Ji4SUNUsyO6IZ+U3vqhvZ2hXB3IIOfyRePiDQ5SY6GaZMaXG2TRD0I9YQFx
         d3OanEva38jqRvzV8+Uqa2zAvXg/cG0UXHS+aKL0hOnJUPd4Jnu2mu3e3+KdPm7p3G
         HQ2YboJAdOofngwP6X3e3IFHIQraWx8zAHUrwGH0ajrfJ5TZkUEZ/JQo53RrPe2RYZ
         bYDYAj2gNuaZzREDA177Rua8I++pYhGyUMmG4TGF1xZdEVdJ0SPr/5qaom+UWwUnQM
         pf8GTUNENIBDFRV5eayQuT4maCxz+YO/MkwFyqfmG/LeOAC85hhMAflbi/xGZjMAgu
         0kUcLXqg+I8oA==
Date:   Sun, 1 Jan 2023 21:54:19 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.12.25 onto master branch
Message-ID: <20230101135419.i5ezvazhjwwgpozy@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.12.25 version.

Thanks,
Zorro

The new head of the master branch is commit:

3dc46f477b39 btrfs/154: migrate to python3

New commits:

Boris Burkov (1):
      [d401145dc1c9] btrfs: new test for logical inode resolution panic

Darrick J. Wong (4):
      [40e983b21375] xfs/122: fix EFI/EFD log format structure size after flex array conversion
      [884daafcd9cc] xfs: regression test for writeback corruption bug
      [5f291f3c9a84] xfs: regression test for writes racing with reclaim writeback
      [56c8f841407c] xfs/179: modify test to trigger refcount update bugs

Hironori Shiina (1):
      [db5626a15a6e] xfs: Test bulkstat special query for root inode

Qu Wenruo (2):
      [daa1c02369c8] btrfs/220: fix the test failure due to new default mount option
      [3dc46f477b39] btrfs/154: migrate to python3


Code Diffstat:

 common/config                   |   2 +-
 common/rc                       |  35 +++++++
 common/tracing                  |  66 +++++++++++++
 src/btrfs_crc32c_forged_name.py |  22 +++--
 tests/btrfs/154                 |   4 +-
 tests/btrfs/220                 |  10 +-
 tests/btrfs/299                 | 103 ++++++++++++++++++++
 tests/btrfs/299.out             |   2 +
 tests/xfs/122                   |   5 +
 tests/xfs/122.out               |   8 +-
 tests/xfs/179                   |  32 +++++-
 tests/xfs/557                   |  63 ++++++++++++
 tests/xfs/557.out               |   2 +
 tests/xfs/558                   | 210 ++++++++++++++++++++++++++++++++++++++++
 tests/xfs/558.out               |   2 +
 tests/xfs/559                   | 126 ++++++++++++++++++++++++
 tests/xfs/559.out               |   2 +
 17 files changed, 676 insertions(+), 18 deletions(-)
--
Zorro Lang
zlang@kernel.org
