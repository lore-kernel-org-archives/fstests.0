Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD6C77B7A
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Jun 2023 01:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjFBBPr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Jun 2023 21:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjFBBPk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Jun 2023 21:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D511A5
        for <fstests@vger.kernel.org>; Thu,  1 Jun 2023 18:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC5164B48
        for <fstests@vger.kernel.org>; Fri,  2 Jun 2023 01:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709BAC433A0;
        Fri,  2 Jun 2023 01:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685668536;
        bh=Fc0MU700zR1e56x8mVzsvoRuyaCuaXsq2+mAyy6BbXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUPlUEp2Uj5Bh9ddZz1OWO988WWPPyWbkwd4Toy6ElryQ1x7nToidz4JeMZDpgQcD
         IVKOqxWpeqGjaZGJa1Q+hNmwrtlGNXcWxPzSpUVqhD/z/y7tD9HN1i574fN9R0Lrbt
         FSc0u3nPZ1/dOIooddwVq8UzjenPoUece69It4MCMO565piCj1RB2vBoPcBCKQqsUc
         nQfPN32lbiK9HdvQzBtsQZmt/f28MUaZRQVmpnZ4BXPQiNOb7B/EOSqPkMHFiy1zGT
         QtILdh+hc6zmCNQBTBSJ3tOo3zhkda/ypFB+/KLw6VA53yPi7K4FizMRkKcGIRZwQY
         wavZNWIT1KzpQ==
Date:   Thu, 1 Jun 2023 18:15:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Enable _test_mkfs to force a mkfs on a xfs
 filesystem
Message-ID: <20230602011535.GC16856@frogsfrogsfrogs>
References: <20230524134207.38224-1-cem@kernel.org>
 <20230524151650.GC11607@frogsfrogsfrogs>
 <20230525043605.hxivdzodlh7vvpow@zlang-mailbox>
 <20230525191312.GE11607@frogsfrogsfrogs>
 <BMAB3h6IL8VKaU10gncYx4R6Qf91YQY_Mocd2xrurFWPhuLRtK7fwvd8H9xoeCA_GhaOLUaoSPETJRd1hGHgfw==@protonmail.internalid>
 <20230526195234.soug6nwxho5rkinq@zlang-mailbox>
 <20230529075839.myw65y56r46j6sun@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529075839.myw65y56r46j6sun@andromeda>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 29, 2023 at 09:58:39AM +0200, Carlos Maiolino wrote:
> On Sat, May 27, 2023 at 03:52:34AM +0800, Zorro Lang wrote:
> > On Thu, May 25, 2023 at 12:13:12PM -0700, Darrick J. Wong wrote:
> > > On Thu, May 25, 2023 at 12:36:05PM +0800, Zorro Lang wrote:
> > > > On Wed, May 24, 2023 at 08:16:50AM -0700, Darrick J. Wong wrote:
> > > > > On Wed, May 24, 2023 at 03:42:07PM +0200, cem@kernel.org wrote:
> > > > > > From: Carlos Maiolino <cmaiolino@redhat.com>
> > > > > >
> > > > > > Calling _test_mkfs on an already initialized xfs FS will fail as the
> > > > > > initialization is not enforced by '-f' argument, unless it's included in
> > > > > > MKFS_OPTIONS.
> > > > > > So, adding 'RECREATE_TEST_DEV=true' to the config file end up being useless
> > > > > > for xfs filesystems.
> > > > > >
> > > > > > So, adding the a specific xfs optiong in _test_mkfs using -f argument
> > > > > > makes RECREATE_TEST_DEV actually useful.
> > > > > >
> > > > > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > > >
> > > > > Makese sense to me,
> > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > Hi Darrick,
> > > >
> > > > I just noticed that there's not any place use "_test_options mkfs", I remembered
> > > > SCRATCH_DEV support rtdev and logdev, the TEST_DEV looks not support that, but
> > > > the "_test_options()" looks like hoping to support.
> > >
> > > Hmmm, that's a very good point -- _test_mkfs() fails to format a test
> > > filesystem with external logs or rt volumes even if the config specified
> > > that.  Perhaps change the patch to add:
> > >
> > >     xfs)
> > >         _test_options mkfs
> > 
> > Current _test_options() only works for xfs, it returns directly if FSTYP != XFS.
> > It more likes a _test_xfs_options. We don't have _test_$FSTYP_options() function,
> > so if we'd like to have a common _test_options(), I think we should deal with
> > fs specific things in _test_options() inside, then call _test_options once before
> > the "case $FSTYP in ...".
> 
> This seems fine, I'm short on time these days, I'll try to find some time to
> work on this.
> 
> But in meantime, wouldn't it required the '-f' option to be passed to mkfs.xfs
> anyway? Calling _test_options before 'case $FSTYP ...' will still require use to
> call mkfs.xfs -f, so, can't the initial patch be applied already? If Darrick's
> updated solution isn't good enough for now, the original patch will fix at
> least part of the problem (without external log/rtdev cases) right away.

Yes, let's please get at least the bare fix merged.

--D

> -- 
> Carlos
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >         $MKFS_XFS_PROG -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
> > >         ;;
> > >
> > > Does that look right?
> > >
> > > --D
> > >
> > > > Thanks,
> > > > Zorro
> > > >
> > > > >
> > > > > --D
> > > > >
> > > > > > ---
> > > > > >  common/rc | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > > > diff --git a/common/rc b/common/rc
> > > > > > index 37074371..dd5d7bc1 100644
> > > > > > --- a/common/rc
> > > > > > +++ b/common/rc
> > > > > > @@ -605,6 +605,9 @@ _test_mkfs()
> > > > > >      ext2|ext3|ext4)
> > > > > >  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
> > > > > >  	;;
> > > > > > +    xfs)
> > > > > > +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
> > > > > > +	;;
> > > > > >      *)
> > > > > >  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
> > > > > >  	;;
> > > > > > --
> > > > > > 2.30.2
> > > > > >
> > > > >
> > > >
> > >
> > 
