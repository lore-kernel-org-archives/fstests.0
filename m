Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:12319 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbeK0Ipm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Nov 2018 03:45:42 -0500
Date: Tue, 27 Nov 2018 08:50:08 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] common/rc: Add _require_filefrag_options() to check
 options for filefrag
Message-ID: <20181126215007.GA19305@dastard>
References: <20181123051251.GJ3889@desktop>
 <1542950663-7784-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542950663-7784-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 23, 2018 at 01:24:23PM +0800, Xiao Yang wrote:
> In generic/519, filefrag command use FIBMAP ioctl(-B option) to print
> output in extent format(-e option) on purpose and sync file(-s option),
> so add _require_filefrag_options() to check if the command supports
> all of these options.
> 
> References:
> 1) filefrag supports -e option by commit 2508eaa since e2fsprogs v1.42.7.
> 2) filefrag supports -B option by commit 5d5e01d since e2fsprogs v1.41.9.
> 3) filefrag supports -s option by commit e62847c since e2fsprogs v1.41.6.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc         | 15 ++++++++++++++-
>  tests/generic/519 |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index ecb1738..e5da648 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3843,10 +3843,23 @@ _require_scratch_btime()
>  	_scratch_unmount
>  }
>  
> -_require_fibmap()
> +_require_filefrag_options()
>  {
>  	_require_command "$FILEFRAG_PROG" filefrag
>  
> +	local options=$1
> +	local file="$TEST_DIR/options_testfile"
> +
> +	echo "XX" > $file
> +	${FILEFRAG_PROG} -$options $file 2>&1 | grep -q "invalid option" && \
> +		_notrun "filefrag doesn't support $options option"
> +	rm -f $file
> +}

Can we just get rid of filefrag and use xfs_io's fiemap commands
instead?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
