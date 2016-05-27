Received: from userp1040.oracle.com ([156.151.31.81]:47186 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbcE0H2j (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 May 2016 03:28:39 -0400
Date: Fri, 27 May 2016 00:28:28 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/122: add check number of structure
Message-ID: <20160527072828.GD9418@birch.djwong.org>
References: <20160526163249.GA4595@birch.djwong.org>
 <1464330792-24031-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464330792-24031-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 27, 2016 at 02:33:12PM +0800, Xiao Yang wrote:
> I think the number of structure is always changing based on
> different xfsporg-dev version. If some expected structure is
> missing in current environment, we won't check structure size
> and offset and set the result to notrun.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/122 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/xfs/122 b/tests/xfs/122
> index 845cdd2..64f4a1b 100755
> --- a/tests/xfs/122
> +++ b/tests/xfs/122
> @@ -239,6 +239,11 @@ if [ $XFSPROGS_VERSION -lt 30000 ]; then
>  	echo 'sizeof( xfs_dsb_t ) = 208' >>$progout;
>  fi
>  
> +actual_num=`cat $progout | wc -l`
> +if [ $actual_num -lt 148 ]; then

I think the maintainer only cares that xfs/122 passes when run against
current xfsprogs git.

For certain, this shouldn't be hardcoded to 148.

--D

> +        _notrun "Some structure is missing in current envirment"
> +fi
> +
>  LC_COLLATE=POSIX sort $progout
>  
>  status=0
> -- 
> 1.8.3.1
> 
> 
> 
