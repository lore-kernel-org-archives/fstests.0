Received: from userp2130.oracle.com ([156.151.31.86]:35300 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfEUSRh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 May 2019 14:17:37 -0400
Date: Tue, 21 May 2019 11:17:30 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] src/attr_replace_test: limit size of extended
 attribute value
Message-ID: <20190521181730.GB5155@magnolia>
References: <fa6146ed-e9c3-20da-0baa-36b9ceafbf8f@suse.com>
 <20190521082836.4482-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521082836.4482-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 21, 2019 at 09:28:36AM +0100, Luis Henriques wrote:
> The maximum size for extended attribute values is 65536 (XATTR_SIZE_MAX).
> Since there are filesystems that can set blksize to really big values
> (CephFS for example has a default of 4M), it's easy to have this test
> failing with fsetxattr returning -E2BIG.
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  src/attr_replace_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index 0720bfdc18ab..cca8dcf8ff60 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -9,6 +9,8 @@
>  #include <sys/types.h>
>  #include <sys/xattr.h>
>  #include <sys/stat.h>
> +#include <sys/param.h>
> +#include <linux/limits.h>
>  
>  #define die() do { perror(""); \
>  fprintf(stderr, "error at line %d\n", __LINE__); \
> @@ -44,6 +46,7 @@ int main(int argc, char *argv[])
>  	size = sbuf.st_blksize * 3 / 4;
>  	if (!size)
>  		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
> +	size = MIN(size, XATTR_SIZE_MAX);
>  	value = malloc(size);
>  	if (!value)
>  		fail("Failed to allocate memory\n");
