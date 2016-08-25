Date: Thu, 25 Aug 2016 20:09:03 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs/098: fix xfs_repair on newer xfsprogs
Message-ID: <20160825120903.GF10350@dhcp12-143.nay.redhat.com>
References: <1472116951-3317-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472116951-3317-1-git-send-email-yangx.jy@cn.fujitsu.com>
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 25, 2016 at 05:22:31PM +0800, Xiao Yang wrote:
> Make sure xfs_repair can't clear the log by default when it is corrupted.
> xfs_repair always and only clear the log when the -L parameter is specified.
> This has updated by:
> Commit f2053bc ("xfs_repair: don't clear the log by default")
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/098 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/098 b/tests/xfs/098
> index d91d617..0fe8d93 100755
> --- a/tests/xfs/098
> +++ b/tests/xfs/098
> @@ -93,7 +93,9 @@ echo "+ mount image"
>  _scratch_mount 2>/dev/null && _fail "mount should not succeed"
>  
>  echo "+ repair fs"
> -_scratch_xfs_repair >> $seqres.full 2>&1
> +_scratch_xfs_repair >> $seqres.full 2>&1 && _fail "xfs_repair should not succeed without -L option"

Hi,

If you make it fail at here, this case can't run for old xfsprogs(without
commit f2053bc).

> +
> +_scratch_xfs_repair -L >> $seqres.full 2>&1

For compatibility, maybe you can use "-L" directly. Or use -L
after _scratch_xfs_repair return error.

Thanks,
Zorro

>  
>  echo "+ mount image (2)"
>  _scratch_mount
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
