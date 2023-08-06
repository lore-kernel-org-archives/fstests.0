Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636BC001B0
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Aug 2023 14:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHFOp4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Aug 2023 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHFOpz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Aug 2023 10:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9FCC2
        for <fstests@vger.kernel.org>; Sun,  6 Aug 2023 07:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD816117F
        for <fstests@vger.kernel.org>; Sun,  6 Aug 2023 14:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D51C433C8;
        Sun,  6 Aug 2023 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691333153;
        bh=cMopr0SAvuVemITehxO9YUEhf1UEBKzNrtL+HE5KUrI=;
        h=Date:From:To:Subject:From;
        b=alLvRA4s0/bjyJ0wjlBM0zfO4BgGbtBKyHhovC7JqZoRqMJVP6l5wqWRMLh9uD3Kz
         JfLJqcp4ikrUj2VyvQFHlRw+a9v7XDA6RIykJLloH93UHxIyToBEFKppf3xPgJKRKH
         TWA8s5zp5vpRsHhdW6O5CNUEQ/yd33eSJbq2CXuMBKoDZj+/qzN4l9/ctwYmuC6oUn
         6MfPa5gHRlBG4a2tBZzCwzKffDkx2VMfOI+CLdfa0v+EKBqyKYN4xRJWLq/fPn5Yz4
         vyZdrKnG3yD6XAKNm1hjZO+L3vm6xYJK2wuwKAaO0LDkDJQg9Fw1VIwfD80aelqlSp
         PuQh8dN61WOJA==
Date:   Sun, 6 Aug 2023 22:45:49 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.08.06
Message-ID: <20230806144549.r7xxsy5a22dowc37@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.08.06 release.

Release Notes:
1) There're 3 new test cases in this release -- generic/730, generic/731 and
   btrfs/297. They won't hang or panic on upstream or downstream kernel.
   generic/730 might fail as "WARNING: possible circular locking dependency
   detected", refer to:
   https://lore.kernel.org/fstests/20230806141145.2lpntvfn7kqglads@zlang-mailbox/T/#u

2) A new global parameter "CANON_DEVS" helps to follow symlink of devices (e.g.
   TEST_DEV=/dev/disk/by-id/nvme-eui.0035385411904c1e) to get real name. (Don't
   follow by default).

3) Another new global parameter "REPORT_GCOV" helps to generate gcov code
   coverage reports. This brings in a new file common/gcov.

4) A new test group -- "smoketest". Set SOAK_DURATION=5m (or other time), then
   run ./check -g smoketest, you'll get a quick (~30m) fs smoke test. If you'd
   like to review a RFC patch (not merged) about this, refer to:
   https://lore.kernel.org/fstests/20230727185315.530134-3-zlang@kernel.org/

More bug fixes and details refer to below, thanks for all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

0ca1d4fbb2e9 xfs: skip fragmentation tests when alwayscow mode is enabled, part 2

New commits ([N]ew file/case, [U]pdate):

Christoph Hellwig (2):
[N]      [625b651b3060] generic: add a test for device removal with dirty data
[N]      [b716634e75d2] generic: add a test for device removal without dirty data

Darrick J. Wong (4):
[U]      [03d27d802569] xfs/122: adjust test for flexarray conversions in 6.5
[N]      [d39fb9a81d76] check: generate gcov code coverage reports at the end of each section
[U]      [d542fbc4ccef] generic/642: fix SOAK_DURATION usage in generic/642
[U]      [0ca1d4fbb2e9] xfs: skip fragmentation tests when alwayscow mode is enabled, part 2

Filipe Manana (1):
[U]      [24cfe625794e] btrfs/276: make test accurate regarding number of expected extents

Luis Chamberlain (1):
[U]      [a0c36009103b] fstests: add helper to canonicalize devices used to enable persistent disks

Qu Wenruo (2):
[U]      [e573069170b6] btrfs/294: reject zoned devices for now
[N]      [d74975e2c284] btrfs: add a test case to make sure scrub can repair parity corruption

Theodore Ts'o (1):
[U]      [32201166fb09] fstests: install soak_duration.awk

Zorro Lang (1):
[U]      [3f86deef7cbd] fstests: add smoketest group


Code Diffstat:

 README                |  6 ++++
 check                 | 19 +++++++++++
 common/config         | 32 ++++++++++++++++++-
 common/gcov           | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/group-names.txt   |  1 +
 src/Makefile          |  3 +-
 tests/btrfs/276       | 86 ++++++++++++++++++++++++++++++++------------------
 tests/btrfs/276.out   | 20 ++++++------
 tests/btrfs/294       |  8 +++--
 tests/btrfs/297       | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/297.out   |  2 ++
 tests/generic/475     |  2 +-
 tests/generic/476     |  2 +-
 tests/generic/521     |  2 +-
 tests/generic/522     |  2 +-
 tests/generic/642     |  4 +--
 tests/generic/730     | 57 +++++++++++++++++++++++++++++++++
 tests/generic/730.out |  2 ++
 tests/generic/731     | 58 ++++++++++++++++++++++++++++++++++
 tests/generic/731.out |  2 ++
 tests/xfs/122         |  8 +++++
 tests/xfs/180         |  1 +
 tests/xfs/208         |  1 +
 23 files changed, 438 insertions(+), 52 deletions(-)
--
Zorro Lang
zlang@kernel.org
