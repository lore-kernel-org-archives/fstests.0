Received: from mx2.suse.de ([195.135.220.15]:47664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbeIYQ6v (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Sep 2018 12:58:51 -0400
Subject: Re: [PATCH v2 1/9] fstests: btrfs: _scratch_mkfs_sized fix min size
 without mixed option
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-2-git-send-email-anand.jain@oracle.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <b054a402-0507-4990-6752-8d75b02a97ed@suse.com>
Date: Tue, 25 Sep 2018 13:51:49 +0300
MIME-Version: 1.0
In-Reply-To: <1537849462-619-2-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
List-ID: <fstests@vger.kernel.org>



On 25.09.2018 07:24, Anand Jain wrote:
> As of now _scratch_mkfs_sized() checks if the requested size is below 1G
> and forces the --mixed option for the mkfs.btrfs. Well the correct size
> considering all possible group profiles at which we need to force the
> mixed option is roughly 256Mbytes. So fix that.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Have you considered the implications of this w.r.t commit
d4da414a9a9d ("common/rc: raise btrfs mixed mode threshold to 1GB")

Initially this threshold was 100mb then Omar changed it to 1g. Does this
change affect generic/427?

> ---
>  common/rc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index d5bb1feee2c3..90dc3002bc3d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -969,7 +969,10 @@ _scratch_mkfs_sized()
>  	;;
>      btrfs)
>  	local mixed_opt=
> -	(( fssize <= 1024 * 1024 * 1024 )) && mixed_opt='--mixed'
> +	# minimum size that's needed without the mixed option.
> +	# Ref: btrfs-prog: btrfs_min_dev_size()
> +	# Non mixed mode is also the default option.
> +	(( fssize < $((256 * 1024 *1024)) )) && mixed_opt='--mixed'
>  	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
>  	;;
>      jfs)
> 
