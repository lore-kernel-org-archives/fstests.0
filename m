Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE696C433E3
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521DD619A5
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhCVNqG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhCVNpf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Mar 2021 09:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C9FC6196F;
        Mon, 22 Mar 2021 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616420735;
        bh=8q0msXTvsYxJ5zolZ5GsNSjdf0v+v57gOC3HitYAscc=;
        h=From:To:Cc:Subject:Date:From;
        b=NA1ldQZ6QMq3u97nfzat0QZzqnRTV6qMQkFb/Mx+CMPehRJJF4BwF1thjnFM3ig2/
         OFrS3goHh+s8RH9pAo18ybOntjcEQZi9Z8/FSm+WFk/e2qTD0KakXx3Sl82gr6tJa3
         VF5PuR/lvt2uuayHw6+8CyMah9KgEPmo51HvWELNVSJ1MB1HdGgm6G/vIAukCtlOEH
         3jMwbic2Q6aIDIfMphumLCtu3fw8PUUsKEc+aDj1p/aWrMSEUp3W7v6Pjpn8IIpVGS
         vKvxssTXh4WR0dGFvhWb2DPfF+0CEuYEiT0ILs+kcC2fd810M9Dd1HVcBLhXXoU7iI
         x7zcaLtGWaeBQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v10 0/6] fstests: add idmapped mounts tests
Date:   Mon, 22 Mar 2021 14:45:16 +0100
Message-Id: <20210322134522.916512-1-brauner@kernel.org>
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

/* v10 */
Reworked according to Eryu's comments.

/* v9 */
Rebased onto current master.

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/631
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/631 files ...  10s
Ran: generic/631
Passed all 1 tests

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/632
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/632	 14s
Ran: generic/632
Passed all 1 tests

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/529
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

xfs/529 files ...  43s
Ran: xfs/529
Passed all 1 tests

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/530
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

xfs/530 files ...  25s
Ran: xfs/530
Passed all 1 tests

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
 src/idmapped-mounts/mount-idmapped.c  |  428 ++
 src/idmapped-mounts/utils.c           |  134 +
 src/idmapped-mounts/utils.h           |   30 +
 tests/generic/631                     |   43 +
 tests/generic/631.out                 |    2 +
 tests/generic/632                     |   42 +
 tests/generic/632.out                 |    2 +
 tests/generic/group                   |    2 +
 tests/xfs/050                         |   19 -
 tests/xfs/299                         |   19 -
 tests/xfs/529                         |  377 ++
 tests/xfs/529.out                     |  657 ++
 tests/xfs/530                         |  211 +
 tests/xfs/530.out                     |  129 +
 tests/xfs/group                       |    2 +
 28 files changed, 11335 insertions(+), 43 deletions(-)
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

