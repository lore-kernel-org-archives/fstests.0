Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF7C4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 31 Jul 2021 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A5D60F46
	for <linux-fstests@archiver.kernel.org>; Sat, 31 Jul 2021 16:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhGaQ64 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 31 Jul 2021 12:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhGaQ64 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 31 Jul 2021 12:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A0E960F3A;
        Sat, 31 Jul 2021 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627750729;
        bh=iiNx/1yA7yKEMM1x3GuqZ5c01BeXr0981Wqck8c407s=;
        h=From:To:Cc:Subject:Date:From;
        b=OwseQjPvvMSBcFBuhReCFfYe8nY9mVeexXcCCnwxUDDtVWWrPdnXzszCULEYbForu
         jGOJ0S6UVUvg6KJL4ymkDdssVRi8e2xfDPdm02SKO8JBIzsf1wTnaWXEv1TW0TkC4i
         JHTlGExHZlqPDwJPIB27og6DnRwvygZxDOQjXxDhR7OcCUDkSRMatFiLpQuI7thN/R
         RZFa58Aiw46DJrBEhhvrSfmTGeYbgH/53vGtCSl5fc2VtNIEeZ+I9rBLwP0dotW95J
         toEyj9kjJdmu8HZrzcCw/+dJLycRX+15MMD8taCo2jeqCTilw7RMtFF13NdNXQbrS3
         oyDgFDrmXyuag==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 0/6] Extend idmapped mount testsuite
Date:   Sat, 31 Jul 2021 18:58:28 +0200
Message-Id: <20210731165834.479633-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; h=from:subject; bh=awvKECNsBqPMEtzk6xUNKpEeZiJfSam4GxQQlsFNnmg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSyNkoIhdheP5HJOUPmcYXMiYfb9OyqY7+uZJyxdVuz1oRc I0OOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkkaTL84fVzfC92fOFjEf/fCsmbdp +dWOckzrx58vef8m93+K/eaMPIsFR43sL2zFuF2a6T3P6ZnbwUs/dYw9X/vw0+GSa1ntj0mwsA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

This adds two new tests:
- a regression test for vfs capabilities
- a new test with nested idmapping layouts

In addition, I've added a new test for btrfs which is on-track to
support idmapped mounts in v5.15. I leave it to Eryu whether he wants to
merge the btrfs test already or not. I think there's no harm in doing so
but I'm also happy to wait.

Thanks!
Christian

Christian Brauner (6):
  idmapped-mounts: prepare for additional tests
  generic/640: add fscaps regression test
  idmapped-mounts: refactor helpers
  idmapped-mounts: add nested userns creation helpers
  generic/641: add nested user namespace tests
  btrfs/244: introduce btrfs specific idmapped mounts tests

 src/idmapped-mounts/idmapped-mounts.c | 4583 ++++++++++++++++++++++++-
 src/idmapped-mounts/mount-idmapped.c  |  229 +-
 src/idmapped-mounts/utils.c           |  359 +-
 src/idmapped-mounts/utils.h           |  102 +-
 tests/btrfs/244                       |   34 +
 tests/btrfs/244.out                   |    2 +
 tests/generic/633                     |    3 +-
 tests/generic/640                     |   28 +
 tests/generic/640.out                 |    2 +
 tests/generic/641                     |   28 +
 tests/generic/641.out                 |    2 +
 11 files changed, 5054 insertions(+), 318 deletions(-)
 create mode 100755 tests/btrfs/244
 create mode 100644 tests/btrfs/244.out
 create mode 100755 tests/generic/640
 create mode 100644 tests/generic/640.out
 create mode 100755 tests/generic/641
 create mode 100644 tests/generic/641.out


base-commit: dad0c0a852d1b10e7da285f29e99397dec0efec1
-- 
2.30.2

