Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:62853 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbeJXNMJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Oct 2018 09:12:09 -0400
Date: Wed, 24 Oct 2018 15:45:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/rc: fix to check inode creation on scratch_mnt in
 _require_btime()
Message-ID: <20181024044541.GD6311@dastard>
References: <20181024022645.74084-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024022645.74084-1-yuchao0@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, chao@kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 24, 2018 at 10:26:45AM +0800, Chao Yu wrote:
> _require_btime() should check inode creation feature on SCRATCH_MNT
> mountpoint intead of TEST_DIR mountpoint, otherwise generic/508 will
> fail due to incorrect check of this function.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index b4987a9cd7f7..5154241a5cee 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3845,10 +3845,10 @@ _dmsetup_create()
>  
>  _require_btime()
>  {
> -	$XFS_IO_PROG -f $TEST_DIR/test_creation_time -c "statx -v" \
> +	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
>  		| grep btime >>$seqres.full 2>&1 || \
>  		_notrun "inode creation time not supported by this filesystem"
> -	rm -f $TEST_DIR/test_creation_time
> +	rm -f $SCRATCH_MNT/test_creation_time
>  }

This doesn't work. the scratch device is not mounted at the time
generic/508 calls it.

If you are going to check the scratch device, the function needs to
be called _require_scratch_btime and be called after
scratch_mkfs/scratch_mount has been run by the test.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
