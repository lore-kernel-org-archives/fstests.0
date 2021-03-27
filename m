Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE71C433C1
	for <linux-fstests@archiver.kernel.org>; Sat, 27 Mar 2021 11:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AFC619C7
	for <linux-fstests@archiver.kernel.org>; Sat, 27 Mar 2021 11:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhC0LTP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 27 Mar 2021 07:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhC0LTO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Mar 2021 07:19:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E79C861995;
        Sat, 27 Mar 2021 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616843954;
        bh=o5mDqzye4rWUaXGPtA7Kn6LNFWUng6MU4u42lmQloh4=;
        h=From:To:Cc:Subject:Date:From;
        b=hYEQ5C7ln7rHgBbqdOMq8lGdKTf3xr1AmpFI56mbDuW0e+ScgolKcMd9sW7/Y6DsS
         l9u4ijMP3KA4FJ/JAYqZ73LMSkV03vDgiryUffdtSU9cG7XCufhNtAk/h6jFldlBEe
         RGc1vaeccF8wHOMZz+jcCRlzP0RnI4dmgK3GaLELFiPlD+FvOgS0/FyHrdyWqsc/cu
         z1+/X6svhStLyDbOMQVUsyyoh6pN4p+E9G/s+h3AggOVEN6vWbcRa/Lp+fHxmrYlzO
         UMu2jY8KTM5uAZZkWYkFddkeI9X62xWs+X2kTyFCWbobCL/8TeAQcXqPGnUUpuv5+r
         DTiA50c7qkUQA==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v11 0/6] fstests: add idmapped mounts tests
Date:   Sat, 27 Mar 2021 12:18:50 +0100
Message-Id: <20210327111856.1211544-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey everyone,

This series is available from:
https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts
https://github.com/brauner/xfstests/tree/idmapped_mounts

/* v11 */
Reworked according to Amir's comments.

/* v10 */
Reworked according to Eryu's comments.

/* v9 */
Rebased onto current master.

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-syz #18 SMP PREEMPT Fri Mar 26 13:27:16 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/632 files ...  27s
xfs/529 files ...  67s
xfs/530 files ...  43s
Ran: generic/632 xfs/529 xfs/530
Passed all 3 tests

Thanks!
Christian

Christian Brauner (6):
  generic/631: add test for detached mount propagation
  generic/632: add fstests for idmapped mounts
  common/rc: add _scratch_{u}mount_idmapped() helpers
  common/quota: move _qsetup() helper to common code
  xfs/529: quotas and idmapped mounts
  xfs/530: quotas on idmapped mounts

 .gitignore                            |    3 +
 common/quota                          |   20 +
 common/rc                             |   60 +
 configure.ac                          |    2 +
 include/builddefs.in                  |    1 +
 m4/Makefile                           |    1 +
 m4/package_libcap.m4                  |    4 +
 src/Makefile                          |    8 +-
 src/detached_mounts_propagation.c     |  189 +
 src/feature.c                         |   40 +-
 src/idmapped-mounts/Makefile          |   41 +
 src/idmapped-mounts/idmapped-mounts.c | 8761 +++++++++++++++++++++++++
 src/idmapped-mounts/missing.h         |  151 +
 src/idmapped-mounts/mount-idmapped.c  |  431 ++
 src/idmapped-mounts/utils.c           |  134 +
 src/idmapped-mounts/utils.h           |   30 +
 tests/generic/631                     |   43 +
 tests/generic/631.out                 |    2 +
 tests/generic/632                     |   42 +
 tests/generic/632.out                 |    2 +
 tests/generic/group                   |    2 +
 tests/xfs/050                         |   19 -
 tests/xfs/299                         |   19 -
 tests/xfs/529                         |  378 ++
 tests/xfs/529.out                     |  657 ++
 tests/xfs/530                         |  212 +
 tests/xfs/530.out                     |  129 +
 tests/xfs/group                       |    2 +
 28 files changed, 11340 insertions(+), 43 deletions(-)
 create mode 100644 m4/package_libcap.m4
 create mode 100644 src/detached_mounts_propagation.c
 create mode 100644 src/idmapped-mounts/Makefile
 create mode 100644 src/idmapped-mounts/idmapped-mounts.c
 create mode 100644 src/idmapped-mounts/missing.h
 create mode 100644 src/idmapped-mounts/mount-idmapped.c
 create mode 100644 src/idmapped-mounts/utils.c
 create mode 100644 src/idmapped-mounts/utils.h
 create mode 100644 tests/generic/631
 create mode 100644 tests/generic/631.out
 create mode 100644 tests/generic/632
 create mode 100644 tests/generic/632.out
 create mode 100644 tests/xfs/529
 create mode 100644 tests/xfs/529.out
 create mode 100644 tests/xfs/530
 create mode 100644 tests/xfs/530.out


base-commit: f6ddaf130d5b0817278afe441fdde52f464f321b
-- 
2.27.0

