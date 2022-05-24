Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC1C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 13:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiEXNYg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 09:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiEXNYd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 09:24:33 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCABC1E3D9
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 06:24:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B2C0C534566;
        Tue, 24 May 2022 23:24:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntUWS-00FqLt-Pz; Tue, 24 May 2022 23:24:28 +1000
Date:   Tue, 24 May 2022 23:24:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
Message-ID: <20220524132428.GO2306852@dread.disaster.area>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
 <20220524122703.GL2306852@dread.disaster.area>
 <CAOQ4uxifd8gee1JLG1FN9fF3aSsVeSEuxFqjAf4D8ruCciXWYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxifd8gee1JLG1FN9fF3aSsVeSEuxFqjAf4D8ruCciXWYg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628cdc8f
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=22LgSLcDW-_urOX6tr8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 03:55:47PM +0300, Amir Goldstein wrote:
> > > > diff --git a/tests/xfs/310 b/tests/xfs/310
> > > > index 3214e04b..c635b39a 100755
> > > > --- a/tests/xfs/310
> > > > +++ b/tests/xfs/310
> > > > @@ -9,14 +9,12 @@
> > > >  . ./common/preamble
> > > >  _begin_fstest auto clone rmap
> > > >
> > > > -# Override the default cleanup function.
> > > > -_cleanup()
> > > > +_dmhuge_cleanup()
> > > >  {
> > > > -       cd /
> > > > -       umount $SCRATCH_MNT > /dev/null 2>&1
> > > >         _dmhugedisk_cleanup
> > > > -       rm -rf $tmp.*
> > > > +       _cleanup
> > > >  }
> > > > +_register_cleanup _dmhuge_cleanup
> > >
> > > Maybe it's just me, but if the intention is to maybe make this
> > > function global someday then the difference with the name
> > > _dmhugedisk_cleanup() is confusing.
> >
> > The names I used here are for classification, so I can grep over
> > the _register_cleanup line and easily determine all the tests use
> > loop devices, dmflakey, dmerror, etc and then consolidate them all
> > into a single cleanup function that works for them all. This is just
> > the first step in that process.
> >
> > > I'd rather keep the local function name local_cleanup
> > > in unclear cases like this one.
> >
> > And that defeats the entire purpose of giving them a descriptive
> > name at this point in time.
> 
> I understand. It makes a lot of sense to do that.
> It is still VERY confusing that there is a helper _dmhugedisk_cleanup
> that SHOULD NOT be used as a trap and a helper _dmhuge_cleanup
> that SHOULD be used as a trap, so a better convention is needed.

I think you missed my point.

_dmhuge_cleanup() is a *temporary name*.

It will *go away* once I've processed the other 1000 tests which
will also classify anything using dmhugedisk with a _dmhuge_cleanup
function. It's a temporary token I can use for further
classification and deduplication, nothing more, nothing less.

> I suggest that all consolidated helpers for trap will be called
> either _cleanup_* (like cleanup_dump) or _*_cleanup (like _fsstress_cleanup)
> 
> The problem is that there is no convetion in the common/* helpers.
> there are _dmhugedisk_cleanup() _dmerror_cleanup() and there are
> _cleanup_dump() _cleanup_delay().

Exactly the reason why I've used simple names and the only
consistency I care about is that I use the same name for the same
subsystem cleanup functions. I can't give them globally consistent
names at this point and because they are temporary tokens I simply
have not tried. I give it a name, copy the function into a register
buffer, and then paste it into any other test that uses the same
subsystem and has the same cleanup requirements.

Once I have all the tests that use dmhugedisk converted to use a
local _dmhuge_cleanup function, I'll derive the commonality from
them, move it into the existing cleanup function for that subsystem,
and register the subsystem cleanup in those tests. _dmhuge_cleanup()
then goes away forever.

Once everythign is deduplicated and common, changing names will be
simple and straight forward. That's when you can argue all you want
over the names of functions and I won't care one bit.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
