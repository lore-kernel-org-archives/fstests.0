Received: from mx1.redhat.com ([209.132.183.28]:56104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdAPIUs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Jan 2017 03:20:48 -0500
Date: Mon, 16 Jan 2017 16:20:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] common/rc: Fix _supports_filetype function
Message-ID: <20170116082047.GF1859@eguan.usersys.redhat.com>
References: <20170116072352.GE1859@eguan.usersys.redhat.com>
 <1484554040-4231-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484554040-4231-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 16, 2017 at 04:07:20PM +0800, Xiao Yang wrote:
> generic/401 failed on RHEL6.8GA because "--output=xxx"
> option is not supported by df.  So we remove it.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 892c46e..87ef849 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -268,14 +268,14 @@ _supports_filetype()
>  {
>  	local dir=$1
>  
> -	local fstyp=$(df --output=fstype $dir | tail -1)
> +	local fstyp=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $2}'`
>  	case "$fstyp" in
>  	xfs)
>  		xfs_info $dir | grep -q "ftype=1"
>  		;;
>  	ext2|ext3|ext4)
> -		tune2fs -l $(df --output=source $dir | tail -1) | \
> -		   grep -q filetype
> +		local mntdir=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $1}'`
                      ^^^^^^ this actually is the underlying device

I'll rename it to "dev" on commit.

Thanks,
Eryu

> +		tune2fs -l $mntdir | grep -q filetype
>  		;;
>  	*)
>  		local testfile=$dir/$$.ftype
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
