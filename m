Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49979 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbfH0PYW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Aug 2019 11:24:22 -0400
Date: Tue, 27 Aug 2019 17:24:16 +0200
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] generic: test for failure to unlock inode after chgrp
 fails with EDQUOT
Message-ID: <20190827152416.GA534@kroah.com>
References: <20190827041816.GB1037528@magnolia>
 <alpine.DEB.2.21.1908270811030.1939@nanos.tec.linutronix.de>
 <20190827150451.GY1037350@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827150451.GY1037350@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Eryu Guan <guaneryu@gmail.com>, Christoph Hellwig <hch@infradead.org>, xfs <linux-xfs@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, Salvatore Bonaccorso <carnil@debian.org>, Security Officers <security@kernel.org>, Debian Security Team <team@security.debian.org>, benjamin.moody@gmail.com, Ben Hutchings <benh@debian.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 27, 2019 at 08:04:51AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 27, 2019 at 08:13:19AM +0200, Thomas Gleixner wrote:
> > On Mon, 26 Aug 2019, Darrick J. Wong wrote:
> > > +++ b/tests/generic/719
> > > @@ -0,0 +1,59 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0-or-newer
> > 
> > Please run scripts/spdxcheck.py on that file and consult the licensing
> > documentation.
> 
> -or-later, sorry.
> 
> So .... now that everyone who wanted these SPDX identifiers have spread
> "GPL-2.0+" around the kernel and related projects (xfsprogs, xfstests)
> just in time for SPDX 3.0 to deprecate the "+" syntax, what are we
> supposed to do?  Another treewide change to fiddle with SPDX syntax?
> Can we just put:
> 
> Valid-License-Identifier: GPL-2.0+
> Valid-License-Identifier: GPL-2.0-or-later
> 
> in the LICENSES/GPL-2.0 file like the kernel does?
> 
> Is that even going to stay that way?  I thought I heard that Greg was
> working on phasing out the "2.0+" tags since SPDX deprecated that?
> 
> I think xfsprogs and xfstests just follow whatever the kernel does, but
> AFAICT this whole initiative /continues/ to communicate poorly with the
> maintainers about (1) how this is supposed to benefit us and (2) what we
> are supposed to do to maintain all of it.
> 
> Do we have to get lawyers involved to roll to a new SPDX version?  Will
> LF do that for (at least) the projects hosted on kernel.org?  Should we
> just do it and hope for the best since IANAFL?  I know how to review
> code.  I don't know how to review licensing and all the tiny
> implications that go along with things like this.  I don't even feel
> confident that the two identifiers above are exactly the same, because
> all I know is that I read it on a webpage somewhere.
> 
> I for one still have heard abso-f*cking-lutely nothing about what is
> this SPDX change other than Greg shoving treewide changes in the kernel.
> That sufficed to get the mechanical work done (at the cost of a lot of
> frustration for Greg) but this doesn't help me sustain our community.

It takes a lot more to get me frustrated :)

And I am _VERY_ supprised to hear you have not heard anything about this
given that Oracle has some lawyers who have been very involved in the
SPDX process.  One would have thought they had discussed it with their
developers.  They sure seem to come to me with questions that start,
"Our developers had a question about...", so I know they must talk to
someone...

> Guidance needed.  Apologies all around if this rant is misdirected, but
> I have no idea who (if anyone) is maintaining SPDX tags.  There's no
> entry for LICENSES/ in MAINTAINERS, which is where I looked first.

Thomas seems to have answered all of your questions, hopefully.

And yeah, Thomas and I should probably be listed in MAINTAINERS for
LICENSES as we somehow got tagged for all of this work.

thanks,

greg k-h
