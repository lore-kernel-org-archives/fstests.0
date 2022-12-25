Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC182C3DA7A
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Dec 2022 16:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLYQHm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Dec 2022 11:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYQHl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Dec 2022 11:07:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3502DEC
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2022 08:07:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4EFC3CE0187
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2022 16:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BC7C433EF;
        Sun, 25 Dec 2022 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671984457;
        bh=gD7GTJIFaQxi9IqF0TeS+NU2NZFUMwZ2T5uD8ujAJNM=;
        h=Date:From:To:Subject:From;
        b=H5bouqUlaSwtQSss11QL/JGM8Fdv1YrlCxn4j4g/bmASANQMti6xDmqQN6fm7woNH
         xi3/V1r73NoWQBcVEIQDUmmTLolAU5rcp6xO/Tgdc36nJ91l+lFp3njs93J6MEtiZj
         8ygaar+XHgkRy+l7c9/ygFW15zBYMtRZvB+lHdYoAZr3Qg5tlNPycczaQfE20zlt3Z
         07GIwY/PJ8CT06j58wXYijFL6yKLVzxw71nphjmMAKoLf2MAhry2iL8TJXZ+UVjMN+
         EM8/f2K1pGpMdMxsEZzk3j+jKX3uXTgh0GwLyFFIo/bHhCjckBkLyvlWa/7LGlssA0
         2DFRYgxerp5sg==
Date:   Mon, 26 Dec 2022 00:07:33 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.12.18 onto master branch
Message-ID: <20221225160733.ijxhlgoizljxipyo@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.12.18 version.

Thanks,
Zorro

The new head of the master branch is commit:

e26310404671 fuzzy: don't fail on compressed metadumps

New commits:

Darrick J. Wong (5):
      [a8a3cd342f90] xfs/018: fix attr value setting in this test
      [538abf799424] common/populate: create helpers to handle restoring metadumps
      [830b45aa636f] common/xfs: create a helper for restoring metadumps to the scratch devs
      [b8c6b5045afb] common/populate: move decompression code to _{xfs,ext4}_mdrestore
      [e26310404671] fuzzy: don't fail on compressed metadumps

David Disseldorp (1):
      [210af953f709] check: ensure sect_stop is initialized if interrupted

Leah Rumancik (1):
      [99b970640652] check: wipe tmp.arglist

Qu Wenruo (1):
      [8a1c35e615fd] check: call _check_dmesg even if the test case failed

Xiao Yang (1):
      [e4b8751d735e] xfs/243: add _require_scratch_delalloc()

Yang Xu (1):
      [9c69817e88ef] src/vfs/utils: Reset errno to zero when detect O_TMPFILE

Ziyang Zhang (2):
      [be957968f6fa] common/xfs: Add a helper to export inode core size
      [8fc059413cc1] common/populate: Ensure that S_IFDIR.FMT_BTREE is in btree format


Code Diffstat:

 check             |  6 +++++-
 common/ext4       | 20 ++++++++++++++++++++
 common/fuzzy      |  5 ++---
 common/populate   | 49 +++++++++++++++++++++++++++++++++++--------------
 common/xfs        | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/vfs/utils.c   |  6 ++++--
 tests/xfs/018     | 17 +++++++++++++++--
 tests/xfs/018.out | 42 +++++++++++++++++++++++++++++++-----------
 tests/xfs/129     |  2 +-
 tests/xfs/234     |  2 +-
 tests/xfs/243     |  1 +
 tests/xfs/253     |  2 +-
 tests/xfs/284     |  2 +-
 tests/xfs/291     |  2 +-
 tests/xfs/335     |  3 ++-
 tests/xfs/336     |  5 +++--
 tests/xfs/337     |  3 ++-
 tests/xfs/341     |  3 ++-
 tests/xfs/342     |  3 ++-
 tests/xfs/432     |  2 +-
 tests/xfs/503     |  8 ++++----
 21 files changed, 186 insertions(+), 49 deletions(-)
--
Zorro Lang
zlang@kernel.org
