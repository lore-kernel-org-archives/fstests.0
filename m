Received: from userp2130.oracle.com ([156.151.31.86]:49222 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPP1a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 11:27:30 -0400
Date: Wed, 16 May 2018 08:27:14 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/486: print correct errno
Message-ID: <20180516152714.GA4910@magnolia>
References: <1526457604-10060-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526457604-10060-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, libc-alpha-help@sourceware.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 16, 2018 at 04:00:04PM +0800, Xiao Yang wrote:
> On glibc v2.12 or v2.17, running generic/486 with XFS got wrong
> EINVAL instead of ENODATA:
> ----------------------------------------------------------------
> QA output created by 486
> No data available
> error=22 at line 63

This is a regression test for a kernel patch; the XATTR_REPLACE is
supposed to succeed if you've added the fix.  If it throws any kind of
error then the kernel is misbehaving, but it doesn't really matter which
error we get.

However, we could just get rid of the redundant error=%d printing,
seeing as we just perror'd anyway.

--D

> ----------------------------------------------------------------
> 
> We want to save the correct errno and print it after calling perror().
> 
> It seems that only calling perror() didn't change the errno, but calling
> perror() and redirecting the output of perror() to a file set errno to
> EINVAL.
> 
> For example, running the special test.c to reproduce the issue:
> ------------------------------------------------------------
> #include <errno.h>
> #include <unistd.h>
> #include <stdio.h>
> 
> int main(void)
> {
>         close(-1);
>         printf("errno %d before\n", errno);
>         perror("");
>         printf("errno %d after\n", errno);
> }
> ------------------------------------------------------------
> # gcc -o test test.c
> # ./test
> # ./test 2>log
> 
> fdopen() called by perror() in glibc seems to set errno to EINVAL
> in some cases(e.g. the access mode of stderr is O_WRONLY). I am not
> sure whether this is a perror bug in glibc or not.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  src/attr_replace_test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index 23adc07..e9a08cc 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -10,8 +10,9 @@
>  #include <sys/xattr.h>
>  #include <sys/stat.h>
>  
> -#define die() do { perror(""); \
> -fprintf(stderr, "error=%d at line %d\n", errno, __LINE__); \
> +#define die() do { int real_errno = errno; \
> +perror(""); \
> +fprintf(stderr, "error=%d at line %d\n", real_errno, __LINE__); \
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
