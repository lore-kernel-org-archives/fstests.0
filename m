Received: from aserp2130.oracle.com ([141.146.126.79]:49696 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCWoH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Apr 2019 18:44:07 -0400
Date: Wed, 3 Apr 2019 15:43:59 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/populate: decrease the step of rm file
Message-ID: <20190403224359.GB32415@magnolia>
References: <1553759339-2206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553759339-2206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 28, 2019 at 03:48:59PM +0800, Yang Xu wrote:
>  Now that we have allocated 2*4096*64/16(32768) inodes after "Inode btree",
>  but the step of rm file is too large to create enough free inodes in agi.
>  So the freecount is not enough large to make free_level gt 1 and call
>  _scratch__populate on xfs will report the following failure(such as xfs/083):
> 
> Failed to create fino of sufficient height!
> 
> By decreasing the step of rm file, xfs/083 will pass.

Hmm, what are MOUNT_OPTS and MKFS_OPTIONS when this happens?  Are you
running on top of some kind of RAID or 4k sector disk or something?

I think this patch looks ok but I'm puzzled for why a step of
$(ino_per_rec + 1) isn't enough.

--D

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  common/populate | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/populate b/common/populate
> index 4fa118f0..7403dec3 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -271,7 +271,7 @@ _scratch_xfs_populate() {
>  		touch "${dir}/${f}"
>  	done
>  
> -	seq 0 "$((ino_per_rec + 1))" "${nr}" | while read f; do
> +	seq 0 2 "${nr}" | while read f; do
>  		rm -f "${dir}/${f}"
>  	done
>  
> -- 
> 2.18.1
> 
> 
> 
