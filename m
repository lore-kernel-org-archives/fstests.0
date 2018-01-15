Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:45816 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750846AbeAOVE1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Jan 2018 16:04:27 -0500
Date: Tue, 16 Jan 2018 08:03:52 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 2/2] xfs: Regression test for invalid sb_logsunit
Message-ID: <20180115210352.GY16421@dastard>
References: <20180111180734.GD1168@magnolia>
 <1515737783-2061-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1515737783-2061-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180112074921.GP5123@eguan.usersys.redhat.com>
 <20180112083605.GE27323@dastard>
 <20180112085005.GQ5123@eguan.usersys.redhat.com>
 <20180113022353.GH27323@dastard>
 <20180115124523.GB44369@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115124523.GB44369@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, xiao yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 15, 2018 at 07:45:23AM -0500, Brian Foster wrote:
> On Sat, Jan 13, 2018 at 01:23:53PM +1100, Dave Chinner wrote:
> > On Fri, Jan 12, 2018 at 04:50:05PM +0800, Eryu Guan wrote:
> > > On Fri, Jan 12, 2018 at 07:36:05PM +1100, Dave Chinner wrote:
> > > > On Fri, Jan 12, 2018 at 03:49:21PM +0800, Eryu Guan wrote:
> > > > > On Fri, Jan 12, 2018 at 02:16:23PM +0800, xiao yang wrote:
> > > > > > If log stripe unit isn't a multiple of the fs blocksize and mounting,
> > > > > > the invalid sb_logsunit leads to crash as soon as we try to write to
> > > > > > the log.
> > > > > > 
> > > > > > Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
> > > > > > ---
> > > > > >  tests/xfs/437     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  tests/xfs/437.out |  2 ++
> > > > > >  tests/xfs/group   |  1 +
> > > > > >  3 files changed, 76 insertions(+)
> > > > > >  create mode 100755 tests/xfs/437
> > > > > >  create mode 100644 tests/xfs/437.out
> > > > > > 
> > > > > > diff --git a/tests/xfs/437 b/tests/xfs/437
> > > > > > new file mode 100755
> > > > > > index 0000000..f2b84ad
> > > > > > --- /dev/null
> > > > > > +++ b/tests/xfs/437
> > > > > > @@ -0,0 +1,73 @@
> > > > > > +#! /bin/bash
> > > > > > +# FS QA Test No. 437
> > > > > > +#
> > > > > > +# Regression test for commit:
> > > > > > +# 9c92ee2 ("xfs: validate sb_logsunit is a multiple of the fs blocksize")
> > > > > > +#
> > > > > > +# If log stripe unit isn't a multiple of the fs blocksize and mounting,
> > > > > > +# the invalid sb_logsunit leads to crash as soon as we try to write to
> > > > > > +# the log.
> > > > > > +#
> > > > > > +#-----------------------------------------------------------------------
> > > > > > +# Copyright (c) 2018 FUJITSU.  All Rights Reserved.
> > > > > > +# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > > > > > +#
> > > > > > +# This program is free software; you can redistribute it and/or
> > > > > > +# modify it under the terms of the GNU General Public License as
> > > > > > +# published by the Free Software Foundation.
> > > > > > +#
> > > > > > +# This program is distributed in the hope that it would be useful,
> > > > > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > > > +# GNU General Public License for more details.
> > > > > > +#
> > > > > > +# You should have received a copy of the GNU General Public License
> > > > > > +# along with this program; if not, write the Free Software Foundation,
> > > > > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > > > > +#-----------------------------------------------------------------------
> > > > > > +
> > > > > > +seq=`basename "$0"`
> > > > > > +seqres="$RESULT_DIR/$seq"
> > > > > > +echo "QA output created by $seq"
> > > > > > +
> > > > > > +here=`pwd`
> > > > > > +tmp=/tmp/$$
> > > > > > +status=1    # failure is the default!
> > > > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > > > +
> > > > > > +_cleanup()
> > > > > > +{
> > > > > > +	rm -rf $tmp.*
> > > > > > +}
> > > > > > +
> > > > > > +# get standard environment and checks
> > > > > > +. ./common/rc
> > > > > > +
> > > > > > +# real QA test starts here
> > > > > > +_supported_os Linux
> > > > > > +_supported_fs xfs
> > > > > > +_require_scratch
> > > > > 
> > > > > This test triggers ASSERT failure and warning on debug build, thus
> > > > > failed _dmesg_check, I think we need _disable_dmesg_check (and some
> > > > > comments) too.
> > > > > 
> > > > > [1809960.157615] XFS (sda6): log stripe unit 4095 bytes must be a multiple of block size
> > > > > [1809960.159228] XFS (sda6): AAIEEE! Log failed size checks. Abort!
> > > > > [1809960.160534] XFS: Assertion failed: 0, file: fs/xfs/xfs_log.c, line: 679
> > > > > [1809960.162298] WARNING: CPU: 1 PID: 2186 at fs/xfs/xfs_message.c:105 asswarn+0x1e/0x30 [xfs]
> > > > 
> > > > If it triggers debug asserts which have been put there to catch bugs
> > > > in other utilities (like mkfs) on a current upstream debug kernel,
> > > > then the test should not be part of the auto and quick groups.
> > > 
> > > This test corrupts the filesystem on purpose (I didn't make this clear
> > > in my last reply, sorry about that), and xfs detects the corruption &
> > > refuses the mount instead of crashing. So I think the ASSERT failure is
> > > expected on debug build and we just need to ignore it.
> > 
> > Except that after that assert, the block device is now busy and can't
> > be released, so we can't use the scratch device anymore. All tests
> > after this assert has been triggered are going to fail because
> > the block device is busy....
> > 
> > That's the whole point of adding debug asserts in cases like this -
> > they are supposed to stop test execution in it's tracks and leave a
> > corpse to analyse. The auto group regression tests are not supposed
> > to take the machine down on normal test configs (i.e.
> > CONFIG_XFS_DEBUG=y).
> > 
> 
> FWIW, my understanding of the dangerous group has always been that it's
> for tests that when they trigger a regression, forcibly affect the
> entire system as such (lockup, hang, crash, etc.). IMO, a test that
> intentionally generates an XFS assert doesn't really follow the spirit
> of that categorization, even though technically an assert can cause a
> BUG. This is why we have CONFIG_XFS_ASSERT_FATAL now, because unless
> that is disabled any auto test that reproduces a regression (assuming we
> have broad/robust assert coverage) can very easily BUG() and have the
> associated effect on the system.

And this is exactly why I opposed the CONFIG_XFS_ASSERT_FATAL
inclusion. It started us down the slippery slope of allowing people
to ignore asserts that indicate an impossible condition had
occurred.

This was a bug found via fuzzing, not user problems in the wild. The
assert had functioned perfectly well up to this point as a mechanism
for preventing the XFS tools from creating a corrupt log stripe
unit, and it still does....

That's the point here - a corrupt log stripe unit *should never
happen* because it should trigger a CRC validation failure long
before we get to parsing it. If we've got a corrupt value with a
correct CRC, then we damn well need to understand the cause
*immediately* because something else has gone very, very wrong.

> The flipside of course is that one should generally be able to run
> xfstests against a FATAL_ASSERTS=y kernel that otherwise has no
> regressions and not bork the system because a test generates a BUG() as
> part of a successful run.

That is the historical behaviour of CONFIG_XFS_DEBUG=y and the
historical policy for xfstests. Adding CONFIG_XFS_ASSERT_FATAL does
not change that because (at least) some of use still treat asserts
as fatal.

> Perhaps the root problem here is that the
> kernel generates an assert from a codepath that "successfully" handles
> the erroneous situation.

We do that all over the place - the assert is there because it
indicates a fatal problem has occurred that should never happen.
For production systems, we still have to handle that gracefully
because people do fuzz testing of "should never happen" conditions
and then get upset we fail to detect this. That does not mean
the ASSERT is wrong - it makes it even more important that
developers know when their code hits these cases....

If we really want to test these "should not ever happen" conditions
that trigger asserts on debug kernels as "everyone always runs"
regression testing, then these need to _notrun on CONFIG_XFS_DEBUG=y
kernels.  fstests already knows that it's running on a debug kernel,
so adding a _requires_production_kernel check may be the way around
this being considered a dangerous test.

> We already spit out several error messages and
> fail the mount, so my .02 (fwiw) would be to leave the test as
> auto+dangerous, delete the useless assert and let people affected by
> older kernels (w/ FATAL_ASSERT behavior) filter out the test as
> appropriate in those environments. (Looking back, I see Darrick already
> suggested to delete the assert as well...).

... and this specific assert caught multiple bugs I introduced while
refactoring mkfs recently. That's it's purpose, and it works for
that purpose very well.

> > If you want to test dangerous regression tests, then you need to
> > *opt-in* by adding "-g dangerous", not force everyone else to
> > opt-out by having to run "-g auto -x dangerous".
> > 
> 
> I often explicitly filter out the dangerous group as above because we
> already have more than a handful of tests that are in both groups. I
> don't think they've historically been mutually exclusive.

Which means we've already deviated from the historic policy. That
doesn't mean it the right direction to take.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
