Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CDFC3DA7A
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Dec 2022 16:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLYQJf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Dec 2022 11:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYQJe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Dec 2022 11:09:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF6A2DEC
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2022 08:09:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71060B803F3
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2022 16:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A31BC433D2;
        Sun, 25 Dec 2022 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671984571;
        bh=GmuuAcOV91zCcOUjyssDguVNapjMhS2FvGskTHXap8g=;
        h=Date:From:To:Subject:From;
        b=lepR+yJhw6fOTK5JdmxTacK/d03WOdzC03gh7U2G04Vzp/CIewolywUDdVRgWQPkg
         tcVVaCldHB0YKrkULwiTm7sE9CpOPvbAF9zpavzj9EvtUe21GBp4ZAEI0roj8xrsEe
         nt+Wb3k/aFsybzT03h9FCGKh4+IDMfTijVxoBiAuVSxZ8kNh7mdUjTK+mBsp2Izzk7
         iPrFdEns+3T3UbpAQarRyTRwBGSsXEJ9sKMfWyG4CU5v9om8qfCnPb7K3CBGNbt4rq
         lAC3BOWNXTCmju6l6SJprXgt/eMvHXj22ruqLd5jV66XahI7bKVCpGcyfHoVCwgUsK
         kacTTWkPHyBhw==
Date:   Mon, 26 Dec 2022 00:09:27 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 3dc46f477b39
Message-ID: <20221225160927.qb7iuzjrnbc6dzb2@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.12.25 release.

Release Notes:
1) There're 4 new cases this week -- btrfs/299, xfs/55[7,8,9]. They're all
   regression test cases.
2) xfs/122 will fail on old linux kernel, although it's passed for long time.
   Due to xfs changed its log format a bit, so xfs/122 changed its expected
   result to match that.

More details please refer to below, thanks for all your contribution, and
*Merry Christmas*!

Thanks,
Zorro

The new head of the for-next branch is commit:

3dc46f477b39 btrfs/154: migrate to python3

New commits ([N]ew, [U]pdate):

Boris Burkov (1):
[N]      [d401145dc1c9] btrfs: new test for logical inode resolution panic

Darrick J. Wong (4):
[U]      [40e983b21375] xfs/122: fix EFI/EFD log format structure size after flex array conversion
[N]      [884daafcd9cc] xfs: regression test for writeback corruption bug
[N]      [5f291f3c9a84] xfs: regression test for writes racing with reclaim writeback
[U]      [56c8f841407c] xfs/179: modify test to trigger refcount update bugs

Hironori Shiina (1):
[N]      [db5626a15a6e] xfs: Test bulkstat special query for root inode

Qu Wenruo (2):
[U]      [daa1c02369c8] btrfs/220: fix the test failure due to new default mount option
[U]      [3dc46f477b39] btrfs/154: migrate to python3


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
