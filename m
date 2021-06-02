Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39315C47080
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Jun 2021 01:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1700F613C1
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Jun 2021 01:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFBBGC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhFBBGC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Jun 2021 21:06:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2054461003;
        Wed,  2 Jun 2021 01:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622595860;
        bh=GRzYmYqPKwUsDcUHvPr0vnsHbxU8SYb59cnmx8yELmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyFaQLT/jynq5/TwGNpaowice5220zWuoKLjvGMAgQgg6/qirehEtYI8BQCyTAKpA
         0QO/4cAbXYeveW47Z1Mtx8HwzUFnKIIARHJASkDxKSflhs4c0P65Pn4yMmK85dbKt6
         k/ipaXaGW+t8Z03LTZVyq2T9YgfRR5HFr25lElox7nwZP+IIL8F/5sFSyYdHznze7B
         S4e6vO6OqAjpyXVN1G5Keh1XtjlXpxK7Qi5Zb5jNC21YcTqRX9GVnpFCeCjZEjkAsB
         LFuWnI3d2r0pYWBCV+THVMmASElgerMYef+ZPJkhWm7tzodvfqJ8CY+XJOR3V80wFZ
         e1Qo6aUSi9MkQ==
Date:   Tue, 1 Jun 2021 18:04:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: master branch updated to 37881397f1aa
Message-ID: <20210602010419.GB26353@locust>
References: <60b39a03.1c69fb81.19580.375a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b39a03.1c69fb81.19580.375a@mx.google.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 30, 2021 at 09:58:21PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. Notably, initial bcachefs support has been added in
> this update, though bcachefs itself is not upstreamed yet, this will help
> bcachefs being tested widely, and help bcachefs being merged in upstream.
> 
> There're also new tests and fixes as usual, and the new btrfs/240 currently
> fails with latest v5.13-rc3 kernel.
> 
> The group file re-work patchset from Darrick J. Wong is still in review, and
> may need more eyes and testings.

Indeed -- I'm quite interested in what people think about the idea of
automatic groupfile generation, which should make it easier for
developers to rebase on the weekly fstests push.

At this point I now have <cough> enough cloud access to run the major
disk filesystems (xfs/btrfs/ext4/overlayfs-atop-xfs) every night for a
month.  All the regressions I found were used to improve the conversion
tool.

--D

> 
> Thanks,
> Eryu
> 
> The new head of the master branch is commit:
> 
> 37881397f1aa ext4: prevent initializing reserved inodes
> 
> New commits:
> 
> Filipe Manana (1):
>       [2605c135e15c] btrfs: add test for multiple fsync with adjacent preallocated extents
> 
> Kent Overstreet (2):
>       [5b44709187ce] fstests: improved .gitignore
>       [986733634c61] fstests: initial bcachefs support
> 
> Sun Ke (2):
>       [9bc323f334b6] xfs: fix check of whether the mkfs fail
>       [05fafbff9950] generic/042: set size to 38M for f2fs
> 
> Yang Xu (1):
>       [ee7383c5f54c] common/xfs: Fix _require_scratch_xfs_shrink bug
> 
> chenlong (1):
>       [37881397f1aa] ext4: prevent initializing reserved inodes
> 
> 
> Code Diffstat:
> 
>  .gitignore          |   3 +
>  common/attr         |   6 ++
>  common/config       |   3 +
>  common/quota        |   4 +-
>  common/rc           |  11 ++++
>  common/xfs          |   3 +-
>  tests/btrfs/240     | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/240.out |  29 +++++++++
>  tests/btrfs/group   |   1 +
>  tests/ext4/049      |  67 ++++++++++++++++++++
>  tests/ext4/049.out  |   7 +++
>  tests/ext4/group    |   1 +
>  tests/generic/042   |   8 ++-
>  tests/generic/425   |   3 +
>  tests/generic/441   |   2 +-
>  tests/xfs/070       |   3 +-
>  tests/xfs/448       |   3 +-
>  17 files changed, 320 insertions(+), 7 deletions(-)
> --
> Eryu Guan
> guaneryu@gmail.com


