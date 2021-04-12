Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B5C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 11:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FC76121E
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 11:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhDLL6d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240788AbhDLL6d (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Apr 2021 07:58:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0D5D611C9;
        Mon, 12 Apr 2021 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618228695;
        bh=WYxFB1YD+mRL18+z671iou5y8zRHPPmcYE9rIuVewEU=;
        h=From:To:Cc:Subject:Date:From;
        b=NoUeQ0uE4uULNiSg+wu+Tr1bXNyafsUNEhFTr0SaBNFJfqmObGP0PwTTx7YFlS9CR
         hg/r4ds5vfKJZRZcjHWN61WL5OxjkcdJrk4VmIS0O40f7X4VCcOCv2XewNKn/Qtk+6
         g0uiZwpDdCOLxG9mj2z9y+YGK8TYhlVt5JAnGLMcIHUK7fV4ulfIfHe2Gt2LY4oelC
         BgNz3LsJTAFkAANAXcUTiLllYPE2yvG3+LdQlJdmdhgscxDcOIHQkm1UxdvBTJJ8Kv
         W4eO/DN+J9JtG12ThepFDQ5glx1yQBVfS+c/EpfC56gzVGdEswY/W/PpAkBqoRzK2o
         KMTpXJGGYdoug==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v13 0/6] fstests: add idmapped mounts tests
Date:   Mon, 12 Apr 2021 13:57:02 +0200
Message-Id: <20210412115708.1628386-1-brauner@kernel.org>
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

#### Unsupported filesystem
ubuntu@f2-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 f2-vm 5.12.0-rc6-ecryptfs-6d82e210b270 #373 SMP PREEMPT Fri Apr 9 13:58:37 UTC 2021
MKFS_OPTIONS  -- /dev/loop3
MOUNT_OPTIONS -- /dev/loop3 /mnt/scratch

generic/632 files ... [not run] idmapped-mounts not support by btrfs
Ran: generic/632
Not run: generic/632
Passed all 1 tests

#### xfs
ubuntu@f2-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 f2-vm 5.12.0-rc6-ecryptfs-6d82e210b270 #373 SMP PREEMPT Fri Apr 9 13:58:37 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/632 files ...  27s
xfs/529 files ...  64s
xfs/530 files ...  41s
Ran: generic/632 xfs/529 xfs/530
Passed all 3 tests

#### ext4
ubuntu@f2-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 f2-vm 5.12.0-rc6-ecryptfs-6d82e210b270 #373 SMP PREEMPT Fri Apr 9 13:58:37 UTC 2021
MKFS_OPTIONS  -- /dev/loop5
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop5 /mnt/scratch

generic/632 files ...  22s
Ran: generic/632
Passed all 1 tests

/* v13 */
- Make sure that idmapped-mount tests are skipped on unsupported
  filesystems.

/* v12 */
- Main change is a fix to the io_uring tests. io_uring_wait_cqe()
  doesn't set errno, it returns a negative errno.
- Make sure we also run without error when libcap isn't available (That
  was always the goal but the logic missed a few new tests.)

/* v11 */
Reworked according to Amir's comments.

/* v10 */
Reworked according to Eryu's comments.

/* v9 */
Rebased onto current master.

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
 README                                |    5 +-
 common/quota                          |   20 +
 common/rc                             |   69 +
 configure.ac                          |    2 +
 include/builddefs.in                  |    1 +
 m4/Makefile                           |    1 +
 m4/package_libcap.m4                  |    4 +
 src/Makefile                          |    8 +-
 src/detached_mounts_propagation.c     |  189 +
 src/feature.c                         |   40 +-
 src/idmapped-mounts/Makefile          |   40 +
 src/idmapped-mounts/idmapped-mounts.c | 8916 +++++++++++++++++++++++++
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
 tests/xfs/529                         |  377 ++
 tests/xfs/529.out                     |  657 ++
 tests/xfs/530                         |  212 +
 tests/xfs/530.out                     |  129 +
 tests/xfs/group                       |    2 +
 29 files changed, 11505 insertions(+), 45 deletions(-)
 create mode 100644 m4/package_libcap.m4
 create mode 100644 src/detached_mounts_propagation.c
 create mode 100644 src/idmapped-mounts/Makefile
 create mode 100644 src/idmapped-mounts/idmapped-mounts.c
 create mode 100644 src/idmapped-mounts/missing.h
 create mode 100644 src/idmapped-mounts/mount-idmapped.c
 create mode 100644 src/idmapped-mounts/utils.c
 create mode 100644 src/idmapped-mounts/utils.h
 create mode 100755 tests/generic/631
 create mode 100644 tests/generic/631.out
 create mode 100755 tests/generic/632
 create mode 100644 tests/generic/632.out
 create mode 100755 tests/xfs/529
 create mode 100644 tests/xfs/529.out
 create mode 100755 tests/xfs/530
 create mode 100644 tests/xfs/530.out


base-commit: f6ddaf130d5b0817278afe441fdde52f464f321b
-- 
2.27.0

