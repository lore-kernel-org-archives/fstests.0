Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980CC4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99A46103A
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 16:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhHLQEB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhHLQEB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Aug 2021 12:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD4616103E;
        Thu, 12 Aug 2021 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628784216;
        bh=TXtuPvIN62GUgOvvXk9kmauwnRvr36uCmL1pCeziSEM=;
        h=From:To:Cc:Subject:Date:From;
        b=k2z4DgLQcXe6m5k3iU0LHHKJOARgQRTNXeU88XbY6ntdn2z5duHhNbUZL2vaoF8eG
         jgY4e4MFLhBAAdnA5laDMqIrlJSbCgrA7kUtuyVwM9RyvFh3xKEaGbm/j/E5A4V5Cs
         4QJgxNZ/Nc4PlPsUNr5zOZSZUbmAGKPkILKoXSuFJwh5mGlYBEpzifLvG1KZ/bccqh
         v7+k9PcnUy0uY486sfYW0mpqNHuQgIvuIa5K/BA8JZZvmazwM4B6rqf+fJjxCFXz4T
         vQrcny6vLZA5iqWTtZSDYZqHfNwtjR26M/0MdvYY6gy2AueWXaPstkg6yrZnmPmIcg
         yl2FjGjBNubwg==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 0/8] Extend idmapped mount testsuite
Date:   Thu, 12 Aug 2021 18:01:32 +0200
Message-Id: <20210812160140.990229-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538; h=from:subject; bh=CE+fgrKU3FAXkvsL+tzEjPJcCZCPMmJU1a4Mghlnze8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKut675RNzbcqFzx4rpeV2TmHxTVwV8s8gL8y05Imy+fRv i36s6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIw9sM/9QeMwa31UnHmSrnTGvkKG r6+PvQ9nDt6vtz2nY+FG6L52dk6ONcG7KjetPuVjmxAG0htypjt85E3pkyXL8OBnX/r5nBDgA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey everyone,

This is v3 with the changes requested by Christoph and his Reviewed-bys
added. I've also added Josef's Reviewed-by for the newly added btrfs
specific idmapped mount testsuite.
There are no major changes to v2.

This time around I've put everyone in To: to make sure that they receive
all patches. The list apparently still refues patches if they are fairly
huge. The series can be pulled from three locations:

git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/xfstests-dev fs.idmapped.nested_userns
git@gitlab.com:brauner/xfstests.git fs.idmapped.nested_userns
git@github.com:brauner/xfstests.git fs.idmapped.nested_userns

This adds three new tests:
- a regression test for vfs capabilities
- a new test with nested and complex idmapping layouts
- a new btrfs specific idmapped mount testsuite

Since v2 patches to support idmapped mounts on btrfs have been merged
into btrfs' for-next tree and so are on track to be included for v5.15.
I'd like to get the btrfs tests merged now so linux-next can be tested
with the them. I hope that's ok.

Thanks!
Christian

Christian Brauner (8):
  idmapped-mounts: use die() helper
  idmapped-mounts: switch to getopt_long_only()
  idmapped-mounts: introduce an explicit command line switch for
    testsuite
  generic/640: add fscaps regression test
  idmapped-mounts: refactor helpers
  idmapped-mounts: add nested userns creation helpers
  generic/641: add nested user namespace tests
  btrfs/244: introduce btrfs specific idmapped mounts tests

 configure.ac                          |   10 +-
 src/idmapped-mounts/idmapped-mounts.c | 4747 ++++++++++++++++++++++++-
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
 12 files changed, 5231 insertions(+), 315 deletions(-)
 create mode 100755 tests/btrfs/244
 create mode 100644 tests/btrfs/244.out
 create mode 100755 tests/generic/640
 create mode 100644 tests/generic/640.out
 create mode 100755 tests/generic/641
 create mode 100644 tests/generic/641.out


base-commit: dad0c0a852d1b10e7da285f29e99397dec0efec1
-- 
2.30.2

