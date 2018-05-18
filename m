Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:58795 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750782AbeEREOe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 May 2018 00:14:34 -0400
Date: Fri, 18 May 2018 14:14:32 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Problems about xfstests g/475
Message-ID: <20180518041431.GL23861@dastard>
References: <20180517090304.GB4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180517143057.GC4910@magnolia>
 <20180517154517.GC4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180517171211.GF4910@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517171211.GF4910@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 17, 2018 at 10:12:11AM -0700, Darrick J. Wong wrote:
> 
> It would seem that you've uncovered a log replay bug in xfs. :)

....

> > 
> > [ 8201.588313] XFS (dm-0): metadata I/O error in "xlog_iodone" at daddr 0xf04fcc len 64 error 5 
> > [ 8201.590504] XFS (dm-0): metadata I/O error in "xlog_iodone" at daddr 0xf00025 len 64 error 5 
> > [ 8201.596839] XFS (dm-0): xfs_do_force_shutdown(0x2) called from line 1262 of file fs/xfs/xfs_log.c.  Return address = 00000000755f7a21 
> > [ 8201.597039] XFS (dm-0): Log I/O Error Detected.  Shutting down filesystem 

Here's the important thing - a failed log write.

> > > > *** xfs_logprint -t output ***
> > > > Log inconsistent or not a log (last==0, first!=1)

ISTR this implies the first checkpoint in the log is incomplete.
i.e. we got a log IO error before an entire checkpoint was written
and hence the log has a tail pointer of 0....

It might be worth cycling the mount before the test is run to see if
that makes the problem go away (as there will be an unmount record
already in the log and so when the test runs the last record to
recover will not be 0....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
