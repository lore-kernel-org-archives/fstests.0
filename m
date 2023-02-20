Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA64C636CC
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Feb 2023 14:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjBTOfo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Feb 2023 09:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjBTOfn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Feb 2023 09:35:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419F5CDD4
        for <fstests@vger.kernel.org>; Mon, 20 Feb 2023 06:35:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC6CD60EB7
        for <fstests@vger.kernel.org>; Mon, 20 Feb 2023 14:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D12FC433D2;
        Mon, 20 Feb 2023 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676903741;
        bh=rn//Jsd5KW47fnLGP7X3G4q8MCfvfX3lfnjV73iYIqc=;
        h=Date:From:To:Subject:From;
        b=rhKxvdM1rqWw7Wc5jMycRXp8BtKVMLA2DekzVQFwIuUZzfSwWXnjmEsw7lTb0vhPz
         +9C9ycYofEf1+tJF/xYsMQL+MiZPzTGTdFQXZvVZh2/ZnQhcikK2bsEWNaPdMCAU2h
         goJshIHDBMbWJctoyk0mXQ3r1HZ6a2u5hj+XB+P8I3+caLZRZwG24Y5Fe/B1PxGO8d
         nZ0KT6zaDrs+XhOkMr2JbZ1Gpq7vUQy9fazdGkB2fc+6SWtKfa3iI+nRoOs1QpblWE
         yk5ogVm30jWoN2cT5zfydaEtHvewuTUu+qohwFavDza77pPRVDy9rj8Ikh5Tjm9Fma
         7F3vh9uPoFm5Q==
Date:   Mon, 20 Feb 2023 22:35:36 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.02.12 onto master branch
Message-ID: <20230220143536.hh7essmm7aauuieb@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.02.12 version.

Thanks,
Zorro

The new head of the master branch is commit:

f6aca7f2ab08 xfs: add 080 to the auto and quick groups

New commits:

Benjamin Coddington (1):
      [8029b849785a] generic/676: Unstable d_type handling for NFS READDIR

Christoph Hellwig (7):
      [fe85ceeba5f5] btrfs: add 198 to the auto group
      [e7abef0c69c7] btrfs: add 125 to the auto and quick groups
      [40df28198284] btrfs: add 185 to the auto and quick groups
      [afcafb472d0c] generic: add 042 to the auto and quick groups
      [a16be1750260] generic: add 125 to the auto group
      [1e4bff9fedb7] generic: add 251 to the auto group
      [f6aca7f2ab08] xfs: add 080 to the auto and quick groups

Darrick J. Wong (6):
      [3da787a95dba] xfs/357: switch fuzzing to agi 1
      [e926c8ffee93] xfs: race fsstress with online scrubbers for AG and fs metadata
      [3fec4791015e] fuzzy: add a custom xfs find utility for scrub stress tests
      [28a30e56d551] fuzzy: allow xfs scrub stress tests to pick preconfigured fsstress configs
      [8bdb40271c00] xfs: race fsstress with online scrubbers for file metadata
      [1d828630570d] common/xfs: use whole-word matching for _require_xfsrestore_xflag

David Disseldorp (1):
      [02f8adf4b2d8] common/btrfs: avoid reinitialization of unsupported profile array

Filipe Manana (1):
      [e5dc5462471b] btrfs: add a stress test for send v2 streams

Gabriel Niebler (2):
      [a04ce1ddfca1] common: Do not chown ro mountpoint when creating idmapped mount
      [711a7a2c2bb6] common: Chown mount even if already idmapped to account for remounts

Jan Kara (3):
      [d4d0c0f02a67] common: Provide blocksize and ecclength to udf fsck
      [d36a4f164f83] common: Unmount udf filesystem prior checking
      [99d0f81f194f] common: Improve blocksize support for udf


Code Diffstat:

 .gitignore            |   1 +
 common/btrfs          |  66 ++++++------
 common/fuzzy          | 166 +++++++++++++++++++++++++++--
 common/quota          |  64 +++++++++++
 common/rc             |  42 ++++++--
 common/xfs            |   2 +-
 configure.ac          |   5 +
 include/builddefs.in  |   4 +
 m4/package_libcdev.m4 |  44 ++++++++
 m4/package_xfslibs.m4 |  15 +++
 src/Makefile          |  10 ++
 src/t_readdir_3.c     |  12 ++-
 src/xfsfind.c         | 290 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/125       |   2 +-
 tests/btrfs/185       |   2 +-
 tests/btrfs/198       |   2 +-
 tests/btrfs/284       | 133 +++++++++++++++++++++++
 tests/btrfs/284.out   |   2 +
 tests/generic/042     |   2 +-
 tests/generic/125     |   2 +-
 tests/generic/251     |   2 +-
 tests/xfs/080         |   2 +-
 tests/xfs/357         |   2 +-
 tests/xfs/570         |  37 +++++++
 tests/xfs/570.out     |   2 +
 tests/xfs/571         |  37 +++++++
 tests/xfs/571.out     |   2 +
 tests/xfs/572         |  37 +++++++
 tests/xfs/572.out     |   2 +
 tests/xfs/573         |  37 +++++++
 tests/xfs/573.out     |   2 +
 tests/xfs/574         |  38 +++++++
 tests/xfs/574.out     |   2 +
 tests/xfs/575         |  38 +++++++
 tests/xfs/575.out     |   2 +
 tests/xfs/576         |  38 +++++++
 tests/xfs/576.out     |   2 +
 tests/xfs/577         |  39 +++++++
 tests/xfs/577.out     |   2 +
 tests/xfs/578         |  39 +++++++
 tests/xfs/578.out     |   2 +
 tests/xfs/579         |  40 +++++++
 tests/xfs/579.out     |   2 +
 tests/xfs/580         |  44 ++++++++
 tests/xfs/580.out     |   2 +
 tests/xfs/581         |  40 +++++++
 tests/xfs/581.out     |   2 +
 tests/xfs/582         |  47 ++++++++
 tests/xfs/582.out     |   2 +
 tests/xfs/583         |  40 +++++++
 tests/xfs/583.out     |   2 +
 tests/xfs/584         |  40 +++++++
 tests/xfs/584.out     |   2 +
 tests/xfs/585         |  40 +++++++
 tests/xfs/585.out     |   2 +
 tests/xfs/586         |  38 +++++++
 tests/xfs/586.out     |   2 +
 tests/xfs/587         |  38 +++++++
 tests/xfs/587.out     |   2 +
 tests/xfs/588         |  37 +++++++
 tests/xfs/588.out     |   2 +
 tests/xfs/589         |  39 +++++++
 tests/xfs/589.out     |   2 +
 tests/xfs/590         |  39 +++++++
 tests/xfs/590.out     |   2 +
 tests/xfs/591         |  37 +++++++
 tests/xfs/591.out     |   2 +
 tests/xfs/592         |  40 +++++++
 tests/xfs/592.out     |   2 +
 tests/xfs/593         |  38 +++++++
 tests/xfs/593.out     |   2 +
 tests/xfs/594         |  38 +++++++
 tests/xfs/594.out     |   2 +
 tests/xfs/595         |  39 +++++++
 tests/xfs/595.out     |   2 +
 75 files changed, 1880 insertions(+), 58 deletions(-)
--
Zorro Lang
zlang@kernel.org
