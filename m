Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F06C25B4E
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Jan 2023 13:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjAVN3R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Jan 2023 08:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVN3R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Jan 2023 08:29:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5D1C337
        for <fstests@vger.kernel.org>; Sun, 22 Jan 2023 05:29:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 014C160C15
        for <fstests@vger.kernel.org>; Sun, 22 Jan 2023 13:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B29FC433EF;
        Sun, 22 Jan 2023 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674394155;
        bh=5LALZmzo1KuKCk990G6Aam2ib7mpfgNmN2WVgQz3TbE=;
        h=Date:From:To:Subject:From;
        b=Z+xPAln6gIhtRJ38DfMEiOnv54yqa8KH2xiTldAIaDq63HYe3ner7zhchZ6VG82pk
         371UWCCquzZTV0bpqTzWtXN+kYX2yPbhCO0Xkf0ywEfxoyJwY1lVurpIRu0bBG6rD5
         btDyTbqFqj42wpuHGt/ZOf+QzKwuFc5tQUwaIM/hoxTcwWgdPazURf1ZnsHTTXsn1n
         xnk13kFNSRVI73w9/nYAjUEzuYDgM/HiizXd9oAg4R2Idddf0jB4fLFITECyy4fsqt
         avjQ2FWHU46n/3WGiD9Ktjj0Addz0Bqaz54DW+PRB9v7ELUMamGD5LyT+ViHLibDvB
         K0yhZhaV6IY3w==
Date:   Sun, 22 Jan 2023 21:29:09 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.01.15 onto master branch
Message-ID: <20230122132909.azljhedgw5upxous@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.01.15 version.

Thanks,
Zorro

The new head of the master branch is commit:

e64416195116 xfs: stress test xfs_scrub(8) with freeze and ro-remount loops

New commits:

Baokun Li (1):
      [e3774b281662] overlay: avoid to use NULL OVL_BASE_FSTYP for mounting

Darrick J. Wong (21):
      [d11cbe84059c] xfs/422: create a new test group for fsstress/repair racers
      [7594bbb51c87] xfs/422: move the fsstress/freeze/scrub racing logic to common/fuzzy
      [8726d00c07a9] xfs/422: rework feature detection so we only test-format scratch once
      [69f8e4b9660d] fuzzy: clean up scrub stress programs quietly
      [47b2e809e8c8] fuzzy: rework scrub stress output filtering
      [7e8c6ae6a371] fuzzy: explicitly check for common/inject in _require_xfs_stress_online_repair
      [1286e151137e] fuzzy: give each test local control over what scrub stress tests get run
      [7dad01eeeda8] fuzzy: test the scrub stress subcommands before looping
      [20df87599f66] fuzzy: make scrub stress loop control more robust
      [ae42d50a2acd] fuzzy: abort scrub stress testing if the scratch fs went down
      [4564b9e5c515] fuzzy: clear out the scratch filesystem if it's too full
      [ef4ba08094d9] fuzzy: increase operation count for each fsstress invocation
      [871ddabd2c02] fuzzy: clean up frozen fses after scrub stress testing
      [471e77707b83] fuzzy: make freezing optional for scrub stress tests
      [c0806ff353c6] fuzzy: allow substitution of AG numbers when configuring scrub stress test
      [fd1fad06abd2] fuzzy: delay the start of the scrub loop when stress-testing scrub
      [a2056ca8917b] fuzzy: enhance scrub stress testing to use fsx
      [310faada9642] fuzzy: refactor fsmap stress test to use our helper functions
      [cbcb0632a81b] xfs: race fsmap with readonly remounts to detect crash or livelock
      [303c484039fd] xfs: stress test xfs_scrub(8) with fsstress
      [e64416195116] xfs: stress test xfs_scrub(8) with freeze and ro-remount loops

David Disseldorp (1):
      [280e3f32e6ef] common/rc: drop SGI DMF specific _mount_ops_filter

Filipe Manana (1):
      [fde636203ffd] generic: test lseek with seek data mode on a one byte file

Johannes Thumshirn (1):
      [2151aae2e038] btrfs/012: check if ext4 is available

Qu Wenruo (1):
      [b2188973c251] btrfs: add a test case to verify scrub speed throttle works


Code Diffstat:

 check                  |   1 +
 common/fuzzy           | 484 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/overlay         |   7 +-
 common/rc              |  15 +-
 doc/group-names.txt    |   2 +
 ltp/fsstress.c         |  18 +-
 src/seek_sanity_test.c |  36 ++++
 tests/btrfs/012        |   1 +
 tests/btrfs/282        |  83 +++++++++
 tests/btrfs/282.out    |   3 +
 tests/generic/706      |  36 ++++
 tests/generic/706.out  |   2 +
 tests/xfs/285          |  44 ++---
 tests/xfs/285.out      |   4 +-
 tests/xfs/286          |  46 ++---
 tests/xfs/286.out      |   4 +-
 tests/xfs/422          | 109 ++---------
 tests/xfs/422.out      |   4 +-
 tests/xfs/517          |  91 +---------
 tests/xfs/517.out      |   4 +-
 tests/xfs/560          |  38 ++++
 tests/xfs/560.out      |   2 +
 tests/xfs/561          |  39 ++++
 tests/xfs/561.out      |   2 +
 tests/xfs/562          |  39 ++++
 tests/xfs/562.out      |   2 +
 tests/xfs/563          |  40 ++++
 tests/xfs/563.out      |   2 +
 tests/xfs/564          |  40 ++++
 tests/xfs/564.out      |   2 +
 tests/xfs/565          |  38 ++++
 tests/xfs/565.out      |   2 +
 tests/xfs/566          |  38 ++++
 tests/xfs/566.out      |   2 +
 34 files changed, 1001 insertions(+), 279 deletions(-)
--
Zorro Lang
zlang@kernel.org
