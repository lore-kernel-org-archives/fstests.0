Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:31809 "EHLO
        ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934691AbcI2WtS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Sep 2016 18:49:18 -0400
Date: Fri, 30 Sep 2016 08:49:13 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160929224913.GP9806@dastard>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926221814.GC2532@dastard>
 <20160928235713.tt76og3lxuvozrpi@thunk.org>
 <20160929021628.GI9806@dastard>
 <20160929035636.g2776ggv2cundlrh@thunk.org>
 <20160929053752.GJ9806@dastard>
 <20160929130501.k7hz2qcp6tgiyji6@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160929130501.k7hz2qcp6tgiyji6@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 29, 2016 at 09:05:01AM -0400, Theodore Ts'o wrote:
> On Thu, Sep 29, 2016 at 03:37:52PM +1000, Dave Chinner wrote:
> > Nobody outside the google echo chamber can say, Ted, because you
> > haven't told anyone what it is you want this for. binary emulation
> > layers (your example, not mine) don't implement persistent
> > filesystems - they translate syscalls.
> 
> Is your only objection that you don't get to can't see what it's going
> to test?

No, it isn't. But it's the most important one on my list right now
because it affects fundamental architecture assumptions the test
harness is based upon. I haven't looked at the implementation,
because if we can't validate the basic architecture there's no point
even looking at the code.

As it is, Eryu and Eric have already outlined a number of serious
issues with the implementation (and your testing process). They've
highlighted a number of magic snowflake conditions we'd have to
sprinkle throughout random tests and maintain forever more. What's
missing from your patch request is the information that allows us to
determine if the benefits of this patchset outweigh the obvious,
significant, ongoing cost of having to maintain these snowflakes.

Ted, as a kernel subsystem maintainer, you should know that
understanding the full picture is a neccessary aspect of reviewing
new proposals. Do you really merge code into ext4 that you think is
going to be a significant future burden on the maintainer without
knowing why it is needed, how it will be used, or even how you'll
maintain it in a working condition over the long term?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
