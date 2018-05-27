Received: from mail-pl0-f67.google.com ([209.85.160.67]:38918 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936343AbeE0MvE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 May 2018 08:51:04 -0400
Date: Sun, 27 May 2018 20:50:58 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/rc: skip atime related tests on CIFS
Message-ID: <20180527125058.GC6581@desktop>
References: <1526959436-7170-1-git-send-email-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526959436-7170-1-git-send-email-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: XiaoLi Feng <xifeng@redhat.com>
Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 22, 2018 at 11:23:56AM +0800, Xiaoli Feng wrote:
> From: xiaoli feng <xifeng@redhat.com>
> 
> The atime related mount options have no effect on cifs mounts
> now or in the future. So skip these tests on CIFS.
> 
> Signed-off-by: xiaoli feng <xifeng@redhat.com>

Looks fine to me. But I really need an ACK from cifs folks.

> ---
>  common/rc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index ffe5323..d3af55f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3244,6 +3244,8 @@ _require_atime()
>  	_exclude_scratch_mount_option "noatime"
>  	if [ "$FSTYP" == "nfs" ]; then
>  		_notrun "atime related mount options have no effect on NFS"
> +	elif [ "$FSTYP" == "cifs" ]; then
> +		_notrun "atime related mount options have no effect on CIFS"

Or just change the check to a case-switch on $FSTYP?

Thanks,
Eryu

>  	fi
>  }
>  
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
