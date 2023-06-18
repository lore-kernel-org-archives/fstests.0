Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA5EB64D7
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jun 2023 13:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFRN0o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Jun 2023 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFRN0o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Jun 2023 09:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166B110
        for <fstests@vger.kernel.org>; Sun, 18 Jun 2023 06:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6082D6125A
        for <fstests@vger.kernel.org>; Sun, 18 Jun 2023 13:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2305CC433C0;
        Sun, 18 Jun 2023 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687094801;
        bh=oqdp5S5/Nto1zputbtN+30JUbyHLFX3bl4rYgrQdobQ=;
        h=Date:From:To:Subject:From;
        b=M5X0S/m4mfcoz7gGBHwuhb3Ji/nUh1sn8xCNXR7um1vNKve/G7/pZ7WiXj1YQAvfG
         jWEegXxOVaYl8TnRGC3CLS38/hS658caFZXPKNPrFuVnvmino9ppGLR6luBQbU3/tg
         kflNV9MwbVIyxv4Iwtf2gznXAi+xERFD8GC2wsZSSpC+5hkmG3FcwfIgTBRVLajzd5
         xEangTu6S5t4KIvgAAYcwAL+KuYSRILI5uzdBNpOhYgP1PZ5RaZGW/iuXF7NeYEcFj
         6NT52GmLQOORCWjL6Qha/A/XWvNflsrVt1xArsoaSXTdHTMO9mPrxWylARGHnAcYeh
         w79kfVbEJuLQw==
Date:   Sun, 18 Jun 2023 21:26:37 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.05.28 onto master branch
Message-ID: <20230618132637.57jwupwv5rtlaeth@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.05.28 version.

Thanks,
Zorro

The new head of the master branch is commit:

596db5ee9182 fuzzy: skip online scrub and health checks if not supported

New commits:

Andrey Albershteyn (1):
      [df0238186fe5] fstests: fix compilation error in splice2pipe on old (<C99) compilers

Anna Schumaker (1):
      [a7afd52b4a89] generic: Add a test for xattr ctime updates

Anthony Iliopoulos (1):
      [596db5ee9182] fuzzy: skip online scrub and health checks if not supported

Filipe Manana (4):
      [e46a74f2e1d7] generic/708: fix commit subject and add its git hash
      [aeb0dccbadac] btrfs/213: add _fixed_by_kernel_commit tag and remove from dangerous group
      [4aa3e1dc28c9] btrfs/287: add git commit hash for the kernel fix
      [6dfe7b6b9033] btrfs/213: avoid occasional failure due to already finished balance

Murphy Zhou (1):
      [199342c9fa48] common/{filter,quota}, xfs/1{06,52}: fix grep pattern


Code Diffstat:

 common/filter         |  2 +-
 common/fuzzy          |  6 ++++++
 common/quota          |  2 +-
 src/splice2pipe.c     |  5 +++--
 tests/btrfs/213       | 21 +++++++++++++++++----
 tests/btrfs/287       |  2 +-
 tests/generic/708     |  3 ++-
 tests/generic/728     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/728.out |  2 ++
 tests/xfs/106         |  4 ++--
 tests/xfs/152         |  4 ++--
 11 files changed, 80 insertions(+), 14 deletions(-)
--
Zorro Lang
zlang@kernel.org
