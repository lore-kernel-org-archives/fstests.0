Received: from mail-pl1-f196.google.com ([209.85.214.196]:34357 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbeLOM3T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 15 Dec 2018 07:29:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so3996400plz.1
        for <fstests@vger.kernel.org>; Sat, 15 Dec 2018 04:29:18 -0800 (PST)
Date: Sat, 15 Dec 2018 20:29:10 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] common/rc: Fix mismatched output from standard mkswap
Message-ID: <20181215122910.GU3889@desktop>
References: <20180607095207.GH2861@desktop>
 <1544774247-14706-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544774247-14706-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, osandov@fb.com
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 14, 2018 at 03:57:27PM +0800, Xiao Yang wrote:
> With older util-linux(e.g. v2.17.2), running some tests(e.g. generic/472,
> generic/495) got the following output:
> -------------------------------------------------------
> +mkswap: /mnt/xfstests/scratch/swap: warning: don't erase bootbits sectors
> +        on whole disk. Use -f to force.
> +mkswap: unable to relabel /mnt/xfstests/scratch/swap to system_u:object_r:swapfile_t:s0: Operation not supported
> -------------------------------------------------------
> 
> 1) Before commit c1f1b30 of util-linux, mkswap didn't zap bootbits sectors
>    and printed a warning until force option(i.e. -f) was given.  We try to
>    add the force option.
> 
> 2) With mounting default SELinux context(e.g. system_u:object_r:root_t:s0),
>    standard mkswap tried to reset the type of default context to swapfile_t
>    if it is not swapfile_t, and then it failed and returned ENOTSUP expectedly
>    as we don't want to create any SELinux attr on purpose.  standard mkswap
>    ignored this relabel error by commit d97dc0e of util-linux, but it still
>    reported the error before commit d97dc0e.  We try to skip the reset step
>    in standard mkswap by mounting swapfile context.
> 
> Note:
> We just mount swapfile context in related tests, and keep default context
> in the rest of tests.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index e5da648..4bdb870 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2210,7 +2210,7 @@ _format_swapfile() {
>  	# Swap files must be nocow on Btrfs.
>  	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
>  	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
> -	mkswap "$fname" >> $seqres.full
> +	mkswap -f "$fname" >> $seqres.full

I looked at it again, and realized that we have other places that call
mkswap would have the same problem, e.g. btrfs/173 and xfs/419.

So I think it'd be better to introduce MKSWAP_PROG and make it
"mkswap -f" and use $MKSWAP_PROG here and in tests, so we don't have to
worry about this issue for new tests.

>  }
>  
>  # Check that the filesystem supports swapfiles
> @@ -2219,6 +2219,8 @@ _require_scratch_swapfile()
>  	_require_scratch
>  
>  	_scratch_mkfs >/dev/null
> +	[ -n "$SELINUX_MOUNT_OPTIONS" ] && export \
> +		SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"

Better to add comments on why we're doing this.

Thanks!
Eryu
>  	_scratch_mount
>  
>  	# Minimum size for mkswap is 10 pages
> -- 
> 1.8.3.1
> 
> 
> 
