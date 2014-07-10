Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:63533 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392AbaGJAoN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 9 Jul 2014 20:44:13 -0400
Date: Thu, 10 Jul 2014 10:44:10 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/300: redirect mkfs output to results/xfs directory
Message-ID: <20140710004410.GH4453@dastard>
References: <1403696406-18763-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403696406-18763-1-git-send-email-gux.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 25, 2014 at 07:40:06PM +0800, Xing Gu wrote:
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  tests/xfs/300 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/300 b/tests/xfs/300
> index 0958f76..db83fd4 100755
> --- a/tests/xfs/300
> +++ b/tests/xfs/300
> @@ -51,7 +51,7 @@ getenforce | grep -q "Enforcing\|Permissive" || _notrun "SELinux not enabled"
>  
>  rm -f $seqres.full
>  
> -_scratch_mkfs_xfs -i size=256 >> $seq.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_xfs -i size=256 >> $seqres.full 2>&1 || _fail "mkfs failed"
>  
>  # Manually mount to avoid fs-wide context set by default in xfstests
>  mount $SCRATCH_DEV $SCRATCH_MNT
> -- 
> 1.9.3

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
