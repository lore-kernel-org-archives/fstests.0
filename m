Received: from mx1.redhat.com ([209.132.183.28]:53932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbdICEZu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 3 Sep 2017 00:25:50 -0400
Date: Sun, 3 Sep 2017 12:25:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 3/3] stat_test, fssum: Include <sys/sysmacros.h> to avoid
 glibc warning
Message-ID: <20170903042547.GV27835@eguan.usersys.redhat.com>
References: <20170829133715.12275-1-tuomas.tynkkynen@iki.fi>
 <20170829133715.12275-3-tuomas.tynkkynen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829133715.12275-3-tuomas.tynkkynen@iki.fi>
Sender: fstests-owner@vger.kernel.org
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 29, 2017 at 04:37:15PM +0300, Tuomas Tynkkynen wrote:
> Compiling against a recent glibc gives a number of warnings of this
> sort:
> 
> stat_test.c: In function 'cmp_statx':
> stat_test.c:251:13: warning: In the GNU C Library, "major" is defined
>  by <sys/sysmacros.h>. For historical compatibility, it is
>  currently defined by <sys/types.h> as well, but we plan to
>  remove this soon. To use "major", include <sys/sysmacros.h>
>  directly. If you did not intend to use a system-defined macro
>  "major", you should undefine it after including <sys/types.h>.
>   devcmp(dev);
> 
> Do as the message says to avoid it. xfstests already includes
> <sys/sysmacros.h> in two other places so it seems safe to assume this
> header generally exists.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> ---
>  src/fssum.c     | 1 +
>  src/stat_test.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/src/fssum.c b/src/fssum.c
> index 04052cdc..fa763d19 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -29,6 +29,7 @@
>  #include <fcntl.h>
>  #include <dirent.h>
>  #include <errno.h>
> +#include <sys/sysmacros.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/sysmacros.h>

Sorry, I just found this in my release review/testing, "sys/sysmacros.h>
has already been included here, and this was from commit 85e3bf85c67c
("src: include <sys/sysmacros.h> for major() and minor()").

I tested with Fedora rawhide (glibc-2.26.90-9, gcc-7.1.1-7) and I didn't
see this warning when compiling current fstests code. Could you please
help double check if this works for you too with latest fstests? I'll
drop this patch for now.

Thanks,
Eryu

> diff --git a/src/stat_test.c b/src/stat_test.c
> index 198c1332..ba1650f2 100644
> --- a/src/stat_test.c
> +++ b/src/stat_test.c
> @@ -17,6 +17,7 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <sys/sysmacros.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/sysmacros.h>
> -- 
> 2.13.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
