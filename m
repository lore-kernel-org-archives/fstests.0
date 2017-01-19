Received: from mx1.redhat.com ([209.132.183.28]:34696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdASER7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jan 2017 23:17:59 -0500
Date: Thu, 19 Jan 2017 12:17:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/4] common/rc: add _require_scratch_dax
Message-ID: <20170119041700.GR1859@eguan.usersys.redhat.com>
References: <1484708826-23529-1-git-send-email-xzhou@redhat.com>
 <1484708826-23529-2-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484708826-23529-2-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, linux-nvdimm@ml01.01.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 18, 2017 at 11:07:03AM +0800, Xiong Zhou wrote:
> To make sure we can test DAX feature on SCRATCH_DEV.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  common/rc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 892c46e..ea7956b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2632,6 +2632,16 @@ _require_scratch_shutdown()
>  	_scratch_unmount
>  }
>  
> +# Does dax mount option work on this dev/fs?
> +_require_scratch_dax()
> +{
> +	_scratch_unmount

Use _require_scratch instead of _scratch_unmount here. _require_scratch
ensures we have SCRATCH_DEV defined and unmounts it if it's mounted.

Thanks,
Eryu

> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount -o dax || \
> +		_notrun "$SCRATCH_DEV $FSTYP does not support -o dax"
> +	_scratch_unmount
> +}
> +
>  # Does norecovery support by this fs?
>  _require_norecovery()
>  {
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
