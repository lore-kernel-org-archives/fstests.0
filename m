Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A5C71153
	for <linux-fstests@archiver.kernel.org>; Sun,  3 Sep 2023 15:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjICPcf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 3 Sep 2023 11:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPce (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Sep 2023 11:32:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95739C
        for <fstests@vger.kernel.org>; Sun,  3 Sep 2023 08:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF9560ED5
        for <fstests@vger.kernel.org>; Sun,  3 Sep 2023 15:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3457C433C7;
        Sun,  3 Sep 2023 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693755150;
        bh=R6hARU6vkHdw9PF3uj2/seG1NQQjrfUXvLuFeFULyh4=;
        h=Date:From:To:Subject:From;
        b=IgktmGQksY2GkWJXKFGy2kIuOVHCAX3WnYXLge9xWPc5Tk5h/YdiSYmAPUin+sx2K
         uoVfOVPmpZaP7Sn+H9SdMbRBASJJL/pj61REGSMk0P7ETNqEc5b6MV2Q2P+QMED8Q3
         xxG6aUUeb3Hs+6HGD2gbrkTssrsaiiKj4yca2ieiJ4ov9hjHIyd8FQeb8/t3je9mq+
         RGcsUz0A/xtq16qhW/xSECsf8F2C4yfQ6QYdaaTHwq/nuXDQ2Y1aFK0Upm34WaydmC
         QRmGVuB9WFg09AsF9tquPU4tFBMsgbaC6Co5Gi3D50yx9ZGYsLuSpywi2rKA88mFkn
         YhJ+52z2SNslQ==
Date:   Sun, 3 Sep 2023 23:32:26 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.09.03
Message-ID: <20230903153226.h2fl2ss4ic5a4qeu@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.09.03 release.

Release Notes:
1) There's a new test case in this release -- xfs/600. It's for a known bug,
   so it fails currently.
2) The g/650, g/616 and g/617 support SOAK_DURATION now, and are added to "soak"
   group. Welcome more soak tests support SOAK_DURATION, and be in soak group.
3) The g/650 runs less time by default (won't break most of my test machines:).
   And It's changed to cover a new bug, which will cause a *kernel crash*. So be
   careful to run it.
4) Several generic test cases are skipped on NFS by default.

More details and other improvements/fixes refer to below, thanks for all these
contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

2848174358e5 xfs/559: adapt to kernels that use large folios for writes

New commits:

Bill O'Donnell (1):
      [0fc226e7eac1] fstests: generic/352 should accomodate other pwrite behaviors

Darrick J. Wong (8):
      [9445d70f0fd6] fstests: test fix for an agbno overflow in __xfs_getfsmap_datadev
      [d8008ba6d6f6] generic/650: add SOAK_DURATION controls
      [6769d7e094f2] generic/650: race mount and unmount with cpu hotplug too
      [7a2663730e69] generic/61[67]: support SOAK_DURATION
      [c5cef5ba74ed] btrfs/282: skip test if /var/lib/btrfs isnt writable
      [bfe2fd60049e] common: split _get_hugepagesize into detection and actual query
      [225170dbbc68] common: rename get_page_size to _get_page_size
      [2848174358e5] xfs/559: adapt to kernels that use large folios for writes

Jeff Layton (6):
      [6bf1570d33cc] common/attr: fix the _require_acl test
      [24f63dbc15de] generic/578: add a check to ensure that fiemap is supported
      [2fcf852d5e6c] generic/*: add a check for security attrs
      [b6f51cac4dbe] generic/294: don't run this test on NFS
      [cf1ef0daf488] generic/357: don't run this test on NFS
      [59037f2aa014] generic/187: don't run this test on NFS

Naohiro Aota (4):
      [2817df3ae9d7] aio-dio-write-verify: check for the IO errors
      [c5e4bff3a8a4] aio-dio-write-verify: print more info on the error case
      [d3bbcf20d8a2] generic/551: bail out test if aio-dio-write-verify failed
      [c1b325152870] btrfs/237: kick reclaim process with a small filesystem


Code Diffstat:

 common/attr                                |  9 +++--
 common/btrfs                               |  2 +-
 common/filter                              |  2 +-
 common/rc                                  | 19 ++++++-----
 common/verity                              |  2 +-
 src/aio-dio-regress/aio-dio-write-verify.c | 17 +++++++--
 tests/btrfs/049                            |  2 +-
 tests/btrfs/106                            |  2 +-
 tests/btrfs/173                            |  4 +--
 tests/btrfs/174                            |  2 +-
 tests/btrfs/175                            |  4 +--
 tests/btrfs/176                            |  4 +--
 tests/btrfs/192                            |  2 +-
 tests/btrfs/215                            |  2 +-
 tests/btrfs/237                            | 21 ++++++++++--
 tests/btrfs/251                            |  2 +-
 tests/btrfs/271                            |  2 +-
 tests/btrfs/274                            |  2 +-
 tests/btrfs/282                            |  7 ++++
 tests/btrfs/293                            |  2 +-
 tests/ext4/003                             |  2 +-
 tests/ext4/022                             |  2 +-
 tests/ext4/306                             |  2 +-
 tests/generic/187                          |  5 ++-
 tests/generic/270                          |  2 ++
 tests/generic/294                          |  6 ++--
 tests/generic/352                          | 10 +++---
 tests/generic/352.out                      |  6 ++--
 tests/generic/357                          |  5 +++
 tests/generic/413                          |  1 +
 tests/generic/416                          |  2 +-
 tests/generic/472                          |  2 +-
 tests/generic/495                          |  2 +-
 tests/generic/496                          |  2 +-
 tests/generic/497                          |  2 +-
 tests/generic/513                          |  2 ++
 tests/generic/551                          |  6 ++--
 tests/generic/574                          |  2 +-
 tests/generic/578                          |  1 +
 tests/generic/605                          |  1 +
 tests/generic/616                          |  3 +-
 tests/generic/617                          |  3 +-
 tests/generic/636                          |  2 +-
 tests/generic/641                          |  2 +-
 tests/generic/650                          | 18 ++++++++--
 tests/generic/675                          |  2 ++
 tests/generic/688                          |  2 ++
 tests/generic/727                          |  2 ++
 tests/xfs/513                              |  2 +-
 tests/xfs/552                              |  2 +-
 tests/xfs/559                              | 29 +++++++++++++++-
 tests/xfs/600                              | 55 ++++++++++++++++++++++++++++++
 tests/xfs/600.out                          |  2 ++
 53 files changed, 228 insertions(+), 68 deletions(-)
--
Zorro Lang
zlang@kernel.org
