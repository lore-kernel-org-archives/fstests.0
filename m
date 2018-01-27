Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:27618 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751427AbeA0Dzr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Jan 2018 22:55:47 -0500
Date: Sat, 27 Jan 2018 14:56:40 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 4/8] metaperf: Include linux/param.h explicitly for HZ
 macro
Message-ID: <20180127035640.4u5u52tx2xuycj6m@destitution>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-5-git-send-email-rostislav@tuxera.com>
 <20180122202406.GD16776@infradead.org>
 <20180124035859.GA30514@eguan.usersys.redhat.com>
 <20180127031659.mtpdvi4t3bis22af@destitution>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127031659.mtpdvi4t3bis22af@destitution>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Rostislav Skudnov <rostislav@tuxera.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jan 27, 2018 at 02:16:59PM +1100, Dave Chinner wrote:
> On Wed, Jan 24, 2018 at 11:58:59AM +0800, Eryu Guan wrote:
> > On Mon, Jan 22, 2018 at 12:24:06PM -0800, Christoph Hellwig wrote:
> > > On Mon, Jan 22, 2018 at 03:57:15PM +0000, Rostislav Skudnov wrote:
> > > > Glibc includes linux/param.h when we include sys/param.h, whereas musl
> > > > libc does not do that. HZ is a Linux-specific macro, therefore include
> > > > the header file that defines it explicitly.
> > > > 
> > > > Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
> > > 
> > > Using HZ in userspace doesn't make any sense at all.  The kernel HZ
> > > (as in the granulairy for jiffies) can vary between architectures
> > > and even configurations.  I guess it wants a hard coded 100 here, but
> > > someone will have to do a detailed analysis.
> > 
> > No one is using metaperf now, all the old benchmark infrastructure was
> > removed by commit b020416d51ff ("xfstests: remove bench infrastructure")
> > 
> > I think we can remove src/metaperf.c too.
> 
> FYI I use dirperf and metaperf for standalone ismoke testing of my
> kernel changes quite a lot...

Sorry for the duplicate response, I thought it had been lost and
hadn't realised the mail queue on my laptop had got stuck a couple
of days ago...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
