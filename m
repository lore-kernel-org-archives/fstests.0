Received: from userp2130.oracle.com ([156.151.31.86]:41890 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeL2Sxg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Dec 2018 13:53:36 -0500
Date: Sat, 29 Dec 2018 10:53:26 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 5/5] fsx: check ENOSYS in test_copy_range()
Message-ID: <20181229185326.GA20474@magnolia>
References: <20181229023452.28074-1-houtao1@huawei.com>
 <20181229023452.28074-6-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229023452.28074-6-houtao1@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Hou Tao <houtao1@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 29, 2018 at 10:34:52AM +0800, Hou Tao wrote:
> In configure script, we only check whether or not the build
> of copy-range test program is successful, but that doesn't
> mean the kernel has implemented the syscall, so checking
> for this case.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Err, oops.  Thanks for catching that!

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  ltp/fsx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 316f08eb..b84180f7 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1583,7 +1583,7 @@ test_copy_range(void)
>  	loff_t o1 = 0, o2 = 0;
>  
>  	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 0, 0) == -1 &&
> -	    (errno == EOPNOTSUPP || errno == ENOTTY)) {
> +	    (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
>  		if (!quiet)
>  			fprintf(stderr,
>  				"main: filesystem does not support "
> -- 
> 2.16.2.dirty
> 
