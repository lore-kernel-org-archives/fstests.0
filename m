Received: from userp2130.oracle.com ([156.151.31.86]:52962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfC0OlR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Mar 2019 10:41:17 -0400
Date: Wed, 27 Mar 2019 07:41:10 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/065: make sure SCRATCH_DEV is unmount before mkfs
Message-ID: <20190327144110.GD6537@magnolia>
References: <20190327074509.27770-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327074509.27770-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 27, 2019 at 03:45:09PM +0800, Zorro Lang wrote:
> Commit "8309b39a fstests: fix broken _require_scratch usage" did
> below change on xfs/065:
> 
>   -_scratch_unmount 2>/dev/null
>   +_scratch_mkfs_xfs >> $seqres.full
> 
> It cause xfs/065 always fails now, as:
>   QA output created by 065
>   mkfs.xfs: /dev/sdb2 contains a mounted filesystem
>   ...
> 
> So use _require_scratch, to make sure the SCRATCH_DEV is unmounted
> before mkfs.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

DOH, stupid editor... <grumble>

Sorry about that.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/065 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/065 b/tests/xfs/065
> index c0d1ee93..f09bd947 100755
> --- a/tests/xfs/065
> +++ b/tests/xfs/065
> @@ -50,6 +50,7 @@ _list_dir()
>  # real QA test starts here
>  _supported_fs xfs
>  _supported_os Linux
> +_require_scratch
>  
>  #
>  # too much hassle to get output matching with quotas turned on
> -- 
> 2.17.2
> 
