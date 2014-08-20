Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21543 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122AbaHTXn2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Aug 2014 19:43:28 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before destroying the ioctx
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
	<20140820225701.GG26465@dastard>
Date: Wed, 20 Aug 2014 19:43:19 -0400
In-Reply-To: <20140820225701.GG26465@dastard> (Dave Chinner's message of "Thu,
	21 Aug 2014 08:57:01 +1000")
Message-ID: <x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi, Dave,

Dave Chinner <david@fromorbit.com> writes:

> IOWs, we now have two AIO+DIO tests showing the same symptoms that
> no other tests show. This tends to point at AIO not being fully
> cleaned up and completely freed by the time the processes
> dispatching it have exit()d. This failure generally occurs when
> there is other load on the system/disks backing the test VM (e.g.
> running xfstests in multiple VMs at the same time) so I suspect it
> has to do with IO completion taking a long time.

Process exit waits for all outstanding I/O, but maybe it's an rcu thing.

> Can you spend some time trying to reproduce this and getting to the
> bottom of whatever is triggering the unmount error?

I can take a look, but not until next week.  Hopefully that's ok?

Cheers,
Jeff
