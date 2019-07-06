Received: from userp2130.oracle.com ([156.151.31.86]:44486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGFPgL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 6 Jul 2019 11:36:11 -0400
Date: Sat, 6 Jul 2019 08:35:57 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/449: test xfs_info on a mounted block device
Message-ID: <20190706153557.GE5167@magnolia>
References: <20190706145217.13336-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706145217.13336-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jul 06, 2019 at 10:52:17PM +0800, Zorro Lang wrote:
> There was a bug, xfs_info fails on a mounted block device:
> 
>   # xfs_info /dev/mapper/testdev
>   xfs_info: /dev/mapper/testdev contains a mounted filesystem
> 
>   fatal error -- couldn't initialize XFS library
> 
>   xfsprogs has fixed it by:
> 
>     bbb43745 xfs_info: use findmnt to handle mounted block devices
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/449 | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/449 b/tests/xfs/449
> index 6a031685..7aae1545 100755
> --- a/tests/xfs/449
> +++ b/tests/xfs/449
> @@ -60,10 +60,15 @@ echo GROWFS >> $seqres.full
>  cat $tmp.growfs >> $seqres.full
>  diff -u $tmp.mkfs $tmp.growfs
>  
> -$XFS_INFO_PROG $SCRATCH_MNT > $tmp.info
> -echo INFO >> $seqres.full
> -cat $tmp.info >> $seqres.full
> -diff -u $tmp.mkfs $tmp.info
> +$XFS_INFO_PROG $SCRATCH_MNT > $tmp.info.mnt
> +echo INFO_MNT >> $seqres.full
> +cat $tmp.info.mnt >> $seqres.full
> +diff -u $tmp.mkfs $tmp.info.mnt
> +
> +$XFS_INFO_PROG $SCRATCH_DEV > $tmp.info.dev
> +echo INFO_DEV >> $seqres.full
> +cat $tmp.info.dev >> $seqres.full
> +diff -u $tmp.mkfs $tmp.info.dev
>  
>  echo "Silence is golden."
>  status=0
> -- 
> 2.17.2
> 
