Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28058 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752674AbbH1VMx (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 28 Aug 2015 17:12:53 -0400
Date: Fri, 28 Aug 2015 14:12:45 -0700
From: Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] Fix test fail of btrfs/006 caused by updated
 _filter_uuid()
Message-ID: <20150828211245.GA30052@huxley.DHCP.TheFacebook.com>
References: <5e1bb4aacc6c5b57585e6f66a708b8c21ce032ab.1440037988.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e1bb4aacc6c5b57585e6f66a708b8c21ce032ab.1440037988.git.zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 20, 2015 at 10:33:49AM +0800, Zhaolei wrote:
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> 
> _filter_uuid() get updated and changed output from:
>  uuid: <UUID>
>  ->
>  uuid:  <UUID>
> 
> It is a typo introduced by xfs/077, this patch fixed this.
> 
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>

Thanks, Zhao Lei, I ran into this today.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
>  common/filter     | 2 +-
>  tests/xfs/077.out | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 8db1b3e..af456c9 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -277,7 +277,7 @@ _filter_uuid()
>  		UUID=$1
>  		sed -e "s/\(uuid[ :=]\+\) $UUID/\1 <EXACTUUID>/i"
>  	else
> -		sed -e "s/\(uuid[ :=]\+\) *[0-9a-f-][0-9a-f-]*/\1 <UUID>/ig"
> +		sed -e "s/\(uuid[ :=]\+\) [0-9a-f-][0-9a-f-]*/\1 <UUID>/ig"
>  	fi
>  }
>  
> diff --git a/tests/xfs/077.out b/tests/xfs/077.out
> index fdc7d72..4e18087 100644
> --- a/tests/xfs/077.out
> +++ b/tests/xfs/077.out
> @@ -2,7 +2,7 @@ QA output created by 077
>  == Generate new UUID
>  Clearing log and setting UUID
>  writing all SBs
> -new UUID =  <UUID>
> +new UUID = <UUID>
>  == Rewrite UUID
>  old UUID = <EXACTUUID>
>  Clearing log and setting UUID
> -- 
> 1.8.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Omar
