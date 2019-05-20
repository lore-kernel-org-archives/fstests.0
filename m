Received: from userp2130.oracle.com ([156.151.31.86]:46304 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbfETQXu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 May 2019 12:23:50 -0400
Date: Mon, 20 May 2019 09:23:43 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] src/attr_replace_test: limit size of extended attribute
 value
Message-ID: <20190520162343.GK5352@magnolia>
References: <20190517120653.22180-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517120653.22180-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 17, 2019 at 01:06:53PM +0100, Luis Henriques wrote:
> The maximum size for extended attribute values is 65536 (XATTR_SIZE_MAX).
> Since there are filesystems that can set blksize to really big values
> (CephFS for example has a default of 4M), it's easy to have this test
> failing with fsetxattr returning -E2BIG.
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  src/attr_replace_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index 0720bfdc18ab..1ca9bf11ba58 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -9,6 +9,7 @@
>  #include <sys/types.h>
>  #include <sys/xattr.h>
>  #include <sys/stat.h>
> +#include <linux/limits.h>
>  
>  #define die() do { perror(""); \
>  fprintf(stderr, "error at line %d\n", __LINE__); \
> @@ -44,6 +45,8 @@ int main(int argc, char *argv[])
>  	size = sbuf.st_blksize * 3 / 4;
>  	if (!size)
>  		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
> +	if (size > XATTR_SIZE_MAX)
> +		size = XATTR_SIZE_MAX;

Looks good to me (this or the min()/MIN()/whatever version),

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D


>  	value = malloc(size);
>  	if (!value)
>  		fail("Failed to allocate memory\n");
