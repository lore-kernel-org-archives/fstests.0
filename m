Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:60391 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751794AbeDLFxv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Apr 2018 01:53:51 -0400
Date: Thu, 12 Apr 2018 15:53:46 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 2/2] common/rc: raise mixed mode threshold to 1GB
Message-ID: <20180412055346.GJ729@dastard>
References: <d928f86c748db034ca4efd849e01c5c2bf805199.1523509644.git.osandov@fb.com>
 <0dfb46a79e393cdb6ef24e567e6c78c8cc230a9a.1523509644.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dfb46a79e393cdb6ef24e567e6c78c8cc230a9a.1523509644.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 11, 2018 at 10:07:29PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> generic/427 creates a 256 MB filesystem and then writes a 200 MB file,
> which fails on Btrfs if mixed mode is not enabled. Raise the threshold
> to 1GB, which is where we typically recommend mixed mode.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 5dbb8fe5..dc0062de 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -999,7 +999,7 @@ _scratch_mkfs_sized()
>  	;;
>      btrfs)
>  	local mixed_opt=
> -	(( fssize <= 100 * 1024 * 1024 )) && mixed_opt='--mixed'
> +	(( fssize <= 1024 * 1024 * 1024 )) && mixed_opt='--mixed'
>  	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
>  	;;
>      jfs)

Makes sense.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
