Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20097C83F11
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Aug 2023 14:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjH0OLN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Aug 2023 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjH0OKt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Aug 2023 10:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73298B9
        for <fstests@vger.kernel.org>; Sun, 27 Aug 2023 07:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11ED662185
        for <fstests@vger.kernel.org>; Sun, 27 Aug 2023 14:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57C9C433C8;
        Sun, 27 Aug 2023 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693145445;
        bh=rK52oo5nigGPr9RrfWJUlwPQ9ACy9Zpanq/6u1nFS1Y=;
        h=Date:From:To:Subject:From;
        b=YDGlcLHBepoYEpIqwP3ZGykil1M5F2pDiN2Jj94rmNSC+BwRgxN7yQk/CG3DjQJLZ
         b5o1BDtcfiP4NiQz/3lruQhkUJbwK0CRDmvRAK2Ruq7td7ZsUCFPVZH250Xq4YkjhW
         bCAZ+FDvQ5VXrY9AWyKwz/1HQvL2oC8eAdJpyl759DVz7UGNyBwziEA/Y9wiV5gOUd
         Tdlia/JdhoHqr9ywoGNdp6bWa+SxbsWvfJY5+yvt6sZ161ZDSjxGO5yqtKnI1O7X+I
         7dcmwiFVXmS9zyZ0wl/UDF//Uxp9NyPYa3SXtbXs/kFlOkthcma+I1eCdDDt5V/T4G
         lDfXI8I4TqL9A==
Date:   Sun, 27 Aug 2023 22:10:38 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.08.06 onto master branch
Message-ID: <20230827141038.2icpo6q5jk32sjnh@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.08.06 version.

Thanks,
Zorro

The new head of the master branch is commit:

0ca1d4fbb2e9 xfs: skip fragmentation tests when alwayscow mode is enabled, part 2

New commits:

Christoph Hellwig (2):
      [625b651b3060] generic: add a test for device removal with dirty data
      [b716634e75d2] generic: add a test for device removal without dirty data

Darrick J. Wong (4):
      [03d27d802569] xfs/122: adjust test for flexarray conversions in 6.5
      [d39fb9a81d76] check: generate gcov code coverage reports at the end of each section
      [d542fbc4ccef] generic/642: fix SOAK_DURATION usage in generic/642
      [0ca1d4fbb2e9] xfs: skip fragmentation tests when alwayscow mode is enabled, part 2

Filipe Manana (1):
      [24cfe625794e] btrfs/276: make test accurate regarding number of expected extents

Luis Chamberlain (1):
      [a0c36009103b] fstests: add helper to canonicalize devices used to enable persistent disks

Qu Wenruo (2):
      [e573069170b6] btrfs/294: reject zoned devices for now
      [d74975e2c284] btrfs: add a test case to make sure scrub can repair parity corruption

Theodore Ts'o (1):
      [32201166fb09] fstests: install soak_duration.awk

Zorro Lang (1):
      [3f86deef7cbd] fstests: add smoketest group


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
