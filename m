Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:55916 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751169AbeFDDJS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Jun 2018 23:09:18 -0400
Date: Mon, 4 Jun 2018 13:09:09 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfstests/btrfs: adapt ppc64le node size at least 65536
Message-ID: <20180604030909.GG10972@dastard>
References: <20180601083727.13709-1-yosun@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601083727.13709-1-yosun@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Yong Sun <yosun@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 01, 2018 at 04:37:27PM +0800, Yong Sun wrote:
> From: yosun <yosun@suse.com>
> 
> node size(leaf size) in ppc64le at least 65536, so mkfs with --nodesize smaller than that number will cause a fail on 057 and 122.
> 
> Signed-off-by: Yong Sun <yosun@suse.com>
> ---
>  tests/btrfs/057 | 6 ++++++
>  tests/btrfs/122 | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/057 b/tests/btrfs/057
> index a834b763..69d096fb 100755
> --- a/tests/btrfs/057
> +++ b/tests/btrfs/057
> @@ -48,6 +48,12 @@ _require_scratch
>  
>  rm -f $seqres.full
>  
> +# the nodesize in ppc64le is at least 65536, it will mismatch output
> +HARDWARE_PLATFORM=`uname -i`
> +if [ "$HARDWARE_PLATFORM" = "ppc64le" ]; then
> +        _notrun "Not supported on ppc64le with nodesize > 4096"
> +fi

Why doesn't ppc64le support node sizes smaller than 64K? What makes
it different to any other hardware? i.e. we should be checking for
the thing that prevents node sizes <64k, not the hardware platform.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
