Received: from aserp2120.oracle.com ([141.146.126.78]:35452 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756185AbeAROEC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Jan 2018 09:04:02 -0500
Subject: Re: [PATCH] Fstests: btrfs/011 fix device mounted when tests aborts
References: <20180116201018.2008-1-bo.li.liu@oracle.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <f925efb9-33af-f4da-f573-51ec02d97676@oracle.com>
Date: Thu, 18 Jan 2018 22:05:05 +0800
MIME-Version: 1.0
In-Reply-To: <20180116201018.2008-1-bo.li.liu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 01/17/2018 04:10 AM, Liu Bo wrote:
> One of btrfs tests, btrfs/011, uses SCRATCH_DEV_POOL and puts a
> non-SCRATCH_DEV device as the first one when doing mkfs, and this makes
> _require_scratch{_nocheck} confused since it checks mount point with
> SCRATCH_DEV only.
> 
> This adds _scratch_umount to cleanup() to umount SCRATCH_MNT by
> 011 itself.
> 
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Tested-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   tests/btrfs/011 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 28f1388..f4c5309 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -51,6 +51,7 @@ _cleanup()
>   	fi
>   	wait
>   	rm -f $tmp.tmp
> +	_scratch_unmount > /dev/null 2>&1
>   }
>   trap "_cleanup; exit \$status" 0 1 2 3 15
>   
> 
