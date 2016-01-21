Received: from sandeen.net ([63.231.237.45]:49113 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbcAUD2G (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jan 2016 22:28:06 -0500
Subject: Re: [PATCH] fsx.c: Add header file stdbool.h
References: <1453190428-7379-1-git-send-email-yangx.jy@cn.fujitsu.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <56A05042.8050706@sandeen.net>
Date: Wed, 20 Jan 2016 21:28:02 -0600
MIME-Version: 1.0
In-Reply-To: <1453190428-7379-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 1/19/16 2:00 AM, Xiao Yang wrote:
> Compilation failed on RHEL6.7GA because stdbool.h is not included in
> xfs/platform_defs-x86_64.h or xfs/linux.h on RHEL6.7GA, so fix it.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

I hit this as well, thanks.


Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  ltp/fsx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 28f109c..a7b36c1 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -20,6 +20,7 @@
>  #include <strings.h>
>  #include <sys/file.h>
>  #include <sys/mman.h>
> +#include <stdbool.h>
>  #ifdef HAVE_ERR_H
>  #include <err.h>
>  #endif
> 
