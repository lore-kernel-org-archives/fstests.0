Received: from mail-pl1-f194.google.com ([209.85.214.194]:42620 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDIBuS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Apr 2019 21:50:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so8386683plb.9
        for <fstests@vger.kernel.org>; Mon, 08 Apr 2019 18:50:18 -0700 (PDT)
Date: Tue, 9 Apr 2019 09:50:11 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3] common/rc: use _try_scratch_mount for scratch_remount
Message-ID: <20190409015011.GK2824@desktop>
References: <20190408023029.13135-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408023029.13135-1-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: XiaoLi Feng <xifeng@redhat.com>
Cc: fstests@vger.kernel.org, smfrench@gmail.com
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 08, 2019 at 10:30:29AM +0800, Xiaoli Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
> 
> When call _scratch_remount for cifs , it always requires to input
> password. This will make generic/306 generic/452 failed because
> cifs remount failed.

You're missing Signed-off-by tag, would you please resend?

And many thanks to Steve French for helping test the patch! May I add
your Tested-by tag?

Thanks,
Eryu

> ---
>  common/rc         | 2 +-
>  tests/overlay/035 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 1c42515f..6c262e32 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -357,7 +357,7 @@ _scratch_remount()
>      local opts="$1"
>  
>      if test -n "$opts"; then
> -	mount -o "remount,$opts" $SCRATCH_MNT
> +	_try_scratch_mount "-o remount,$opts"
>      fi
>  }
>  
> diff --git a/tests/overlay/035 b/tests/overlay/035
> index f36c1e10..c0aae935 100755
> --- a/tests/overlay/035
> +++ b/tests/overlay/035
> @@ -55,7 +55,7 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
>  $MOUNT_PROG -t overlay -o"lowerdir=$lowerdir2:$lowerdir1" \
>  			$OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
>  touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> -_scratch_remount rw 2>&1 | _filter_ro_mount
> +$MOUNT_PROG -o remount,rw $SCRATCH_MNT 2>&1 | _filter_ro_mount
>  $UMOUNT_PROG $SCRATCH_MNT
>  
>  # Make workdir immutable to prevent workdir re-create on mount
> -- 
> 2.18.1
> 
