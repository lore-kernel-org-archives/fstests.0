Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:42212 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754298AbbHRW24 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 18 Aug 2015 18:28:56 -0400
Date: Wed, 19 Aug 2015 08:28:32 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
Message-ID: <20150818222832.GF3902@dastard>
References: <1439918511-2859-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439918511-2859-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
> The below command in "Test 4":
> 
>     xfs_io -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512"
> 
> will run failed on 4k sector drives. So I use min_alignment size
> to replace the hard-code 512.
> 
> Also I make sure the blksize won't less than min_alignment size,
> after blksize=`expr $pgsize / 8`.
> 
> If blksize really less than min_alignment size, I set blksize =
> min_alignment size, and for sure the consistency of test result,
> I repair pgsize(already not real page size) number according to
> the new blksize.
> 
> Because IRIX can't use _min_dio_alignment(), so remove it from
> supported os list.

Not true - that's what the 'feature -s' branch in
_min_dio_alignment() is supposed to be for. Just add another check
for "$HOSTOS" == "Linux"....


> At last, make the crc flag be disabled only when blksize=512.

That makes things unnecessarily complex. I'd prefer to leave it as
it is (i.e. with -m crc=0), as CRCs do not affect what is being
tested at all.

> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/xfs/194 | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/194 b/tests/xfs/194
> index e11b459..4491dd4 100755
> --- a/tests/xfs/194
> +++ b/tests/xfs/194
> @@ -42,7 +42,7 @@ _cleanup()
>  
>  # only xfs supported due to use of xfs_bmap
>  _supported_fs xfs
> -_supported_os IRIX Linux
> +_supported_os Linux
>  
>  # real QA test starts here
>  rm -f $seqres.full
> @@ -50,6 +50,16 @@ rm -f $seqres.full
>  # For this test we use block size = 1/8 page size
>  pgsize=`$here/src/feature -s`
>  blksize=`expr $pgsize / 8`
> +secsize=`_min_dio_alignment $SCRATCH_DEV`
> +
> +# The minimal blksize can't less than sector size, So if
> +# blksize < secsize, we should adjust blksize and pgsize number.
> +# Of course, if we adjust pgsize, pgsize won't equal to the
> +# real page size of system.
> +if [ $blksize -lt $secsize ];then
> +        blksize=$secsize
> +        pgsize=`expr $blksize \* 8`
> +fi

No, this is wrong. the page size stays fixed at the machine page
size. We are testing *sub-page block sizes* here and the sector size
must be <= page size. Increasing the "page size" to larger than the
machine page size does not make the kernel use larger page sizes.

IOWs, if you've got sector size = page size (e.g. 4k sector device)
then no matter what you say $pgsize is, the kernel will see a block
size = page size test.

This whole chunk of code can simply be replaced with:

blksize=`_min_dio_alignment $SCRATCH_DEV`

Because that's what we actually need to test...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
