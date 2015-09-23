Received: from mail.tuxera.com ([5.250.163.136]:56639 "EHLO mail.tuxera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079AbbIWRJ5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 23 Sep 2015 13:09:57 -0400
Message-ID: <1443027628.5929.46.camel@ari-lenovo>
Subject: Re: [PATCH 1/2] Add checks for hardlinks support.
From: Ari Sundholm <ari@tuxera.com>
Date: Wed, 23 Sep 2015 20:00:28 +0300
In-Reply-To: <20150828042527.GK3902@dastard>
References: <1440580477.29614.3.camel@ari-macbook>
	 <20150827014718.GI3902@dastard> <1440673103.29614.13.camel@ari-macbook>
	 <20150828042527.GK3902@dastard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, 2015-08-28 at 14:25 +1000, Dave Chinner wrote:
> On Thu, Aug 27, 2015 at 01:58:23PM +0300, Ari Sundholm wrote: 
> > Do you mean why this patch is needed?
> 
> Of course.
> 
> Just because the answer migh be obvious to you, it doesn't mean it
> is obvious to anyone else, nor is an empty commit message useful in
> 2-3 years time when someone reads the commit and wonders "why did
> they make that change?"
> 

I understand. I had simply thought that a longer explanation was not
necessary in this case. I was wrong.

> > Because there are filesystems that
> > do not support hard links (at least not yet, but may support symlinks)
> > we would like to run xfstests on.
> >
> > I'd be glad to add this explanation and reroll the patches, but I
> > thought this would be obvious from what the patch does.
> 
> xfstests doesn't support any filesystems that don't have hardlinks.
> Why we should carry dead code, at minimum, needs explaining and
> discussing.
> 

But it does support filesystems which don't support symlinks. What I did
is just an analog of that for hardlinks.

Our company develops filesystem implementations, some of which support
symlinks or hardlinks, but not necessarily both - at least not yet. We
have found xfstests immensely useful in testing both work-in-progress
and established FS implementations and are integrating it as part of our
regular testing framework.

We try to contribute back as much as possible of those things that we
find generally useful. I am strongly of the opinion that this patch *is*
generally useful, as we are far from the only people developing new
filesystems. This is why I do not find this patch to be dead code. The
types of filesystems we work on might not always completely overlap with
the typical features of the filesystems xfstests is usually run on, such
as xfs, ext4 and btrfs, but I think the effort required to support our
filesystems remains small enough to be worth it.

It will definitely not be the end of the world for us if you don't find
this feature generally useful, but we try to upstream as much as
possible of what we think might benefit not only us, but others as well.

> Develop the habits that make you a better software engineer - using
> a "from:" line in patch submissions does not do that.

Will do. I try to learn and hope to keep learning.

Best regards,
Ari Sundholm
ari@tuxera.com

