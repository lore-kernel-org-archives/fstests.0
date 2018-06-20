Received: from userp2130.oracle.com ([156.151.31.86]:47708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFTDaj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 23:30:39 -0400
Date: Tue, 19 Jun 2018 20:30:29 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] src/t_stripealign.c: Fix complier error
Message-ID: <20180620033029.GA4850@magnolia>
References: <1529464320-6721-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529464320-6721-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 20, 2018 at 11:12:00AM +0800, Xiao Yang wrote:
> The FIEMAP_EXTENT_SHARED flag was added into kernel since commit
> 8c0414cd524e, so undefined FIEMAP_EXTENT_SHARED resulted in complier
> error on old distros(e.g. RHEL6), as below:
> ----------------------------------------------------------------------
> t_stripealign.c:99: error: 'FIEMAP_EXTENT_SHARED' undeclared (first use in this function)
> ----------------------------------------------------------------------
> 
> We fix it by defining the flag manually.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Oops, yeah, sorry about that.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  src/t_stripealign.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/src/t_stripealign.c b/src/t_stripealign.c
> index 690f743..2685d97 100644
> --- a/src/t_stripealign.c
> +++ b/src/t_stripealign.c
> @@ -20,6 +20,10 @@
>  #include <linux/fiemap.h>
>  #include <linux/fs.h>
>  
> +#ifndef FIEMAP_EXTENT_SHARED
> +# define FIEMAP_EXTENT_SHARED	0x00002000
> +#endif
> +
>  #define FIEMAP_EXTENT_ACCEPTABLE	(FIEMAP_EXTENT_LAST | \
>  		FIEMAP_EXTENT_DATA_ENCRYPTED | FIEMAP_EXTENT_ENCODED | \
>  		FIEMAP_EXTENT_UNWRITTEN | FIEMAP_EXTENT_MERGED | \
> -- 
> 1.7.1
> 
> 
> 
