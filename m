Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51310 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668AbbAVXuv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 Jan 2015 18:50:51 -0500
Date: Thu, 22 Jan 2015 15:50:45 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2 v3] xfs/087: test f2fs selectively
Message-ID: <20150122235045.GB16473@jaegeuk-mac02>
References: <1420804366-85126-1-git-send-email-jaegeuk@kernel.org>
 <20150121033832.GB16510@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150121033832.GB16510@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 21, 2015 at 02:38:32PM +1100, Dave Chinner wrote:
> On Fri, Jan 09, 2015 at 03:52:45AM -0800, Jaegeuk Kim wrote:
> > This patch add the f2fs support for xfs/087 with goingdown.
> > 
> 
> xfs/087 is not really a test that should be made generic/shared;
> it's testing a bunch of different XFS specific mount options and log
> recovery behaviour which has no relevance to any other filesystem.

When I took a closer look at clean and dirty logs in xfs, I thought that they
are very similar to the f2fs's logs.
If it is correct that the dirty log in xfs means that there are something to
replay metadata operations, I think f2fs can also detect them in a same manner.

So, actually I've already been testing xfs/086 and xfs/087 on f2fs having clean
and dirty log statement (which is retrieved by f2fs-tools).

Additionally, I've found that f2fs can be added into:
 xfs/051
 xfs/085

Anyway, if you think these are still not proper testcases, let me know.

> 
> If you want to take xfs specific tests that are only XFS specific
> because of the shutdowns they use, look at these ones:
> 
> 	xfs/053		(data exposure)
> 	xfs/137		(data vs filesize)
> 	xfs/138		(data vs filesize vs truncate)
> 	xfs/139		(data vs filesize vs partial truncate)
> 	xfs/140		(data vs filesize vs extending truncate)
> 	xfs/179		(data vs filesize w/ fsync)
> 	xfs/180		(data vs filesize w/ sync)
> 	xfs/182		(data vs filesize w/ recovery)
> 	xfs/200		(recovery vs ro-block device)
> 	xfs/306		(fsstress vs recovery)
> 
> These can all be made generic with very little effort -
> "_require_shutdown" is probably all that is necessary for most of
> them....
> 
> Also, we really are trying not to add more "shared" tests - with the
> correct "_requires_foo" rules we can just place those tests in
> generic/ and filesystems that don't support "foo" will avoid it.

Thank you for the list. :)
I'll check and try to follow the rule for _requires_foo.

Thanks,

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
