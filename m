Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:13151 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757409AbcAJXaY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 10 Jan 2016 18:30:24 -0500
Date: Mon, 11 Jan 2016 10:29:38 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] fstests: give user friendly prompts for already
 mounted dir
Message-ID: <20160110232938.GF10456@dastard>
References: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
 <1452148649-22451-3-git-send-email-hejianet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452148649-22451-3-git-send-email-hejianet@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jia He <hejianet@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 07, 2016 at 02:37:29PM +0800, Jia He wrote:
> This adds user friendly prompts to output the already mounted line from _mount.
> xfstests will do the cleanup (ie. umount) and user can not get the mount directory
> information.
> 
> Signed-off-by: Jia He <hejianet@gmail.com>
> ---
>  common/rc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index d33e3fb..5b40fb4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1271,7 +1271,9 @@ _require_scratch_nocheck()
>          # if it's mounted, make sure its on $SCRATCH_MNT
>          if ! _mount | grep -F $SCRATCH_DEV | grep -q $SCRATCH_MNT
>          then
> -            echo "\$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT - aborting"
> +            echo "\$SCRATCH_DEV=$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT=$SCRATCH_MNT - aborting"
> +            echo "Already mounted result:"
> +            _mount | grep -F $SCRATCH_DEV
>              exit 1
>          fi

Should use a temporary local variable rather than looking at the
mount table twice. e.g.

	mount_rec=`_mount | grep -F $SCRATCH_DEV`
	echo $mount_rec | grep -q $SCRATCH_MNT
	if [ $? -ne 0 ]; then
		# new error message
		echo $mount_rec
	fi

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
