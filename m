Received: from mx1.redhat.com ([209.132.183.28]:41716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbdCPHYC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Mar 2017 03:24:02 -0400
Date: Thu, 16 Mar 2017 15:24:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/dmthin: Fix grep command for finding exact value
Message-ID: <20170316072401.GQ14226@eguan.usersys.redhat.com>
References: <1489639730-15004-1-git-send-email-harish@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489639730-15004-1-git-send-email-harish@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: Harish <harish@linux.vnet.ibm.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 16, 2017 at 10:18:50AM +0530, Harish wrote:
> Sometimes there are multiple occurences of pool_name and data_name in
> dmsetup command which causes failures while adding in next line.
> This patch greps for pool_name at start of line.
> 
> Signed-off-by: Harish <harish@linux.vnet.ibm.com>
> ---
>  common/dmthin | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/dmthin b/common/dmthin
> index e774175..fe48eef 100644
> --- a/common/dmthin
> +++ b/common/dmthin
> @@ -180,8 +180,8 @@ _dmthin_grow()
>  	# Get current sizes & values
>  	local   meta_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_META_NAME | awk '{print $3}'`
>  	local meta_dev_offset=`$DMSETUP_PROG table | grep $DMTHIN_META_NAME | awk '{print $6}'`
> -	local   data_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_DATA_NAME | awk '{print $3}'`
> -	local   pool_dev_size=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $3}'`
> +	local   data_dev_size=`$DMSETUP_PROG table | grep ^$DMTHIN_DATA_NAME | awk '{print $3}'`
> +	local   pool_dev_size=`$DMSETUP_PROG table | grep ^$DMTHIN_POOL_NAME | awk '{print $3}'`

Do we need to do the same to all other $DMTHIN_.*_NAME, not only
DMTHIN_DATA_NAME and DMTHIN_POOL_NAME?

Thanks,
Eryu
>  	local    cluster_size=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $7}'`
>  	local       low_water=`$DMSETUP_PROG table | grep $DMTHIN_POOL_NAME | awk '{print $8}'`
>  
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
