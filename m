Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbbCAO2u (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 1 Mar 2015 09:28:50 -0500
Date: Sun, 1 Mar 2015 09:28:41 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: ramdisk problems in 4.0-rc1? (was Re: [PATCH 1/4] xfs/104: log
 size too small for 4k sector drives)
Message-ID: <20150301142840.GA13044@bfoster.bfoster>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
 <1424818479-10083-2-git-send-email-david@fromorbit.com>
 <20150225161151.GC28053@bfoster.bfoster>
 <20150225223248.GH4251@dastard>
 <20150225233115.GA1009@bfoster.bfoster>
 <20150225234343.GI4251@dastard>
 <54EECF53.8010207@plexistor.com>
 <20150226172313.GA2520@laptop.bfoster>
 <54F2D28C.8070903@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54F2D28C.8070903@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Boaz Harrosh <boaz@plexistor.com>
Cc: Jens Axboe <axboe@fb.com>, Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Mar 01, 2015 at 10:49:16AM +0200, Boaz Harrosh wrote:
> On 02/26/2015 07:23 PM, Brian Foster wrote:
> <>
> > 
> > Thanks Boaz, but I still see the same behavior with the part_show patch.
> > It seems to be something that broke in systemd on Fedora between
> > versions systemd-218 and systemd-219. The latter is broken on a 3.19
> > kernel as well.
> > 
> > I've filed a systemd bug so we'll see what comes of it from that end:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1196452
> > 
> > Brian
> > 
> 
> Hi Brian
> 
> It says in bugzilla (link above) that this issue is "fixed in git" so
> I guess we should be fine ?
> 

Yes, I picked up a more recent systemd version and it seems to work fine
now without the patch referenced below.

Brian

> Jens does *not* need to take
> 	[PATCH] brd: Re-instate ram disk visibility option (part_show)
> 
> Please confirm.
> 
> Please tell me if there is anything I can help with?
> 
> Thanks
> Boaz
> 
