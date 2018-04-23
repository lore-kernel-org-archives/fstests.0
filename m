Received: from userp2120.oracle.com ([156.151.31.85]:45786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeDWFky (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Apr 2018 01:40:54 -0400
Date: Sun, 22 Apr 2018 22:40:48 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/rc: move rm out from if block to always delete
 kmemleak temp file
Message-ID: <20180423054048.GA26261@magnolia>
References: <8a5faeaa-e053-ab1b-4712-edec8d32fd93@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a5faeaa-e053-ab1b-4712-edec8d32fd93@jp.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 23, 2018 at 02:23:14PM +0900, Misono Tomohiro wrote:
> Otherwise, *.kmemleak.tmp may remain in result folder if kmemleak is on.
> 
> Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 366489bb..0c3359fd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3515,8 +3515,8 @@ EXPERIMENTAL kmemleak reported some memory leaks!  Due to the way kmemleak
>  works, the leak might be from an earlier test, or something totally unrelated.
>  ENDL
>  		cat "$leak_file.tmp" >> "$leak_file"
> -		rm -rf "$leak_file.tmp"
>  	fi
> +	rm -rf "$leak_file.tmp"
>  	echo "clear" > "$kern_knob"
>  }
>  
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
