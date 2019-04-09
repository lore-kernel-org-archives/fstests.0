Received: from aserp2130.oracle.com ([141.146.126.79]:53668 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfDIGB1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Apr 2019 02:01:27 -0400
Date: Mon, 8 Apr 2019 23:01:17 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] src/t_attr_corruption: covert value to little endian
 order
Message-ID: <20190409060117.GG32415@magnolia>
References: <20190409045404.20215-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409045404.20215-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 09, 2019 at 12:54:04PM +0800, Zorro Lang wrote:
> generic/529 always fails on ppc64 or s390x big-endian machine as:
> 
>   set posix acl: Operation not supported
> 
> Due to the members of struct posix_acl_xattr_entry/header need to be
> little-endian byte order, so use htole*() helper to make sure that.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Heh, seems ok... :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  src/t_attr_corruption.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/src/t_attr_corruption.c b/src/t_attr_corruption.c
> index 9101024e..e7d435b1 100644
> --- a/src/t_attr_corruption.c
> +++ b/src/t_attr_corruption.c
> @@ -32,6 +32,7 @@
>  #include <stdint.h>
>  #include <unistd.h>
>  #include <sys/xattr.h>
> +#include <endian.h>
>  
>  void die(const char *msg)
>  {
> @@ -52,13 +53,14 @@ struct myacl {
>  
>  int main(int argc, char *argv[])
>  {
> +	/* posix_acl_xattr_entry/header need little-endian order */
>  	struct myacl acl = {
> -		.d = 2,
> +		.d = htole32(2),
>  		.e = {
> -			{1, 0, 0},
> -			{4, 0, 0},
> -			{0x10, 0, 0},
> -			{0x20, 0, 0},
> +			{htole16(1), 0, 0},
> +			{htole16(4), 0, 0},
> +			{htole16(0x10), 0, 0},
> +			{htole16(0x20), 0, 0},
>  		},
>  	};
>  	char buf[64];
> -- 
> 2.17.2
> 
