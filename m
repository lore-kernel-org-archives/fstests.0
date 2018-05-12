Received: from aserp2120.oracle.com ([141.146.126.78]:47636 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbeELARp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 May 2018 20:17:45 -0400
Date: Fri, 11 May 2018 17:15:17 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: limit xfs_growfs size if test with --large-fs
Message-ID: <20180512001517.GI4116@magnolia>
References: <20180427082254.25524-1-zlang@redhat.com>
 <20180510221859.GS10363@dastard>
 <20180511034150.GF1963@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180511232910.GY23861@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511232910.GY23861@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, darrick.wong@oracle.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Sat, May 12, 2018 at 09:29:10AM +1000, Dave Chinner wrote:
> On Fri, May 11, 2018 at 11:41:50AM +0800, Zorro Lang wrote:
> > On Fri, May 11, 2018 at 08:18:59AM +1000, Dave Chinner wrote:
> > > On Fri, Apr 27, 2018 at 04:22:54PM +0800, Zorro Lang wrote:
> > > > When test on large SCRATCH_DEV, grow a small XFS to huge size is a
> > > > horrible thing (e.g grow 128m to 500T). So add a helper named
> > > > _scratch_xfs_growfs_limited() to do below things:
> > > > 
> > > > 1) If --large-fs is used, limit growfs size.
> > > > 2) If a limit size parameter is specified, make sure growfs won't
> > > > beyond this size.
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > 
> > > I think I originally just didn't run growfs tests like this on large
> > > filesystems. i.e. require_no_largefs....
> > 
> > Hmm... Sorry, am I facing different review-points from 3 different XFS maintainers? ...
> 
> I'm not a maintainer, I'm just the guy who added this functionality
> to xfstests originally. Deciding what is to be done needs to start
> from an understanding of the criteria I used for skipping tests on
> large devices.  In this case, I never intended to have multiple
> order magnitude growfs tests run on large scratch devices.
> 
> When I added large device support, I tried to avoid tests that we
> already had substantial coverage for. i.e. if inreasing the space
> used by the test doesn't increase test coverage but only increased
> test runtime, then I skipped it.  In this case, we already test
> small to large size growfs via loopback devices on small scratch
> devices (e.g. xfs/078), so doing it on extremely large scratch
> devices doesn't reallycover any new code or error conditions.
> 
> Hence, based on my original criteria for deciding what tests to run
> on large filesystems, I would have skipped this test if it caused
> excessive runtime. I was testing on sparse devices on SSDs, so seek
> times for growfs did not impact performance, hence I probably didn't
> skip it...
> 
> > Dave: require_no_largefs is better.
> > Darrick: nearly ack this patch.
> > Eric: 
> > 2018-04-27 04:03 < sandeen> [15:01]  <zoro> [00:55:47] I think maybe use _require_no_large_scratch_dev for xfs/002 will be better. Grow a 128M XFS to large size is 'horrible'
> > 2018-04-27 04:03 < sandeen> just limit growfs to something smaller.
> > 
> > What should I do next?
> 
> Make your own decision about how best to proceed based on the
> feedback you've received. Or ask the fstests maintainer to decide
> what is best....  :P

No, don'... :) jk

Yes, it's worth asking Eryu.  I'm ok with either resolution
(_require_no_large_scratch_dev or just constrict it to 10x growfs).

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
