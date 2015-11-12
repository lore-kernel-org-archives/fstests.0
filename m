Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:50827 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752438AbbKLAtT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 11 Nov 2015 19:49:19 -0500
Date: Thu, 12 Nov 2015 11:49:17 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] btrfs/104: replace ugly sleep with subvol sync
Message-ID: <20151112004917.GQ19199@dastard>
References: <20151110003002.GK15575@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151110003002.GK15575@wotan.suse.de>
Sender: fstests-owner@vger.kernel.org
To: Mark Fasheh <mfasheh@suse.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Mark,

On Mon, Nov 09, 2015 at 04:30:02PM -0800, Mark Fasheh wrote:
> Btrfsprogs now has 'subvolume sync' which will wait until deleted subvolumes
> are cleaned from disk.
> 
> Signed-off-by: Mark Fasheh <mfasheh@suse.de>
> ---
>  tests/btrfs/104 | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/btrfs/104 b/tests/btrfs/104
> index 80161a3..6848b87 100644
> --- a/tests/btrfs/104
> +++ b/tests/btrfs/104
> @@ -146,11 +146,9 @@ _scratch_remount
>  # referenced above.
>  _run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
>  
> -# There is no way from userspace to force btrfs_drop_snapshot to run
> -# at a given time (even via mount/unmount). We must wait for it to
> -# start and complete. This is the shortest time on my tests systems I
> -# have found which always allows drop_snapshot to run to completion.
> -sleep 45
> +# Subvol delete is a delayed operation, wait for it to complete before
> +# unmounting.
> +_run_btrfs_util_prog subvolume sync $SCRATCH_MNT

Won't that now fail on systems without the "subvolume sync"
command because of the hidden use of _run_check in
_run_btrfs_util_prog? i.e. doesn't it need to do something like:

$BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT
if [ $? -ne 0 ]; then
	sleep 45
fi

So that it works on all versions of the btrfs utility?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
