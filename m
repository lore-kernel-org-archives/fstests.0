Received: from mx1.redhat.com ([209.132.183.28]:53842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbdCAI7k (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 1 Mar 2017 03:59:40 -0500
Date: Wed, 1 Mar 2017 16:59:39 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ext4/306: require 64bit feature to run ext4/306
Message-ID: <20170301085939.GG14226@eguan.usersys.redhat.com>
References: <1488355022-22218-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488355022-22218-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 01, 2017 at 03:57:02PM +0800, Xiao Yang wrote:
> The 64bit feature isn't supported by mkfs.ext4 on RHEL6, so
> we add _require_ext4_mkfs_64bit to check it.  If 64bit feature
> isn't supported, we could skip this case.  This feature has
> been produced by 'commit 02d6f47e9647d ("mke2fs: Fix up mke2fs
> to be able to make 64-bit file systems")'.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc      | 7 +++++++
>  tests/ext4/306 | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 8f23334..0c3c154 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1669,6 +1669,13 @@ _require_scratch_ext4_crc()
>  	_scratch_unmount
>  }
>  
> +# this test requires the 64bit feature to be available in mkfs.ext4
> +_require_ext4_mkfs_64bit()
> +{
> +	$MKFS_EXT4_PROG -F -O 64bit -n $SCRATCH_DEV 512m >/dev/null 2>&1 \

I think you can use an fs image file instead of the SCRATCH_DEV, so that
it doesn't assume we have SCRATCH_DEV defined.

Thanks,
Eryu

> +	   || _notrun "mkfs.ext4 doesn't have 64bit feature"
> +}
> +
>  # this test requires the bigalloc feature to be available in mkfs.ext4
>  #
>  _require_ext4_mkfs_bigalloc()
> diff --git a/tests/ext4/306 b/tests/ext4/306
> index fa3b782..4a92dd2 100755
> --- a/tests/ext4/306
> +++ b/tests/ext4/306
> @@ -44,6 +44,7 @@ _supported_fs ext4
>  _supported_os Linux
>  
>  _require_scratch
> +_require_ext4_mkfs_64bit
>  
>  rm -f $seqres.full
>  
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
