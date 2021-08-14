Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2318C4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D07760F48
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhHNKt2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237924AbhHNKt1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Aug 2021 06:49:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B8F560F42;
        Sat, 14 Aug 2021 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628938139;
        bh=SdGDSFpPuNW/8h72VRImING/8d4yN42zCODlaWAoMd8=;
        h=From:To:Cc:Subject:Date:From;
        b=aJL1C56GJDMO6wd9QinHZOVHEDJwuqeNiHvjZgbGLXZH3+bOtBupdKaVECEyn6nJH
         MGgOpQe4Li20qs44baEXXS6pd/EtxRNhztg070UnVsRUmo9a8p8+QZMf45QwcLFS6f
         8YvQX8SjCt5ljn0mJVWiZ4Wg1qqllzqXOuW5u1K7nrr1wyuPYDeNPU0kzxz3S71T6m
         pCDPKoDUDU6ByEeTc6qc24wxx7gyccPi5FYqMKH6OHFyr1/GGz26I04J5n5n1OVvX3
         Ys/FUhhfZHpLtnq7ETbAHa95dlZi5xIvaFlpK8bj8B9NqA/P8ma/uDD/1UqrrLL4e4
         rUuc0SaFPsw2A==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 0/8] Extend idmapped mount testsuite
Date:   Sat, 14 Aug 2021 12:47:57 +0200
Message-Id: <20210814104805.1124023-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2875; h=from:subject; bh=FIlYuLl8JkMzzJ1JVKMLh9c737t70WQO67z8IYPSiJs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKzw/7xaopEO/yx4blTH/5l+d36z3flh7teP4xvIu59PfT mt+fO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS7s7IsMV6vvhU3VgPwa7Cq8l7D4 TnPomyFfNg017ndLhyUe9EU4Z/Vtu5l72ZLS6Yy/x/ozSLxESe3xseRW2Te/9oYenmGRq3WAE=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey everyone,

This is v4 with only a minimal change to getopt_long_only(). The rest is
identical. In v3 the changes requested by Christoph and his Reviewed-bys
added. I've also added Josef's Reviewed-by for the newly added btrfs
specific idmapped mount testsuite. There are no major changes to v2.

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
into btrfs' for-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=for-next&id=f691ae1e0bc591df5e9897387d726adbb440fc4c
and so are on track to be included for v5.15.  I'd like to get the btrfs
tests merged now so linux-next can be tested with the them. I hope
that's ok.

I ran:
git rebase -i -x "make -j4 clean && make -j4 && sudo ./check -g idmapped" HEAD~8
on the whole series. Everthing passes.

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

