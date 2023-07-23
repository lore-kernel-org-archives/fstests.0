Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2032C001B0
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Jul 2023 15:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjGWPeL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Jul 2023 11:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGWPeL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jul 2023 11:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D91A7
        for <fstests@vger.kernel.org>; Sun, 23 Jul 2023 08:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1AFF60DBA
        for <fstests@vger.kernel.org>; Sun, 23 Jul 2023 15:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949A0C433C8;
        Sun, 23 Jul 2023 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690126449;
        bh=nJ9tSPFJkWjqiWhI7AwsF156cKmXhMW2cXVarACSjAo=;
        h=Date:From:To:Subject:From;
        b=EaGhyTXnF1MT5Bd1R3NEZCcThhN+7prh6w4bdwg6RGIVIvpYQbED5ZYgnh0B4f6NW
         xupjUc+EGAOcSS+KssSaIU8Nwwb7/+PmkCQQ/Lp6vEsZXR2G/FIxQ/Hem54clZA0Ov
         ibQUI9nbxY0AkRfYSdEEvBDghpUNlqx4X023m6eFbh5SMybmUKGo24aMgkBTqFRR8Z
         g8Vkw5pgWWZKuTlNqnqIHUwus29EN6uw9SFevZ4bsGNglBgN08Cahxw8mRM833sOQH
         7qnvQTEne0U2wN3u3Ko5JiKIzZFm1GA2BW2M2DvQ678vw91KQtnoBCM70akpwwzJ9A
         QyvMyiV57wxCQ==
Date:   Sun, 23 Jul 2023 23:34:05 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.07.23
Message-ID: <20230723153405.mjsjdpxdvivsqqym@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.07.23 release.

Release Notes:
1) There're 8 new test cases in this release, include:
   -- btrfs/294, btrfs/295 and btrfs/296 are known btrfs regression test cases.
   -- overlay/079 and overlay/080 are new feature test cases, for data-only
      upperdir feature and fs-verity validation feature. (Note: overlay/060 is
      changed too, we add new feature testing into it, but won't fail old kernel
      testing).
   -- xfs/597, xfs/598 and xfs/599 are functional test cases for ascii
      case-insensitive directory lookup.
2) Fix some issues on bcachefs testing, help fstests to work on it better.

More details refer to below, thanks for all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

8de535c53887 btrfs: add a test case to verify that per-fs features directory gets updated

New commits ([N]ew, [U]pdate):

Alexander Larsson (1):
[N]      [f2c9af189a76] overlay: Add test coverage for fs-verity support

Amir Goldstein (3):
[U]      [23f643a0c3e4] overlay: add helper for mounting rdonly overlay
[U]      [5f8c60fe8140] overlay/060: add test cases of follow to lowerdata
[N]      [019122400875] overlay: Add test for follow of lowerdata in data-only layers

Darrick J. Wong (2):
[N]      [1cd6b612992a] xfs: add a couple more tests for ascii-ci problems
[U]      [d28912bad3c0] generic/558: avoid forkbombs on filesystems with many free inodes

Luís Henriques (1):
[U]      [05574f3cfc49] common/rc: cleanup old .kmemleak files

Qu Wenruo (3):
[N]      [6ca154c1b239] btrfs: add a test case to verify the write behavior of large RAID5 data chunks
[N]      [9b84d93f225f] btrfs: add a test case to check btrfs won't crash on certain corruption
[N]      [8de535c53887] btrfs: add a test case to verify that per-fs features directory gets updated


Code Diffstat:

 common/overlay        |  35 +++++-
 common/rc             |   4 +
 common/verity         |  16 ++-
 tests/btrfs/294       |  72 +++++++++++
 tests/btrfs/294.out   |   2 +
 tests/btrfs/295       |  38 ++++++
 tests/btrfs/295.out   |   2 +
 tests/btrfs/296       |  66 ++++++++++
 tests/btrfs/296.out   |   2 +
 tests/generic/558     |  27 +++--
 tests/overlay/060     |  43 ++++++-
 tests/overlay/060.out |  18 +++
 tests/overlay/079     | 325 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/079.out |  42 +++++++
 tests/overlay/080     | 326 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/080.out |   7 ++
 tests/xfs/597         |  56 +++++++++
 tests/xfs/597.out     |  24 ++++
 tests/xfs/598         | 101 ++++++++++++++++
 tests/xfs/598.out     |   9 ++
 tests/xfs/599         |  91 ++++++++++++++
 tests/xfs/599.out     |   2 +
 22 files changed, 1287 insertions(+), 21 deletions(-)
--
Zorro Lang
zlang@kernel.org
