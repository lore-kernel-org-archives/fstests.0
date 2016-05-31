Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:36330 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752488AbcEaVMx (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 31 May 2016 17:12:53 -0400
Date: Wed, 1 Jun 2016 07:12:49 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFD] fstests needs a new maintainer
Message-ID: <20160531211249.GE12670@dastard>
References: <20160523045350.GF26977@dastard>
 <20160523064138.GA5051@zlang.usersys.redhat.com>
 <20160523145503.GA32314@infradead.org>
 <20160524140301.GU5140@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160524140301.GU5140@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 24, 2016 at 10:03:01PM +0800, Eryu Guan wrote:
> On Mon, May 23, 2016 at 07:55:03AM -0700, Christoph Hellwig wrote:
> > On Mon, May 23, 2016 at 02:41:38PM +0800, Zorro Lang wrote:
> > > Thanks for what you did for us. I'm just thinking maybe you can
> > > separate fstests maintenance jobs to several different maintainers?
> > > Due to fstests project become bigger and bigger, it maybe hard for
> > > someone review & merge & verify all kinds of patches.
> > > 
> > > As I know LTP have "not only one" maintainers. I think we still
> > > need someone like you can make important decision for fstests.
> > > But for some daily jobs, you can distribute them to others.
> > 
> > FYI, back when we team-maintained the xfstests-dev repo together with
> > all the other xfs -dev repos it worked out fine.  But even with that
> > we need someone to volunteer for doing the day to day grunt work.
> > 
> > While I'd be happy to help out I fear I don't have time to do the
> > majority of the work at the moment either.
> 
> I'd like to help out to do the day to day dirty work as well, though I
> don't have such experience before.

Thank you for putting your hand up, Eryu. I don't think ayone else
is going to nominate themselves (or anyone else) at this point, so
I'll happily accept your offer. If anyone objects, then please speak
up now...

Eryu, I don't think a lack of experience will be a problem - there
isn't a whole lot of things you need to learn to manage git trees in
a consistent manner.

I'm not sure what the best way to start you off is - we can probably
talk a bit off-list and work out how best to get you up to speed and
so not overload and drown you instantly. Once we work that out we
can let everyone know how we'll manage everything and what the
longer term plan is.

Sound reasonable?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
