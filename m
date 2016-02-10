Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:53287 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751186AbcBJGB0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 01:01:26 -0500
Date: Wed, 10 Feb 2016 17:00:58 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 02/12] common: _scratch_mkfs_sized() for tmpfs
Message-ID: <20160210060058.GU19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-3-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455069001-17846-3-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 09, 2016 at 08:49:51PM -0500, Theodore Ts'o wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> _scratch_mkfs_sized() avoid blockdev and update MOUNT_OPTIONS with
> required size on tmpfs, so those tests using it can now run.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Junho Ryu <jayr@google.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/rc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 76e02e4..aca723f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -813,7 +813,7 @@ _scratch_mkfs_sized()
>  
>      blocks=`expr $fssize / $blocksize`
>  
> -    if [ "$HOSTOS" == "Linux" ]; then
> +    if [ "$HOSTOS" == "Linux" -a -b "$SCRATCH_DEV" ]; then
>  	devsize=`blockdev --getsize64 $SCRATCH_DEV`
>  	[ "$fssize" -gt "$devsize" ] && _notrun "Scratch device too small"
>      fi
> @@ -849,6 +849,9 @@ _scratch_mkfs_sized()
>  	sector_size=`blockdev --getss $SCRATCH_DEV`
>  	$MKFS_F2FS_PROG $MKFS_OPTIONS $SCRATCH_DEV `expr $fssize / $sector_size`
>  	;;
> +    tmpfs)
> +	export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"

So what happens when the test asks for 10GB of device space, and you
only have 4GB of RAM?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
