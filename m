Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:6664 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753468AbaHUJRE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Aug 2014 05:17:04 -0400
Date: Thu, 21 Aug 2014 19:16:29 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before
 destroying the ioctx
Message-ID: <20140821091629.GZ20518@dastard>
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
 <20140820225701.GG26465@dastard>
 <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 20, 2014 at 07:43:19PM -0400, Jeff Moyer wrote:
> Hi, Dave,
> 
> Dave Chinner <david@fromorbit.com> writes:
> 
> > IOWs, we now have two AIO+DIO tests showing the same symptoms that
> > no other tests show. This tends to point at AIO not being fully
> > cleaned up and completely freed by the time the processes
> > dispatching it have exit()d. This failure generally occurs when
> > there is other load on the system/disks backing the test VM (e.g.
> > running xfstests in multiple VMs at the same time) so I suspect it
> > has to do with IO completion taking a long time.
> 
> Process exit waits for all outstanding I/O, but maybe it's an rcu thing.

Hmmm - __fput()?

> > Can you spend some time trying to reproduce this and getting to the
> > bottom of whatever is triggering the unmount error?
> 
> I can take a look, but not until next week.  Hopefully that's ok?

Yeah, that's fine. I don't have the bandwidth to look at it either
right now, so I'll just expunge the test for the meantime.

Thanks, Jeff!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
