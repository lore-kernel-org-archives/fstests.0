Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17012 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752344AbcJJX57 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Oct 2016 19:57:59 -0400
Date: Tue, 11 Oct 2016 10:31:49 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: make 17[1-4] work well when btrfs
 compression is enabled
Message-ID: <20161010233149.GH23194@dastard>
References: <20161010080617.10139-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161010080617.10139-1-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 10, 2016 at 04:06:17PM +0800, Wang Xiaoguang wrote:
> When enabling btrfs compression, original codes can not fill fs
> correctly, fix this.
> 
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> ---
> V2: In common/, I did't find an existing function suitable for
>     these 4 test cases to fill fs, so I still use _pwrite_byte() with
>     a big enough file length fo fill fs. Note, for btrfs, metadata space
>     still is not full, only data space is full, but it's OK for these
>     4 test cases.
> 
>     All these 4 cases pass in xfs and btrfs(without compression), if
>     btrfs has compression enabled, these 4 cases will fail for false
>     enospc error, I have sent kernel patches to fix this bug.
> ---
>  tests/generic/171 | 7 ++++---
>  tests/generic/172 | 6 ++++--
>  tests/generic/173 | 7 ++++---
>  tests/generic/174 | 7 ++++---
>  4 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/generic/171 b/tests/generic/171
> index f391685..2d7f683 100755
> --- a/tests/generic/171
> +++ b/tests/generic/171
> @@ -75,9 +75,10 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
>  sync
>  
>  echo "Allocate the rest of the space"
> -nr_free=$(stat -f -c '%f' $testdir)
> -touch $testdir/file0 $testdir/file1
> -_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
> +# here we try to write big enough data in case some fs support
> +# compression, such as btrfs.
> +len=$((2 ** 36))
> +_pwrite_byte 0x61 0 $len $testdir/eat_my_space >> $seqres.full 2>&1

NACK. This is no better than the last proposal. 2^36 = 64GB, which
will not fill filesystems of any significant size, especially as the
data will compress down to nearly nothing.

Trying to hack around compression artifacts by inflating the size of
the file just doesn't work reliably.  The way to fix this is to
either use one of the "fill filesystem" functions that isn't
affected by compression, or to add the ability to xfs_io to write
incompressible data patterns and otherwise leave the test alone.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
