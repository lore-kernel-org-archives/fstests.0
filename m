Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750902AbeELNT1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 12 May 2018 09:19:27 -0400
Date: Sat, 12 May 2018 21:19:24 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs: limit xfs_growfs size if test with --large-fs
Message-ID: <20180512131924.GI1963@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180427082254.25524-1-zlang@redhat.com>
 <20180510221859.GS10363@dastard>
 <20180511034150.GF1963@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180512055328.GP8373@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180512055328.GP8373@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, darrick.wong@oracle.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Sat, May 12, 2018 at 01:53:28PM +0800, Eryu Guan wrote:
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
> > 
> > Dave: require_no_largefs is better.
> > Darrick: nearly ack this patch.
> > Eric: 
> > 2018-04-27 04:03 < sandeen> [15:01]  <zoro> [00:55:47] I think maybe use _require_no_large_scratch_dev for xfs/002 will be better. Grow a 128M XFS to large size is 'horrible'
> > 2018-04-27 04:03 < sandeen> just limit growfs to something smaller.
> > 
> > What should I do next?
> 
> If testing on large device won't add more test coverage but only test
> runtime, I'd like to just skip the tests.
> 
> Would you please send a new version of the patch that adds
> _require_no_large_scratch_dev to the affected tests?

Sure, going to do that.

> 
> And thanks all for the comments!
> 
> Eryu
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Cheers,
> > > 
> > > Dave.
> > > 
> > > -- 
> > > Dave Chinner
> > > david@fromorbit.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
