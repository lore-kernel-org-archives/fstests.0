Received: from mx1.redhat.com ([209.132.183.28]:46259 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932731AbbGVIgJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 22 Jul 2015 04:36:09 -0400
Date: Wed, 22 Jul 2015 16:36:05 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] Make -g and -x option meet description in manual
Message-ID: <20150722083605.GB3945@dhcp-13-216.nay.redhat.com>
References: <faccdf430dfe4d06f656f267f4f176a32193d2da.1437539516.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faccdf430dfe4d06f656f267f4f176a32193d2da.1437539516.git.zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 22, 2015 at 12:32:37PM +0800, Zhaolei wrote:
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> 
> In manual:
>  # ./check --help
>  ...
>  -g group[,group...] include tests from these groups
>  -x group[,group...] exclude tests from these groups
>  ...
> 
> Above format is not supported, because ',' is not parsed in code.
> This patch fixed it.
> 
> Before patch:
>  # ./check -g scrub,replace
>  Group "scrub,replace" is empty or not defined?
> 
> After patch:
>  # ./check -g scrub,replace
>  FSTYP         -- btrfs
>  PLATFORM      -- Linux/x86_64 kerneldev 4.2.0-rc2_HEAD_c65b99f046843d2455aa231747b5a07a999a9f3d_+
>  MKFS_OPTIONS  -- /dev/vdd
>  MOUNT_OPTIONS -- /dev/vdd /var/ltf/tester/scratch_mnt
>  ...(right result)...
> 
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>

Looks good to me. One nitpick is summary is missing "check: " or
"fstests: " prefix.

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  check | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index a300130..330c3e8 100755
> --- a/check
> +++ b/check
> @@ -209,11 +209,11 @@ while [ $# -gt 0 ]; do
>  	-tmpfs)	FSTYP=tmpfs ;;
>  
>  	-g)	group=$2 ; shift ;
> -		GROUP_LIST="$GROUP_LIST $group"
> +		GROUP_LIST="$GROUP_LIST ${group//,/ }"
>  		;;
>  
>  	-x)	xgroup=$2 ; shift ;
> -		XGROUP_LIST="$XGROUP_LIST $xgroup"
> +		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
>  		;;
>  
>  	-X)	xfile=$2; shift ;
> -- 
> 1.8.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
