Received: from mx1.redhat.com ([209.132.183.28]:38924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdAPHXx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Jan 2017 02:23:53 -0500
Date: Mon, 16 Jan 2017 15:23:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/rc: use $FSTYP and $SCRATCH_DEV in
 _supports_filetype function
Message-ID: <20170116072352.GE1859@eguan.usersys.redhat.com>
References: <1484548819-4295-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484548819-4295-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 16, 2017 at 02:40:19PM +0800, Xiao Yang wrote:
> generic/401 failed on RHEL6.8GA because output option is not
> supported by df.  So we use $FSTYP and $SCRATCH_DEV instead of
> df --output to fix it.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 892c46e..90ad496 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -268,14 +268,12 @@ _supports_filetype()
>  {
>  	local dir=$1
>  
> -	local fstyp=$(df --output=fstype $dir | tail -1)
> -	case "$fstyp" in
> +	case $FSTYP in

$FSTYP can't be used directly in this function, because it's also used
to detect the fstype of upperfs of overlayfs in overlay testing, in
which case FSTYP is overlay. See _overlay_mount().

Just remove "--output=xxx" option and parse the output, e.g.

local fstyp=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $2}'`

Note that $DF_PROG is defined as "df -T -P", which prints the fstyp
field.

>  	xfs)
>  		xfs_info $dir | grep -q "ftype=1"
>  		;;
>  	ext2|ext3|ext4)
> -		tune2fs -l $(df --output=source $dir | tail -1) | \
> -		   grep -q filetype
> +		tune2fs -l $SCRATCH_DEV | grep -q filetype

Same here, $SCRATCH_DEV doesn't fit.

Thanks,
Eryu

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
