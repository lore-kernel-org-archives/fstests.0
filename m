Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:24451 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727288AbeK2NEc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Nov 2018 08:04:32 -0500
Date: Thu, 29 Nov 2018 13:00:49 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/111: Filter a "Structure needs cleaning" error from
 xfs_fsr
Message-ID: <20181129020048.GI19305@dastard>
References: <1543298175-5405-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543298175-5405-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 27, 2018 at 01:56:15PM +0800, Xiao Yang wrote:
> on upstream kernel, running xfs/111 got the following error:
> -------------------------------------------------
> +xfs_fsr: xfs_bulkstat: Structure needs cleaning
> -------------------------------------------------
> 
> Since kernel commit 29cad0b, we don't convert a -EFSCORRUPTED error
> to -EINVAL in xfs_imap_to_bp() if we are doing an untrusted lookup.
> So xfs_bulkstat() called by xfs_fsr command fails and returns
> EFSCORRUPTED.  We think it is reasonable for xfs_fsr to report
> EFSCORRUPTED because some inodes are actually corrupted.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/111 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/111 b/tests/xfs/111
> index 2ef69f0..2bcf002 100755
> --- a/tests/xfs/111
> +++ b/tests/xfs/111
> @@ -58,7 +58,8 @@ _try_scratch_mount || _fail "Couldn't mount after itrash"
>  
>  echo Attempting bulkstat
>  #src/bstat -q $SCRATCH_MNT
> -$XFS_FSR_PROG $SCRATCH_MNT | _filter_scratch
> +#Since kernel commit 29cad0b, xfs_fsr reports a "Structure needs cleaning" error
> +$XFS_FSR_PROG $SCRATCH_MNT | _filter_scratch | grep -v "Structure needs cleaning"

So the test tripped over a filesystem corruption and it didn't
before? Regressions like this should be reported in full to the xfs
list when they are discovered, not silenced by the test.

We may decide that the test needs changing, but reporting the
regression to the upstream developers should be done first.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
