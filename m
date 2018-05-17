Received: from mail-pf0-f193.google.com ([209.85.192.193]:43997 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEQDQv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 23:16:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id j20-v6so1348694pff.10
        for <fstests@vger.kernel.org>; Wed, 16 May 2018 20:16:51 -0700 (PDT)
Date: Thu, 17 May 2018 11:16:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/486: Get rid of the redundant error=%d printing
Message-ID: <20180517031645.GE29080@desktop.hz.ali.com>
References: <20180516152714.GA4910@magnolia>
 <1526520970-17213-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526520970-17213-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: darrick.wong@oracle.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 17, 2018 at 09:36:10AM +0800, Xiao Yang wrote:
> 1) Without the fix, perror() can indicate the actual error(ENODATA).
> 2) After calling perror() and redirecting the output of perror()
>    to a file, errno seems to be set to EINVAL unexpectedly.
>    See the following mail for detailed info:
>    https://www.spinics.net/lists/fstests/msg09675.html
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  src/attr_replace_test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index 23adc07..33fa74d 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -11,7 +11,6 @@
>  #include <sys/stat.h>
>  
>  #define die() do { perror(""); \
> -fprintf(stderr, "error=%d at line %d\n", errno, __LINE__); \

We can remove the error number in fprintf, but I think the line number
info is still useful (at least it helped me when I was reviewing the
test).

Thanks,
Eryu

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
