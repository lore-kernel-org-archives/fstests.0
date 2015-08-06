Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:33665 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756493AbbHFWVm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 6 Aug 2015 18:21:42 -0400
Date: Fri, 7 Aug 2015 08:21:27 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/038: speed up file creation
Message-ID: <20150806222127.GE3902@dastard>
References: <1438820848-13325-1-git-send-email-david@fromorbit.com>
 <20150806141722.GF17933@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150806141722.GF17933@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 06, 2015 at 10:17:22PM +0800, Eryu Guan wrote:
> On Thu, Aug 06, 2015 at 10:27:28AM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Now that generic/038 is running on my test machine, I notice how
> > slow it is:
> > 
> > generic/038      692s
> > 
> > 11-12 minutes for a single test is way too long.
> > The test is creating
> > 400,000 single block files, which can be easily parallelised and
> > hence run much faster than the test is currently doing.
> > 
> > Split the file creation up into 4 threads that create 100,000 files
> > each. 4 is chosen because XFS defaults to 4AGs, ext4 still has decent
> > speedups at 4 concurrent creates, and other filesystems aren't hurt
> > by excessive concurrency. The result:
> > 
> > generic/038      237s
> > 
> > on the same machine, which is roughly 3x faster and so it (just)
> > fast enough to to be considered acceptible.
> 
> I got a speedup from 5663s to 639s, and confirmed the test could

Oh, wow. You should consider any test that takes longer than 5
minutes in the auto group as taking too long. An hour for a test in
the auto group is not acceptible. I expect the auto group to
complete within 1-2 hours for an xfs run, depending on storage in
use. 

On my slowest test vm, the slowest tests are:

$ cat results/check.time | sort -nr -k 2 |head -10
generic/127 1060
generic/038 537
xfs/042 426
generic/231 273
xfs/227 267
generic/208 200
generic/027 156
shared/005 153
generic/133 125
xfs/217 123
$

As you can see, generic/038 is the second worst offender here (it's
a single CPU machine, so parallelism doesn't help a great deal).
generic/127 and xfs/042 are the other two tests that really need
looking at, and only generic/231 and xfs/227 are in the
"borderline-too-slow" category.

generic/038 was a simple on to speed up. I've looked at generic/127,
and it's limited by the pair of synchronous IO fsx runs of 100,000
ops, which means there's probably 40,000 synchronous writes in the
test. Of course, this is meaningless on a ramdisk - generic/127
takes only 24s on my fastest test vm....

> fail the test on unpatched btrfs (btrfsck failed, not every time).

Seeing as you can reproduce the problem, I encourage you to work out
what the minimum number of files need to reproduce the problem is,
and update the test to use that so that it runs even faster...

> Reviewed-by: Eryu Guan <eguan@redhat.com>

Thanks!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
