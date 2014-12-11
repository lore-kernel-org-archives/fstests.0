Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:49523 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964971AbaLKXdm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Dec 2014 18:33:42 -0500
Date: Fri, 12 Dec 2014 10:30:59 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: suppress "Broken pipe" errors
Message-ID: <20141211233059.GG24183@dastard>
References: <1418264718-31198-1-git-send-email-tytso@mit.edu>
 <20141211041323.GF24183@dastard>
 <20141211122408.GA31008@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141211122408.GA31008@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 11, 2014 at 07:24:08AM -0500, Theodore Ts'o wrote:
> On Thu, Dec 11, 2014 at 03:13:23PM +1100, Dave Chinner wrote:
> > On Wed, Dec 10, 2014 at 09:25:18PM -0500, Theodore Ts'o wrote:
> > > It's possible based on a race conditions (and possibly the version of
> > > coreutils which supplies /usr/bin/yes) that commands of the form:
> > > 
> > > yes | $MKFS_PROG ...
> > > 
> > > will end up causing the following failure:
> > 
> > What race conditions?
> 
> It looks like under some circumstances, mkfs reads from stdin and then
> exits quickly; in the mean time, since the pipe has read from, yes
> then tries to send more "y\n" to stdout, and then it gets an EPIPE
> error and complains.
>
> > But thats indicative that something failed and you need to analyse
> > the reason, yes? So AFAICT this is deisred behaviour, and hiding the
> > error will actually hide other failures, right?
> 
> No, I don't think anything fails; it's perfectly OK that mkfs can read
> from stdin and then exit very quickly.  It seems to happen primarily
> when we're running a test where mkfs can exit quickly enough to hit
> this race.


Ok, seems like a pretty strange corner case and more like a
bug in yes than anything....

> > I'd highly recommend you add ext4 specific mkfs branches so you can
> > use the non-interactive/force mkfs flags so that "yes |" is not
> > necessary for your (and everyone elses ext4) test environments.
> 
> Sure, I'd be happy to add a ext2/3/4 specific mkfs branch.

Great!

> Does any
> other file system's mkfs try to do interactive I/O?  If so, then they
> could hit this too, so I think the "yes 2> /dev/null | ..."
> formulation is still a good thing to do.  If not, maybe we should be
> removing the "yes | ..." construct entirely, since it's pretty ugly
> IMHO.

I don't know what other mkfs programs do. I agree that it's an ugly
construct, but it seems to work for all the other non-specific mkfs
programs around. If you create extN specific mkfs branches, then I'd
just leave the default alone so we don't inadvertantly break some
other filesystem that needs it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
