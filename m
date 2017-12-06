Received: from mx1.redhat.com ([209.132.183.28]:39036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754714AbdLFJzN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 6 Dec 2017 04:55:13 -0500
Date: Wed, 6 Dec 2017 17:55:10 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/3] Check pwrite parameters
Message-ID: <20171206095510.GU2749@eguan.usersys.redhat.com>
References: <20171129163358.19759-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129163358.19759-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: darrick.wong@oracle.com, fstests@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 29, 2017 at 10:33:56AM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> There are some parameters added with xfs_io. Check if the pwrite
> parameters are available. For some cases, xfs_io now returns "command
> -%c not supported", so added "not supported" to count as error.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Change since v2:
>  - More comments
>  - opts to become local variable
> 
> ---
>  common/rc | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 4c053a53..90408b7e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2035,6 +2035,7 @@ _require_xfs_io_command()
>  	shift
>  	local param="$*"
>  	local param_checked=0
> +	local opts=""
>  
>  	testfile=$TEST_DIR/$$.xfs_io
>  	case $command in
> @@ -2079,6 +2080,15 @@ _require_xfs_io_command()
>  		echo $testio | grep -q "invalid option" && \
>  			_notrun "xfs_io $command support is missing"
>  		;;
> +	"pwrite")
> +		# -N (RWF_NOWAIT) only works with direct I/O writes
> +		if [ "$param" == "-N" ]; then
> +			opts+=" -d"
> +		fi
> +		testio=`$XFS_IO_PROG -f $opts -c "pwrite $param 0 1M" \
> +			$testfile 2>&1`

Do we need to specify the vector count when testing "-N" support? e.g.

$XFS_IO_PROG -f $opts -c "pwrite $param -V 1 0 1M" ...

>From xfsprogs code, it seems to me that we need to do so

io/pwrite.c::do_pwrite
do_pwrite(
	...
{
	if (!vectors)
		return pwrite(fd, ...);
	return do_pwritev(fd, ..., pritev2_flags);
}

and 'vectors' is a global variable with 0 as default value (no vector
number specified via "-V N" option).

So without "-V N", we call pwrite(2) not pwritev2(2) and RWF_NOWAIT
doesn't get tested.

Thanks,
Eryu

> +		param_checked=1
> +		;;
>  	"scrub"|"repair")
>  		testio=`$XFS_IO_PROG -x -c "$command probe 0" $TEST_DIR 2>&1`
>  		echo $testio | grep -q "Inappropriate ioctl" && \
> @@ -2109,7 +2119,9 @@ _require_xfs_io_command()
>  		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
>  			_notrun "xfs_io $command doesn't support $param"
>  	else
> -		echo $testio | grep -q "invalid option" && \
> +		# xfs_io could result in "command %c not supported" if it was
> +		# built on kernels not supporting pwritev2() calls
> +		echo $testio | grep -q "\(invalid option\|not supported\)" && \
>  			_notrun "xfs_io $command doesn't support $param"
>  	fi
>  }
> -- 
> 2.14.2
> 
