Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D980C001B0
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Jul 2023 15:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGWPar (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Jul 2023 11:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGWPar (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jul 2023 11:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25631A5
        for <fstests@vger.kernel.org>; Sun, 23 Jul 2023 08:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F04F60DD0
        for <fstests@vger.kernel.org>; Sun, 23 Jul 2023 15:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F18C433C8;
        Sun, 23 Jul 2023 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690126245;
        bh=CEesjs/njCqXmfI6D4XBVJpLQjxQ137vsjlFqo5znpc=;
        h=Date:From:To:Subject:From;
        b=UhvvE7qHjDR4jBrPh27gRRPGESCBILaHUVB492BD17PxRtLhxl2UY6f4WMEkNyDuV
         9l1tgBhYMzcIX83al3JdCdXkHwF8dpiLY/tOKBe1JMKsOI1wlqAW567pa0F0IRBcd5
         a9yIDzeGSN8e0FZy60brqT9/br2vl8+IC9h+21DYdiRgoJGJEEs54cA/sHktyilpZ5
         QMIyZOumegHOEtSPZ2JrwfznvVtOer3TwXyNb32LFM7I6JGqYIZcuj242oRqciCYLH
         fG88UesUyi+nfISGOuNDADyo+5SyEykUiEeUkEXCiRBjQO7Dk3QTAouaCSWDr6gtDn
         ieTD84TXsdhsw==
Date:   Sun, 23 Jul 2023 23:30:40 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.07.09 onto master branch
Message-ID: <20230723153040.jgf3egnqfc4dc5f4@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.07.09 version.

Thanks,
Zorro

The new head of the master branch is commit:

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
