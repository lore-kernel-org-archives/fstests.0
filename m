Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B610EB64DC
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Jul 2023 13:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGINVq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Jul 2023 09:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGINVp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jul 2023 09:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DCBEB
        for <fstests@vger.kernel.org>; Sun,  9 Jul 2023 06:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9675560BB1
        for <fstests@vger.kernel.org>; Sun,  9 Jul 2023 13:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D900C433C8;
        Sun,  9 Jul 2023 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688908903;
        bh=YZ7KnWSHVLbbmDcpHOXnZoOU1Kuk/wWKvZfgNQhPKl0=;
        h=Date:From:To:Subject:From;
        b=Uca7u1cix4JcCZrIqzy7m0AvwY4hsWb+4uY1uofUnk5xowEAVe3j3mH2RwYe1k1WJ
         KkvQn8W5sXiw2dW4GOzr6Nuatx42G9kucNU2YFAlg9syEtCgpJeS/mJkl6885OSg2u
         fmy5c5MdQROOWPt/9/UUmx6/EREbmJ01wy6t6QwTmnPWftJDLYPDXlHE1aKzfg9aOw
         7kshRcdcyG9tkir0vH9AcaZF/MCFA0ubFjk0ZLS4vHzDJ4e2OewLtv7Ro+OehGVW2g
         EWN97eXfuuu+5HcLwHPSPQurKBpKWtT0SSG433fI9isNlW2JcaXUBj73Zn23BlCcsq
         iWSBfKe40mZ9Q==
Date:   Sun, 9 Jul 2023 21:21:39 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.07.09
Message-ID: <20230709132139.jnb4nupbwm4jkwt3@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.07.09 release.

Releate notes:
1) There're 3 new test cases this week --- xfs/596, btrfs/292 and btrfs/293.
   xfs/596 is a functional test case for xfs rtdev only, the other two btrfs
   cases are regression test for two (new) known btrfs fixes.
2) Tow basic fix/improvement on check script, one for the -i option works with
   -e and -E properly, the other helps the -n option run faster.
3) Fix a regression test issue on btrfs with dmdust.

More fixes and details refer to below, thanks for all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

66fcf86bbaea report: remove xmlns specifier

New commits:

Amir Goldstein (2):
      [3e7166ffb2ef] fstests: reduce runtime of check -n
      [06cee93225c9] generic/604: Fix for overlayfs

Darrick J. Wong (5):
      [2fc1f5dc90f4] xfs/529: fix bogus failure when realtime is configured
      [cfa2c8fadbc8] xfs/569: skip post-test fsck run
      [08389a5aaa29] xfs/439: amend test to work with new log geometry validation
      [14941ffecb85] xfs/041: force create files on the data device
      [27211f9bb44b] xfs: test growfs of the realtime device

Filipe Manana (1):
      [db7fb78fda69] btrfs: test activating swapfile in the presence of snapshots

Qu Wenruo (2):
      [4ea344909aba] btrfs: add test case to verify the behavior with large RAID0 data chunks
      [e7006c6dc1c2] common/btrfs: handle dmdust as mounted device in _btrfs_buffered_read_on_mirror()

Stas Sergeev (1):
      [2c29b9b58618] common/config: redirect modprobe helpinfo to stdout for busybox

Theodore Ts'o (2):
      [8bab8ef9872e] report: safely update the result.xml file
      [66fcf86bbaea] report: remove xmlns specifier

Yuezhang Mo (1):
      [60054d5118fd] check: fix excluded tests are only expunged in the first iteration


Code Diffstat:

 check               | 52 +++++++++++++++---------------
 common/btrfs        | 13 ++++++--
 common/config       |  2 +-
 common/report       | 21 +++++++------
 tests/btrfs/292     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out |  2 ++
 tests/btrfs/293     | 72 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/293.out | 17 ++++++++++
 tests/generic/604   |  4 ++-
 tests/xfs/041       |  3 ++
 tests/xfs/439       | 14 +++++++--
 tests/xfs/529       |  4 +++
 tests/xfs/569       |  2 +-
 tests/xfs/596       | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/596.out   | 19 +++++++++++
 15 files changed, 351 insertions(+), 44 deletions(-)
--
Zorro Lang
zlang@kernel.org
