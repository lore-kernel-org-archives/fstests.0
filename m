Received: from userp2120.oracle.com ([156.151.31.85]:54906 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfC1Pbw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Mar 2019 11:31:52 -0400
Date: Thu, 28 Mar 2019 08:31:46 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] Fix fsx errors due to unsupported FIDEDUPERANGE
Message-ID: <20190328153146.GE6537@magnolia>
References: <20190328105119.31257-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328105119.31257-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 28, 2019 at 11:51:19AM +0100, Jan Kara wrote:
> Older kernels (prior commit 494633fac7896 "vfs: vfs_dedupe_file_range()
> doesn't return EOPNOTSUPP") will return EINVAL when operation is not
> supported. Make fsx treat this error as a sign of unsupported
> deduplication as well to make it usable with these older kernels.

Bleh, I forgot about that age-old quirk...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D


> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  ltp/fsx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index f4a1c7cf820b..391824bfbc68 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1482,7 +1482,8 @@ test_dedupe_range(void)
>  	else
>  		error = 0;
>  
> -	if (error == EOPNOTSUPP || error == ENOTTY) {
> +	/* Older kernels may return EINVAL... */
> +	if (error == EOPNOTSUPP || error == ENOTTY || error == EINVAL) {
>  		if (!quiet)
>  			fprintf(stderr,
>  				"main: filesystem does not support "
> -- 
> 2.16.4
> 
