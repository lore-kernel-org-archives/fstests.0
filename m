Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:45188 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751409AbbJRXOR (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 18 Oct 2015 19:14:17 -0400
Date: Mon, 19 Oct 2015 10:14:02 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: introduce XFS_IO_AVOID env var
Message-ID: <20151018231402.GA27164@dastard>
References: <1445107518-32022-1-git-send-email-tytso@mit.edu>
 <20151018213745.GX27164@dastard>
 <20151018220805.GN2678@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151018220805.GN2678@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 18, 2015 at 06:08:05PM -0400, Theodore Ts'o wrote:
> On Mon, Oct 19, 2015 at 08:37:45AM +1100, Dave Chinner wrote:
> > On Sat, Oct 17, 2015 at 02:45:18PM -0400, Theodore Ts'o wrote:
> > > Like FSSTRESS_AVOID and FSX_AVOID, XFS_IO_AVOID can be used to avoid
> > > using various advanced file system features such as "fpunch"
> > > "fcollapse", "finsert", or "zero".  Tests that require an xfs_io
> > > command which is included in the space-separated list found in the
> > > XFS_IO_AVOID environment variable will be skipped using _notrun.
> > 
> > This tells me what the change does, not why you need it.
> 
> We didn't go into as much detail for FSX_AVOID and FSSTRESS_AVOID, but
> it's basically for the same reason.  Sometimes we might want to
> exclude certain operational modes from the xfststs.

That's because FSSTRESS_AVOID had existed for a *long time* and
FSX_AVOID was basically the same thing. 

However, chopping out entire tests because they use a specific
xfs_io command is a little different - it can exclude a lot of
explicit correctness tests, rather than just change the pattern of
stress loads by excluding certain operations.

> As one example, currently xfstests doesn't understand the difference
> between the allocation cluster size and the block size.  In the case
> of collapse/insert range, it means operations need to be done in
> cluster-aligned chunks, as opposed to block-aligned clusters.  So to
> suppress test noise it's nice if we can suppress all attempts to use
> insert_range/collapse_range while running a test --- and using
> FSX_AVOID and FSSTRESS_AVOID isn't sufficient for this purpose.

Clearly they weren't designed for that purpose, either. :)

> So I wanted to be able to suppress all use of collapse range by being
> able to do something as simple as "gce-xfstests --no-collapse".  This
> gets expanded to setting the FSX_AVOID, FSSTRESS_AVOID, and
> XFS_IO_AVOID environment variables.

This is exactly what the "-x group" CLI option is for: To exclude
specific groups of tests from running, such as:

# ./check -g auto -x fcollapse

i.e. selection/exclusion of tests is done by group classifications
in tests/*/group, not environment variables. Update the group files,
and everything will work just fine for you.

FWIW, any test that uses a fallocatei() based command should also be
in the prealloc group. Can you update the group files to ensure
these tests are tagged with prealloc at the same time?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
