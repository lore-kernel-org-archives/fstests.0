Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:43914
        "EHLO ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750859AbeEUWvW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 May 2018 18:51:22 -0400
Date: Tue, 22 May 2018 08:51:20 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/132: unmount scratch fs after test
Message-ID: <20180521225120.GT23861@dastard>
References: <20180521160648.GI4910@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521160648.GI4910@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, May 21, 2018 at 09:06:48AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> If this test runs successfully, it'll leave a shutdown scratch fs
> behind.  The test framework doesn't unmount the fs for us (because we
> told it not to check the fs) so the test framework tries to "test -d
> $SCRATCH_MNT" and blows up on the IO error it receives from the dead fs.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  tests/xfs/132 |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/132 b/tests/xfs/132
> index 6bb03e79..3fa695a7 100755
> --- a/tests/xfs/132
> +++ b/tests/xfs/132
> @@ -67,6 +67,7 @@ _scratch_mount
>  
>  # The corrupt inode should be tripped over during these initial file creates.
>  touch $SCRATCH_MNT/file{0,1,2,3,4,5}{0,1,2,3,4,5} 2>&1 | _filter_scratch
> +_scratch_unmount

I've already NAK'd that patch - the test harness should be
unmounting scratch in all situations and returning the test harness
to a known initial state before the next test runs...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
