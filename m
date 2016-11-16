Received: from mx1.redhat.com ([209.132.183.28]:34436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752409AbcKPDvv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Nov 2016 22:51:51 -0500
Date: Wed, 16 Nov 2016 11:51:49 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs/298: cd to / instead of ~
Message-ID: <20161116035149.GE14383@dhcp12-143.nay.redhat.com>
References: <151e7c9999ff4680ee8456a75c5a527dede906fe.1479256416.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151e7c9999ff4680ee8456a75c5a527dede906fe.1479256416.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 15, 2016 at 04:34:01PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In our kernel testing infrastructure, "$HOME" isn't defined. Everywhere
> else in xfstests does `cd /` instead, so let's just do that.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  tests/xfs/298 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/298 b/tests/xfs/298
> index 7702526..26fb5c8 100755
> --- a/tests/xfs/298
> +++ b/tests/xfs/298
> @@ -80,7 +80,7 @@ while [ $SIZE -lt 1024 ];do
>  # remove the symlink - make sure ifree removes the remote symlink.
>  	rm $SYMLINK_FILE
>  # umount and check the number of extents on the inode. Should be 0.
> -	cd
> +	cd /

How about do this:
  while
    ...
    pushd $SCRATCH_MNT >/dev/null
    ...
    ...
    popd >/dev/null
    ...
  done

Thanks,
Zorro

>  	_scratch_unmount >/dev/null 2>&1
>  	_scratch_xfs_db  -c "inode $inode" -c "p core.nextents"
>  
> -- 
> 2.10.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
