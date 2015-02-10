Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:14200 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755393AbbBJFrw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 10 Feb 2015 00:47:52 -0500
Date: Tue, 10 Feb 2015 16:47:48 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/9 v5] common/rc: add _require_fiemap and
 _extent_hole_counts
Message-ID: <20150210054748.GL4251@dastard>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
 <1423204633-66673-3-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423204633-66673-3-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 05, 2015 at 10:37:06PM -0800, Jaegeuk Kim wrote:
> This is to detect whether fiemap tool supports or not.
> 
> For the follwoing tests, this patch adds general script to get extent and
> hole counts.
> 
>  xfs/137         (data vs filesize)
>  xfs/138         (data vs filesize vs truncate)
>  xfs/139         (data vs filesize vs partial truncate)
>  xfs/140         (data vs filesize vs extending truncate)
>  xfs/179         (data vs filesize w/ fsync)
>  xfs/180         (data vs filesize w/ sync)
>  xfs/182         (data vs filesize w/ recovery)
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  common/rc     | 13 +++++++++++++
>  tests/xfs/137 | 10 ++++++----
>  tests/xfs/138 | 10 ++++++----
>  tests/xfs/139 | 10 ++++++----
>  tests/xfs/140 |  6 ++++--
>  tests/xfs/179 |  6 ++++--
>  tests/xfs/180 |  6 ++++--
>  tests/xfs/182 |  6 ++++--
>  8 files changed, 47 insertions(+), 20 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 234638b..078d3ca 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2332,6 +2332,19 @@ _require_scratch_shutdown()
>  	_scratch_unmount
>  }
>  
> +# Does fiemap support?
> +_require_fiemap()
> +{
> +	_require_xfs_io_command "fiemap"
> +}
> +
> +_extent_hole_counts()
> +{
> +	res=`$XFS_IO_PROG -c "fiemap" $1 | tail -n +2`
> +	echo $res | grep -v hole | wc -l | $AWK_PROG '{print $1}'
> +	echo $res | grep hole | wc -l | $AWK_PROG '{print $1}'
> +}

Two functions - _count_extents() and _count_holes().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
