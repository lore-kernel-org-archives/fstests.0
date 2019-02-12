Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:8569 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728406AbfBLVEf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Feb 2019 16:04:35 -0500
Date: Wed, 13 Feb 2019 08:04:22 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: new EOF fragmentation tests
Message-ID: <20190212210422.GJ20493@dastard>
References: <20190211013647.22580-1-david@fromorbit.com>
 <20190212140330.GC35803@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212140330.GC35803@bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 12, 2019 at 09:03:30AM -0500, Brian Foster wrote:
> On Mon, Feb 11, 2019 at 12:36:47PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > These tests create substantial file fragmentation as a result of
> > application actions that defeat post-EOF preallocation
> > optimisations. They are intended to replicate known vectors for
> > these problems, and provide a check that the fragmentation levels
> > have been controlled. The mitigations we make may not completely
> > remove fragmentation (e.g. they may demonstrate speculative delalloc
> > related extent size growth) so the checks don't assume we'll end up
> > with perfect layouts and hence check for an exceptable level of
> > fragmentation rather than none.
.....
> > +workfile=$SCRATCH_MNT/file
> > +nfiles=8
> > +wsize=4096
> > +wcnt=1000
> > +
> > +write_sync_file()
> > +{
> > +	idx=$1
> > +
> > +	for ((cnt=0; cnt<$wcnt; cnt++)); do
> > +		$XFS_IO_PROG -f -s -c "pwrite $((cnt * wsize)) $wsize" $workfile.$idx
> > +	done
> > +}
> > +
> > +rm -f $workfile*
> > +for ((n=0; n<$nfiles; n++)); do
> > +	write_sync_file $n > /dev/null 2>&1 &
> > +done
> > +wait
> > +sync
> 
> I'm not a huge fan of seeing these global syncs sprinkled around tests
> where they might not be needed. Are these here for a reason? If so, could
> they be replaced with an xfs_io -c syncfs or some such?

sync is there to ensure that everything is stable and I don't need
to care about using sync flags for counting extents.

I could use syncfs (either binary or xfs_io) but that's not
supported on all the OS's that fstests runs on. And I don't think
using sync really matters - if "sync" causes problems for fstests
that using syncfs fixes, then we've got bigger issues to worry
about.

> > +
> > +for ((n=0; n<$nfiles; n++)); do
> > +	count=$(_count_extents $workfile.$n)
> > +	# Acceptible extent count range is 1-40
> > +	_within_tolerance "file.$n extent count" $count 21 19 -v
> > +done
> > +
> > +# success, all done
> > +status=0
> > +exit
> ...
> > diff --git a/tests/xfs/502 b/tests/xfs/502
> > new file mode 100755
> > index 00000000..9f314a3d
> > --- /dev/null
> > +++ b/tests/xfs/502
> > @@ -0,0 +1,81 @@
> ...
> > +
> > +# Write multiple files in parallel using O_DIRECT writes w/ extent size hints.
> > +# Aim is to interleave allocations to fragment the files. O_DIRECT writes defeat
> > +# the open/write/close heuristics in xfs_release() that prevent EOF block
> > +# removal, so this should fragment badly. Typical problematic behaviour shows
> > +# per-file extent counts of ~1000 (worst case) whilst fixed behaviour typically
> > +# shows extent counts in the low single digits (almost best case)
> > +#
> 
> This is essentially equivalent to the previous test, right? E.g.,

IMO, no. This is a different IO pattern that demonstrates a
fragmentation problem, regardless of the underlying cause. We may
fix the buffered write problem (e.g. via enabling delalloc on extent
size hints) but that leaves the direct IO variant unchanged. Hence,
if we drop this test, we'll never realise we still have a direct IO
variant we have to ensure we don't break.

IOWs, I'm attempting to characterise and exercise the userspace IO
patterns that cause fragmentation problems rather than exercise a
specific bug in the filesystem implementation.

> path as direct I/O with an extent size hint in current XFS. Of course
> that may not always be so, but I wonder if these two could be combined.

That's kinda my point - these IO patterns haven't always (and won't
always) exercised the same code paths and allocation behaviours.
Hence we nee dto exercise them both, even if they currently both
expose the same underlying problem.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
