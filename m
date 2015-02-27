Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:4247 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753539AbbB0AYF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 19:24:05 -0500
Date: Fri, 27 Feb 2015 11:23:02 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] brd: Only request 4K sectors if DAX is enabled
Message-ID: <20150227002302.GF18360@dastard>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
 <1424818479-10083-2-git-send-email-david@fromorbit.com>
 <20150225161151.GC28053@bfoster.bfoster>
 <20150225223248.GH4251@dastard>
 <54EED5F6.2030804@plexistor.com>
 <54EEDC4A.8090000@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EEDC4A.8090000@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Boaz Harrosh <boaz@plexistor.com>
Cc: Jens Axboe <axboe@fb.com>, Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 26, 2015 at 10:41:46AM +0200, Boaz Harrosh wrote:
> 
> People systems have been using ramdisk with
> smaller-than-page-size blocks in their mkfs.
> 
> The 4K sectors is only important if we will be
> using brd with a DAX filesystem.
> 
> So only enable 4K sectors if DAX is configured

4k sectors are not a problem - we should be handling them fine and
because it makes the ramdisk look like a 512e drive, no applications
should fail, either.

The main "unexpected" part about it was how much of xfstests didn't
handle 4k sectors in mkfs output properly. This isn't a problem with
the kernel change and so doesn't need fixing.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
