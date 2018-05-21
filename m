Received: from mx1.redhat.com ([209.132.183.28]:35510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeEUIuk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 May 2018 04:50:40 -0400
Date: Mon, 21 May 2018 04:50:39 -0400 (EDT)
From: Xiaoli Feng <xifeng@redhat.com>
Message-ID: <2039299000.2955896.1526892639579.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180521075027.GL29080@desktop.hz.ali.com>
References: <1526641829-9893-1-git-send-email-xifeng@redhat.com> <20180521075027.GL29080@desktop.hz.ali.com>
Subject: Fwd: [PATCH] common/rc: add the function _require_noatime
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: linux-cifs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


[add linux-cifs@vger.kernel.org to cc list]

----- Forwarded Message -----
From: "Eryu Guan" <guaneryu@gmail.com>
To: "XiaoLi Feng" <xifeng@redhat.com>
Cc: fstests@vger.kernel.org
Sent: Monday, May 21, 2018 3:50:27 PM
Subject: Re: [PATCH] common/rc: add the function _require_noatime

[add linux-cifs@vger.kernel.org to cc list]

On Fri, May 18, 2018 at 07:10:29PM +0800, Xiaoli Feng wrote:
> From: xiaoli feng <xifeng@redhat.com>
> 
> In the generic/120, it will make the test not-pass if the filesystem
> mounts failed with noatime. Now change this result to norun. The
> filesystem cifs doesn't support noatime. Just make the test norun
> until it supports noatime.
> 
> Signed-off-by: xiaoli feng <xifeng@redhat.com>
> ---
>  common/rc         | 8 +++++++-
>  tests/generic/120 | 7 +------
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index ffe5323..9c45f1b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3244,7 +3244,13 @@ _require_atime()
>  	_exclude_scratch_mount_option "noatime"
>  	if [ "$FSTYP" == "nfs" ]; then
>  		_notrun "atime related mount options have no effect on NFS"
> -	fi

I'm not sure what's the expected behavior from CIFS on atime/noatime, so
I added linux-cifs list for input.

If CIFS behaves similarly to NFS, looks like that you could simply add
another check for cifs in _require_atime(), as what we already do for
nfs, so all tests that _require_atime() will _notrun on cifs.

> +}
> +
> +_require_noatime()
> +{
> +	_exclude_scratch_mount_option "atime"
> +	 _try_scratch_mount -o noatime || \
> +                _notrun "noatime not supported by the current tested filesystem"
>  }
>  
>  _require_relatime()
> diff --git a/tests/generic/120 b/tests/generic/120
> index 1180c10..ddd61b3 100755
> --- a/tests/generic/120
> +++ b/tests/generic/120
> @@ -60,12 +60,7 @@ _compare_access_times()
>  
>  }
>  
> -if ! _try_scratch_mount "-o noatime" >$tmp.out 2>&1
> -then
> -    cat $tmp.out
> -    echo "!!! mount failed"
> -    exit
> -fi
> +_require_noatime

Anyway, failing the test when "noatime" mount fails is one of the
purposes of the test, and it shouldn't be removed, as we've already made
sure current FSTYP supports atime/noatime (by _require rules), so a
noatime mount failure indicates a bug in the filesystem.

Thanks,
Eryu

>  
>  #executable file
>  echo "*** copying file ***"
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
