Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:56999 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932533AbaGVXE2 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Jul 2014 19:04:28 -0400
Date: Wed, 23 Jul 2014 09:04:24 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Problem building xfsprogs
Message-ID: <20140722230424.GS4453@dastard>
References: <20140722160641.GU17967@beardog.cce.hp.com>
 <20140722215151.GO25291@thunk.org>
 <20140722220449.GR4453@dastard>
 <20140722221950.GQ25291@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140722221950.GQ25291@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: scameron@beardog.cce.hp.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 22, 2014 at 06:19:51PM -0400, Theodore Ts'o wrote:
> On Wed, Jul 23, 2014 at 08:04:49AM +1000, Dave Chinner wrote:
> > On Tue, Jul 22, 2014 at 05:51:51PM -0400, Theodore Ts'o wrote:
> > > On Tue, Jul 22, 2014 at 11:06:41AM -0500, scameron@beardog.cce.hp.com wrote:
> > > > 
> > > > I'm trying to build xfsprogs (in order to run xfstests), and I'm running into this:
> > > 
> > > What distribution are you building on?  I had a frustrating enough
> > > time getting it to build on Ubuntu and Debian systems a while back
> > > (not xfstests' fault; sometimes the distro doesn't ship all of the
> > > header files or have recent enough libraries) that I created
> > > xfstests-bld which does a hermetic build of xfstests.  That way, it
> > > doesn't depend on anything getting shipped by the distribution.
> > 
> > That doesn't help us triage or fix up the problems people have, Ted.
> > xfstests needs to run on lots of different distros - even ones that
> > are years old - and so we need to understand and fix these problems,
> > not work around them.
> > 
> > Perhaps you could spend some time and send patches to document the
> > build/installation procedure that you use so we can improve the
> > process for everyone?
> 
> Xfstests depends on external libraries which might not be there, or
> might be out of date.

Yup, that's why we have:

	a) autoconf
	b) _requires_* rules
	c) output filters

So that xfstests works in as wide a range of environments as
possible. We've been doing this since xfstests was first created -
it even works on different OSes, not just different Linux distros...

> Or the xfsprogs might be out of date, or again,
> non-existent.  Do you really want to try to make xfststs work in such
> an environment?

I didn't say that.  I'm not sure how you made the leap from being
asked "can you document the build dependencies you needed to solve"
to "lets make xfstests run without any external dependencies". I'm
trying to get someone to document the build dependencies in the
INSTALL file, not trying to justify the existence of your xfstests
fork ;)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
