Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:53129 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750791AbcGUXFW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:05:22 -0400
Date: Fri, 22 Jul 2016 09:05:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/371: run write(2) and fallocate(2) in parallel
Message-ID: <20160721230519.GF12670@dastard>
References: <20160721073025.25557-1-wangxg.fnst@cn.fujitsu.com>
 <20160721104100.GD27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160721104100.GD27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 06:41:00PM +0800, Eryu Guan wrote:
> On Thu, Jul 21, 2016 at 03:30:25PM +0800, Wang Xiaoguang wrote:
> > +
> > +run_time=$((180 * $TIME_FACTOR))
> 
> 180s is too long time, I can reproduce it in around 10s on my test vm,
> just loop for 100 times for each operation (pwrite and falloc)

Or simply do:

run_time=$((20 * $TIME_FACTOR * $TIME_FACTOR))

So that the time factor scales up quickly when you want to run long
running tests.

> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -373,3 +373,4 @@
> >  368 auto quick richacl
> >  369 auto quick richacl
> >  370 auto quick richacl
> > +371 auto enospc prealloc stress
> 
> So we can add 'quick' group and remove 'stress'.

I'd leave the test in stress if we can run it based on time as per
my above suggestion.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
