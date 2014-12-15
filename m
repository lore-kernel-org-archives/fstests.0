Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:5996 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777AbaLOXST (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 18:18:19 -0500
Date: Tue, 16 Dec 2014 10:18:12 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Reiser4 initial implementation
Message-ID: <20141215231812.GB2152@dastard>
References: <alpine.LNX.2.00.1412152315300.21847@reiser4.gekom>
 <20141215210631.GT24183@dastard>
 <548F5505.4050807@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548F5505.4050807@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Dushan Tcholich <dusanc@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 15, 2014 at 03:39:17PM -0600, Eric Sandeen wrote:
> On 12/15/14 3:06 PM, Dave Chinner wrote:
> > On Mon, Dec 15, 2014 at 11:19:43PM +0100, Dushan Tcholich wrote:
> >>
> >> This is initial xfstests implementation for Reiser4 filesystem.
> >>
> > 
> > Policy question to the wider audience: should we support out of tree
> > filesystems in fstests? I can't verify the patches nor maintain
> > support for such filesystems, nor is there a wide developer or
> > distro demand for testing such filesystems. If there's only one or
> > two developers that need support for reiser4, then it might be best
> > for to maintain the xfstests patches out of tree, too.
> > 
> > What does everyone think?
> 
> I think you have your hands completely full with in-tree filesystems,
> and opening the door to many new tests for out-of-tree filesystems could
> lead to Too Much Work.
> 
> But simply adding the simple things in this patch to make generic tests
> work seems fairly harmless; it should be a one-shot deal, with no ongoing load.
> So from where I sit I don't see a big problem with a patch like this.

That seems fair enough, though I do wonder if we should try to
structure the common code to make it easier to add/maintain support
like this.

> Adding a lot of reiser4 specific tests is probably a different question,
> though.

Yup, and that's my main concern.

> In theory it shouldn't be hard for out-of-tree filesystems to maintain
> their own tree of tests which could just drop in under tests/ right?

Yes, the high level scripts source fs specific tests from
tests/$FSTYP, so such test directories would be easy to maintain as
out of tree patches.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
