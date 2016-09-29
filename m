Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:18567 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753509AbcI2G2d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Sep 2016 02:28:33 -0400
Date: Thu, 29 Sep 2016 16:28:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] generic/052: use _check_scratch_fs not _xfs_check
Message-ID: <20160929062819.GN9806@dastard>
References: <1475034250-6909-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475034250-6909-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 28, 2016 at 11:44:09AM +0800, Eryu Guan wrote:
> generic/052 was made generic from an xfs test, and generic functions
> should be used not the xfs-specific ones.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

> ---
>  tests/generic/052 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/052 b/tests/generic/052
> index a81885b..74cf5b6 100755
> --- a/tests/generic/052
> +++ b/tests/generic/052
> @@ -72,7 +72,7 @@ _print_logstate
>  
>  # curious if FS consistent at start
>  if false; then
> -    if _xfs_check $SCRATCH_DEV; then
> +    if _check_scratch_fs; then
>         echo "*** checked ok ***"
>      fi
>  fi
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Dave Chinner
david@fromorbit.com
