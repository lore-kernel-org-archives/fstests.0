Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:61827 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932338AbaIRBdT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Sep 2014 21:33:19 -0400
Date: Thu, 18 Sep 2014 11:33:13 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/5] generic: add write vs fcollapse test
Message-ID: <20140918013313.GY4322@dastard>
References: <1410918113-23516-1-git-send-email-david@fromorbit.com>
 <1410918113-23516-6-git-send-email-david@fromorbit.com>
 <20140917124029.GA29222@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140917124029.GA29222@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 17, 2014 at 08:40:30AM -0400, Brian Foster wrote:
> On Wed, Sep 17, 2014 at 11:41:53AM +1000, Dave Chinner wrote:
> > This test exposed a problem with XFS where it failed to write back a
> > partial page correctly during a fcollapse operation. This left a
> > stray dirty buffer on the page, and hence invalidation of the page
> > then failed of the fcollapse returned an EBUSY error.
> > 
> > Make this a generic test so that we can ensure that all filesystems
> > handle the case correctly. Test case originally worked out and
> > written by Brian Foster.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/generic/031     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/031.out | 19 ++++++++++++++
> >  tests/generic/group   |  1 +
> >  3 files changed, 93 insertions(+)
> >  create mode 100644 tests/generic/031
> >  create mode 100644 tests/generic/031.out
> > 
> > diff --git a/tests/generic/031 b/tests/generic/031
> > new file mode 100644
> > index 0000000..7d615c0
> > --- /dev/null
> > +++ b/tests/generic/031
> > @@ -0,0 +1,73 @@
> > +#! /bin/bash
> > +# FS QA Test No. generic/031
> > +#
> > +# Test non-aligned writes against fcollapse to ensure that partial pages are
> > +# correctly written and aren't left behind causing invalidation or data
> > +# corruption issues.

Note the test already documents what the problem it is trying to
expose in it's description....

......
> > +$XFS_IO_PROG -f \
> > +	-c "pwrite 185332 55756" \
> > +	-c "fcollapse 28672 40960" \
> > +	-c "pwrite 133228 63394" \
> > +	-c "fcollapse 0 4096" \
> > +$testfile | _filter_xfs_io
> > +
> 
> A comment (or per-line comments as in the other tests) would be good
> here to explain what's going on. E.g.:
> 
> # This sequence of operations exploits a known failure to handle partial
> # page writeback on sub page sized fsb filesystems. This occurs when a
> # page has a non-contiguous mix of dirty and clean blocks (e.g., dirty
> # block, clean block, dirty block, ...).
> #
> # The first write and collapse creates a dirty range in the file,
> # flushes and truncates the file down to an unaligned boundary. The
> # truncate implicit in the collapse dirties a block somewhere in the 2nd
> # half of the new EOF page. The second write creates more dirty data,
> # but specifically only writes to the first few bytes of the EOF page.
> # This and the previous truncate creates the mixed page state described
> # above.
> #
> # The final collapse attempts to flush and invalidate the entire cached
> # set for the file. If the writeback of the mixed page does not
> # complete, the invalidate fails with -EBUSY upon hitting a dirty page
> # and aborts the collapse.

Details of how XFS failed really aren't relevant to the test case -
that belongs in the commit message for the XFS fix.  The test case
simply needs to document is what condition the test is supposed to
be exercising. That's done in the intial test description, so
there's no need to duplicate it again.

> $XFS_IO_PROG -f \
> 	-c "pwrite 185332 55756"	# write extend file
> 	-c "fcollapse 28672 40960"	# collapse to unaligned boundary
> 	-c "pwrite 133228 63394"	# dirty first part of new eof page
> 	-c "fcollapse 0 4096"		# try a collapse
> $testfile | _filter_xfs_io

That's about as much as is necessary, I think.

> > +echo "==== Pre-Remount ==="
> > +hexdump -C $testfile
> > +_scratch_remount
> > +echo "==== Post-Remount =="
> > +hexdump -C $testfile
> > +
> 
> Note that this test is a collapse failure moreso than the data
> corruption error (e.g., collapse returns EBUSY), though the reason
> for that occurrence (data sync failure) is certainly a data
> corruption issue. The hexdump/remount checks are fine, I just want
> to clarify that they aren't necessary and they will probably just
> reflect the fact that the collapse failed. I think the comment is
> sufficient to provide that context and avoid any confusion.

Again, this focuses on the specific XFS failure. How XFS failed is
mostly irrelevant - we know that ext4 had a similar problem that
showed up as data corruption and not a syscall failure. Further, now
that we've fixed the XFS problem that lead to syscall failure we
still need to check that we are actually writing the data correctly.

Simply put: a test doesn't care what the failure is, it just needs to
verify the functionality is operating correctly. And for a data
manipulation operation, checking that data isn't corrupted is a
pretty important check to make. ;)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
