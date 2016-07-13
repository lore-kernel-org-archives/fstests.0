Date: Wed, 13 Jul 2016 12:25:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/083: disable dmesg check
Message-ID: <20160713042555.GN2432@eguan.usersys.redhat.com>
References: <1468302104-15288-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468302104-15288-1-git-send-email-yangx.jy@cn.fujitsu.com>
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 12, 2016 at 01:41:44PM +0800, Xiao Yang wrote:
> xfs/083 will corrupt the fs intentionally, there will be WARNINGs
> in dmesg as expected, so here disable dmesg check.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/083 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/xfs/083 b/tests/xfs/083
> index d897754..040f3b6 100755
> --- a/tests/xfs/083
> +++ b/tests/xfs/083
> @@ -102,6 +102,10 @@ scratch_repair() {
>  }
>  
>  rm -f $seqres.full
> +# This test will corrupt fs intentionally, so there will be WARNINGs
> +# in dmesg as expected
> +_disable_dmesg_check
> +

This looks fine to me, but I'd like Darrick to review it as well :)

Thanks,
Eryu

>  echo "See interesting results in $seqres.full" | sed -e "s,$RESULT_DIR,RESULT_DIR,g"
>  SRCDIR=`pwd`
>  test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-3 -n 32"
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
