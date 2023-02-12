Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F0C636D3
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Feb 2023 11:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBLLN6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Feb 2023 06:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLN5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Feb 2023 06:13:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E867A113CA
        for <fstests@vger.kernel.org>; Sun, 12 Feb 2023 03:13:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 902BEB80B0C
        for <fstests@vger.kernel.org>; Sun, 12 Feb 2023 11:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9828CC433D2;
        Sun, 12 Feb 2023 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676200434;
        bh=VdqRJfmfnjLWccJrEwoNTHql+f9wNwrtu24qzAgSlYI=;
        h=Date:From:To:Subject:From;
        b=qrqDfdfSaZP3v3Yo3rT04ShMfqs2QtF6pS71iQ3OXlL4ovcJfEoZvx0N/kHliV2BF
         JSIuNUDN3SyvNzZuQ3WybU+IF8LJpS/2N04C9puhHnHdRhMe8zXLQ8Q882WMQGbHxS
         cUHaO4JU70gpnGL5w/q7VB9VX5ZZ5E5XPqgfkYs5XLVotcCsS4Wrd6+QIyrRvKM13g
         Yl5Un4NSOVumdQxagCqKwHaQfh5n6R6/29WPrFE77C/flwfjvC/PsJbpfjCTGXFGnA
         T4+pi3oydW6YoN5e7ZkfTgjlsiFihYeVCv3GlUaiOLSGEg+5jmG/MIh4DZRBgcHjlu
         a1P7SFEYnosxw==
Date:   Sun, 12 Feb 2023 19:13:49 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.02.05 onto master branch
Message-ID: <20230212111349.tmebqecuhiaguvus@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.02.05 version.

Thanks,
Zorro

The new head of the master branch is commit:

f6ab376b553d xfs/191: fix xattr leaf block emptying on 64k blocksized fses

New commits:

Anand Jain (4):
      [7fa8a9a25bd1] fstests: doio.c, fix missing initialization of -C arg
      [8d8d05a8e222] fstests: fstest.c, fix compile warnings replace sprintf with snprintf
      [c569ebf56180] fstests: t_getcwd.c, fix a warning related to buffer overflow
      [1f12612b7c29] fstests: aiodio_sparse2.c, fix compiler warning buffer overflow

Anthony Iliopoulos (1):
      [f6ab376b553d] xfs/191: fix xattr leaf block emptying on 64k blocksized fses

Darrick J. Wong (2):
      [82961ee6b44f] generic/038: set a maximum runtime on this test
      [c7c1063809ef] generic/500: skip this test if formatting fails

Filipe Manana (2):
      [d3db87166a6d] btrfs/299: update kernel commit hash and subject
      [276e00a966b3] btrfs: test send optimal cloning behaviour

Hironori Shiina (2):
      [e100e9dfd87b] xfs: add helper to create fake root inode
      [6a19144c851c] xfs: test xfsrestore on multi-level dumpfiles with wrong root

Jan Kara (1):
      [da69ce70dfcd] generic/707: Test moving directory while being grown


Code Diffstat:

 common/dmthin                        |    7 +-
 common/rc                            |   22 +-
 common/xfs                           |   40 +
 ltp/doio.c                           |    1 +
 src/aio-dio-regress/aiodio_sparse2.c |    1 +
 src/fstest.c                         |   17 +-
 src/t_getcwd.c                       |    4 +-
 tests/btrfs/283                      |   88 ++
 tests/btrfs/283.out                  |   26 +
 tests/btrfs/299                      |    3 +-
 tests/generic/038                    |    6 +
 tests/generic/500                    |    3 +-
 tests/generic/707                    |   70 ++
 tests/generic/707.out                |    2 +
 tests/xfs/191                        |   12 +-
 tests/xfs/545                        |   31 +-
 tests/xfs/554                        |   35 +-
 tests/xfs/557                        |   31 +-
 tests/xfs/567                        |  125 +++
 tests/xfs/567.out                    | 1517 ++++++++++++++++++++++++++++++++++
 tests/xfs/568                        |  213 +++++
 tests/xfs/568.out                    |  849 +++++++++++++++++++
 22 files changed, 2999 insertions(+), 104 deletions(-)
--
Zorro Lang
zlang@kernel.org
