Received: from userp1040.oracle.com ([156.151.31.81]:39391 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbcJIVE4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Oct 2016 17:04:56 -0400
Date: Sun, 9 Oct 2016 14:04:45 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic: make 17[1-4] work well when btrfs compression
 is enabled
Message-ID: <20161009042333.GA5609@birch.djwong.org>
References: <20161007070042.12258-1-wangxg.fnst@cn.fujitsu.com>
 <20161007143610.GX27872@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161007143610.GX27872@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 08, 2016 at 01:36:10AM +1100, Dave Chinner wrote:
> On Fri, Oct 07, 2016 at 03:00:42PM +0800, Wang Xiaoguang wrote:
> > When enabling btrfs compression, original codes can not fill fs
> > correctly, fix this.
> > 
> > Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> > ---
> >  tests/generic/171 | 4 +---
> >  tests/generic/172 | 2 +-
> >  tests/generic/173 | 4 +---
> >  tests/generic/174 | 4 +---
> >  4 files changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tests/generic/171 b/tests/generic/171
> > index f391685..d2ae8e4 100755
> > --- a/tests/generic/171
> > +++ b/tests/generic/171
> > @@ -75,9 +75,7 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
> >  sync
> >  
> >  echo "Allocate the rest of the space"
> > -nr_free=$(stat -f -c '%f' $testdir)
> > -touch $testdir/file0 $testdir/file1

Why remove this line which ensures that the inode we're going to use (file1)
later in the test has been allocated /before/ we try to eat all the space?

> > -_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
> > +dd if=/dev/zero of=$testdir/eat_my_space >> $seqres.full 2>&1

Uh... isn't a bunch of zeroes just as compressible as 0x61?  I suppose
the point here is to write until write returns ENOSPC, since in btrfs
land we can't assume that writing $nr blocks will use up at least that
much space.

Does XFS reflink still pass this test with this patch?

> Please don't replace xfs_io writes using a specific data pattern
> with dd calls that write zeros. Indeed, we don't use dd for new
> tests anymore - xfs_io should be used.
> 
> Write a function that fills all the remaining free space (one may
> already exist) and call it in all these places.

Yeah, there already are a few of these...

--D

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
