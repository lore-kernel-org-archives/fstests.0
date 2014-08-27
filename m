Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:37486 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754451AbaH0Itm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 27 Aug 2014 04:49:42 -0400
Date: Wed, 27 Aug 2014 18:49:22 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before
 destroying the ioctx
Message-ID: <20140827084922.GB26465@dastard>
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
 <20140820225701.GG26465@dastard>
 <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
 <20140821165750.GA7116@lenny.home.zabbo.net>
 <20140825165043.GF20070@kvack.org>
 <x49oav76xu0.fsf@segfault.boston.devel.redhat.com>
 <20140826172740.GA18337@lenny.home.zabbo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140826172740.GA18337@lenny.home.zabbo.net>
Sender: fstests-owner@vger.kernel.org
To: Zach Brown <zab@zabbo.net>
Cc: Jeff Moyer <jmoyer@redhat.com>, Benjamin LaHaise <bcrl@kvack.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 26, 2014 at 10:27:40AM -0700, Zach Brown wrote:
> On Tue, Aug 26, 2014 at 12:05:11PM -0400, Jeff Moyer wrote:
> > Benjamin LaHaise <bcrl@kvack.org> writes:
> > 
> > > Does someone already have a simple test case we can add to the libaio test 
> > > suite to verify this behaviour?
> > 
> > I can't reproduce this problem using a loop device, which is what the
> > libaio test suite uses.  Even when using real hardware, you have to have
> > disks that are slow enough in order for this to trigger reliably (or
> > at all).
> 
> I wonder if you could use something like dm suspend to abuse indefinite
> latencies.
> 
> > I could write a more targeted test within xfstests, but I don't think
> > that's strictly necessary (it would just make it more clear what the
> > expectations are, and maybe bump the hit rate percentage up).
> 
> I think it'd be worth it (he says, not commiting *his* time).  It would
> have been nice if a targeted test helped Dave raise the alarm
> immediately rather than gnaw away at his brain with inconsistent mostly
> unrelated failures for months.

I'm not sure it's worth the effort. now we have two tests that have
triggered the same problem, I've been easily able to reproduce it
with 2 VMs with test/scratch image files sharing the same spindle.
i.e. run xfstests in one VM, run generic/323 in the other VM, and
it reproduces fairly easily.

I'm just running it in a loop now to measure how successfully I'm
reproducing the problem, then I'll apply the fix and see if it gets
better. If it does get better, then I'll keep the patch around
locally until it is upstream, and then I'll shout whenever I see
this problem occur again....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
