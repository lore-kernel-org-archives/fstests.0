Received: from userp1040.oracle.com ([156.151.31.81]:43705 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdBWHBh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Feb 2017 02:01:37 -0500
Date: Wed, 22 Feb 2017 23:01:30 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/095: fix duplicate variable name
Message-ID: <20170223070130.GA22332@birch.djwong.org>
References: <1487819301-7401-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487819301-7401-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 23, 2017 at 11:08:21AM +0800, Zorro Lang wrote:
> I think this definitely isn't what we want:
>   local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
>   local warn4="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
> 
> The second warn4 will overlay the first one. So change the second
> to warn5.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/095 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/095 b/tests/generic/095
> index 991baef..d837564 100755
> --- a/tests/generic/095
> +++ b/tests/generic/095
> @@ -128,12 +128,12 @@ filter_xfs_dmesg()
>  	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
>  	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
>  	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
> -	local warn4="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
> +	local warn5="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
>  	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
>  	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
>  	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
>  	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
> -	    -e "s#$warn4#Intentional warnings in iomap_dio_rw#"
> +	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#"
>  }
>  
>  # umount before checking dmesg in case umount triggers any WARNING or Oops
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
