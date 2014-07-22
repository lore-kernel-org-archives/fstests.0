Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:50933 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182AbaGVWWI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Jul 2014 18:22:08 -0400
Date: Tue, 22 Jul 2014 18:19:51 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Problem building xfsprogs
Message-ID: <20140722221950.GQ25291@thunk.org>
References: <20140722160641.GU17967@beardog.cce.hp.com>
 <20140722215151.GO25291@thunk.org>
 <20140722220449.GR4453@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140722220449.GR4453@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: scameron@beardog.cce.hp.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 23, 2014 at 08:04:49AM +1000, Dave Chinner wrote:
> On Tue, Jul 22, 2014 at 05:51:51PM -0400, Theodore Ts'o wrote:
> > On Tue, Jul 22, 2014 at 11:06:41AM -0500, scameron@beardog.cce.hp.com wrote:
> > > 
> > > I'm trying to build xfsprogs (in order to run xfstests), and I'm running into this:
> > 
> > What distribution are you building on?  I had a frustrating enough
> > time getting it to build on Ubuntu and Debian systems a while back
> > (not xfstests' fault; sometimes the distro doesn't ship all of the
> > header files or have recent enough libraries) that I created
> > xfstests-bld which does a hermetic build of xfstests.  That way, it
> > doesn't depend on anything getting shipped by the distribution.
> 
> That doesn't help us triage or fix up the problems people have, Ted.
> xfstests needs to run on lots of different distros - even ones that
> are years old - and so we need to understand and fix these problems,
> not work around them.
> 
> Perhaps you could spend some time and send patches to document the
> build/installation procedure that you use so we can improve the
> process for everyone?

Xfstests depends on external libraries which might not be there, or
might be out of date.  Or the xfsprogs might be out of date, or again,
non-existent.  Do you really want to try to make xfststs work in such
an environment?

The only solution would be to either try to radically restrict which
tests run if various bits of infrastructure which xfstests depends on
aren't there (which means you don't get as much testing done, which is
certainly non-ideal), or you need to be willing to (optionally) build
various libaries and other support programs as part of the xfstests
build.

I didn't bother sending patches that would do any of this, because I
assumed they would have been rejected with extreme prejudice.  Was I
wrong?

Are you really interested in making xfstests not depend on *anything*
(not xfsprogs, not the aio, acl, xattr, or quota library, etc., etc)
being available in its build-time and run-time environment?  Because
that's the problem I needed to solve.

Cheers,

						- Ted
