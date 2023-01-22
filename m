Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AADC25B4E
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Jan 2023 13:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAVNbh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Jan 2023 08:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjAVNbg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Jan 2023 08:31:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73B1C333
        for <fstests@vger.kernel.org>; Sun, 22 Jan 2023 05:31:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B5360B9C
        for <fstests@vger.kernel.org>; Sun, 22 Jan 2023 13:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8CEC433D2;
        Sun, 22 Jan 2023 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674394294;
        bh=NYWYijbepwXxxgmX8+j4o2ZgDXO/pWENhakIsbVws+s=;
        h=Date:From:To:Subject:From;
        b=FL2ANZgcn6a/uBAz6tFkMD7Z9kVAPHDtVNoIedhxCP+irUSwPQSAwL/wowCOLTZsJ
         2VEIHsZSvIsk7vbL79dioivl4EFzX5R9BX7LeL32XFu8xUPtmDWKtbpuZuectzaqEN
         SQErt/uHhbk3VICJfnIHIFcBGEfK9AN+nu9GaYKSzH7NmSiaSq/ov5wgVAG/0fcksu
         jS/45/QkcvfTFAPhf8kufBQZWdA9jX7m8P7apAk8PombHkUd9C0nvpVYwglvw7bqrX
         Xi2x5s6phoZe82UGwvR04qhUh+8cEDf8oR2ivxGQFDkLJalIkQpjpiMyt2KD62XVIw
         ebkgZMvtj77kA==
Date:   Sun, 22 Jan 2023 21:31:30 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.01.22
Message-ID: <20230122133130.wau77fp4756imkw5@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.01.22 release.

Release Notes:
1) fstests supports a new fs type -- "fuse" (and subtype). Feel free to try
   it and feedback to us if you find any issues. More details refer to
   README.fuse
2) Due to kernel default behavior changes, so we update/remove some setgid
   related tests. If you find more issues, please report to us.
3) Some testing improvement for populate testing

More cases' bug fix refer to below. Thanks for all these contribution, and ...
*Happy Chinese New Year*!

Thanks,
Zorro

The new head of the for-next branch is commit:

3aa3a26e075c xfstests: add fuse support

New commits ([N]ew feature, [U]pdate):

Christian Brauner (1):
[U]      [81e6f6284499] generic: update setgid tests

Darrick J. Wong (8):
[U]      [bbfa08730c1e] xfs: fix dax inode flag test failures
[U]      [8f8ba51412a0] xfs: fix reflink test failures when dax is enabled
[U]      [11afd20ba354] xfs/182: fix spurious direct write failure
[U]      [28aadc29ed2f] xfs: skip fragmentation tests when alwayscow mode is enabled
[U]      [1cb825fdefd7] xfs/{080,329,434,436}: add missing check for fallocate support
[U]      [49da0ed40794] various: test is not appropriate for always_cow mode
[U]      [3ea9a3274403] populate: remove file creation loops that take forever
[U]      [39bb1e3d3b2c] populate: improve attr creation runtime

Dave Chinner (1):
[U]      [116804dc92d2] populate: ensure btree directories are created reliably

Miklos Szeredi (1):
[N]      [3aa3a26e075c] xfstests: add fuse support

Ojaswin Mujoo (1):
[U]      [c08fcc7fb71c] generic/692: generalize the test for non-4K Merkle tree block sizes


Code Diffstat:

 README.fuse           | 26 ++++++++++++++++
 check                 |  3 +-
 common/config         |  9 ++++--
 common/populate       | 86 +++++++++++++++++++++++++++------------------------
 common/rc             | 24 ++++++++++----
 common/xfs            |  9 ++++++
 src/Makefile          |  2 +-
 src/popattr.py        | 62 +++++++++++++++++++++++++++++++++++++
 src/popdir.pl         | 72 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/020     |  4 +--
 tests/generic/392     | 10 ++++++
 tests/generic/673     | 16 ++--------
 tests/generic/673.out | 16 ++--------
 tests/generic/683     | 16 ++--------
 tests/generic/683.out | 12 ++-----
 tests/generic/684     | 16 ++--------
 tests/generic/684.out | 12 ++-----
 tests/generic/685     | 16 ++--------
 tests/generic/685.out | 12 ++-----
 tests/generic/686     | 16 ++--------
 tests/generic/686.out | 12 ++-----
 tests/generic/687     | 16 ++--------
 tests/generic/687.out | 12 ++-----
 tests/generic/692     | 37 +++++++++++++++-------
 tests/xfs/080         |  1 +
 tests/xfs/128         |  2 +-
 tests/xfs/182         |  5 +--
 tests/xfs/182.out     |  1 -
 tests/xfs/184         |  1 +
 tests/xfs/192         |  2 ++
 tests/xfs/198         |  1 +
 tests/xfs/200         |  1 +
 tests/xfs/204         |  2 ++
 tests/xfs/211         |  1 +
 tests/xfs/232         |  1 +
 tests/xfs/326         | 12 +++++++
 tests/xfs/329         |  1 +
 tests/xfs/434         |  1 +
 tests/xfs/436         |  1 +
 tests/xfs/440         |  1 +
 tests/xfs/558         |  6 ++++
 41 files changed, 340 insertions(+), 216 deletions(-)
--
Zorro Lang
zlang@kernel.org
