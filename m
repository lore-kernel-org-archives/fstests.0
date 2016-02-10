Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:9202 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107AbcBJXJe (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 18:09:34 -0500
Date: Thu, 11 Feb 2016 10:07:00 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 05/12] xfstests: do not unmount tmpfs during remount
Message-ID: <20160210230700.GA19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-6-git-send-email-tytso@mit.edu>
 <20160210060716.GV19486@dastard>
 <20160210160732.GE26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210160732.GE26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 11:07:32AM -0500, Theodore Ts'o wrote:
> On Wed, Feb 10, 2016 at 05:07:16PM +1100, Dave Chinner wrote:
> > >  # Remounting with nodiratime option
> > > -_scratch_unmount
> > > -_scratch_mount "-o nodiratime"
> > > +_scratch_remount "-o nodiratime"
> > 
> > This makes me go "no, that can't work, nodiratime is not an option
> > that we allow on remount."
> 
> Hmm, yes, we're not consistent here.  xfs doesn't allow nodiratime on
> remounts.  ext4 allows nodiratime on remount, but not diratime, so
> there's no way to clear nodiratime once its set.  tmpfs allows
> diratime and nodiratime on remount.
> 
> I wonder if it's worth it make things more consistent across the
> various file systems.  What do you think?

Different problem, care factor approaching zero right now. :/

Talk to Eric - he's futzing with this stuff on XFS right now.

> > So, at minimum, the name of the helper needs to get changed so that
> > it doesn't imply that a "-o remount" with new options is being
> > done...
> 
> Hmm, how about having two helper functions: _scratch_remount that
> doesn't take any arguments, and a _scratch_change_mount_opts which
> does?

No, it's not really the options that are the problem here. The
problem is -o remount vs unmount/mount and what the test is actually
expecting.

I'd say "_scratch_remount" should do "-o remount" unconditionally
(least surprise) and the current _scratch_remount should be changed
to something like _scratch_cycle_mount(). That way both can take
options, but it's clear they do different things. tmpfs can simply
implement them the same way.

> > > -_umount_mount
> > > +_scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
> > > +_scratch_mount > /dev/null 2>&1 || _fail "mount failed"
> > 
> > Please don't add _fail to mkfs/mount like this, especially where the
> > test doesn't already have them.
> 
> Could you say more about why?  We do have tests that do use _fail if
> the mkfs or mount fails.  Should we be changing them to remove it?

Because, in general, scratch_mkfs should not ever fail, and nor
should a mounting the scratch device. If they do fail, something has
already gone wrong...

> But if we do that, and the mount fails for some reason, then won't
> things stagger on and perhaps make life harder to debug.

Yes, but we don't care that they make lots of noise or that they
stagger on, because that staggering on can exercise failure and
other unexpected paths that wouldn't otherwise get exercised. I've
lost count of the number of times that I've had a stuck process
prevent an unmount and a subsequent test has tripped over and
uncovered a previously unknown bug because we allowed mkfs and mount
to fail....

As for debugging - you always have to go back to the first failure
you see in xfstests and work from there, so the subsequent noise of
other tests failing can simply be ignored. Yes, it can make it a
little harder to identify the first failure, but it only takes a few
seconds looking at log files to identify that these functions have
failed...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
