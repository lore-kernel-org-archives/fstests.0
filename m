Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2CCC2B9F7
	for <linux-fstests@archiver.kernel.org>; Wed, 26 May 2021 03:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EC96141C
	for <linux-fstests@archiver.kernel.org>; Wed, 26 May 2021 03:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhEZDnL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 23:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhEZDnK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 23:43:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 326B0610CB;
        Wed, 26 May 2021 03:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622000500;
        bh=43j1DN1A5XWowYwnc6gihSRSAHAAG49n+0OmY+CEcM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnF5nv7nRAIrubxNypqs5DW4AkGKs366w1DHc+tbHhUSxbubwKSz0ul/yMKig7ZOr
         zu7HH65aqrmKjEsj9LgF78mSrx2MuM7kVJolqNTRLeJjozBQgdTZfR2PXIq+CMeVR1
         VFT8Csyk91OVHbqTAYgT9FCxP9WwiJlPtmuaSn2OtGJn+edudmc3XadZkeIJJFBTX5
         vh56BUQkim5J+XMdBIwY1K31zbqYXEYk51DCalk2qQy0Xs4yaMSiVHWYS7iQeNoKfC
         tIGT8BQqgXQt8F3yMYepI7YM4vBuBAwoPLIpw1ovo8Hei0B8t7qP+Gq2N94J8pf71f
         K7llIJCrAlQEQ==
Date:   Tue, 25 May 2021 20:41:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     Jakob Unterwurzacher <jakobunt@gmail.com>,
        Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/286: fix integer underflow on block sizes != 4096
Message-ID: <20210526034139.GL202095@locust>
References: <20210522184814.95802-1-jakobunt@gmail.com>
 <YKoa7dtkdmu8hp+/@desktop>
 <CAPv9ZmkirKWThgE7q2oHFFMtk0bQ7A9xG8i+RGqgyLnCkCJJZg@mail.gmail.com>
 <20210526032037.GF60846@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526032037.GF60846@e18g06458.et15sqa>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 26, 2021 at 11:20:37AM +0800, Eryu Guan wrote:
> On Tue, May 25, 2021 at 07:34:14PM +0200, Jakob Unterwurzacher wrote:
> > On Sun, May 23, 2021 at 11:05 AM Eryu Guan <guan@eryu.me> wrote:
> > > The total read length should be
> > >
> > > "The length of this extent is (hole_off - data_off)"
> > >
> > > according to the comments above do_extent_copy(). Total read length
> > > being not a multiple of 4k means 'data_off' or 'hole_off' is not 4k
> > > aligned.
> > 
> > That is correct.
> > 
> > > But generic/286 creates source files with length of all data extents and
> > > hole extents being multiple of 4k. So I still don't understand why this
> > > is valid for gocryptfs. Shouldn't that be a bug in seek_data/seek_hole
> > > in gocryptfs? Could you please elaborate?
> > 
> > Yes sure, the situation is a bit complicated. gocryptfs works similar
> > to eCryptFS and EncFS (also overlay filesystems).
> > The files are stored in encrypted form in regular files on ext4 or xfs
> > or whatever "real disk" filesystem.
> > Disk space allocation & file holes are handled by the real filesystem.
> > A gocryptfs mount shows a decrypted view of these files.
> > 
> > Now, gocryptfs uses AES-GCM for encryption. This adds 32 bytes of
> > overhead to every 4096-byte block,
> > which gives a storage size of 4128 bytes.
> 
> Ah, that makes sense to me now. Would you please include the detailed
> explaination in commit log as well?

...and maybe a sample output of a seek_data/seek_hole scan between a
gocryptfs file and the ext4fs underneath it?  I'm still trying to wrap
my head around what the problem here is.

It might also help to describe where the 32 bytes of overhead goes --
are you interleaving the overhead inline with 4k of encrypted content?

--D

> 
> Thanks,
> Eryu
> 
> > 
> > The encryption overhead is why the files & holes created by
> > generic/286 are not 4k-aligned on disk when viewed through the
> > gocryptfs mount.
> > 
> > Thanks, Jakob
