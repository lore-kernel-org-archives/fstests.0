Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:27198 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753078AbcK3VLl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Nov 2016 16:11:41 -0500
Date: Thu, 1 Dec 2016 08:11:04 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/2] common: make common/rc easier to manage
Message-ID: <20161130211104.GB11750@dastard>
References: <20161129213233.8462-1-david@fromorbit.com>
 <20161130101028.GS22989@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161130101028.GS22989@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 30, 2016 at 06:10:28PM +0800, Eryu Guan wrote:
> On Wed, Nov 30, 2016 at 08:32:31AM +1100, Dave Chinner wrote:
> > Hi folks,
> > 
> > common/rc has grown huge with lots of library functions, and it's
> > becoming hard to manage. The following two patches split the XFS and
> > btrfs specific functionality in common/rc into separate files which
> > are sourced directly from common/rc based on $FSTYP.
> 
> Thanks, Dave!
> 
> > 
> > This moves a large chunk of code spread throughout common/rc into
> > smaller, more contained files where it is easier to see how the
> > filesystem specific pieces are put together. I'd like to see this
> > happen for other filesytems, and quite possibly other groups of
> > functionality that make sense to manage separately.
> > 
> > Thoughts and comments welcome!
> 
> They look good to me, and I'm testing them now. Two things I noticed:
> - Can we take this opportunity to fix some code style issues, along with
>   the movement? e.g. tab indention, if-then-else-fi format and while-do
>   format and whitespace issues.

In the patch that moves the code, no. In follow-on cleanup patches,
yes.

> - Should _require_scratch_richacl_xfs() be moved to common/xfs too?

I ignored that for the moment because XFS doesn't actually have any
richacl support and I didn't want to think about how the richacl
checks might be best separated.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
