Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:44228 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360AbbBECBP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 4 Feb 2015 21:01:15 -0500
Date: Thu, 5 Feb 2015 13:01:00 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/8 v4] common/rc: add _require_scratch_shtudown
Message-ID: <20150205020100.GB12722@dastard>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
 <1423004840-45315-2-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423004840-45315-2-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 03, 2015 at 03:07:13PM -0800, Jaegeuk Kim wrote:
> This is to detect whether filesystem supports shutdown feature or not.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  common/rc | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5377ba0..438cd51 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2320,6 +2320,17 @@ _require_freeze()
>  	[ $result -eq 0 ] || _notrun "$FSTYP does not support freezing"
>  }
>  
> +# Does shutdown work on this fs?
> +_require_scratch_shutdown()
> +{
> +	[ -x src/godown ] || _notrun "src/godown executable not found"
> +
> +        _scratch_mount

Whitespace damage. Also, the state of the scratch device is
undefined until scratch_mkfs is run.

> +	src/godown -v -f $SCRATCH_MNT >/dev/null 2>&1 \
> +		|| _notrun "$FSTYP does not support shutdown"

Why verbose if you are redirecting all output to /dev/null?

> +	_scratch_unmount
> +}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
