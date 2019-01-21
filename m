Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:26090 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfAUWv6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jan 2019 17:51:58 -0500
Date: Tue, 22 Jan 2019 09:51:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] filter: fix assumed whitespace in _filefrag_filter
 regex
Message-ID: <20190121225155.GG4205@dastard>
References: <20190121163316.20616-1-jeffm@suse.com>
 <20190121163316.20616-2-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121163316.20616-2-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: jeffm@suse.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 21, 2019 at 11:33:11AM -0500, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> The regex assumes there will be whitespace after the .. in the ranges
> and, with larger offsets, there may not be any.

Does more than this, right?

> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  common/filter | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/filter b/common/filter
> index ed082d24..b4443a34 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -532,7 +532,7 @@ _filter_filefrag()
>  		next
>  	}
>  	($ext, $logical, $physical, $length) =
> -		(/^\s*(\d+):\s+(\d+)..\s+\d+:\s+(\d+)..\s+\d+:\s+(\d+):/)
> +		(/^\s*(\d+):\s+(\d+)\.\.\s*\d+:\s+(\d+)\.\.\s*\d+:\s+(\d+):/)

This is escaping "..", too, isn't it? 

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
