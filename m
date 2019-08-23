Received: from aserp2120.oracle.com ([141.146.126.78]:45788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389397AbfHWOhE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Aug 2019 10:37:04 -0400
Date: Fri, 23 Aug 2019 07:36:50 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] t_stripealign: Fix fibmap error handling
Message-ID: <20190823143650.GI1037350@magnolia>
References: <20190823092530.11797-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823092530.11797-1-cmaiolino@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Carlos Maiolino <cmaiolino@redhat.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 23, 2019 at 11:25:30AM +0200, Carlos Maiolino wrote:
> FIBMAP only returns a negative value when the underlying filesystem does
> not support FIBMAP or on permission error. For the remaining errors,
> i.e. those usually returned from the filesystem itself, zero will be
> returned.
> 
> We can not trust a zero return from the FIBMAP, and such behavior made
> generic/223 succeed when it should not.
> 
> Also, we can't use perror() only to print errors when FIBMAP failed, or
> it will simply print 'success' when a zero is returned.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  src/t_stripealign.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/t_stripealign.c b/src/t_stripealign.c
> index 5cdadaae..164831f8 100644
> --- a/src/t_stripealign.c
> +++ b/src/t_stripealign.c
> @@ -76,8 +76,11 @@ int main(int argc, char ** argv)
>  		unsigned int	bmap = 0;
>  
>  		ret = ioctl(fd, FIBMAP, &bmap);
> -		if (ret < 0) {
> -			perror("fibmap");
> +		if (ret <= 0) {
> +			if (ret < 0)
> +				perror("fibmap");
> +			else
> +				fprintf(stderr, "fibmap error\n");

"fibmap returned no result"?

--D

>  			free(fie);
>  			close(fd);
>  			return 1;
> -- 
> 2.20.1
> 
