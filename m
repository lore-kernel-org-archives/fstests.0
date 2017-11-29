Received: from mx1.redhat.com ([209.132.183.28]:41607 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754000AbdK2Jtu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 29 Nov 2017 04:49:50 -0500
Date: Wed, 29 Nov 2017 17:49:48 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/3] Check pwrite parameters
Message-ID: <20171129094948.GP2749@eguan.usersys.redhat.com>
References: <20171127184920.13864-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127184920.13864-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 27, 2017 at 12:49:18PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> There are some parameters added with xfs_io. Check if the pwrite
> parameters are available. For some cases, xfs_io now returns "command
> -%c not supported", so added "not supported" to count as error.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  common/rc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 4c053a53..b6778f07 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2079,6 +2079,14 @@ _require_xfs_io_command()
>  		echo $testio | grep -q "invalid option" && \
>  			_notrun "xfs_io $command support is missing"
>  		;;
> +	"pwrite")
> +		if [ "$param" == "-N" ]; then
> +			opts="-d"

I think we'd need some comments on why direct I/O is needed for "-N"
option. And better to declare 'opts' as a local variable.

> +		fi
> +		testio=`$XFS_IO_PROG -f $opts -c "pwrite $param 0 1M" \
> +			$testfile 2>&1`
> +		param_checked=1
> +		;;
>  	"scrub"|"repair")
>  		testio=`$XFS_IO_PROG -x -c "$command probe 0" $TEST_DIR 2>&1`
>  		echo $testio | grep -q "Inappropriate ioctl" && \
> @@ -2109,7 +2117,7 @@ _require_xfs_io_command()
>  		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
>  			_notrun "xfs_io $command doesn't support $param"
>  	else
> -		echo $testio | grep -q "invalid option" && \
> +		echo $testio | grep -q "\(invalid option\|not supported\)" && \

Need comments on the "not supported" case, because we've checked
"Operation not supported" case above, it's a bit confusing why the two
"not supported" can't be merged into one.

Thanks,
Eryu

>  			_notrun "xfs_io $command doesn't support $param"
>  	fi
>  }
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
