Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:59861 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751038AbcI2G3y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Sep 2016 02:29:54 -0400
Date: Thu, 29 Sep 2016 16:29:51 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] xfs/287: fix wrong seq number in test
Message-ID: <20160929062951.GO9806@dastard>
References: <1475034250-6909-1-git-send-email-eguan@redhat.com>
 <1475034250-6909-2-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475034250-6909-2-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 28, 2016 at 11:44:10AM +0800, Eryu Guan wrote:
> It's 287 not 285.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Easy to miss when moving tests manually. Fix looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

> ---
>  tests/xfs/287 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/287 b/tests/xfs/287
> index aca410a..766c91e 100755
> --- a/tests/xfs/287
> +++ b/tests/xfs/287
> @@ -1,5 +1,5 @@
>  #! /bin/bash
> -# FS QA Test No. 285
> +# FS QA Test No. 287
>  #
>  # Test to verify project quota xfs_admin, xfsdump/xfsrestore and
>  # xfs_db functionality
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
