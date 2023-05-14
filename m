Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64096C7EE22
	for <linux-fstests@archiver.kernel.org>; Sun, 14 May 2023 15:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjENPFN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 May 2023 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENPFM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 May 2023 11:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826E61994
        for <fstests@vger.kernel.org>; Sun, 14 May 2023 08:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 193B360C4A
        for <fstests@vger.kernel.org>; Sun, 14 May 2023 15:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AE9C433D2;
        Sun, 14 May 2023 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684076710;
        bh=Rh5jjoRZFKnf2ztHG2ANn02CVTSLLPIKlngyNnJpOPM=;
        h=Date:From:To:Subject:From;
        b=u5X/pnOtxW1d+slvozGTfzJPc1PS7q8nbhk0eVPtDRDZYfqJqdg3TD+eaJv+7sF0Z
         BVYjz+s2Of7TQN5Gn7s9Blvq+OLBFULfLtaOLk6zTIxjJU9hfizfFlTSHLtjBgL6G7
         ej7VkFRthRiQzDuNdL5Wg+1V7aBNGYGt/is3TUUzezb0fz+NVO4GZEk9R+cCdKS/S5
         nTdWmq2DAyfYCM/VcO4iqbzB7mdzfklcAoJDUZDElEjPDk+gRmuG1ZuV87HzSdQKIx
         Z7EFHFHRIF+x8UbnzdmtHhO22RMoHZ0LwFsHKZaYUvMClypJFaYQSO8F9Kba49FxYD
         uadIQIhIcPZ/g==
Date:   Sun, 14 May 2023 23:05:06 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.05.14
Message-ID: <20230514150506.uyrvrubbgbrrnytw@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.05.14 release.

Release Notes:
1) There's 1 new test case in this release -- btrfs/287.
2) A new group named "logical_resolve", for btrfs generally.

More updates or fixes as below, thanks for all!

Thanks,
Zorro

The new head of the for-next branch is commit:

33144e0693b5 generic/{094,225}: drop the file allocation unit requirements

New commits ([N]ew, [U]pdate):

Darrick J. Wong (7):
[U]      [8c5f19b701ea] fsx: fix indenting of columns in bad buffers report
[U]      [f093a7503a6a] xfs/262: remove dangerous labels
[U]      [23e11f53b4b6] generic/724,xfs/791: adjust test preconditions for post-EOF stripe zeroing
[U]      [715d052a8faf] xfs/{243,245,272,274}: ignore raid alignment flags in bmap output
[U]      [c387c694bde3] fiemap-tester: holes can be backed by unwritten extents
[U]      [6a0bba58d043] fiemap: FIEMAP_EXTENT_LAST denotes the last record in the recordset
[U]      [33144e0693b5] generic/{094,225}: drop the file allocation unit requirements

Filipe Manana (5):
[U]      [a580ecd1dfc6] common/btrfs: add helper to get the bytenr for a file extent item
[N]      [f635f9c3153c] btrfs: add a test case for the logical to ino ioctl
[U]      [7ab65dae2751] groups: add logical_resolve group for btrfs
[U]      [802f42f7a5b2] btrfs/254: correct subject of the relevant kernel patch and add git commit
[U]      [e35817daa103] btrfs/228: sync filesystem after creating subvolume


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
