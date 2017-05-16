Received: from mx1.redhat.com ([209.132.183.28]:47548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdEPIE6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 May 2017 04:04:58 -0400
Date: Tue, 16 May 2017 16:04:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] common: cleanup _require_xfs_io_command
Message-ID: <20170516080455.GX7250@eguan.usersys.redhat.com>
References: <1494832679-13246-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1494832679-13246-2-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494832679-13246-2-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 15, 2017 at 03:17:59PM +0800, Xiao Yang wrote:
> We don't need to check specific flags at the end of this function
> if we have checked them before. e.g, generic/071 and generic/422
> are marked as notrun unexpectedly because xfs_io doesn't support
> long-format help for falloc before xfsprogs v4.9.  Actually, xfs_io
> has supported falloc, so these case should not be marked as notrun.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks for the fix!

> ---
>  common/rc | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 539f153..2c893c0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2041,6 +2041,7 @@ _require_xfs_io_command()
>  	command=$1
>  	shift
>  	param="$*"
> +	param_check=0
>  
>  	testfile=$TEST_DIR/$$.xfs_io
>  	case $command in
> @@ -2055,6 +2056,7 @@ _require_xfs_io_command()
>  		;;
>  	"falloc" )
>  		testio=`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2>&1`
> +		param_check=1
>  		;;
>  	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" | "funshare")
>  		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
> @@ -2063,6 +2065,7 @@ _require_xfs_io_command()
>  	"fiemap")
>  		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
>  			-c "fiemap -v $param" $testfile 2>&1`
> +		param_check=1
>  		;;
>  	"flink" )
>  		testio=`$XFS_IO_PROG -T -F -c "flink $testfile" \
> @@ -2087,7 +2090,7 @@ _require_xfs_io_command()
>  		testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
>  		;;
>  	*)
> -		testio=`$XFS_IO_PROG -c "$command help" 2>&1`
> +		testio=`$XFS_IO_PROG -c "help $command" 2>&1`
>  	esac
>  
>  	rm -f $testfile 2>&1 > /dev/null
> @@ -2100,9 +2103,10 @@ _require_xfs_io_command()
>  	echo $testio | grep -q "foreign file active" && \
>  		_notrun "xfs_io $command not supported on $FSTYP"
>  
> -	test -z "$param" && return
> -	$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
> -		_notrun "xfs_io $command doesn't support $param"
> +	if [ -n $param -a $param_check -eq 0 ]; then

$param needs quotes here, otherwise if no param is specified [ -n ]
still reports pass, e.g.

$ unset empty_var
$ if [ -n $empty_var ]; then echo "should not see this"; fi
should not see this
$ if [ -n "$empty_var" ]; then echo "should not see this"; fi
<nothing printed>

I can fix it at commit time.

Thanks,
Eryu

> +		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
> +			_notrun "xfs_io $command doesn't support $param"
> +	fi
>  }
>  
>  # check that kernel and filesystem support direct I/O
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
