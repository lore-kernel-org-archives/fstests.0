Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3C6C636D3
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Feb 2023 11:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBLLT0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Feb 2023 06:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLTZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Feb 2023 06:19:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF80A125BD
        for <fstests@vger.kernel.org>; Sun, 12 Feb 2023 03:19:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73FB3B80C0A
        for <fstests@vger.kernel.org>; Sun, 12 Feb 2023 11:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7691BC433EF;
        Sun, 12 Feb 2023 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676200761;
        bh=xADsHuEovhOWFAX2PCjRb/8IFPAbEv1BgfjXR+iEDiA=;
        h=Date:From:To:Subject:From;
        b=GvgKuHahwmd/vYUkSD4TzlWJjXiWOjMz2vNaMM/hn5KImXLwQCyzBVBeqvKy7Xvih
         ulLKCxvIfqm1otTf16lX2E9ni99aBqKgyLV1xbnWYgGG9s2eGDQZQsT2DnaUjXxo6o
         rBR+UvHJ2UnEEybJnaIVIgOq/W9X4uFzZpjwtOg2ohcATe9e6OiyDu8YrfBjY1jjkG
         zPTh123kuv0jiMTWdQNJBF+9PX1oTam7efs2y0H5KQXmr+kvsJwnpp/wWnoziw7vQC
         U0RqrlGiEJWyhsE3sbTUvcYzo8UIGd1yno2Tdz/IzIOiCr1imRhG8E6pEu1t/EJl2f
         XhmBH7wBJkORw==
Date:   Sun, 12 Feb 2023 19:19:16 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.02.12
Message-ID: <20230212111916.kjheg7p3klpl3kzq@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.02.12 release.

Release notes:
1) There're 27 new cases this week, btrfs/284 and xfs/570 ~ 595. Those xfs
   cases are not in auto group, nearly all about xfs fuzzy or online scrub
   test, and they bring in a new .c file -- src/xfsfind.c
2) There're some fixes from udf and nfs side, helps fstests be more suitable
   for udf and nfs testing. Welcome more patches on these parts :)
3) More (stable & quick enough) cases be added into default *auto* test group.
   Generally they don't fail on latest upstream kernel.

More bug fixes or updates refer to below, thanks for all your contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

f6aca7f2ab08 xfs: add 080 to the auto and quick groups

New commits ([N]ew, [U]pdate):

Benjamin Coddington (1):
[U]      [8029b849785a] generic/676: Unstable d_type handling for NFS READDIR

Christoph Hellwig (7):
[U]      [fe85ceeba5f5] btrfs: add 198 to the auto group
[U]      [e7abef0c69c7] btrfs: add 125 to the auto and quick groups
[U]      [40df28198284] btrfs: add 185 to the auto and quick groups
[U]      [afcafb472d0c] generic: add 042 to the auto and quick groups
[U]      [a16be1750260] generic: add 125 to the auto group
[U]      [1e4bff9fedb7] generic: add 251 to the auto group
[U]      [f6aca7f2ab08] xfs: add 080 to the auto and quick groups

Darrick J. Wong (6):
[U]      [3da787a95dba] xfs/357: switch fuzzing to agi 1
[N]      [e926c8ffee93] xfs: race fsstress with online scrubbers for AG and fs metadata
[N]      [3fec4791015e] fuzzy: add a custom xfs find utility for scrub stress tests
[U]      [28a30e56d551] fuzzy: allow xfs scrub stress tests to pick preconfigured fsstress configs
[N]      [8bdb40271c00] xfs: race fsstress with online scrubbers for file metadata
[U]      [1d828630570d] common/xfs: use whole-word matching for _require_xfsrestore_xflag

David Disseldorp (1):
[U]      [02f8adf4b2d8] common/btrfs: avoid reinitialization of unsupported profile array

Filipe Manana (1):
[N]      [e5dc5462471b] btrfs: add a stress test for send v2 streams

Gabriel Niebler (2):
[U]      [a04ce1ddfca1] common: Do not chown ro mountpoint when creating idmapped mount
[U]      [711a7a2c2bb6] common: Chown mount even if already idmapped to account for remounts

Jan Kara (3):
[U]      [d4d0c0f02a67] common: Provide blocksize and ecclength to udf fsck
[U]      [d36a4f164f83] common: Unmount udf filesystem prior checking
[U]      [99d0f81f194f] common: Improve blocksize support for udf

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
