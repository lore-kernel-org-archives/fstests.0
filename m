Received: from mail-pl1-f193.google.com ([209.85.214.193]:34805 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfC3Lyo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 30 Mar 2019 07:54:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so2260844plt.1
        for <fstests@vger.kernel.org>; Sat, 30 Mar 2019 04:54:44 -0700 (PDT)
Date: Sat, 30 Mar 2019 19:54:36 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/rc: use _try_scratch_mount for scratch_remount
Message-ID: <20190330115436.GC2824@desktop>
References: <20190328115233.24816-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328115233.24816-1-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: XiaoLi Feng <xifeng@redhat.com>
Cc: fstests@vger.kernel.org, smfrench@gmail.com, Xiaoli Feng <fengxiaoli0714@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 28, 2019 at 07:52:33PM +0800, Xiaoli Feng wrote:
> From: Xiaoli Feng <fengxiaoli0714@gmail.com>
> 
> When use scratch_remount, it always gives up the global mounted
> options. Then will make cifs mount failed for generic/306
> generic/452.
> 
> Signed-off-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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

This breaks overlay/035, in which the first overlay mount is done with
only lowerdir, so a normal _try_scratch_mount won't work. Switch it to a
bare $MOUNT_PROG would work.

Thanks,
Eryu

>      fi
>  }
>  
> -- 
> 2.18.1
> 
