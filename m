Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE62C636CC
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Feb 2023 14:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjBTOqy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Feb 2023 09:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjBTOqx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Feb 2023 09:46:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962131555D
        for <fstests@vger.kernel.org>; Mon, 20 Feb 2023 06:46:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43756B80B9A
        for <fstests@vger.kernel.org>; Mon, 20 Feb 2023 14:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F85EC433D2;
        Mon, 20 Feb 2023 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676904409;
        bh=OiSncXmTQ4BkyK3ohnG0SX/3z0VQjorbBGn0gQDJ61Y=;
        h=Date:From:To:Subject:From;
        b=PPwIWpFASHzyUoAHxG5/4MyJTnOSdUui2R4ZmRy2IpuFgU4aa9Y46VEy6vC4O1COw
         pr9kZJrwT3d2kP2x25csMs4uP7+nidSuwu+cF53sDBSZn4dTUXbnmMd09mUsQUO8vC
         WhK2Mpzsj4kZRUveej0HYdftEfbDCEGvtwU2sGkSToSsoII7bcIlsdZv9fszBfpV4j
         Z1qS3vAyOtjmq0qf+9CJR3Qi1g1+w85dgknomNjHS8JBSNgrzIXQyhOCh5Kczy3ooK
         RuCBW0/lqJgF26aNbCLLqBd37V0aizEAGA+CZgMML1UukfFADrCKA2CfUBxz4/t7xV
         uUHVcJlrBXs9g==
Date:   Mon, 20 Feb 2023 22:46:44 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.02.19
Message-ID: <20230220144644.y5oj2uvyskite4ec@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.02.19 release.

Release notes:
1) There're 25 new cases this week --- btrfs/285 and xfs/708~732. The btrfs/285
   is in default auto test group, but xfs/708~732 are not in auto group, they're
   about xfs online repair/scrub tests.
2) As more cases were added into auto test group last week, so this release add
   more _fixed_by/_wants tags to these cases, to help to clarify some failures
   might happen on old downstream kernel.

More update or bug fix refer to below. Thanks for all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

9ba85b9a6f0f populate: fix some weirdness in __populate_check_xfs_agbtree_height

New commits ([N]ew, [U]pdate):

An Long (1):
[U]      [4eb6985b70ab] btrfs/011: use $_btrfs_profile_configs to limit the tests

Anand Jain (2):
[U]      [085ee672b3d8] fstests: btrfs/185, 198 and 219 add _fixed_by_kernel_commit
[U]      [63c4983ca5c5] fstests: btrfs/249: add _wants_kernel_commit and _fixed_by_git_commit

Boris Burkov (1):
[N]      [150efa34087d] btrfs: test block group size class loading logic

Darrick J. Wong (16):
[U]      [89224e31d44a] fuzzy: use FORCE_REBUILD over injecting force_repair
[U]      [2690ec99261d] xfs: test rebuilding the entire filesystem with online fsck
[N]      [76070f8f0e2c] xfs: stress test ag repair functions
[N]      [4ec8fcc61022] xfs: race fsstress with online repair for inode record metadata
[N]      [b3fc8bc8f7c0] xfs: test rebuilding xattrs when the data fork is btree format
[N]      [ee1df86f65be] xfs: race fsstress with online repair for inode and fork metadata
[N]      [4d1f5cae8771] xfs: ensure that online file data fork repairs don't hit EDQUOT
[N]      [74a089e8bcb4] xfs: race fsstress with online repair for special file metadata
[N]      [82d24c3cdac7] xfs: race fsstress with online scrub and repair for quota metadata
[N]      [3a4d641020e8] xfs: race fsstress with online scrub and repair for quotacheck
[N]      [c2c1a3f8c423] xfs: race fsstress with inode link count check and repair
[N]      [a02d2818e9d1] xfs: test fs summary counter online repair
[N]      [74065e2f1821] xfs: race fsstress with online repair for summary counters
[U]      [a6cbb0cc0d5e] xfs/422: don't freeze while racing rmap repair and fsstress
[U]      [215075d03ddf] populate: take a snapshot of the filesystem if creation fails
[U]      [9ba85b9a6f0f] populate: fix some weirdness in __populate_check_xfs_agbtree_height

Filipe Manana (1):
[U]      [2cbd24f84a63] generic/604: fix test to actually create dirty inodes


Code Diffstat:

 README              |  3 ++
 common/btrfs        |  3 ++
 common/fuzzy        | 71 +++++++++++++++++++++++++++++++++++---------
 common/populate     | 70 ++++++++++++++++++++++++++++---------------
 common/rc           |  2 +-
 common/xfs          | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/011     | 30 +++++++++++--------
 tests/btrfs/185     |  2 ++
 tests/btrfs/198     |  6 ++--
 tests/btrfs/219     |  9 +++---
 tests/btrfs/249     |  7 +++--
 tests/btrfs/285     | 50 +++++++++++++++++++++++++++++++
 tests/btrfs/285.out |  2 ++
 tests/generic/604   |  2 +-
 tests/xfs/422       |  4 +--
 tests/xfs/708       | 37 +++++++++++++++++++++++
 tests/xfs/708.out   |  2 ++
 tests/xfs/709       | 37 +++++++++++++++++++++++
 tests/xfs/709.out   |  2 ++
 tests/xfs/710       | 38 ++++++++++++++++++++++++
 tests/xfs/710.out   |  2 ++
 tests/xfs/711       | 37 +++++++++++++++++++++++
 tests/xfs/711.out   |  2 ++
 tests/xfs/712       | 37 +++++++++++++++++++++++
 tests/xfs/712.out   |  2 ++
 tests/xfs/713       | 37 +++++++++++++++++++++++
 tests/xfs/713.out   |  2 ++
 tests/xfs/714       | 37 +++++++++++++++++++++++
 tests/xfs/714.out   |  2 ++
 tests/xfs/715       | 38 ++++++++++++++++++++++++
 tests/xfs/715.out   |  2 ++
 tests/xfs/716       | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/716.out   |  2 ++
 tests/xfs/717       | 37 +++++++++++++++++++++++
 tests/xfs/717.out   |  2 ++
 tests/xfs/718       | 39 ++++++++++++++++++++++++
 tests/xfs/718.out   |  2 ++
 tests/xfs/719       | 39 ++++++++++++++++++++++++
 tests/xfs/719.out   |  2 ++
 tests/xfs/720       | 72 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/720.out   |  3 ++
 tests/xfs/721       | 38 ++++++++++++++++++++++++
 tests/xfs/721.out   |  2 ++
 tests/xfs/722       | 39 ++++++++++++++++++++++++
 tests/xfs/722.out   |  2 ++
 tests/xfs/723       | 40 +++++++++++++++++++++++++
 tests/xfs/723.out   |  2 ++
 tests/xfs/724       | 40 +++++++++++++++++++++++++
 tests/xfs/724.out   |  2 ++
 tests/xfs/725       | 40 +++++++++++++++++++++++++
 tests/xfs/725.out   |  2 ++
 tests/xfs/726       | 40 +++++++++++++++++++++++++
 tests/xfs/726.out   |  2 ++
 tests/xfs/727       | 40 +++++++++++++++++++++++++
 tests/xfs/727.out   |  2 ++
 tests/xfs/728       | 38 ++++++++++++++++++++++++
 tests/xfs/728.out   |  2 ++
 tests/xfs/729       | 37 +++++++++++++++++++++++
 tests/xfs/729.out   |  2 ++
 tests/xfs/730       | 36 +++++++++++++++++++++++
 tests/xfs/730.out   |  4 +++
 tests/xfs/731       | 41 ++++++++++++++++++++++++++
 tests/xfs/731.out   |  2 ++
 tests/xfs/732       | 46 +++++++++++++++++++++++++++++
 tests/xfs/732.out   |  2 ++
 65 files changed, 1369 insertions(+), 67 deletions(-)
--
Zorro Lang
zlang@kernel.org
