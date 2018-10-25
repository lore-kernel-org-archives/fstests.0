Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:18641 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbeJYKqt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Oct 2018 06:46:49 -0400
Date: Thu, 25 Oct 2018 13:16:09 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic/508: fix to check inode creation time feature
 on scratch mountpoint
Message-ID: <20181025021609.GG6311@dastard>
References: <20181024072433.109167-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024072433.109167-1-yuchao0@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, chao@kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 24, 2018 at 03:24:33PM +0800, Chao Yu wrote:
> _require_btime() just check inode creation time feature on TEST_DIR
> mountpoint, but generic/508 needs to do that check on SCRATCH_MNT
> mountpoint. Let's add _require_scratch_btime() for that, meanwhile
> moving the check behind scratch_mkfs/scratch_moun.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> As Dave Chinner suggested:
> - introduce _require_scratch_btime() to check inode creation time
> feature in scratch mountpoint, adjust generic/508 to use it.
> - relocate the check behind scratch_mkfs/scratch_mount.
>  common/rc         | 8 ++++++++
>  tests/generic/508 | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index b4987a9cd7f7..111ba5410506 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3851,6 +3851,14 @@ _require_btime()
>  	rm -f $TEST_DIR/test_creation_time
>  }
>  
> +_require_scratch_btime()
> +{
> +	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
> +		| grep btime >>$seqres.full 2>&1 || \
> +		_notrun "inode creation time not supported by this filesystem"
> +	rm -f $SCRATCH_MNT/test_creation_time
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/508 b/tests/generic/508
> index b869b3a9c260..f1cda52fa44c 100755
> --- a/tests/generic/508
> +++ b/tests/generic/508
> @@ -46,7 +46,6 @@ _supported_os Linux
>  _require_test_lsattr
>  _require_statx
>  _require_xfs_io_command "statx" "-v"
> -_require_btime
>  
>  _require_scratch
>  _require_scratch_shutdown
> @@ -59,6 +58,7 @@ testfile=$SCRATCH_MNT/testfile
>  do_check()
>  {
>  	_scratch_mount
> +	_require_scratch_btime

There is no need to check it every time the scratch device is
mounted. Do the require checks up front befor the test starts
after _scratch_mkfs has been run.

But, oh, what an inconsistent mess these scratch device require
statements are.  Some just check the scratch device. Some mkfs the
scratch device, mount it and then run tests. Others require that the
scratch device is already made and mounted. It doesn't look like
there's any consistency here, so it's no wonder test writers are
getting this stuff wrong....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
