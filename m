Return-Path: <fstests-owner@vger.kernel.org>
Received: from tetsuo.zabbo.net ([50.193.208.193]:60417 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbaHUQ5u (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Aug 2014 12:57:50 -0400
Date: Thu, 21 Aug 2014 09:57:50 -0700
From: Zach Brown <zab@zabbo.net>
Subject: Re: [patch, v3] add an aio test which closes the fd before
 destroying the ioctx
Message-ID: <20140821165750.GA7116@lenny.home.zabbo.net>
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
 <20140820225701.GG26465@dastard>
 <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>
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

I thought it did too but it doesn't look like upstream exit_aio() is
waiting for iocbs to complete.

Ben, are you digging in to this?  Want me to throw something together?

- z
