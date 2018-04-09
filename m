Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:18352 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751464AbeDIJvl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Apr 2018 05:51:41 -0400
Date: Mon, 9 Apr 2018 19:51:38 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: generic test for fsync after fallocate
Message-ID: <20180409095138.GU23861@dastard>
References: <20180405215614.611-1-fdmanana@kernel.org>
 <20180408020754.GA2932@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408020754.GA2932@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fdmanana@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Sun, Apr 08, 2018 at 10:07:54AM +0800, Eryu Guan wrote:
> On Thu, Apr 05, 2018 at 10:56:14PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Test that fsync operations preserve extents allocated with fallocate(2)
> > that are placed beyond a file's size.
> > 
> > This test is motivated by a bug found in btrfs where unwritten extents
> > beyond the inode's i_size were not preserved after a fsync and power
> > failure. The btrfs bug is fixed by the following patch for the linux
> > kernel:
> > 
> >  "Btrfs: fix loss of prealloc extents past i_size after fsync log replay"
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Hmm, xfs fails this test, while ext4 passes.
> 
> # diff -u tests/generic/483.out /root/workspace/xfstests/results//xfs_4k_crc/generic/483.out.bad
> --- tests/generic/483.out       2018-04-07 23:35:00.555555511 +0800
> +++ /root/workspace/xfstests/results//xfs_4k_crc/generic/483.out.bad    2018-04-07 23:39:48.780659707 +0800
> @@ -6,5 +6,5 @@
>  0: [0..511]: data
>  1: [512..2559]: unwritten
>  File baz fiemap:
> -0: [0..511]: data
> -1: [512..6143]: unwritten
> +0: [0..895]: data
> +1: [896..6143]: unwritten

Perfectly valid result from the test.

> > +# A file which already has a prealloc extent beyond its size.
> > +# The fsync done on it is motivated by differences in the btrfs implementation
> > +# of fsync (first fsync has different logic from subsequent fsyncs).
> > +$XFS_IO_PROG -f -c "pwrite -S 0xf1 0 256K" \
> > +	     -c "falloc -k 256K 768K" \
> > +	     -c "fsync" \
> > +	     $SCRATCH_MNT/baz >/dev/null

Delayed allocation extending the file to 256k means we'll have
speculative prealloc of data beyond 256k - it should be somewhere
around 448k IIRC.

Now, falloc doesn't guarantee unwritten extents are allocated - it
just guarantees space is allocated. unwritten extents are an
optimisation to avoid needing to zero the extents pre-allocated
within EOF. i.e. we can quite safely allocate data extents beyond
EOF rather than unwritten extents, and this is not a bug.

In this case, the delalloc extent is completely allocated as written
data, but nothing is written beyond EOF @ 256k.  Hence it reports as
a data extent, not an unwritten extent, and this is a perfectly
valid thing to do.

> > +# Allocate another extent beyond the size of file baz.
> > +$XFS_IO_PROG -c "falloc -k 1M 2M"\
> > +	     -c "fsync" \
> > +	     $SCRATCH_MNT/baz

You also cannot assume that two separate preallocations beyond EOF
are going to be contiguous (i.e. it could be two separate extents.

What you should just be checking is that there are extents allocated
covering EOF to 3MB, not the exactly size, shape and type of extents
are allocated.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
