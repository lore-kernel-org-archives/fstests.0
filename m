Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B8DC77B7C
	for <linux-fstests@archiver.kernel.org>; Sun, 28 May 2023 14:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjE1Odl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 May 2023 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1Odk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 May 2023 10:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE579BD
        for <fstests@vger.kernel.org>; Sun, 28 May 2023 07:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC8060CA0
        for <fstests@vger.kernel.org>; Sun, 28 May 2023 14:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1437FC433D2;
        Sun, 28 May 2023 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685284418;
        bh=jxlBOTModJoltPgqEJTp+W0V4HIWhifJUxH5wR/skNE=;
        h=Date:From:To:Subject:From;
        b=B1zc3DEMdk9Ujk9jJ2XGyfwUCOYNFahrtc0TjoZjUoUHKuwL1BQFdklIzlPIcgEJU
         mpZFkv0Hz1j65HXOXWBfaOt0BNkYo4tO4WE+43YsMDVnxZ8gHNcLa/T4uBL1Op0rfx
         pdF0Bskfa4DnKAc7fMhJ1qPM8i2CaYMIM7pvZK0aO2B60uad5lhMESdlPEj1DFmIH5
         XdAryj3dB8Bd4rIMIBhX8bc2jAJAWsYD+ZZpCi0hFfmHL2+E6vO3qAbpu/dG1eGY3y
         V6gDZ3v113GGebVEL38qsmdzkxbx74xzZYcTWLBF5yiS5RX/KMJEjW+OM3HL4AbfHT
         HuLbQAESBA+OA==
Date:   Sun, 28 May 2023 22:33:34 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.05.14 onto master branch
Message-ID: <20230528143334.kdsv4hju5ehlqqtl@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.05.14 version.

Thanks,
Zorro

The new head of the master branch is commit:

33144e0693b5 generic/{094,225}: drop the file allocation unit requirements

New commits:

Darrick J. Wong (7):
      [8c5f19b701ea] fsx: fix indenting of columns in bad buffers report
      [f093a7503a6a] xfs/262: remove dangerous labels
      [23e11f53b4b6] generic/724,xfs/791: adjust test preconditions for post-EOF stripe zeroing
      [715d052a8faf] xfs/{243,245,272,274}: ignore raid alignment flags in bmap output
      [c387c694bde3] fiemap-tester: holes can be backed by unwritten extents
      [6a0bba58d043] fiemap: FIEMAP_EXTENT_LAST denotes the last record in the recordset
      [33144e0693b5] generic/{094,225}: drop the file allocation unit requirements

Filipe Manana (5):
      [a580ecd1dfc6] common/btrfs: add helper to get the bytenr for a file extent item
      [f635f9c3153c] btrfs: add a test case for the logical to ino ioctl
      [7ab65dae2751] groups: add logical_resolve group for btrfs
      [802f42f7a5b2] btrfs/254: correct subject of the relevant kernel patch and add git commit
      [e35817daa103] btrfs/228: sync filesystem after creating subvolume


Code Diffstat:

 common/btrfs        |  52 ++++++++++++++++++
 doc/group-names.txt |   1 +
 ltp/fsx.c           |   9 +--
 src/fiemap-tester.c |  25 ++++-----
 tests/btrfs/004     |   2 +-
 tests/btrfs/228     |   5 ++
 tests/btrfs/254     |   6 +-
 tests/btrfs/287     | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/287.out |  95 ++++++++++++++++++++++++++++++++
 tests/btrfs/299     |  20 +------
 tests/generic/094   |   5 --
 tests/generic/225   |   5 --
 tests/generic/724   |   2 +-
 tests/xfs/243       |  12 ++--
 tests/xfs/245       |   6 +-
 tests/xfs/262       |   2 +-
 tests/xfs/272       |   4 +-
 tests/xfs/274       |   8 +--
 tests/xfs/791       |   2 +-
 19 files changed, 347 insertions(+), 68 deletions(-)
--
Zorro Lang
zlang@kernel.org
