Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:49932 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755812AbcBJFzc (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 00:55:32 -0500
Date: Wed, 10 Feb 2016 16:54:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 08/12] xfstests: fix generic/312 on tmpfs, ignore
 /proc/partitions
Message-ID: <20160210055455.GS19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-9-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455069001-17846-9-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 09, 2016 at 08:49:57PM -0500, Theodore Ts'o wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> 312 avoid reading /proc/partitions for tmpfs, just assume enough space.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/312 | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/312 b/tests/generic/312
> index b570814..a826071 100755
> --- a/tests/generic/312
> +++ b/tests/generic/312
> @@ -51,12 +51,13 @@ _require_scratch
>  
>  # 5G in byte
>  fssize=$((2**30 * 5))
> -required_blocks=$(($fssize / 1024))
> -dev_blocks=$(grep -w $(_short_dev $SCRATCH_DEV) /proc/partitions | $AWK_PROG '{print $3}')
> -if [ $required_blocks -gt $dev_blocks ];then
> -	_notrun "this test requires \$SCRATCH_DEV has ${fssize}B space"
> +if [ "$FSTYP" != "tmpfs" ]; then
> +	required_blocks=$(($fssize / 1024))
> +	dev_blocks=$(grep -w $(_short_dev $SCRATCH_DEV) /proc/partitions | $AWK_PROG '{print $3}')
> +	if [ $required_blocks -gt $dev_blocks ];then
> +	    _notrun "this test requires \$SCRATCH_DEV has ${fssize}B space"
> +	fi
>  fi

_scratch_mkfs
_scratch_mount
_require_fs_space $SCRATCH_MNT $((fssize / 1024))
_scratch_unmount
_scratch_mkfs_sized $fssize

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
