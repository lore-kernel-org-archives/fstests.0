Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:16743 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888AbbBJGBN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 10 Feb 2015 01:01:13 -0500
Date: Tue, 10 Feb 2015 17:01:00 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 8/9 v5] common/quota: give quota mount option per
 filesystem
Message-ID: <20150210060100.GM4251@dastard>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
 <1423204633-66673-9-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423204633-66673-9-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 05, 2015 at 10:37:12PM -0800, Jaegeuk Kim wrote:
> This patch add _get_quota_option to assign the mount option selectively
> in:
> 
>   tests/xfs/087
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  common/quota  | 15 +++++++++++++++
>  tests/xfs/087 |  7 ++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/common/quota b/common/quota
> index b320cf2..a103826 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -78,6 +78,21 @@ _require_xfs_quota()
>  }
>  
>  #
> +# give quota option accoring to the filesystems.
> +#
> +_get_quota_option()
> +{
> +    case $FSTYP in
> +    xfs)
> +        _require_xfs_quota
> +        echo "-o uquota"
> +        ;;
> +    *)
> +        ;;
> +    esac
> +}

Looking at this, it's pretty specific to the test, so it's probably
best just to leave it as a helper function in the test itself.

Otherwise look s good.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
