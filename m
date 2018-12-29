Received: from mail-pf1-f195.google.com ([209.85.210.195]:37814 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeL2IQ0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Dec 2018 03:16:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so11380366pfb.4
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 00:16:25 -0800 (PST)
Date: Sat, 29 Dec 2018 16:16:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 5/5] fsx: check ENOSYS in test_copy_range()
Message-ID: <20181229081619.GH21777@desktop>
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

Should we also check for ENOSYS in other operations like
{clone,dedupe}_range and fallocate?

Other fixes look good to me, thanks a lot for the fixes!

Thanks,
Eryu

>  		if (!quiet)
>  			fprintf(stderr,
>  				"main: filesystem does not support "
> -- 
> 2.16.2.dirty
> 
