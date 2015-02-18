Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:4044 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719AbbBRBVm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 17 Feb 2015 20:21:42 -0500
Date: Wed, 18 Feb 2015 12:21:39 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] xfstests: fix a typo in _require_block_device()
Message-ID: <20150218012139.GO4251@dastard>
References: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 16, 2015 at 02:50:39PM +0800, Zhaolei wrote:
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> 
> We need to check "$1" instead "$SCRATCH_DEV" in this function.
> And make tabs same with other code.
> 
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> ---
>  common/rc | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7449a1d..76522d4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1284,13 +1284,13 @@ _require_command()
>  # $1 - device
>  _require_block_device()
>  {
> -	if [ -z "$1" ]; then
> -		echo "Usage: _require_block_device <dev>" 1>&2
> -		exit 1
> -	fi
> -	if [ "`_is_block_dev $SCRATCH_DEV`" == "" ]; then
> -		_notrun "require $1 to be valid block disk"
> -	fi
> +    if [ -z "$1" ]; then
> +	echo "Usage: _require_block_device <dev>" 1>&2
> +	exit 1
> +    fi
> +    if [ "`_is_block_dev $1`" == "" ]; then
> +	_notrun "require $1 to be valid block disk"
> +    fi
>  }

The change is fine - the reformating of the code is not. 8 space
tabs for all new code and all new modifications, please.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
