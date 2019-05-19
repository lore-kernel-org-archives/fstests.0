Received: from mx2.suse.de ([195.135.220.15]:34772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfESR1f (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 19 May 2019 13:27:35 -0400
Subject: Re: [PATCH] src/attr_replace_test: limit size of extended attribute
 value
References: <20190517120653.22180-1-lhenriques@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <a7ca5248-89ce-6695-7809-9c2c483a5142@suse.com>
Date: Sun, 19 May 2019 20:27:31 +0300
MIME-Version: 1.0
In-Reply-To: <20190517120653.22180-1-lhenriques@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Luis Henriques <lhenriques@suse.com>, fstests@vger.kernel.org
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>



On 17.05.19 =D0=B3. 15:06 =D1=87., Luis Henriques wrote:
> The maximum size for extended attribute values is 65536 (XATTR_SIZE_MAX=
).
> Since there are filesystems that can set blksize to really big values
> (CephFS for example has a default of 4M), it's easy to have this test
> failing with fsetxattr returning -E2BIG.
>=20
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  src/attr_replace_test.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index 0720bfdc18ab..1ca9bf11ba58 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -9,6 +9,7 @@
>  #include <sys/types.h>
>  #include <sys/xattr.h>
>  #include <sys/stat.h>
> +#include <linux/limits.h>
> =20
>  #define die() do { perror(""); \
>  fprintf(stderr, "error at line %d\n", __LINE__); \
> @@ -44,6 +45,8 @@ int main(int argc, char *argv[])
>  	size =3D sbuf.st_blksize * 3 / 4;
>  	if (!size)
>  		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
> +	if (size > XATTR_SIZE_MAX)
> +		size =3D XATTR_SIZE_MAX;

nit: size =3D max(size, XATTRS_SIZE_MAX);

>  	value =3D malloc(size);
>  	if (!value)
>  		fail("Failed to allocate memory\n");
>=20
