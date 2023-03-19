Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCEC7618A
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Mar 2023 11:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCSLoF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Mar 2023 07:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCSLoF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Mar 2023 07:44:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B54815178
        for <fstests@vger.kernel.org>; Sun, 19 Mar 2023 04:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 143A9B80A6C
        for <fstests@vger.kernel.org>; Sun, 19 Mar 2023 11:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E01AC433D2;
        Sun, 19 Mar 2023 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679226240;
        bh=Ys0T1G36Vm55MkF0rSNiYsXIFwWKHeNStKfzIXB3F8A=;
        h=Date:From:To:Subject:From;
        b=QEEyL7LZUN1KIdehUKzPTdMRUOBPsmIRfnN+Wy/FdI1UlQN160ZglrpaI43fz/WUc
         /CqzzGovKF4Mw6kwDRSNGbjloc4AJJCP3kZmAWESKucIVAoIHiIv2/jpFlXjsuq+AV
         llfKPrfHJDZJ9hlt5H5c7s4TYpe6FRNG45rj27/eHdnQqzau2g+E+exwcS0AV7JgtA
         GuGE55pFshFLD+WYlopv6VW8VAGd5HIhOqnku1fuSUD3SVjFAuZs0W3r3HNg6jMJvM
         cR7VDBp4Xk41MUsGSpPg/CA7na32kbTh+ViVO/C34r2BHoQeB83cWfufCSQSsR/tJF
         c/kdftE3AIVUg==
Date:   Sun, 19 Mar 2023 19:43:56 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.03.19
Message-ID: <20230319114356.nv46k37ylxqiwhta@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.03.19 release.

Release Notes:
1. There're three new cases in this release --- tmpfs/001, xfs/799 and xfs/800.
   Those two xfs cases are not belong to auto group, and might fail on old
   kernel (which support scrub/online repair).
2. The tmpfs/001 case is the first test case for tmpfs only, so tests/tmpfs/
   directory is created with it. Besides that, new vfs/tmpfs-idmapped-mounts.[c,h]
   are created for tmpfs idmapped testing. Welcome more tmpfs test cases.
3. More updates on src/vfs and btrfs part.

Thanks for all these contribution!
Zorro

The new head of the for-next branch is commit:

02200cb8853d xfs: stress test cycling parent pointers with online repair

New commits ([N]ew, [U]pdate):

Darrick J. Wong (1):
[N]      [02200cb8853d] xfs: stress test cycling parent pointers with online repair

Filipe Manana (2):
[U]      [c7cc038e0a4d] btrfs/284: list a couple btrfs-progs git commits
[U]      [caac10c77786] btrfs/286: add missing calls to _scratch_dev_pool_put and _spare_dev_put

Rodrigo Campos (9):
[U]      [7f1135469db7] vfs: Don't open-code safe_close()
[U]      [2f94417630d5] vfs: Fix documentation typo
[U]      [e4332ec809d0] vfs: Use tabs to indent, not spaces
[U]      [f4f0038d5c48] vfs: Fix race condition on get_userns_fd()
[U]      [60de82ed2d23] vfs: Make switch_userns set PR_SET_DUMPABLE
[U]      [dd7d35111432] vfs: Prepare tests in &s_idmapped_mounts to be reused inside a userns
[U]      [6e230a617c67] vfs: Make idmapped core tests public
[U]      [4dd193b59b25] vfs: Export test_setup() and test_cleanup()
[N]      [3f96d37e3942] vfs: Add tmpfs tests for idmap mounts


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
