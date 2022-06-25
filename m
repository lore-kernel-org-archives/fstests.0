Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5561C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 03:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiFYDPd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFYDPc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 23:15:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85A549B52
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 20:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 664E8B82C0C
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 03:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D87EC34114;
        Sat, 25 Jun 2022 03:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656126928;
        bh=P1P8SvQIVhIZLyp9wjfBs8y0QeNEk20FMROuA62sexk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EG1mVtWnVesoOJMh62EcJwBzMG+YOPF2NT2FzQolxSYO8rZUIGtWgWWeutqQI5Hv1
         xZScuU/MZJ5dHoSqPFtviBNOPWSe58dQwLOXaUdHZP1ZhYM3HFiz3DrEzftY0VAkrV
         U6s6/PJTXLP85NZo/4yE8AbvMqzfhDY3BmDw4o+zp5fr03L5M9iE5voRHRTdWoI5jo
         Z7xfqGDlQ5ZKaUibAidVKmyHJYgL26C8U3o65peDctnInKGUMSSI9gJtxuztdFK6n/
         BDiaScSFv/7R02q7Fd0U8SzAcJ/P7f0MFo0+Wh07rmFeFT1wefOAJGawJIsjihN6fx
         JUIjIMr79GsSQ==
Date:   Fri, 24 Jun 2022 20:15:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Long An <lan@suse.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/config: Fix use of MKFS_OPTIONS
Message-ID: <YrZ9z/vok66YwMYn@magnolia>
References: <20220623160825.31788-1-lan@suse.com>
 <YrSuSKLKA6LMjyf/@magnolia>
 <20220624024141.GI1098723@dread.disaster.area>
 <d7d49af51014829438bab8c30da3f8c2e5fedd1d.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d49af51014829438bab8c30da3f8c2e5fedd1d.camel@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 03:29:43AM +0000, Long An wrote:
> On Fri, 2022-06-24 at 12:41 +1000, Dave Chinner wrote:
> > On Thu, Jun 23, 2022 at 11:17:44AM -0700, Darrick J. Wong wrote:
> > > On Fri, Jun 24, 2022 at 12:08:25AM +0800, An Long wrote:
> > > > _scratch_mkfs_sized() only receive integer number of bytes as a
> > > > valid
> > > > input. But if the MKFS_OPTIONS variable exists, it will use the
> > > > value of
> > > > block size in MKFS_OPTIONS to override input. In case of
> > > > MKFS_OPTIONS="-b 4k", would result in blocksize=4 but not 4096.
> > > > This
> > > > will give errors to ext2/3/4 etc, and brings potential bugs to
> > > > xfs or
> > > > btrfs.
> > > > 
> > > > Therefore, add validation check to force MKFS_OPTIONS to use pure
> > > > integer in bytes for any size value.
> > > > 
> > > > Signed-off-by: An Long <lan@suse.com>
> > > > ---
> > > >  README        | 3 ++-
> > > >  common/config | 5 +++++
> > > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/README b/README
> > > > index 80d148be..7c2d3334 100644
> > > > --- a/README
> > > > +++ b/README
> > > > @@ -241,7 +241,8 @@ Misc:
> > > >     this option is supported for all filesystems currently only
> > > > -overlay is
> > > >     expected to run without issues. For other filesystems
> > > > additional patches
> > > >     and fixes to the test suite might be needed.
> > > > -
> > > > + - If MKFS_OPTIONS is used, the size value must be an integer
> > > > number of bytes
> > > > +   without units. For example, set MKFS_OPTIONS="-b 4096" but
> > > > not "-b 4k".
> > > 
> > > IDGI.  mkfs.$FSTYP does its own input validation, which means that
> > > fstest
> > > runners are required to set MKFS_OPTIONS to something that mkfs
> > > will
> > > accept.  It's not the job of fstests to add /another/ layer of
> > > validation...
> > 
> > It's not validating it - it refelecting the fact that fstests parses
> > the block device size out of MKFS_OPTIONS and does integer math on
> > it and does not handle human readable units....
> > 
> > > >  USING THE FSQA SUITE
> > > >  ______________________
> > > > diff --git a/common/config b/common/config
> > > > index de3aba15..ec723ac4 100644
> > > > --- a/common/config
> > > > +++ b/common/config
> > > > @@ -896,5 +896,10 @@ else
> > > >  	fi
> > > >  fi
> > > >  
> > > > +# check the size value in $MKFS_OPTIONS is an integer
> > > > +if [[ $MKFS_OPTIONS =~ [0-9]+[^0-9\ ] ]] ; then
> > > 
> > > ...because this regex will break /any/ MKFS_OPTIONS with a number
> > > followed by a letter.  mkfs.xfs handles units just fine, so I don't
> > > understand why you're adding this blunt instrument.
> > > 
> > > MKFS_OPTIONS='-b size=1k' works just fine for XFS.
> > 
> > Except it where it doesn't.
> > 
> > For example, _scratch_mkfs_sized does unexpected stuff
> > because it assumes filesystem block sizes are all in bytes when it
> > tries to parse the custom test block sizes out of MKFS_OPTIONS to
> > set the default block size.
> > 
> > https://lore.kernel.org/fstests/20220616043845.14320-1-lan@suse.com/
> > 
> > In this case, using "1k" in the XFS mkfs specifications results in
> > the default block size is incorrectly calculated:
> > 
> > $ echo "-bsize=1024" | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'
> > 1024
> > $ echo "-bsize=1k" | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'
> > 1
> > $
> > 
> > So it sets the block size to 1, not 1024.
> > 
> > But then this bug is covered up later on by this code:
> > 
> >                 # don't override MKFS_OPTIONS that set a block size.
> >                 echo $MKFS_OPTIONS |egrep -q "b?size="
> >                 if [ $? -eq 0 ]; then
> >                         _scratch_mkfs_xfs -d size=$fssize $rt_ops
> >                 else
> >                         _scratch_mkfs_xfs -d size=$fssize $rt_ops -b
> > size=$blocksize
> >                 fi
> > 
> > Which omits the poorly calculated block size because there's
> > already a block size specified in the MKFS_OPTIONS so it ignores the
> > fact it calculated the block size incorrectly from MKFS_OPTIONS.
> > 
> > But it also means that if the test specifies a block size via
> > 
> > _scratch_mkfs_sized $((256 * 1024 * 1024)) 2048
> > 
> > Then _scratch_mkfs_sized does the wrong thing for XFS if there is
> > a MKFS_OPTIONS specified block size.....
> > 
> > Other filesystems, like ext4, don't have this magic "don't override
> > MKFS_OPTIONS" code that XFS does here, so they are exposed to the
> > block size calculation bugs when human readable units are used. But
> > then they don't have the "ignore test specified block size" bug and
> > <head explodes>
> > 
> > The whole thing is a mess of bugs and technical debt. Randomly
> > adding more complex regexes and string parsing to random bits of
> > fstests to support doing integer math on human readable units in
> > random variables doesn't improve this situation at all.

Ah, ok.  I hadn't realized there was /more/ history to this patch than
just some random change that looked weird on its own.

> > Hence my suggestion that we set a requirement that all block size
> > specifications in MKFS_OPTIONS are in byte units, and we check and
> > enforce that once at startup. With that requirement in place, we can
> > clean up all this mess knowing that we only have to support integer
> > units...
> > 
> > What I expected to see was a function like:
> > 
> > _check_mkfs_block_options()
> > {
> > 	case $FSTYP:
> > 	xfs)
> > 		# check for -b?size= option in integer format
> > 		# exit if not valid
> > 	ext4)
> > 		# check for -b <num> option in integer format
> > 		# exit if not valid
> > 	.....
> > }
> > 
> Hello Dave,
> 
> Actually, I have tried the above methods. It's works, but we have to
> add specific function for specific type of size?
> Such as node size, sector size, device size or cluster size.

Personally I thought the v2 approach of fixing _scratch_mkfs_sized was
better, since it's a much smaller change than making fstests reject all
unit-having numbers and then everyone has to update their fstests
wrappers.  I know we like to pretend that nobody wraps fstests, but
everyone wraps fstests in even more bash goo.

Also I didn't like the fact that (I think) this patch would reject
something like MKFS_OPTIONS='-m dirhandling=3bsd' or something like
that.

Anyway, I'll go focus on other things.

--D

> Thanks,
> An Long
> 
> > called from get_next_config() similar to how we call _check_device
> > on every block device for existence after reading them from the
> > config file.
> > 
> > Cheers,
> > 
> > Dave.
