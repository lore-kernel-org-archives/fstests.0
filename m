Received: from aserp1040.oracle.com ([141.146.126.69]:51330 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdIRVKr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Sep 2017 17:10:47 -0400
Date: Mon, 18 Sep 2017 14:10:42 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: xfs/310: relax extent count check
Message-ID: <20170918211042.GA6533@magnolia>
References: <20170903155101.GA30258@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170903155101.GA30258@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 03, 2017 at 05:51:01PM +0200, Christoph Hellwig wrote:
> If we got over the bmbt length we'll always allocate two extents,
> its just that so far getbmap merged them.
> 
> Also fix/update some comments.
> 
> diff --git a/tests/xfs/310 b/tests/xfs/310
> index c78f6f1..f33a15a 100755
> --- a/tests/xfs/310
> +++ b/tests/xfs/310
> @@ -1,7 +1,7 @@
>  #! /bin/bash
>  # FS QA Test No. 310
>  #
> -# Create a file with more than 2^21 extents (the max length of a bmbt record).
> +# Create a file with more than 2^21 blocks (the max length of a bmbt record).
>  #
>  #-----------------------------------------------------------------------
>  # Copyright (c) 2016, Oracle and/or its affiliates.  All Rights Reserved.
> @@ -75,8 +75,9 @@ mkdir $testdir
>  blksz="$(_get_block_size $testdir)"
>  $XFS_IO_PROG -f -c "falloc 0 $((nr_blks * blksz))" $testdir/file1 >> $seqres.full
>  
> +# make sure the allocator didn't allocate more than the needed two extents
>  echo "Check extent count"
> -xfs_bmap -l -p -v $testdir/file1 | grep '^[[:space:]]*1:' -q && xfs_bmap -l -p -v $testdir/file1
> +xfs_bmap -l -p -v $testdir/file1 | grep '^[[:space:]]*2:' -q && xfs_bmap -l -p -v $testdir/file1

I haven't had time to read the getbmap rework over in xfs-land yet, but
I'm assuming from this diff that the new getbmap no longer merges adjacent
records?

Also, won't this break the test on old kernels?

--D

>  inum=$(stat -c '%i' $testdir/file1)
>  umount $SCRATCH_MNT
>  
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
