Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:40673 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753342AbbHRWnx (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 18 Aug 2015 18:43:53 -0400
Date: Wed, 19 Aug 2015 08:43:51 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
Message-ID: <20150818224351.GG3902@dastard>
References: <1439918511-2859-1-git-send-email-zlang@redhat.com>
 <20150818222832.GF3902@dastard>
 <55D3B2A1.2020307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55D3B2A1.2020307@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 18, 2015 at 05:33:05PM -0500, Eric Sandeen wrote:
> On 8/18/15 5:28 PM, Dave Chinner wrote:
> > On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
> >> @@ -50,6 +50,16 @@ rm -f $seqres.full
> >>  # For this test we use block size = 1/8 page size
> >>  pgsize=`$here/src/feature -s`
> >>  blksize=`expr $pgsize / 8`
> >> +secsize=`_min_dio_alignment $SCRATCH_DEV`
> >> +
> >> +# The minimal blksize can't less than sector size, So if
> >> +# blksize < secsize, we should adjust blksize and pgsize number.
> >> +# Of course, if we adjust pgsize, pgsize won't equal to the
> >> +# real page size of system.
> >> +if [ $blksize -lt $secsize ];then
> >> +        blksize=$secsize
> >> +        pgsize=`expr $blksize \* 8`
> >> +fi
> > 
> > No, this is wrong. the page size stays fixed at the machine page
> > size. We are testing *sub-page block sizes* here and the sector size
> > must be <= page size. Increasing the "page size" to larger than the
> > machine page size does not make the kernel use larger page sizes.
> > 
> > IOWs, if you've got sector size = page size (e.g. 4k sector device)
> > then no matter what you say $pgsize is, the kernel will see a block
> > size = page size test.
> > 
> > This whole chunk of code can simply be replaced with:
> > 
> > blksize=`_min_dio_alignment $SCRATCH_DEV`
> > 
> > Because that's what we actually need to test...
> 
> That won't work either, because we could easily get 512 from that.

If 'blockdev --getss $dev' returns 512, then the device supports 512
byte IOs and so it is fine to do 512 byte IOs in the test.

> and then this test:
> 
> # Now try the same thing but write a sector in the middle of that hole
> # If things go badly stale data will be exposed either side.
> # This is most interesting for block size > 512 (page size > 4096)
> 
> # We *should* get:
> # |1100|HHHH|33HH|HHHH|2222|----|----|----|
> 
> echo "== Test 4 =="
> xfs_io \
> -c "pwrite -S 0x11 -b $pgsize 0 $pgsize" \
> -c "mmap -r 0 $blksize" -c "mread 0 $blksize" -c "munmap" \
> -c "truncate `expr $blksize / 2`" \
> -c "truncate `expr $blksize + 1`" \
> -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
> -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
> -t -d -f $SCRATCH_MNT/testfile4 >> $seqres.full
> 
> will be impossible.
> 
> AFAICT everything works except for that explicit 512-byte IO.

Right. That hard coded 512 needs to change to $blksize, because
blksize is now equal to the sector size. I thought this would be
obvious to the reader, so I didn't comment on it.

> All we really need here is a sub-block-size IO, but at least as
> large as the logical sector size.

Yes. See above.

> So we want sub-page-size blocks, an sub-block-sized IOS (here).

Yes. See above.

> Can't be *that* tricky to work out the scaling for various pages
> and sector sizes, I hope? :)  Famous last words!

It's not. See above. :)

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
