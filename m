Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:5264 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752810AbcBKDHy (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 22:07:54 -0500
Date: Thu, 11 Feb 2016 14:07:51 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 05/12] xfstests: do not unmount tmpfs during remount
Message-ID: <20160211030751.GE19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-6-git-send-email-tytso@mit.edu>
 <20160210060716.GV19486@dastard>
 <20160210160732.GE26922@thunk.org>
 <20160210230700.GA19486@dastard>
 <20160210232826.GK26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210232826.GK26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 06:28:26PM -0500, Theodore Ts'o wrote:
> On Thu, Feb 11, 2016 at 10:07:00AM +1100, Dave Chinner wrote:
> > No, it's not really the options that are the problem here. The
> > problem is -o remount vs unmount/mount and what the test is actually
> > expecting.
> > 
> > I'd say "_scratch_remount" should do "-o remount" unconditionally
> > (least surprise) and the current _scratch_remount should be changed
> > to something like _scratch_cycle_mount(). That way both can take
> > options, but it's clear they do different things. tmpfs can simply
> > implement them the same way.
> 
> Well, I can do that, but it's going to be a huge patch --- the vast
> majority of the calls to _scratch_remount in the tree (over 100) would
> have to be changed to _scratch_cycle_mount, because they are just
> doing a _scratch_umount / _scratch_mount without taking any arguments
> to change the mount option.

Yup, but we do this sort of tree-wide cleanup fairly often if it
makes sense. In this case, it's just an initial patch taht
does sed -i -e 's/_scratch_remount/_scratch_cycle_mount/' ....

And, let's put things in context: changing 108 lines of code is a
pretty damn small patch in the greater scheme of things. Indeed,
it's smaller than most patches that add a new regression test.

A "huge" patch is something like the series Darrick posted earlier
in the week - something like 20 patches, including somewhere in the
order of 30 new tests, a couple of new binary test programs, a heap
of cleanups across all 80-90 existing reflink/dedupe tests, and a
bunch of bug fixes to go with them.

IOWs, s/_scratch_remount/_scratch_cycle_mount/ is the sort of
no-brainer change that takes less time to write, test and review
than it did for me to write this email....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
