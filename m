Received: from userp2120.oracle.com ([156.151.31.85]:53026 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQOzv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 May 2018 10:55:51 -0400
Date: Thu, 17 May 2018 07:55:43 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v3] generic/486: Get rid of the redundant error=%d
 printing
Message-ID: <20180517145543.GE4910@magnolia>
References: <20180517031645.GE29080@desktop.hz.ali.com>
 <1526527947-4905-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526527947-4905-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 17, 2018 at 11:32:27AM +0800, Xiao Yang wrote:
> 1) Without the fix, perror() can indicate the actual error(ENODATA).
> 2) After calling perror() and redirecting the output of perror()
>    to a file, errno seems to be set to EINVAL unexpectedly.
>    See the following mail for detailed info:
>    https://www.spinics.net/lists/fstests/msg09675.html
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  src/attr_replace_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index 23adc07..0720bfd 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -11,7 +11,7 @@
>  #include <sys/stat.h>
>  
>  #define die() do { perror(""); \
> -fprintf(stderr, "error=%d at line %d\n", errno, __LINE__); \
> +fprintf(stderr, "error at line %d\n", __LINE__); \
>  exit(1); } while (0)
>  
>  #define fail(...) do { \
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
