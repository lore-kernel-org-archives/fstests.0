Received: from mx1.redhat.com ([209.132.183.28]:56458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbdECH3q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 3 May 2017 03:29:46 -0400
Date: Wed, 3 May 2017 15:29:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] attr: adbjust acl_max of f2fs
Message-ID: <20170503072943.GE7250@eguan.usersys.redhat.com>
References: <20170428131307.3384-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428131307.3384-1-chao@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 28, 2017 at 09:13:07PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> f2fs has set inline_xattr as a default option, and introduced a new option
> named 'noinline_xattr' for disabling default inline_xattr option. So in
> _acl_get_max we need to check 'noinline_xattr' string in fs option,
> otherwise we may select the wrong max acl number since we always found
> the string 'ininline_xattr' in fs option.
> 
> Additionally, f2fs has changed disk layout of xattr block a bit, so will
> contain one more entry in both inline and noinline xattr inode, this patch
> will modify the max acl number to adjust it.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Thanks for the patch! It looks fine to me from fstests POV, but need
review from f2fs developers too.

Thanks,
Eryu

> ---
>  common/attr | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index ac139e61..6d4f68ed 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -43,11 +43,11 @@ _acl_get_max()
>  		echo 8191
>  		;;
>  	f2fs)
> -		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
> +		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
>  		if [ $? -eq 0 ]; then
> -			echo 531
> +			echo 507
>  		else
> -			echo 506
> +			echo 532
>  		fi
>  		;;
>  	*)
> -- 
> 2.12.2.575.gb14f27f
> 
