Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:39127 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbfAWEQa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jan 2019 23:16:30 -0500
Date: Wed, 23 Jan 2019 15:16:28 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] filter: fix assumed whitespace in _filefrag_filter
 regex
Message-ID: <20190123041628.GP6173@dastard>
References: <20190121163316.20616-1-jeffm@suse.com>
 <20190121163316.20616-2-jeffm@suse.com>
 <20190121225155.GG4205@dastard>
 <02910403-e6c2-5af8-ebe6-c7fe19b7c02a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02910403-e6c2-5af8-ebe6-c7fe19b7c02a@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 22, 2019 at 08:38:17PM -0500, Jeff Mahoney wrote:
> On 1/21/19 5:51 PM, Dave Chinner wrote:
> > On Mon, Jan 21, 2019 at 11:33:11AM -0500, jeffm@suse.com wrote:
> >> From: Jeff Mahoney <jeffm@suse.com>
> >>
> >> The regex assumes there will be whitespace after the .. in the ranges
> >> and, with larger offsets, there may not be any.
> > 
> > Does more than this, right?
> 
> I suppose.  It converts the interpreted .. into a literal .., which I
> believe was the original intent.
> 
> >> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> >> ---
> >>  common/filter | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/common/filter b/common/filter
> >> index ed082d24..b4443a34 100644
> >> --- a/common/filter
> >> +++ b/common/filter
> >> @@ -532,7 +532,7 @@ _filter_filefrag()
> >>  		next
> >>  	}
> >>  	($ext, $logical, $physical, $length) =
> >> -		(/^\s*(\d+):\s+(\d+)..\s+\d+:\s+(\d+)..\s+\d+:\s+(\d+):/)
> >> +		(/^\s*(\d+):\s+(\d+)\.\.\s*\d+:\s+(\d+)\.\.\s*\d+:\s+(\d+):/)
> > 
> > This is escaping "..", too, isn't it? 
> 
> Yes, but what else could the .. in the original regex have been
> referring to?  I don't recall seeing any other filefrag format that
> would match otherwise.

Neither do I. My point was it was a change that was not documented
in the commit message and so there might be something I was missing.

> I don't have a problem documenting it further, though.

That'd be great, thanks!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
