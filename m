Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:6957 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbeJ0MKX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 27 Oct 2018 08:10:23 -0400
Date: Sat, 27 Oct 2018 14:28:01 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] generic/508: fix to check inode creation time feature
 on scratch mountpoint
Message-ID: <20181027032801.GH6311@dastard>
References: <20181027015520.7355-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027015520.7355-1-yuchao0@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, chao@kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 27, 2018 at 09:55:20AM +0800, Chao Yu wrote:
> _require_btime() just check inode creation time feature on TEST_DIR
> mountpoint, but generic/508 needs to do that check on SCRATCH_MNT
> mountpoint. Let's add _require_scratch_btime() for that, meanwhile
> handling scratch_{mkfs,mount,umount} inside the function to decouple
> with caller.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v3:
> - hanlde scratch mkfs/mount/umount inside _require_scratch_btime
> - relocate _require_scratch_btime
>  common/rc         | 14 ++++++++++++++
>  tests/generic/508 |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index b4987a9cd7f7..a882fada7d02 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3851,6 +3851,20 @@ _require_btime()
>  	rm -f $TEST_DIR/test_creation_time
>  }
>  
> +_require_scratch_btime()
> +{
> +	_require_scratch
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +
> +	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
> +		| grep btime >>$seqres.full 2>&1 || \
> +		_notrun "inode creation time not supported by this filesystem"
> +	rm -f $SCRATCH_MNT/test_creation_time

No need to remove that file - it's going to get mkfs'd again,
anyway.

Otherwise looks fine. I'm not a fan of all these require_scratch
rules having to run mkfs, but I can live with it.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
