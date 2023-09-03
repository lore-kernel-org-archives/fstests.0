Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF090C83F2D
	for <linux-fstests@archiver.kernel.org>; Sun,  3 Sep 2023 15:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbjICP3G (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 3 Sep 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICP3G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Sep 2023 11:29:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF7F1
        for <fstests@vger.kernel.org>; Sun,  3 Sep 2023 08:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 75F97CE0ADA
        for <fstests@vger.kernel.org>; Sun,  3 Sep 2023 15:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139B2C433C7;
        Sun,  3 Sep 2023 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693754939;
        bh=Xie6pyVUzM1UDsrtd0LaHjntC0J5Fo0w8xijPNKjRKE=;
        h=Date:From:To:Subject:From;
        b=H8WgG6OjdLost9uJLTltMQorgICi+Rz/x7RB+IbIFPX9fBcq0Y58VPJEr3e0sOPhV
         nOBEw0YDasYsduiAeUXmQ7C7X7jh+DwzS5wP9lbHmfzBvhjymFut88tDc/39GqegEa
         eQaBBn09Y4IglhT1TGZHkEmKzuxciAALpg4wdR7sZegc2/xPv+2xKJ6OGekwN1sLz+
         a8ngLTgqMPQufaIkLpm64sRoEzIL/u7E+vK3+xTHiWKPGKQh+PBDXsVS5MLuVgjWA9
         +wpIQSpgg006/yiA59C2M81ID9YDjx8tW1aT5FUd5Q0C11IntFWhnECUpcEWYZTkcO
         p4FqjbnIFZ29A==
Date:   Sun, 3 Sep 2023 23:28:55 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.08.27 onto master branch
Message-ID: <20230903152855.rywf46rp75ppcn6u@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.08.27 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

fd94fc408b3e generic/471: Remove this broken case

New commits:

Amir Goldstein (2):
      [6d63f23987a6] check: fix parsing expunge file with comments
      [9caf3ee07d0d] generic/{175,297,298}: fix use of uninitialized var

David Disseldorp (1):
      [515adab889b9] common/rc: drop 'fsck -f' parameter from _repair_test_fs

Filipe Manana (1):
      [4a78fc26ab16] btrfs/213: fix failure due to misspelled function name

Lee Trager (1):
      [eccdeae8fc41] fstests: Verify dir permissions when creating a stub subvolume

Naohiro Aota (4):
      [697988c94e87] btrfs/220: do not run async discard test on zoned device
      [778364fffb35] common/rc: introduce _random_file() helper
      [4dd2822ae01a] fstests/btrfs: use _random_file() helper
      [a0c6958c0e36] btrfs/004: use shuf to shuffle the file lines

Qu Wenruo (1):
      [79d409ce9e39] fstests: fsstress: wait interrupted aio to finish

Shiyang Ruan (1):
      [d9b0c584e25b] fsx: tidy options usage and format

Stas Sergeev (2):
      [857c18868a0e] t_ofd_locks: fix stalled semaphore handling
      [ae154c192b95] t_ofd_locks: fix sem initialization sequence

Yang Xu (1):
      [fd94fc408b3e] generic/471: Remove this broken case


Code Diffstat:

 check                 |   4 +-
 common/rc             |  14 +++++-
 ltp/fsstress.c        |  20 ++++++++-
 ltp/fsx.c             |  29 +++++++-----
 src/t_ofd_locks.c     | 121 +++++++++++++++++++++-----------------------------
 tests/btrfs/004       |   2 +-
 tests/btrfs/179       |   9 ++--
 tests/btrfs/192       |  14 ++----
 tests/btrfs/213       |   2 +-
 tests/btrfs/220       |   4 +-
 tests/btrfs/300       |  52 ++++++++++++++++++++++
 tests/btrfs/300.out   |  18 ++++++++
 tests/generic/175     |   1 -
 tests/generic/297     |   1 -
 tests/generic/298     |   1 -
 tests/generic/471     |  67 ----------------------------
 tests/generic/471.out |  13 ------
 tests/generic/478     |  37 +++++++++++++--
 tests/overlay/020     |   7 +--
 19 files changed, 219 insertions(+), 197 deletions(-)
--
Zorro Lang
zlang@kernel.org
