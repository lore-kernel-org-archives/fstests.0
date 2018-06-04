Received: from aserp2120.oracle.com ([141.146.126.78]:53638 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFDPoZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jun 2018 11:44:25 -0400
Date: Mon, 4 Jun 2018 08:44:16 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/rc: Fix _require_xfs_io_command for scrub probe
Message-ID: <20180604154416.GB6086@magnolia>
References: <20180604045436.GN6581@desktop>
 <1528087812-24372-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528087812-24372-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 04, 2018 at 12:50:12PM +0800, Xiao Yang wrote:
> Currently, xfs_io scrub command doesn't allow the probe function
> to have any parameter, so we remove the invalid parameter.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Bleh, sorry I've muddied the waters so much on this.  Yes, we changed
the xfs_io 'scrub probe' command not to take any parameters and forgot
to fix this. :/

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 9273ff7..dadbed4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2148,7 +2148,7 @@ _require_xfs_io_command()
>  		param_checked=1
>  		;;
>  	"scrub"|"repair")
> -		testio=`$XFS_IO_PROG -x -c "$command probe 0" $TEST_DIR 2>&1`
> +		testio=`$XFS_IO_PROG -x -c "$command probe" $TEST_DIR 2>&1`
>  		echo $testio | grep -q "Inappropriate ioctl" && \
>  			_notrun "xfs_io $command support is missing"
>  		;;
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
