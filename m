Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F5DC433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Apr 2022 15:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348917AbiD1PTk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiD1PTj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 11:19:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885CAC07B
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E046B82E10
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 15:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1DFC385AE;
        Thu, 28 Apr 2022 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651158981;
        bh=v1Y0woGORpxDzlfzYsuT0ijazid3WZKg402aYP+9x7E=;
        h=From:To:Cc:Subject:Date:From;
        b=It/g6mRvidl9aVc5fntX2D97qMNUNYJbrLBCUQpgxw/W8HOG6/Q6zmnmlkypy+mgb
         5OZBR0jNAkGxrKLaU3tYiDDsJNcloY6YSIOIAubKWyFGPcrX2grSYarF/LcmaIPhIy
         rwPnDEYh50h7P0/U/8l632q0eZCB9un7vqh+ic0cmHtzsCnQNCv8Gt4jDT9j1j0WC5
         RTDSrcgDPEAfdjF9h6KutNxDl96vO9J8SmQ6UM61LmwJwv6fAs/ZTZ4urbjf9bNXyC
         RCYAZbmrlZ7PORLpZ9igtiRIynSzekyOymQPcRSj4jcE/EFxeqjhHbjP34aNuZyhWA
         qTEJtWs3l6E4Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 00/11] rename & split tests
Date:   Thu, 28 Apr 2022 17:15:48 +0200
Message-Id: <20220428151559.947144-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; h=from:subject; bh=EXBxyyX1NlnS+wveYEBWWrb4XAjMdw8VCuCTcdVwjHI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRlrV94bcl6vqCO7qW+b2+V1y44kBfCGBPP4/70jd6GVDbd ussGHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJ3MfwV2CedCSb0q6NWdWnqqdFme qLLNkgE3E4aXLqsgdyPydpKjH8MzNT/dajUL/ETGGWtPnGH/L/pjQ9n+5qeG/2jx2TFpk9ZAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Hey everyone,

As announced multiple times already we need to rename and split the
idmapped mount testsuite into separate source files and also give it a
better name to reflect the fact that it covers a lot more than just
idmapped mounts.

I have decided against compiling different binaries for now. Instead we
compile a single vfstest binary that can be called with various command
line switches to run the various test suites. This is not different than
what we did for the idmapped-mounts binary. Of course, nothing prevents
us from using multiple binaries in the future.

Note that this will have a conflict with Jan's series at:
https://lore.kernel.org/fstests/20220425131809.qzjrah7cw67mzzcw@zlang-mailbox/T/#m47d8da68ef1aff250918398e8d2228729a6acf97

If this patch series here is acceptable I'd pick up Jan's patch and
apply it on top of mine as rebasing will introduce too many conflicts.

Thanks!
Christian

Christian Brauner (11):
  src: rename idmapped-mounts folder
  src/vfs: rename idmapped-mounts.c file
  vfstest: rename struct t_idmapped_mounts
  utils: add missing global.h include
  utils: add struct vfstest_info
  utils: move helpers into utils
  missing: move sys_execveat() to missing.h
  utils: add struct test_suite
  vfstests: split idmapped mount tests into separate suite
  vfstest: split out btrfs idmapped mounts test
  vfstest: split out remaining idmapped mount tests

 .gitignore                                    |     4 +-
 common/rc                                     |    32 +-
 src/Makefile                                  |     2 +-
 src/detached_mounts_propagation.c             |     2 +-
 src/feature.c                                 |     2 +-
 src/idmapped-mounts/utils.c                   |   425 -
 src/idmapped-mounts/utils.h                   |   130 -
 src/{idmapped-mounts => vfs}/Makefile         |    14 +-
 src/vfs/btrfs-idmapped-mounts.c               |  3854 +++++
 src/vfs/btrfs-idmapped-mounts.h               |    15 +
 .../idmapped-mounts.c                         | 11865 ++++------------
 src/vfs/idmapped-mounts.h                     |    17 +
 src/{idmapped-mounts => vfs}/missing.h        |    11 +
 src/{idmapped-mounts => vfs}/mount-idmapped.c |     0
 src/vfs/utils.c                               |  1003 ++
 src/vfs/utils.h                               |   364 +
 src/vfs/vfstest.c                             |  1952 +++
 tests/btrfs/245                               |     2 +-
 tests/generic/633                             |     2 +-
 tests/generic/644                             |     2 +-
 tests/generic/645                             |     2 +-
 tests/generic/656                             |     2 +-
 tests/xfs/152                                 |     4 +-
 tests/xfs/153                                 |     2 +-
 24 files changed, 9952 insertions(+), 9756 deletions(-)
 delete mode 100644 src/idmapped-mounts/utils.c
 delete mode 100644 src/idmapped-mounts/utils.h
 rename src/{idmapped-mounts => vfs}/Makefile (59%)
 create mode 100644 src/vfs/btrfs-idmapped-mounts.c
 create mode 100644 src/vfs/btrfs-idmapped-mounts.h
 rename src/{idmapped-mounts => vfs}/idmapped-mounts.c (50%)
 create mode 100644 src/vfs/idmapped-mounts.h
 rename src/{idmapped-mounts => vfs}/missing.h (93%)
 rename src/{idmapped-mounts => vfs}/mount-idmapped.c (100%)
 create mode 100644 src/vfs/utils.c
 create mode 100644 src/vfs/utils.h
 create mode 100644 src/vfs/vfstest.c

-- 
2.32.0

