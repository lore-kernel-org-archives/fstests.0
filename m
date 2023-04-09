Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF28C77B70
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Apr 2023 14:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDIOlj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Apr 2023 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIOli (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Apr 2023 10:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CF130DA
        for <fstests@vger.kernel.org>; Sun,  9 Apr 2023 07:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C477F60C3A
        for <fstests@vger.kernel.org>; Sun,  9 Apr 2023 14:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906FBC433D2;
        Sun,  9 Apr 2023 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681051297;
        bh=SlEctcK4bXBwps9+cuLWLjBVRPXtRPeHsgnAmInCOqU=;
        h=Date:From:To:Subject:From;
        b=h+1zY8/966DdasM5ws0s744Q7U6F6Oy50LnVCaLFNjG/VRgBYr86h/C27iFaG398F
         xT4rpULEeKe/jyyrikKJ5eFLA1qcL5oiPCP4oUgbiIfwkWTQYGtI22pE9kkpvpLseT
         q3JLtYBj+RL+qXavYCQzUJZd7PxCZd3eSBTOG4YpHq9s9kRR+ggHH5I7l/t02PQItj
         H5F6nAZ4rntfWvAXoC50J+PcNuhcvg8igmU/pF5uPUq/eknK4TCbcjPIxT5xnq3LoW
         S5Tk5FrHz3I2BQoIoIl/wM2V0uxsBzna1zcmZwc1p36v9ijWkWLI9tQYsYK4JhLoK3
         P81nfYI02bQwQ==
Date:   Sun, 9 Apr 2023 22:41:33 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.04.09
Message-ID: <20230409144133.aj6fswijvzj37oop@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.04.09 release.

Release Note:
1. There's not new test case this week, most of patches are cases or helpers
   updating/fixing.
2. This release brings in MAINTAINERS and get_maintainer.pl (copied from linux
   project, then made a few changes), to record some mailing list or people who
   are related with fstests, and shows email address can be CCed for a specific
   fstests patch.

(P.S. the MAINTAINERS file isn't the final version.)

Thanks,
Zorro

The new head of the for-next branch is commit:

3a56e665384e fstests/MAINTAINERS: add a co-maintainer for btrfs testing part

New commits ([New], [U]pdate):

Anthony Iliopoulos (1):
[U]      [c91ff78d21f6] common: switch _get_{available,total}_space accounting to units of single bytes

Darrick J. Wong (6):
[U]      [5858995b1f4e] generic/{251,260}: compute maximum fitrim offset
[U]      [7d5d3f77154e] xfs/242: fix _filter_bmap for xfs_io bmap that does rt file properly
[U]      [ccf4d08d12e3] common/report: fix typo in FSSTRESS_AVOID
[U]      [a8e4eb5f7d2f] common/populate: fix btree-format xattr creation on xfs
[U]      [c7db4edfe967] populate: create fewer subdirs when constructing directories
[U]      [8d69dc3757ce] populate: create fewer holes in directories and xattrs

Zorro Lang (5):
[N]      [2a442d6a587d] fstests: add MAINTAINERS and get_maintainer.pl files
[U]      [d349bd4a0dff] tools/get_maintainer.pl: remove penguin chiefs
[U]      [c72cc820eb60] fstests/MAINTAINERS: add supported mailing list
[U]      [3a49eed5c634] fstests/MAINTAINERS: add some specific reviewers
[U]      [3a56e665384e] fstests/MAINTAINERS: add a co-maintainer for btrfs testing part


Code Diffstat:

 MAINTAINERS             |  200 ++++
 common/populate         |   63 +-
 common/punch            |    8 +
 common/rc               |   23 +-
 common/report           |    2 +-
 common/xfs              |    8 +
 src/popdir.pl           |   15 +-
 tests/generic/251       |    2 +-
 tests/generic/260       |    2 +-
 tools/get_maintainer.pl | 2573 +++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 2876 insertions(+), 20 deletions(-)
--
Zorro Lang
zlang@kernel.org
