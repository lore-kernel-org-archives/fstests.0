Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:39621 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752185AbbHCFz6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2015 01:55:58 -0400
Date: Mon, 3 Aug 2015 15:55:37 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/5] xfstest: generic/219 add _require_odirect
Message-ID: <20150803055537.GS3902@dastard>
References: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
 <1438236417-24612-3-git-send-email-yangds.fnst@cn.fujitsu.com>
 <20150803035909.GP3902@dastard>
 <55BEF5A2.6090606@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55BEF5A2.6090606@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org, dedekind1@gmail.com, richard.weinberger@gmail.com, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 03, 2015 at 01:01:22PM +0800, Dongsheng Yang wrote:
> On 08/03/2015 11:59 AM, Dave Chinner wrote:
> >On Thu, Jul 30, 2015 at 02:06:54PM +0800, Dongsheng Yang wrote:
> >>generic/219 is testing quota in three use cases including
> >>Direct I/O. So we have to add a dependence to odirect in
> >>this test.
> >
> >Hmmm - you've modified on only 2 tests here in this patch series
> >that use direct IO. There are many more - just looking for direct IO
> >comments, these generic tests use direct IO in some way, and there
> >are others that such usage is not obvious (e.g. this patch to
> >generic/219):
> >
> >generic/091
> >generic/113
> >generic/130
> >generic/214
> >generic/224
> >generic/263
> >shared/272
> >
> >And all the aio/dio tests:
> >
> >generic/036
> >generic/198
> >generic/207
> >generic/208
> >generic/209
> >generic/210
> >generic/211
> >generic/212
> >generic/239
> >generic/240
> >generic/323
> >
> >And there are others that run fio that uses DIO, too, like
> >
> >generic/299
> >generic/300
> >
> >And so on. I haven't even looked at all the fsx tests that might
> >use DIO, and I know that some of them are not listed above...
> >
> >On the whole, I think ubifs would be better to implement DIO via
> >buffered fallback that to make us have to annotate every test that
> >uses DIO in some way...
> 
> Fair point. Yes, It's difficult to find out all the tests which
> would use DIO.
> 
> And we are discussing about dio in ubifs.
> 
> So if you are strongly rejecting this kind of change, I will drop
> this patch in my next version.

I would say "strongy rejecting", more advising a different approach
to solve the problem.  i.e. with a "return 0" ->direct_IO method,
applications that use direct IO won't randomly fail or refuse to
run.  That seems like a much better (and simpler!) solution compared
to chasing down applications that use direct IO and changing
them....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
