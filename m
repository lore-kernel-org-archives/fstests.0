Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:47725 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750830AbeAPIu1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Jan 2018 03:50:27 -0500
Date: Tue, 16 Jan 2018 19:50:23 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 2/2] xfs: Regression test for invalid sb_logsunit
Message-ID: <20180116085023.GH16421@dastard>
References: <20180111180734.GD1168@magnolia>
 <1515737783-2061-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1515737783-2061-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180112074921.GP5123@eguan.usersys.redhat.com>
 <20180112083605.GE27323@dastard>
 <20180112085005.GQ5123@eguan.usersys.redhat.com>
 <20180113022353.GH27323@dastard>
 <20180115124523.GB44369@bfoster.bfoster>
 <20180115210352.GY16421@dastard>
 <20180116040254.GE3102@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116040254.GE3102@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>, xiao yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 16, 2018 at 12:02:54PM +0800, Eryu Guan wrote:
> On Tue, Jan 16, 2018 at 08:03:52AM +1100, Dave Chinner wrote:
> > On Mon, Jan 15, 2018 at 07:45:23AM -0500, Brian Foster wrote:
> > > On Sat, Jan 13, 2018 at 01:23:53PM +1100, Dave Chinner wrote:
> > > > That's the whole point of adding debug asserts in cases like this -
> > > > they are supposed to stop test execution in it's tracks and leave a
> > > > corpse to analyse. The auto group regression tests are not supposed
> > > > to take the machine down on normal test configs (i.e.
> > > > CONFIG_XFS_DEBUG=y).
> > > > 
> > > 
> > > FWIW, my understanding of the dangerous group has always been that it's
> > > for tests that when they trigger a regression, forcibly affect the
> > > entire system as such (lockup, hang, crash, etc.). IMO, a test that
> 
> I had the same understanding of dangerous group. And I recommended the
> usage of "-g auto -x dangerous" before[1], and Dave acknowledged this
> dangerous group usage[2] :)
> 
> [1] https://www.spinics.net/lists/linux-btrfs/msg57312.html
> [2] https://www.spinics.net/lists/linux-btrfs/msg57330.html

Context is important. The context that the above links were talking
about filtering the dangerous group was for older kernels that don't
have the fixes for the bugs that crash the kernel.

This particular test fails this auto group criteria in the case of
people using CONFIG_XFS_DEBUG=y:

"
    - it passes on current upstream kernels, if it fails, it's
      likely to be resolved in forseeable future [2]
"

It fails, and isn't likely to ever work, because the assert needs to
remain there to catch userspace tool screwups....

> > If we really want to test these "should not ever happen" conditions
> > that trigger asserts on debug kernels as "everyone always runs"
> > regression testing, then these need to _notrun on CONFIG_XFS_DEBUG=y
> > kernels.  fstests already knows that it's running on a debug kernel,
> > so adding a _requires_production_kernel check may be the way around
> > this being considered a dangerous test.
> 
> This reminds that we already have a _require_no_xfs_debug rule, as used
> in xfs/115, which is known to trigger ASSERT failure on debug build. So
> we can do the same in this new test.

Ok, good! And it appears to be addressing the same "intentional
corruption triggers failures" case as we are discussing here:

# we corrupt XFS on purpose, and debug built XFS would crash due to assert
# failure, so skip if we're testing on a debug built XFS
_require_no_xfs_debug

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
