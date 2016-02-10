Received: from mx1.redhat.com ([209.132.183.28]:34497 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064AbcBJJJM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 04:09:12 -0500
Date: Wed, 10 Feb 2016 17:09:10 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 09/12] xfstests: generic/079 requires chattr, not xattrs
Message-ID: <20160210090909.GW11419@eguan.usersys.redhat.com>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-10-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455069001-17846-10-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 09, 2016 at 08:49:58PM -0500, Theodore Ts'o wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/079 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/079 b/tests/generic/079
> index 041d9c0..a2c3286 100755
> --- a/tests/generic/079
> +++ b/tests/generic/079
> @@ -48,7 +48,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  
> -_require_attrs
> +_require_chattr

I don't see _require_chattr in any of the common files, did I miss
anything?

Thanks,
Eryu

>  _require_scratch
>  
>  [ -x $timmutable ] || _notrun "t_immutable was not built for this platform"
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
