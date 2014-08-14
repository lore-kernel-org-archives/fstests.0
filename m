Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49404 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059AbaHNONO (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Aug 2014 10:13:14 -0400
Date: Thu, 14 Aug 2014 16:13:06 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH 1/2] xfstest: shared/298 fixup mkfs options
In-Reply-To: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org>
Message-ID: <alpine.LFD.2.00.1408141612240.2267@localhost.localdomain>
References: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Wed, 13 Aug 2014, Dmitry Monakhov wrote:

> Date: Wed, 13 Aug 2014 19:36:27 +0400
> From: Dmitry Monakhov <dmonakhov@openvz.org>
> To: fstests@vger.kernel.org
> Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
> Subject: [PATCH 1/2] xfstest: shared/298 fixup mkfs options
> 
> Currently mkfs faile due to incorrect options

Looks good.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

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
>  
>  echo -n "Generating garbage on loop..."
>  # Goal is to fill it up, ignore any errors.
> 
