Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:24542 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752252AbcJJX3q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Oct 2016 19:29:46 -0400
Date: Tue, 11 Oct 2016 10:09:38 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/175: disable inline data feature for btrfs
Message-ID: <20161010230938.GG23194@dastard>
References: <20161010050647.30262-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161010050647.30262-1-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 10, 2016 at 01:06:47PM +0800, Wang Xiaoguang wrote:
> For btrfs, if compression is enabled, it may generate inline data for a
> blocksize data range, this inline data is stored in fs tree, will not have
> a individual extent, try to reflink this data range at a not-zero offset
> will return EOPNOTSUPP, so here we disable inline data feature for btrfs.
> 
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> ---
>  tests/generic/175 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/generic/175 b/tests/generic/175
> index 964580c..b3f90dc 100755
> --- a/tests/generic/175
> +++ b/tests/generic/175
> @@ -50,6 +50,13 @@ rm -f "$seqres.full"
>  
>  echo "Format and mount"
>  _scratch_mkfs > "$seqres.full" 2>&1
> +# For btrfs, if compression is enabled, it may generate inline data for a
> +# blocksize data range, this inline data is stored in fs tree, will not have
> +# a individual extent, try to reflink this data range at a not-zero offset
> +# will return EOPNOTSUPP, so here we disable inline data feature for btrfs.
> +if [ "$FSTYP" = "btrfs" ]; then
> +	export MOUNT_OPTIONS="-o max_inline=0 $MOUNT_OPTIONS"
> +fi

Can we /please stop/ putting special case code like this in tests?

This is an unsustainable and unmaintainable practice - it's making a
mess of the test code. If there are specific mount options that
needs to be avoided, then add an option to filter them out. e.g.
something like this:

_scratch_options_filter btrfs compress

so that it removes any compression option from the btrfs mount/mkfs
that is run for that test.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
