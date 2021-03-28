Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993BDC433C1
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B74F6044F
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhC1Wed (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 18:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhC1WeN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 28 Mar 2021 18:34:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EAB26044F;
        Sun, 28 Mar 2021 22:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616970852;
        bh=GBoD+H+163SsF8/Wzeynw/etJ8BKSkQvudLwRW3QQcA=;
        h=From:To:Cc:Subject:Date:From;
        b=XqiOBQpS04fAlm9hT1AjPzTo3Dcwum/XzMofaG6TfRJF9vpImRQss75G1ZG6C5/BI
         Emtazgrj4BhgmgsGIp0Xxj+0U1LGDtivRF+T5Ez5cZ0e6pUTaozKr0Mv4NN5JpGL0r
         uHJ2AEzGqG3yFZzyMkAReNbtL5azCe29UyIGaA2CI11fAeaZsJ+N+fc4yNKsTIf7pW
         twlY92xv4LA+GVQS0NU0Y7Bq5HUF6PRtF4pxfsW2gzg+03hKYqGV+mGK57HaKGR0j1
         w+zmI7K3rE906gXMMrzvdFMPmHIrb8jrE8cfnL8o53fRd4Pteh+BrvyJ81MEV5rz/n
         JQKrp8ModQ+FA==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v12 0/6] fstests: add idmapped mounts tests
Date:   Mon, 29 Mar 2021 00:33:54 +0200
Message-Id: <20210328223400.1800301-1-brauner@kernel.org>
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
 README                                |    5 +-
 common/quota                          |   20 +
 common/rc                             |   60 +
 configure.ac                          |    2 +
 include/builddefs.in                  |    1 +
 m4/Makefile                           |    1 +
 m4/package_libcap.m4                  |    4 +
 src/Makefile                          |    8 +-
 src/detached_mounts_propagation.c     |  189 +
 src/feature.c                         |   40 +-
 src/idmapped-mounts/Makefile          |   40 +
 src/idmapped-mounts/idmapped-mounts.c | 8873 +++++++++++++++++++++++++
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
 29 files changed, 11453 insertions(+), 45 deletions(-)
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

