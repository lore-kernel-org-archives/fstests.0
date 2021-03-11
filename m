Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315DC433E6
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Mar 2021 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B0864FFF
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Mar 2021 17:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCKR4C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:56:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39359 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCKRzw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Mar 2021 12:55:52 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lKPXI-0008Tn-Jr; Thu, 11 Mar 2021 17:55:48 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/4] fstests: add idmapped mounts tests
Date:   Thu, 11 Mar 2021 18:55:32 +0100
Message-Id: <20210311175536.1971732-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hey everyone,

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

Hopefully we can merge this soon so we can have regular testing asap!
Thanks!
Christian

Christian Brauner (4):
  generic/626: add test for detached mount propagation
  generic/627: add fstests for idmapped mounts
  xfs/528: quotas and idmapped mounts
  xfs/529: quotas on idmapped mounts

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
 tests/generic/626                     |   41 +
 tests/generic/626.out                 |    2 +
 tests/generic/627                     |   42 +
 tests/generic/627.out                 |    2 +
 tests/generic/group                   |    2 +
 tests/xfs/528                         |  373 ++
 tests/xfs/528.out                     |  657 ++
 tests/xfs/529                         |  274 +
 tests/xfs/529.out                     |  129 +
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
 create mode 100755 tests/generic/626
 create mode 100644 tests/generic/626.out
 create mode 100755 tests/generic/627
 create mode 100644 tests/generic/627.out
 create mode 100755 tests/xfs/528
 create mode 100644 tests/xfs/528.out
 create mode 100755 tests/xfs/529
 create mode 100644 tests/xfs/529.out


base-commit: 52a3700b26e15a7267527463766ef1f22768ae25
-- 
2.27.0

