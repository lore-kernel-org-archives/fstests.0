Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:50919 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752178AbbCBBJu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 1 Mar 2015 20:09:50 -0500
Date: Mon, 2 Mar 2015 12:09:24 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: ramdisk problems in 4.0-rc1? (was Re: [PATCH 1/4] xfs/104: log
 size too small for 4k sector drives)
Message-ID: <20150302010924.GQ4251@dastard>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
 <1424818479-10083-2-git-send-email-david@fromorbit.com>
 <20150225161151.GC28053@bfoster.bfoster>
 <20150225223248.GH4251@dastard>
 <20150225233115.GA1009@bfoster.bfoster>
 <20150225234343.GI4251@dastard>
 <54EECF53.8010207@plexistor.com>
 <20150227005837.GG18360@dastard>
 <54F2CD85.3060303@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54F2CD85.3060303@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Boaz Harrosh <boaz@plexistor.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@fb.com
List-ID: <fstests@vger.kernel.org>

On Sun, Mar 01, 2015 at 10:27:49AM +0200, Boaz Harrosh wrote:
> On 02/27/2015 02:58 AM, Dave Chinner wrote:
> >> It looks like the system anticipates that ramdisk "should
> >> not have these events"
> > 
> > Right, but not because it's a ramdisk. Those events should not be
> > occurring because I'm not creating or destroying devices, I'm not
> > changing partition tables, I'm not resizing ramdisks or partitions,
> > and so on. I'm simply mkfs'ing, mounting and unmounting filesystems
> > on the ramdisks - nothing should be generating device based udev
> > events...
> > 
> > Finding the trigger that is causing these events will tell us what
> > the bug is - 
> 
> > restricting the config won't help, especially as DAX
> > will *always* be enabled on my test machines as it's something
> > needed in my test matrix.
> 
> No the "if DAX" is for the 4k thing. The enablement of the uevents is
> with a new "part_show" module parameter (See patch-1).

Sure, but that doesn't answer my question: what is generating device
level uevents when all I'm doing is mkfs/mount/umount on the device?

> > I'm not sure how to go about finding that
> > trigger right now and as such I won't really have time to look at it
> > until after lsfmm/vault...
> > 
> 
> I'll try to reproduce this here. What Fedora version do I need?

I'm running debian unstable w/ systemd-215 on the particular test
machine that is hitting this problem.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
