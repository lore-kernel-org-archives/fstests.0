Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:37202 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752571AbcD2BGO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2016 21:06:14 -0400
Date: Fri, 29 Apr 2016 11:05:31 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: xfs: add necessary version check for xfs/122
Message-ID: <20160429010531.GM18496@dastard>
References: <1458549088-468-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
 <20160322225614.GW11812@dastard>
 <5720462B.4050900@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5720462B.4050900@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 27, 2016 at 12:55:07PM +0800, Xiaoguang Wang wrote:
> hello,
> 
> On 03/23/2016 06:56 AM, Dave Chinner wrote:
> > On Mon, Mar 21, 2016 at 04:31:28PM +0800, Xiaoguang Wang wrote:
> >> From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> >>
> >> Since commit c0cfa5651f2d ("xfs/122: update against xfsprogs 4.3"), xfs/122
> >> has been updated against xfsprogs 4.3, so add necessary version check.
> >>
> >> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> > 
> > This sort of version test belongs in autoconf, not the tests
> > themselves.
> Would you please give me some hints about how to add version test
> in autoconf,

Well, first it helps to see what the problem is that your are trying
ot work around. In general, if it's a compilation problem of a test
program, then we use autoconf to set conditional defines to
determine what gets compiled, and then write code that works for
all the different versions we need to support.

In this case, it's the test that is building source code to be
compiled, so the problem is likely the test itself and the way it
assmebles the header files for inclusion. That's what would need to
be fixed....

> also in xfs/188,
> I see similar usage:
>     if [ $XFSPROGS_VERSION -lt 21000 ]; then
>         _notrun "this test requires case-insensitive support"
>     fi

That's really old and was done before we settled on the _require*
rules patterns for explicitly checking for support in tools.

Indeed, this should simply check whether mkfs supports the "-n
version=ci" parameter, as we do for things like CRC support...

i.e.

_requires_xfs_case_insensitive()
{
	_scratch_mkfs_xfs_supported -n version=ci >/dev/null 2>&1 \
	           || _notrun "mkfs.xfs doesn't have case-insensitive feature"
}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
