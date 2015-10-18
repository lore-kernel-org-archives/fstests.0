Received: from imap.thunk.org ([74.207.234.97]:57890 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbbJRWII (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 18 Oct 2015 18:08:08 -0400
Date: Sun, 18 Oct 2015 18:08:05 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: introduce XFS_IO_AVOID env var
Message-ID: <20151018220805.GN2678@thunk.org>
References: <1445107518-32022-1-git-send-email-tytso@mit.edu>
 <20151018213745.GX27164@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151018213745.GX27164@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 19, 2015 at 08:37:45AM +1100, Dave Chinner wrote:
> On Sat, Oct 17, 2015 at 02:45:18PM -0400, Theodore Ts'o wrote:
> > Like FSSTRESS_AVOID and FSX_AVOID, XFS_IO_AVOID can be used to avoid
> > using various advanced file system features such as "fpunch"
> > "fcollapse", "finsert", or "zero".  Tests that require an xfs_io
> > command which is included in the space-separated list found in the
> > XFS_IO_AVOID environment variable will be skipped using _notrun.
> 
> This tells me what the change does, not why you need it.

We didn't go into as much detail for FSX_AVOID and FSSTRESS_AVOID, but
it's basically for the same reason.  Sometimes we might want to
exclude certain operational modes from the xfststs.

As one example, currently xfstests doesn't understand the difference
between the allocation cluster size and the block size.  In the case
of collapse/insert range, it means operations need to be done in
cluster-aligned chunks, as opposed to block-aligned clusters.  So to
suppress test noise it's nice if we can suppress all attempts to use
insert_range/collapse_range while running a test --- and using
FSX_AVOID and FSSTRESS_AVOID isn't sufficient for this purpose.

(As you may recall, I while back had a test patch allowed the file
system to claim that it doesn't support collapse or insert range, and
you and Eric argued that the right way to handle this was using
environment variables like FSX_AVOID and FSSTRESS_AVOID to cause
xfstests to avoid to use certain fallocate operational modes.
XFS_IO_AVOID is basically an extension of that same functionality.
Without this, hacking the kernel to always fail certain fallocate mode
is still needed in order to force certain tests to be skipped.)

As another example, recently I was trying to debug a memory leak, both
on the most recent version of the kernel, as well as old stable
kernels, and it's very useful to be able to see if a particular bug
might be caused by say, buggy collapse range support.

So I wanted to be able to suppress all use of collapse range by being
able to do something as simple as "gce-xfstests --no-collapse".  This
gets expanded to setting the FSX_AVOID, FSSTRESS_AVOID, and
XFS_IO_AVOID environment variables.

This way it becomes easier to see if certain test failures go away if
an fallocate operational mode is suppressed --- and hence, allows us
to localize the failure to collapse_range or insert_range.

Cheers,

							- Ted
