Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47731 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176AbbE2CvI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 28 May 2015 22:51:08 -0400
Date: Fri, 29 May 2015 10:51:05 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs: tests extent size hint size overflows
Message-ID: <20150529025104.GM3672@dhcp-13-216.nay.redhat.com>
References: <1432694617-23525-1-git-send-email-david@fromorbit.com>
 <20150527033404.GE3672@dhcp-13-216.nay.redhat.com>
 <20150529012031.GD4316@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150529012031.GD4316@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 29, 2015 at 11:20:31AM +1000, Dave Chinner wrote:
> On Wed, May 27, 2015 at 11:34:04AM +0800, Eryu Guan wrote:
> > On Wed, May 27, 2015 at 12:43:37PM +1000, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > in certain cases, the extent size hints can cause maximum extent
> > > size overflows resulting in extent tree corruptions. This test
> > > exercises the original reproducer, and another corner case
> > > demonstrated to expose problems on 1k block size filesystems.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ....
> > > +rm -f $seqres.full
> > > +
> > > +_require_test
> > > +_require_xfs_io_command "falloc"
> > > +
> > > +# we use loop devices for this so that we can create large files for prealloc
> > > +# without having to care about the underlying device size.
> > > +_require_loop
> > > +
> > > +LOOP_FILE=$TESTDIR/$seq.img
> > > +LOOP_MNT=$TESTDIR/$seq.mnt
> > 
> > This should be $TEST_DIR, TESTDIR is empty and ends up in /074.mnt
> 
> Oops, will fix.
> 
> > > +mkdir -p $LOOP_MNT
> > > +$XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE 2>&1 > $seqres.full
> > 
> > This will leave stderr to stdout, then only stdout goes to $seqres.full
> > I see "+ fallocate: No space left on device" when testing.
> 
> Why would the truncate command give an "fallocate" failure?

Oh, I mean at the "falloc" time, I should refer to the next xfs_io
command below..

> 
> And, besides, allowing stderr to be exposed is done on purpose - an
> error in the execution of the truncate command will trigger a test
> failure because stderr is captured by the test harness...

Then I think a comment should be added, because "2>&1 >$seqres.full" is
not a usual usage, usually it indicates a programming mistake. Or just
">$seqres.full" and leave stderr untouched? which indicates clearly we
leave stderr unfiltered on purpose.

> 
> > "command >$seqres.full 2>&1" will do the work.
> > 
> > > +LOOP_DEV=`_create_loop_device $LOOP_FILE`
> > > +
> > > +_mkfs_dev -d size=40051712b,agcount=4 -l size=32m $LOOP_DEV
> > > +_mount $LOOP_DEV $LOOP_MNT
> > > +
> > > +# Corrupt the BMBT by creating extents larger than MAXEXTLEN
> > > +$XFS_IO_PROG -ft \
> > > +	-c "extsize 16m" \
> > > +	-c "falloc 0 30g" \
> > > +	$LOOP_MNT/foo 2>&1 > $seqres.full

The "+ fallocate: No space left on device" error comes from this
command. Is this on purpose too? So on patched kernel the error
shouldn't be there?

Thanks,
Eryu
