Received: from userp2120.oracle.com ([156.151.31.85]:48352 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBVC2E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Feb 2018 21:28:04 -0500
Date: Wed, 21 Feb 2018 18:28:00 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/25[02]: increase filesystem size
Message-ID: <20180222022800.GC14582@magnolia>
References: <20180222003203.20231-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222003203.20231-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 22, 2018 at 11:32:03AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> On reflink+rmapbt XFs filesystems there isn't enough free space to
> run this test on the 64MB filesystem image created. It notruns with
> a curious error message - needs at least 0GB free:
> 
> generic/250             [10:01:57] [10:01:58] [not run]
>         generic/250 -- This test requires at least 0GB free on /mnt/scratch to run

TBH I think someone ought to fix that to spit out MB if < 1024M, but
that's a different patch.

Worksforme,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> Fix this by increasing the size of the base filesystem image.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/250 | 6 +++---
>  tests/generic/252 | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/250 b/tests/generic/250
> index a8fd97e31ff0..6b0f7e3126af 100755
> --- a/tests/generic/250
> +++ b/tests/generic/250
> @@ -54,10 +54,10 @@ _require_no_rtinherit
>  
>  rm -f $seqres.full
>  
> -
> +fssize=$((100 * 1048576))
>  echo "Format and mount"
> -$XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $((64 * 1048576))" $SCRATCH_DEV >> $seqres.full
> -_scratch_mkfs_sized $((64 * 1048576)) > $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
> +_scratch_mkfs_sized $fssize > $seqres.full 2>&1
>  _dmerror_init
>  _dmerror_mount >> $seqres.full 2>&1
>  _dmerror_unmount
> diff --git a/tests/generic/252 b/tests/generic/252
> index b506d599f638..e102945d83b7 100755
> --- a/tests/generic/252
> +++ b/tests/generic/252
> @@ -56,9 +56,10 @@ AIO_TEST="src/aio-dio-regress/aiocp"
>  rm -f $seqres.full
>  
>  
> +fssize=$((100 * 1048576))
>  echo "Format and mount"
> -$XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $((64 * 1048576))" $SCRATCH_DEV >> $seqres.full
> -_scratch_mkfs_sized $((64 * 1048576)) > $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
> +_scratch_mkfs_sized $fssize > $seqres.full 2>&1
>  _dmerror_init
>  _dmerror_mount >> $seqres.full 2>&1
>  _dmerror_unmount
> -- 
> 2.16.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
