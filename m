Received: from mx1.redhat.com ([209.132.183.28]:51944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390080AbfIJE2x (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Sep 2019 00:28:53 -0400
Date: Tue, 10 Sep 2019 12:28:51 +0800
From: Murphy Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] generic/566:  skip this test if -f option is
 non-supported
Message-ID: <20190910042851.ybwqgmh2a4xue3f4@XZHOUW.usersys.redhat.com>
References: <1568024086-2151-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568024086-2151-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 09, 2019 at 06:14:46PM +0800, Yang Xu wrote:
> This test will use xfs_quota -f option, this option was introduced
> since xfsprogs v4.10.0-rc1. On old version, we should skip this case.

Tested and ack.

Thanks!

> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/generic/566 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/566 b/tests/generic/566
> index e8491e54..173974ad 100755
> --- a/tests/generic/566
> +++ b/tests/generic/566
> @@ -34,6 +34,7 @@ _supported_os Linux
>  _supported_fs generic
>  _require_scratch
>  _require_quota
> +_require_xfs_quota_foreign
>  _require_user
>  
>  rm -f $seqres.full
> -- 
> 2.18.1
> 
> 
> 
