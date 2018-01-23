Received: from mx1.redhat.com ([209.132.183.28]:40072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeAWEBs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 23:01:48 -0500
Date: Tue, 23 Jan 2018 12:01:46 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 1/8] fsstress: Include stddef.h for ptrdiff_t
Message-ID: <20180123040146.GG3102@eguan.usersys.redhat.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-2-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516636639-9107-2-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 03:57:12PM +0000, Rostislav Skudnov wrote:
> In musl C library headers ptrdiff_t is only defined in stddef.h.

It seems ptrdiff_t is only used to save the return value of xfsctl(),

	ptrdiff_t       srval;
	...
	srval = xfsctl(buf, fd, XFS_IOC_ERROR_INJECTION, &err_inj);

and xfsctl(3) shows that it returns an int.

	int xfsctl(const char *path, int fd, int cmd, void *ptr);

I think we could just change type of srval to int.

Thanks,
Eryu

>
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
> ---
>  ltp/fsstress.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 4dea029..63c2eb4 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -19,6 +19,7 @@
>  #include <linux/fs.h>
>  #include <setjmp.h>
>  #include <sys/uio.h>
> +#include <stddef.h>
>  #include "global.h"
>  
>  #ifdef HAVE_ATTR_XATTR_H
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
