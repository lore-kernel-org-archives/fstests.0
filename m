Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:37013 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbaHNRIv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Aug 2014 13:08:51 -0400
Message-ID: <53ECED1E.4070106@sandeen.net>
Date: Thu, 14 Aug 2014 10:08:46 -0700
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] xfstest: shared/298 fixup mkfs options
References: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org
Cc: david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On 8/13/14, 8:36 AM, Dmitry Monakhov wrote:
> Currently mkfs faile due to incorrect options

fails how, for what fs, with what options?

Thanks,
-Eric

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
>  
>  echo -n "Generating garbage on loop..."
>  # Goal is to fill it up, ignore any errors.
> 

