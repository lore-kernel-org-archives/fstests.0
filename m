Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:43701 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750698AbbH1EZw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 28 Aug 2015 00:25:52 -0400
Date: Fri, 28 Aug 2015 14:25:27 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] Add checks for hardlinks support.
Message-ID: <20150828042527.GK3902@dastard>
References: <1440580477.29614.3.camel@ari-macbook>
 <20150827014718.GI3902@dastard>
 <1440673103.29614.13.camel@ari-macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440673103.29614.13.camel@ari-macbook>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 27, 2015 at 01:58:23PM +0300, Ari Sundholm wrote:
> Hello Dave!
> 
> On Thu, 2015-08-27 at 11:47 +1000, Dave Chinner wrote:
> > On Wed, Aug 26, 2015 at 12:14:37PM +0300, Ari Sundholm wrote:
> > > From: Ari Sundholm <ari@tuxera.com>
> > > 
> > > Signed-off-by: Ari Sundholm <ari@tuxera.com>
> > 
> > Why?
> > 
> 
> Do you mean why this patch is needed?

Of course.

Just because the answer migh be obvious to you, it doesn't mean it
is obvious to anyone else, nor is an empty commit message useful in
2-3 years time when someone reads the commit and wonders "why did
they make that change?"

> Because there are filesystems that
> do not support hard links (at least not yet, but may support symlinks)
> we would like to run xfstests on.
>
> I'd be glad to add this explanation and reroll the patches, but I
> thought this would be obvious from what the patch does.

xfstests doesn't support any filesystems that don't have hardlinks.
Why we should carry dead code, at minimum, needs explaining and
discussing.

> OTOH, if you meant to ask why I have both a From: line and a
> Signed-off-by: line, it's just a habit due to a pedantic reading of the
> kernel patch submission instructions, which I've since applied to other
> contexts as well.

Then I'm sure that you would have also read the entire section on
writing a decent commit message:

"
2) Describe your changes.
-------------------------

Describe your problem. ....

Describe user-visible impact. ....

Quantify optimizations and trade-offs. ....

Once the problem is established, describe what you are actually
doing about it in technical detail. ....
"

Develop the habits that make you a better software engineer - using
a "from:" line in patch submissions does not do that.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
