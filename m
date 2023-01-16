Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907FC46467
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Jan 2023 06:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjAPGLB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 Jan 2023 01:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjAPGKk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Jan 2023 01:10:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5CF77B
        for <fstests@vger.kernel.org>; Sun, 15 Jan 2023 22:08:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD82C60EBB
        for <fstests@vger.kernel.org>; Mon, 16 Jan 2023 06:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C6AC433EF;
        Mon, 16 Jan 2023 06:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673849273;
        bh=hM46fr9Ba57v3mMVGN+gKgdn6dCzXqykKB4tS9YPsNI=;
        h=Date:From:To:Subject:From;
        b=BDJk2x8ymChLJCQijDi1r1yEbJATnz7zo/xs7ar+smnxqky3pdo0wxar7dQ4WixMv
         mdMIn/sPCgf3ywORINSrM6lvvsR1Ys77vTHxAXUWtbaIiwKgHMBVeSwG+6m6iGi37H
         MVPW/bTpzQeBBucplm8kskxqIqjtnO/Hh8izk9tXLR4ifR10WWofhVRjEsTuMx5tcv
         BVj+D5IHyaq1HBZ2t6a0vkzpT5FNL8jwPvOWLMAjZ5y7fl+MaEblHQYgY7CVZ6Uqr6
         YpYtPdjeIkF6yTbQZWlp9IPUvHueiAa23gS74vLv6Behuvp6wO+OOJeEP1BIWtWOl3
         byNnOisI0SAzw==
Date:   Mon, 16 Jan 2023 14:07:49 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.01.01 onto master branch
Message-ID: <20230116060749.xi2d42w2qjls7ch7@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.01.01 version.

Thanks,
Zorro

The new head of the master branch is commit:

fbd489798b31 generic/575: test 1K Merkle tree block size

New commits:

Eric Biggers (10):
      [d60bd999f580] common/verity: add and use _fsv_can_enable()
      [d206c4d04b6a] common/verity: set FSV_BLOCK_SIZE to an appropriate value
      [5fadb20865e6] common/verity: use FSV_BLOCK_SIZE by default
      [658d8d249e97] common/verity: add _filter_fsverity_digest()
      [3f15400a5fab] generic/572: support non-4K Merkle tree block size
      [abe649bd4776] generic/573: support non-4K Merkle tree block size
      [e25ea6825c08] generic/577: support non-4K Merkle tree block size
      [a89062a98d07] generic/574: test multiple Merkle tree block sizes
      [772a394868c9] generic/624: test multiple Merkle tree block sizes
      [fbd489798b31] generic/575: test 1K Merkle tree block size


Code Diffstat:

 common/verity         |  84 ++++++++++++++-----
 tests/generic/572     |  21 ++---
 tests/generic/572.out |  10 +--
 tests/generic/573     |   8 +-
 tests/generic/574     | 219 ++++++++++++++++++++++++++++++--------------------
 tests/generic/574.out |  83 ++-----------------
 tests/generic/575     |  57 +++++++++----
 tests/generic/575.out |   8 +-
 tests/generic/577     |  24 +++---
 tests/generic/577.out |  10 +--
 tests/generic/624     | 119 +++++++++++++++++++--------
 tests/generic/624.out |  15 ++--
 12 files changed, 370 insertions(+), 288 deletions(-)
--
Zorro Lang
zlang@kernel.org
