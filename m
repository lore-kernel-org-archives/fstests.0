Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225F9C433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Mar 2021 10:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D251265031
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Mar 2021 10:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhCPKhA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Mar 2021 06:37:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42066 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCPKgl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Mar 2021 06:36:41 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lM742-0008JF-Bo; Tue, 16 Mar 2021 10:36:38 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v9 0/4 REBASED] fstests: add idmapped mounts tests
Date:   Tue, 16 Mar 2021 11:36:23 +0100
Message-Id: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hey everyone,

/* v9 */
Rebased onto current master.
Hopefully we can merge this soon so we can have regular testing asap and
the rebasing is getting a bit tedious too. ;)

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/631
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-inode-helpers #343 SMP Mon Mar 15 12:57:02 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/631 9s ...  11s
Ran: generic/631
Passed all 1 tests

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/632
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-inode-helpers #343 SMP Mon Mar 15 12:57:02 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/632      15s
Ran: generic/632
Passed all 1 tests

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/529
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-inode-helpers #343 SMP Mon Mar 15 12:57:02 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

xfs/529 25s ...  43s
Ran: xfs/529
Passed all 1 tests

ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/530
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-inode-helpers #343 SMP Mon Mar 15 12:57:02 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

xfs/530  24s
Ran: xfs/530
Passed all 1 tests

/* v8 */
This adds the testsuite for idmapped mounts. It has been expanded quite
a bit too since the last version:
- Add a testcase to verify that detached mounts in the new mount api
  work correctly.
- Add a full testsuite for idmapped mounts.
- Add two quota tests verifying xfs behavior.

Sorry that it took so long to resend this testsuite but I had to chase
and fix a bug in the new mount API (completely independent of idmapped
mounts) before I could add quota tests because they would otherwise run
danger to render the host mount namespace unuseable due to that bug
(cf.  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3110f256d126b44d34c1f662310cd295877c447)
All tests here pass for me on a kernel with idmapped mounts. The xfs
specific quota tests should go on top of the fixes that Darrick is
currently carrying for 5.12 and which he sent out a little while ago.

Thanks!
Christian

Christian Brauner (4):
  generic/631: add test for detached mount propagation
  generic/632: add fstests for idmapped mounts
  xfs/529: quotas and idmapped mounts
  xfs/530: quotas on idmapped mounts

 .gitignore                            |    3 +
 common/rc                             |   25 +
 configure.ac                          |    2 +
 include/builddefs.in                  |    1 +
 m4/Makefile                           |    1 +
 m4/package_libcap.m4                  |    4 +
 src/Makefile                          |    8 +-
 src/detached_mounts_propagation.c     |  189 +
 src/feature.c                         |   40 +-
 src/idmapped-mounts/Makefile          |   41 +
 src/idmapped-mounts/idmapped-mounts.c | 8627 +++++++++++++++++++++++++
 src/idmapped-mounts/missing.h         |  151 +
 src/idmapped-mounts/mount-idmapped.c  |  428 ++
 src/idmapped-mounts/utils.c           |  134 +
 src/idmapped-mounts/utils.h           |   30 +
 tests/generic/631                     |   41 +
 tests/generic/631.out                 |    2 +
 tests/generic/632                     |   42 +
 tests/generic/632.out                 |    2 +
 tests/generic/group                   |    2 +
 tests/xfs/529                         |  373 ++
 tests/xfs/529.out                     |  657 ++
 tests/xfs/530                         |  274 +
 tests/xfs/530.out                     |  129 +
 tests/xfs/group                       |    2 +
 25 files changed, 11203 insertions(+), 5 deletions(-)
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

