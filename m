Received: from mail-pl1-f195.google.com ([209.85.214.195]:36408 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDALO2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Apr 2019 07:14:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so3136109plb.3
        for <fstests@vger.kernel.org>; Mon, 01 Apr 2019 04:14:28 -0700 (PDT)
Date: Mon, 1 Apr 2019 19:14:21 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/populate: decrease the step of rm file
Message-ID: <20190401111421.GD2824@desktop>
References: <1553759339-2206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553759339-2206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <darrick.wong@oracle.com>
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
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

I may need some help from Darrick (cc'ed) on this one :)

Thanks,
Eryu

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
