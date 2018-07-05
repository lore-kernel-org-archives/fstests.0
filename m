Received: from userp2130.oracle.com ([156.151.31.86]:55676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeGEECT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Jul 2018 00:02:19 -0400
Date: Wed, 4 Jul 2018 21:02:12 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH ] xfs/262: remove -y parameter
Message-ID: <20180705040212.GC5703@magnolia>
References: <1530754623-2694-1-git-send-email-liuyd.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530754623-2694-1-git-send-email-liuyd.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 05, 2018 at 09:37:03AM +0800, Liu Yiding wrote:
> Since commit 66f7b4c2ce14 ("xfs_scrub: remove -y parameter") has removed parameter -y, -y is an invalid option.
> 
> Signed-off-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>

Good catch!

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/262 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/262 b/tests/xfs/262
> index 6c39268..b109f93 100755
> --- a/tests/xfs/262
> +++ b/tests/xfs/262
> @@ -48,7 +48,7 @@ done
>  LD_LIBRARY_PATH=$SCRATCH_MNT $LDD_PROG $SCRATCH_MNT/xfs_scrub >> $seqres.full
>  
>  echo "Force online repairs"
> -XFS_SCRUB_FORCE_REPAIR=1 LD_LIBRARY_PATH=$SCRATCH_MNT $SCRATCH_MNT/xfs_scrub -dTvy $SCRATCH_MNT >> $seqres.full
> +XFS_SCRUB_FORCE_REPAIR=1 LD_LIBRARY_PATH=$SCRATCH_MNT $SCRATCH_MNT/xfs_scrub -dTv $SCRATCH_MNT >> $seqres.full
>  
>  # success, all done
>  status=0
> -- 
> 2.7.4
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
