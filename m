Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:3636 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbeLRVyu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Dec 2018 16:54:50 -0500
Date: Wed, 19 Dec 2018 08:54:24 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/3] common: add _require_test_swapfile
Message-ID: <20181218215424.GB31274@dastard>
References: <20181203064256.26768-1-david@fromorbit.com>
 <20181203064256.26768-2-david@fromorbit.com>
 <5C124D9A.3040305@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C124D9A.3040305@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 13, 2018 at 08:16:26PM +0800, Xiao Yang wrote:
> On 2018/12/03 14:42, Dave Chinner wrote:
> 
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Because we can host swap files on the test device, not just the
> > scratch device.
> >
> > Also, move the tests for the utilities needed to manipulate swap
> > files into the functions that test whether swap files are supported
> > so they are checked for existence /before/ we try to us them. This
> > fixes all the tests that currently check for these utilities
> > manually /after/ checking if swapfiles are supported.
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  common/rc         | 29 +++++++++++++++++++++--------
> >  tests/generic/472 |  2 --
> >  tests/generic/495 |  2 --
> >  tests/generic/496 |  2 --
> >  tests/generic/497 |  2 --
> >  5 files changed, 21 insertions(+), 16 deletions(-)
> >
> > diff --git a/common/rc b/common/rc
> > index ecb17380bad8..5b344b25012b 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2214,22 +2214,35 @@ _format_swapfile() {
> >  }
> >  
> >  # Check that the filesystem supports swapfiles
> > -_require_scratch_swapfile()
> > +_require_swapfile()
> >  {
> > -	_require_scratch
> > +	dir=$1
> >  
> > -	_scratch_mkfs >/dev/null
> > -	_scratch_mount
> > +	# fstests also has custom binaries for mkswap/swapon
> > +	_require_test_program mkswap
> > +	_require_test_program swapon
> Hi Dave,
> 
> Is it necessary to include the check for custom mkswap/swapon in _require_swapfile()?
> In fact, some tests calling _require_scratch_swapfile() just use default mkswap/swapon
> command(e.g. generic/356, generic/357, generic/493, generic/494).  I perfer to keep it
> in separate tests.

Those binaries are built by fstests, so there is absolutely no harm
in requiring them. If they didn't get built, then the fstests
install is in no shape to be run because it wasn't built correctly.

And by adding them here, we do not need to clutter up tests with
lots different requires - we just say "we require swapfile support"
and that pulls in everything swapfile related. This makes the tests
easier to review and maintain because there is less that needs to be
done to write a swapfile related test.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
