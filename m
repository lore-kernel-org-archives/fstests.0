Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:39233 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750982AbcIOEYK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Sep 2016 00:24:10 -0400
Date: Thu, 15 Sep 2016 14:24:04 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v6 1/6] fstests: common: Introduce _post_mount_hook for
 btrfs
Message-ID: <20160915042404.GS22388@dastard>
References: <20160914015527.10274-1-quwenruo@cn.fujitsu.com>
 <20160914015527.10274-2-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160914015527.10274-2-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, fdmanana@gmail.com, mfasheh@suse.de
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 14, 2016 at 09:55:22AM +0800, Qu Wenruo wrote:
> Introduce _post_mount_hook(), which will be executed after mounting
> scratch/test.
> 
> It's quite useful for fs(OK, only btrfs yet, again) which needs to
> use ioctl other than mount option to enable some of its feature.

Just implement a _btrfs_mount() function (similar to
_overlay_mount()) to do btrfs specific things at mount time.
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  common/rc | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 23c007a..631397f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -321,6 +321,27 @@ _overlay_scratch_unmount()
>  	$UMOUNT_PROG $SCRATCH_MNT
>  }
>  
> +_run_btrfs_post_mount_hook()
> +{
> +	mnt_point=$1
> +	for n in $ALWAYS_ENABLE_BTRFS_FEATURE; do

What's this magic, undefined, undocumented variable?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
