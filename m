Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:26500 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754583AbeFVWQa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 22 Jun 2018 18:16:30 -0400
Date: Sat, 23 Jun 2018 08:16:25 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] btrfs/149: don't run if PAGE_SIZE > 4096
Message-ID: <20180622221625.GE13748@dastard>
References: <20180622213843.GF28053@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622213843.GF28053@wotan.suse.de>
Sender: fstests-owner@vger.kernel.org
To: Mark Fasheh <mfasheh@suse.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 22, 2018 at 11:38:43PM +0200, Mark Fasheh wrote:
> The test assumes a 4K block size and fails on larger block sizes - the
> extent layout will not match and the reflink command will fail.

The usual way of fixing this is it use 64k sizes and offsets for IO
rather than 4k, and change the output to match. That way the test
should behave the same across all supported block and page sizes.
> 
> Signed-off-by: Mark Fasheh <mfasheh@suse.de>
> ---
>  tests/btrfs/149 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/btrfs/149 b/tests/btrfs/149
> index 3e955a30..64bc8ac3 100755
> --- a/tests/btrfs/149
> +++ b/tests/btrfs/149
> @@ -37,6 +37,12 @@ _require_scratch
>  _require_scratch_reflink
>  _require_odirect
>  
> +# Test output will not match results if page size > 4096
> +PAGE_SIZE=`getconf PAGE_SIZE`
> +if [ $PAGE_SIZE -gt 4096 ]; then
> +    _notrun "Not supported with page size > 4096"
> +fi

FWIW, the commi description talks about block sizes - this tests the
machien page size, not the filesystem block size....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
