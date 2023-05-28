Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D217C77B7E
	for <linux-fstests@archiver.kernel.org>; Sun, 28 May 2023 14:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjE1OgL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 May 2023 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjE1OgK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 May 2023 10:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C6BBD
        for <fstests@vger.kernel.org>; Sun, 28 May 2023 07:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 624A9615EB
        for <fstests@vger.kernel.org>; Sun, 28 May 2023 14:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F97C433D2;
        Sun, 28 May 2023 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685284567;
        bh=iM09MakMrpbVfWcKyzUn1jshMgFSShYy3B8aeVnZ4us=;
        h=Date:From:To:Subject:From;
        b=hZ4TfqmV2wIbD++tqN06CKI01ZarC2pNXJ4XJNt74famK38XRNLAFWVcHRqzvs8xs
         6+yAo98x1CK4+YjtQF9MzHo4MLHh6sqYiJNhm8PndKlq2qVE2fLiOk8JgpNGkxg72T
         GbAS/L8fw32ax+5M7wFSg7fQOf80OlxJ95v12KedQJvwF4WqruehWAyEr1+kBnStDd
         M8X5ohpuksBHPpB0eJgipeZ2wdwQEosvDBy7j7oKwlXiMC9Xn1fKZvzfWET9EPNqQJ
         NRUkiFQTe7uRmNo4Wbv9cmArPu6tIMBtcmRppN5pUNSE9dK/nyjS+kpeZGuHgbo0d1
         mEwswGnvFj2wQ==
Date:   Sun, 28 May 2023 22:36:01 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.05.28
Message-ID: <20230528143601.qcgbsxdegufprcrz@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.05.28 release.

Release Note:
1) There's 1 new test case (generic/728) in this release.
2) Update some btrfs _fixed_by_kernel_commit lines.
3) Fix some failures caused by fstests or userspace updating.

More details refer to below, thanks all!

Thanks,
Zorro

The new head of the for-next branch is commit:

596db5ee9182 fuzzy: skip online scrub and health checks if not supported

New commits ([N]ew, [U]pdate):

Andrey Albershteyn (1):
[U]      [df0238186fe5] fstests: fix compilation error in splice2pipe on old (<C99) compilers

Anna Schumaker (1):
[N]      [a7afd52b4a89] generic: Add a test for xattr ctime updates

Anthony Iliopoulos (1):
[U]      [596db5ee9182] fuzzy: skip online scrub and health checks if not supported

Filipe Manana (4):
[U]      [e46a74f2e1d7] generic/708: fix commit subject and add its git hash
[U]      [aeb0dccbadac] btrfs/213: add _fixed_by_kernel_commit tag and remove from dangerous group
[U]      [4aa3e1dc28c9] btrfs/287: add git commit hash for the kernel fix
[U]      [6dfe7b6b9033] btrfs/213: avoid occasional failure due to already finished balance

Murphy Zhou (1):
[U]      [199342c9fa48] common/{filter,quota}, xfs/1{06,52}: fix grep pattern


Code Diffstat:

 common/filter         |  2 +-
 common/fuzzy          |  6 ++++++
 common/quota          |  2 +-
 src/splice2pipe.c     |  5 +++--
 tests/btrfs/213       | 21 +++++++++++++++++----
 tests/btrfs/287       |  2 +-
 tests/generic/708     |  3 ++-
 tests/generic/728     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/728.out |  2 ++
 tests/xfs/106         |  4 ++--
 tests/xfs/152         |  4 ++--
 11 files changed, 80 insertions(+), 14 deletions(-)
--
Zorro Lang
zlang@kernel.org
