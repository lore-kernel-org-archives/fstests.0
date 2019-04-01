Received: from mail-pg1-f194.google.com ([209.85.215.194]:41936 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDALQB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Apr 2019 07:16:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so4598320pgs.8
        for <fstests@vger.kernel.org>; Mon, 01 Apr 2019 04:16:01 -0700 (PDT)
Date: Mon, 1 Apr 2019 19:15:54 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] common/rc: add global mounted option for
 _scratch_remount
Message-ID: <20190401111554.GE2824@desktop>
References: <20190331123130.14922-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331123130.14922-1-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: XiaoLi Feng <xifeng@redhat.com>
Cc: fstests@vger.kernel.org, smfrench@gmail.com
List-ID: <fstests@vger.kernel.org>

On Sun, Mar 31, 2019 at 08:31:30PM +0800, Xiaoli Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
> 
> When call _scratch_remount for cifs , it always requires to input
> password. This will make generic/306 generic/452 failed because
> cifs remount failed.
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 1c42515f..ea1eaf6a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -357,7 +357,7 @@ _scratch_remount()
>      local opts="$1"
>  
>      if test -n "$opts"; then
> -	mount -o "remount,$opts" $SCRATCH_MNT
> +	mount $MOUNT_OPTIONS -o "remount,$opts" $SCRATCH_MNT

IMHO, your v1 patch looks better, just need to update overlay/035 to use
bare $MOUNT_PROG to do the first remount.

Thanks,
Eryu

>      fi
>  }
>  
> -- 
> 2.18.1
> 
