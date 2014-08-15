Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:1590 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751365AbaHOAog (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 Aug 2014 20:44:36 -0400
Date: Fri, 15 Aug 2014 10:44:20 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] xfstest: shared/298 fixup mkfs options
Message-ID: <20140815004420.GI20518@dastard>
References: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 13, 2014 at 07:36:27PM +0400, Dmitry Monakhov wrote:
> Currently mkfs faile due to incorrect options
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  tests/shared/298 |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/shared/298 b/tests/shared/298
> index 372fd02..685ba27 100755
> --- a/tests/shared/298
> +++ b/tests/shared/298
> @@ -134,8 +134,8 @@ mkdir $loop_mnt
>  
>  [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
>  
> -$MKFS_PROG -t $FSTYP $MKFS_OPTIONS $loop_dev &> /dev/null
> -$MOUNT_PROG $loop_dev $loop_mnt
> +run_check $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $loop_dev
> +run_check $MOUNT_PROG $loop_dev $loop_mnt

Urk. Please don't propagate run_check into code that doesn't need
it.

What we should do here is write a generic wrapper - _mkfs_dev -
which allows you to pass in a device to run mkfs on.  This can then
be implemented similar to _scratch_mkfs, and so avoid the need for
everyone to re-invent the wheel slightly differently to support
different filesystems on loop devices in generic/shared tests.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
