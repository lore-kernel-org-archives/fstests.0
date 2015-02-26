Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49166 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124AbbBZKpd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Feb 2015 05:45:33 -0500
Date: Thu, 26 Feb 2015 11:45:12 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH v2 1/2] xfstests: fix a typo in _require_block_device()
In-Reply-To: <196cc72cb39e1a338339fa09c73f6334af63a2d6.1424946979.git.zhaolei@cn.fujitsu.com>
Message-ID: <alpine.LFD.2.00.1502261144090.25704@localhost.localdomain>
References: <196cc72cb39e1a338339fa09c73f6334af63a2d6.1424946979.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, 26 Feb 2015, Zhaolei wrote:

> Date: Thu, 26 Feb 2015 18:38:47 +0800
> From: Zhaolei <zhaolei@cn.fujitsu.com>
> To: fstests@vger.kernel.org
> Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
> Subject: [PATCH v2 1/2] xfstests: fix a typo in _require_block_device()
> 
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> 
> We need to check "$1" instead "$SCRATCH_DEV" in this function.
> 
> Changelog v1->v2:
>  Use tab instead of space to fit new code style.
>  Suggested by: Dave Chinner <david@fromorbit.com>

Looks good, thanks.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 1ed9df5..5a8c74d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1288,7 +1288,7 @@ _require_block_device()
>  		echo "Usage: _require_block_device <dev>" 1>&2
>  		exit 1
>  	fi
> -	if [ "`_is_block_dev $SCRATCH_DEV`" == "" ]; then
> +	if [ "`_is_block_dev $1`" == "" ]; then
>  		_notrun "require $1 to be valid block disk"
>  	fi
>  }
> 
