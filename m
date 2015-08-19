Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:5945 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750923AbbHSCmT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 18 Aug 2015 22:42:19 -0400
Date: Wed, 19 Aug 2015 12:42:16 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
Message-ID: <20150819024216.GH3902@dastard>
References: <1439918511-2859-1-git-send-email-zlang@redhat.com>
 <20150818222832.GF3902@dastard>
 <55D3B2A1.2020307@redhat.com>
 <20150818224351.GG3902@dastard>
 <55D3B9D1.6030609@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55D3B9D1.6030609@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 18, 2015 at 06:03:45PM -0500, Eric Sandeen wrote:
> On 8/18/15 5:43 PM, Dave Chinner wrote:
> > On Tue, Aug 18, 2015 at 05:33:05PM -0500, Eric Sandeen wrote:
> >> On 8/18/15 5:28 PM, Dave Chinner wrote:
> >>> On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
> >>>> @@ -50,6 +50,16 @@ rm -f $seqres.full
> >>>>  # For this test we use block size = 1/8 page size
> >>>>  pgsize=`$here/src/feature -s`
> >>>>  blksize=`expr $pgsize / 8`
> >>>> +secsize=`_min_dio_alignment $SCRATCH_DEV`
> >>>> +
> >>>> +# The minimal blksize can't less than sector size, So if
> >>>> +# blksize < secsize, we should adjust blksize and pgsize number.
> >>>> +# Of course, if we adjust pgsize, pgsize won't equal to the
> >>>> +# real page size of system.
> >>>> +if [ $blksize -lt $secsize ];then
> >>>> +        blksize=$secsize
> >>>> +        pgsize=`expr $blksize \* 8`
> >>>> +fi
> >>>
> >>> No, this is wrong. the page size stays fixed at the machine page
> >>> size. We are testing *sub-page block sizes* here and the sector size
> >>> must be <= page size. Increasing the "page size" to larger than the
> >>> machine page size does not make the kernel use larger page sizes.
> >>>
> >>> IOWs, if you've got sector size = page size (e.g. 4k sector device)
> >>> then no matter what you say $pgsize is, the kernel will see a block
> >>> size = page size test.
> >>>
> >>> This whole chunk of code can simply be replaced with:
> >>>
> >>> blksize=`_min_dio_alignment $SCRATCH_DEV`
> >>>
> >>> Because that's what we actually need to test...
> >>
> >> That won't work either, because we could easily get 512 from that.
> > 
> > If 'blockdev --getss $dev' returns 512, then the device supports 512
> > byte IOs and so it is fine to do 512 byte IOs in the test.
> > 
> >> and then this test:
> >>
> >> # Now try the same thing but write a sector in the middle of that hole
> >> # If things go badly stale data will be exposed either side.
> >> # This is most interesting for block size > 512 (page size > 4096)
> >>
> >> # We *should* get:
> >> # |1100|HHHH|33HH|HHHH|2222|----|----|----|
> >>
> >> echo "== Test 4 =="
> >> xfs_io \
> >> -c "pwrite -S 0x11 -b $pgsize 0 $pgsize" \
> >> -c "mmap -r 0 $blksize" -c "mread 0 $blksize" -c "munmap" \
> >> -c "truncate `expr $blksize / 2`" \
> >> -c "truncate `expr $blksize + 1`" \
> >> -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
> >> -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
> >> -t -d -f $SCRATCH_MNT/testfile4 >> $seqres.full
> >>
> >> will be impossible.
> >>
> >> AFAICT everything works except for that explicit 512-byte IO.
> > 
> > Right. That hard coded 512 needs to change to $blksize, because
> > blksize is now equal to the sector size. I thought this would be
> > obvious to the reader, so I didn't comment on it.
> 
> if that last IO is $blksize, and blocksize == sector size, then the
> test won't be testing what it's designed to test here, i.e. a
> sub-block direct IO write.

That's not what the test is exercising:

# Test mapping around/over holes for sub-page blocks

it's testing *sub-page block behaviour*, not sub-block direct IO.

> 
> # We *should* get:
> # |1100|HHHH|33HH|HHHH|2222|----|----|----|
>              ^^
>              this

That implies a sub-block sized direct IO, on a single page that has
8 blocks. On a 4k page size machine, that is impossible and so most
of the time we are not doing what the comment implies.

With a 4k page, 512 byte block size:

| xfs_io \
| -c "pwrite -S 0x11 -b $pgsize 0 $pgsize" \

Write an entire page (4k)

# |1111|1111|1111|1111|1111|1111|1111|1111|

| -c "mmap -r 0 $blksize" -c "mread 0 $blksize" -c "munmap" \

map the first block (0-511 bytes - one sector)

| -c "truncate `expr $blksize / 2`" \
| -c "truncate `expr $blksize + 1`" \

sub-block truncate down, sub-block truncate up, make sure page cache
is correctly zeroed.

# |1100|HHHH|----|----|----|----|----|----|

| -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \

DIO write of a single block half way through the original page, make
sure page cache is flushed correctly before DIO.

# |1100|HHHH|HHHH|HHHH|2222|----|----|----|

FWIW, this write will fail on a 4k sector device on a 4k page size
platform, because the IO is not sector aligned, and is why the
original patch needed to multiply pgsize out to 8 * sector size....

| -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \

do a -minimum sized write- to the *3rd* block in the page.

# |1100|HHHH|3333|HHHH|2222|----|----|----|

And that matches the expected output. We do not get this output with
a block size that is anything other than pgsize / 8, regardless of
whether the last write is a sub-block DIO or not.

IOWs, this test assumes that there are at least 8 blocks to page
because to exercise the appropriate paths it needs a hole between
each region that is written.  4k sector/4k page means the kernel
cannot do sub-page block size operations, and the test does not
exercise the code paths we're expecting it to. Hence it may simply
be best to do this:

if [ $sector_size > $page_size / 8 ]; then
	_not_run "sector size too large for platform page size"
fi

and replace the hard coded 512 with $sector_size.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
