Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:33488 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754169AbbE2BVG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 May 2015 21:21:06 -0400
Date: Fri, 29 May 2015 11:20:31 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: tests extent size hint size overflows
Message-ID: <20150529012031.GD4316@dastard>
References: <1432694617-23525-1-git-send-email-david@fromorbit.com>
 <20150527033404.GE3672@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150527033404.GE3672@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 27, 2015 at 11:34:04AM +0800, Eryu Guan wrote:
> On Wed, May 27, 2015 at 12:43:37PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > in certain cases, the extent size hints can cause maximum extent
> > size overflows resulting in extent tree corruptions. This test
> > exercises the original reproducer, and another corner case
> > demonstrated to expose problems on 1k block size filesystems.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
....
> > +rm -f $seqres.full
> > +
> > +_require_test
> > +_require_xfs_io_command "falloc"
> > +
> > +# we use loop devices for this so that we can create large files for prealloc
> > +# without having to care about the underlying device size.
> > +_require_loop
> > +
> > +LOOP_FILE=$TESTDIR/$seq.img
> > +LOOP_MNT=$TESTDIR/$seq.mnt
> 
> This should be $TEST_DIR, TESTDIR is empty and ends up in /074.mnt

Oops, will fix.

> > +mkdir -p $LOOP_MNT
> > +$XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE 2>&1 > $seqres.full
> 
> This will leave stderr to stdout, then only stdout goes to $seqres.full
> I see "+ fallocate: No space left on device" when testing.

Why would the truncate command give an "fallocate" failure?

And, besides, allowing stderr to be exposed is done on purpose - an
error in the execution of the truncate command will trigger a test
failure because stderr is captured by the test harness...

> "command >$seqres.full 2>&1" will do the work.
> 
> > +LOOP_DEV=`_create_loop_device $LOOP_FILE`
> > +
> > +_mkfs_dev -d size=40051712b,agcount=4 -l size=32m $LOOP_DEV
> > +_mount $LOOP_DEV $LOOP_MNT
> > +
> > +# Corrupt the BMBT by creating extents larger than MAXEXTLEN
> > +$XFS_IO_PROG -ft \
> > +	-c "extsize 16m" \
> > +	-c "falloc 0 30g" \
> > +	$LOOP_MNT/foo 2>&1 > $seqres.full
> 
> Here too, and should append to $seqres.full with ">>"

Will fix.

> 
> > +
> > +umount $LOOP_MNT
> > +_check_xfs_filesystem $LOOP_DEV none none
> 
> I think '_check_scratch_fs $LOOP_DEV' is eaiser, it accepts optional
> device argument to check and deal with SCRATCH_LOG and SCRATCH_RT
> internally.

But it's not the scratch device I'm using. i.e. it doesn't use
SCRATCH_LOG or SCRATCH_RT because I didn't use _scratch_mkfs to
create the filesystem, nor am I using _scratch_mount, so it would
fail to mount if mkfs used external devices....

> > --- /dev/null
> > +++ b/tests/xfs/074.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 074-extsz-hints-vs-maxextlen
> 
> This should be "QA output created by 074"

Hmm - the patch is stale then. That's strange, because I pulled it
from the git tree to my test machines, and they didn't fail. I'll
fix it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
