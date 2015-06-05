Received: from mx1.redhat.com ([209.132.183.28]:37525 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566AbbFED2x (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 4 Jun 2015 23:28:53 -0400
Date: Fri, 5 Jun 2015 11:28:50 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/324: fix small typos in comment
Message-ID: <20150605032850.GQ3672@dhcp-13-216.nay.redhat.com>
References: <1433464449-21027-1-git-send-email-shhuiw@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433464449-21027-1-git-send-email-shhuiw@foxmail.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Sheng-Hui <shhuiw@foxmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 05, 2015 at 08:34:09AM +0800, Wang Sheng-Hui wrote:
> Fix some spelling mistakes in the comment.

I'd recommend you fix all comment typos in one patch, as the one in
generic/288 and this one and any other spelling errors in comments. I'm
sure you can find more :)

Thanks,
Eryu
> 
> Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>
> ---
>  tests/generic/324 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/324 b/tests/generic/324
> index 5e642dc..ac2ae8b 100755
> --- a/tests/generic/324
> +++ b/tests/generic/324
> @@ -61,7 +61,7 @@ _workout()
>  	# Fill holes for half of range , as result file will contain nr*1.5 fragments
>  	$XFS_IO_PROG -c "falloc 0 $((204800*nr))"  \
>  	    $SCRATCH_MNT/test.$nr | _filter_xfs_io
> -	# Data wrilte will convert extetns to inialized ones
> +	# Data write will convert extents to initialized ones
>  	for ((i=0;i<nr;i++))
>  	do
>  		patt=`printf "0x%x" $i`
> -- 
> 1.8.3.2
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
