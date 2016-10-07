Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:61649 "EHLO
        ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756715AbcJGOgR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Oct 2016 10:36:17 -0400
Date: Sat, 8 Oct 2016 01:36:10 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: make 17[1-4] work well when btrfs compression
 is enabled
Message-ID: <20161007143610.GX27872@dastard>
References: <20161007070042.12258-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161007070042.12258-1-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 07, 2016 at 03:00:42PM +0800, Wang Xiaoguang wrote:
> When enabling btrfs compression, original codes can not fill fs
> correctly, fix this.
> 
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> ---
>  tests/generic/171 | 4 +---
>  tests/generic/172 | 2 +-
>  tests/generic/173 | 4 +---
>  tests/generic/174 | 4 +---
>  4 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/generic/171 b/tests/generic/171
> index f391685..d2ae8e4 100755
> --- a/tests/generic/171
> +++ b/tests/generic/171
> @@ -75,9 +75,7 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
>  sync
>  
>  echo "Allocate the rest of the space"
> -nr_free=$(stat -f -c '%f' $testdir)
> -touch $testdir/file0 $testdir/file1
> -_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
> +dd if=/dev/zero of=$testdir/eat_my_space >> $seqres.full 2>&1

Please don't replace xfs_io writes using a specific data pattern
with dd calls that write zeros. Indeed, we don't use dd for new
tests anymore - xfs_io should be used.

Write a function that fills all the remaining free space (one may
already exist) and call it in all these places.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
