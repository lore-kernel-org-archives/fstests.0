Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:8922 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755133AbaHYXMT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 Aug 2014 19:12:19 -0400
Date: Tue, 26 Aug 2014 09:12:15 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before
 destroying the ioctx
Message-ID: <20140825231215.GA26465@dastard>
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
 <20140820225701.GG26465@dastard>
 <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
 <20140821165750.GA7116@lenny.home.zabbo.net>
 <20140825165043.GF20070@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140825165043.GF20070@kvack.org>
Sender: fstests-owner@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Zach Brown <zab@zabbo.net>, Jeff Moyer <jmoyer@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 25, 2014 at 12:50:43PM -0400, Benjamin LaHaise wrote:
> On Thu, Aug 21, 2014 at 09:57:50AM -0700, Zach Brown wrote:
> > On Wed, Aug 20, 2014 at 07:43:19PM -0400, Jeff Moyer wrote:
> > > Hi, Dave,
> > > 
> > > Dave Chinner <david@fromorbit.com> writes:
> > > 
> > > > IOWs, we now have two AIO+DIO tests showing the same symptoms that
> > > > no other tests show. This tends to point at AIO not being fully
> > > > cleaned up and completely freed by the time the processes
> > > > dispatching it have exit()d. This failure generally occurs when
> > > > there is other load on the system/disks backing the test VM (e.g.
> > > > running xfstests in multiple VMs at the same time) so I suspect it
> > > > has to do with IO completion taking a long time.
> > > 
> > > Process exit waits for all outstanding I/O, but maybe it's an rcu thing.
> > 
> > I thought it did too but it doesn't look like upstream exit_aio() is
> > waiting for iocbs to complete.
> > 
> > Ben, are you digging in to this?  Want me to throw something together?
> 
> Something like the following should fix it.  This is only lightly tested.  
> Does someone already have a simple test case we can add to the libaio test 
> suite to verify this behaviour?  I'm assuming that waiting for one ioctx 
> at a time is sufficient and we don't need to parallelise cancellation at 
> exit.

both xfstests::generic/208 and xfstests::generic/323 reproduce this.
I'm seeing a long term failure rate (i.e. over the past year) of
around 15% for generic/208 on my test VMs....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
