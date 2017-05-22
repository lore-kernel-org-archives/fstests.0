Received: from mx1.redhat.com ([209.132.183.28]:45658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934920AbdEVOiL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 May 2017 10:38:11 -0400
Date: Mon, 22 May 2017 22:38:04 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] Stop relying on OpenSSL
Message-ID: <20170522143804.GT7250@eguan.usersys.redhat.com>
References: <20170522010528.23463-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522010528.23463-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, May 21, 2017 at 09:05:27PM -0400, Theodore Ts'o wrote:
> The OpenSSL dependency was added for one program, fssum, and it needs
> it only because it needs a md5 implementation.  Use Solar Designer's
> openssl compatible implementation of md5 so we no longer need to
> depend on OpenSSL.
> 
> Since the OpenSSL libraries are not always available, we had to add
> extra complexity to test to see whether fssum exists.  This commit
> will allow us to drop _require_fssum tests.
> 
> The other problem with depending on the OpenSSL libraries is that
> shared library compatibility situation is terrible; a fssum binary
> built on a system using libssl1.0.0 is *NOT* run on a system with
> libssl1.0.2, since the shared libraries are incompatible even across a
> minor version bump.  (Sigh.)
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

README can be updated too to remove openssl-devel as a prerequisite
package.

> ---
>  configure.ac         |   1 -
>  include/builddefs.in |   1 -
>  m4/package_ssldev.m4 |   4 -
>  src/Makefile         |  16 ++-
>  src/fssum.c          |   6 +-
>  src/md5.c            | 291 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/md5.h            |  45 ++++++++
>  7 files changed, 345 insertions(+), 19 deletions(-)
>  delete mode 100644 m4/package_ssldev.m4
>  create mode 100644 src/md5.c
>  create mode 100644 src/md5.h
> 
> diff --git a/configure.ac b/configure.ac
> index 5ddaadc2..843ff6b6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -79,7 +79,6 @@ in
>  		AC_PACKAGE_WANT_OPEN_BY_HANDLE_AT
>  		AC_PACKAGE_WANT_LINUX_PRCTL_H
>  		AC_PACKAGE_WANT_LINUX_FS_H
> -		AC_PACKAGE_WANT_SSL
>  		;;
>  esac
>  
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 952a3e03..38fb9c60 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -63,7 +63,6 @@ HAVE_DB = @have_db@
>  HAVE_AIO = @have_aio@
>  HAVE_FALLOCATE = @have_fallocate@
>  HAVE_OPEN_BY_HANDLE_AT = @have_open_by_handle_at@
> -HAVE_SSL = @have_ssl@
>  HAVE_DMAPI = @have_dmapi@
>  HAVE_ATTR_LIST = @have_attr_list@
>  HAVE_FIEMAP = @have_fiemap@
> diff --git a/m4/package_ssldev.m4 b/m4/package_ssldev.m4
> deleted file mode 100644
> index 2eae3c50..00000000
> --- a/m4/package_ssldev.m4
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -AC_DEFUN([AC_PACKAGE_WANT_SSL],
> -  [ AC_CHECK_HEADERS(openssl/md5.h, [ have_ssl=true ], [ have_ssl=false ])
> -    AC_SUBST(have_ssl)
> -  ])
> diff --git a/src/Makefile b/src/Makefile
> index e5042c9b..278f9e55 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -61,24 +61,20 @@ ifeq ($(HAVE_AIO), true)
>  LLDLIBS += -laio
>  endif
>  
> -ifeq ($(HAVE_SSL), true)
> -TARGETS += fssum
> -LLDLIBS += -lssl -lcrypto
> -ifeq ($(PKG_PLATFORM),linux)
> -CFLAGS += -D__LINUX__
> -endif
> -endif
> -
>  CFILES = $(TARGETS:=.c)
>  LDIRT = $(TARGETS)
>  
>  
> -default: depend $(TARGETS) $(SUBDIRS)
> +default: depend $(TARGETS) $(SUBDIRS) fssum

One problem with fssum not being in $(TARGETS) is that fssum won't be
removed on make clean.

Thanks,
Eryu

>  
>  depend: .dep
>  
>  include $(BUILDRULES)
>  
> +fssum: fssum.c md5.c
> +	@echo "    [CC]    $@"
> +	$(Q)$(LTLINK) fssum.c md5.c -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
> +
>  $(TARGETS): $(LIBTEST)
>  	@echo "    [CC]    $@"
>  	$(Q)$(LTLINK) $@.c -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS) $(LIBTEST)
> @@ -87,7 +83,7 @@ LINKTEST = $(LTLINK) $@.c -o $@ $(CFLAGS) $(LDFLAGS)
>  
>  install: default $(addsuffix -install,$(SUBDIRS))
>  	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src
> -	$(LTINSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src
> +	$(LTINSTALL) -m 755 $(TARGETS) fssum $(PKG_LIB_DIR)/src
>  	$(LTINSTALL) -m 755 fill2attr fill2fs fill2fs_check scaleread.sh $(PKG_LIB_DIR)/src
>  	$(LTINSTALL) -m 644 dumpfile $(PKG_LIB_DIR)/src
>  
> diff --git a/src/fssum.c b/src/fssum.c
> index c26d32b9..88e75621 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -15,7 +15,7 @@
>   * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>   * Boston, MA 021110-1307, USA.
>   */
> -#ifdef __LINUX__
> +#ifdef __linux__
>  #define _BSD_SOURCE
>  #define _LARGEFILE64_SOURCE
>  #ifndef _GNU_SOURCE
> @@ -34,7 +34,7 @@
>  #ifdef __SOLARIS__
>  #include <sys/mkdev.h>
>  #endif
> -#include <openssl/md5.h>
> +#include "md5.h"
>  #include <netinet/in.h>
>  #include <inttypes.h>
>  #include <assert.h>
> @@ -42,7 +42,7 @@
>  #define CS_SIZE 16
>  #define CHUNKS	128
>  
> -#ifdef __LINUX__
> +#ifdef __linux__
>  #ifndef SEEK_DATA
>  #define SEEK_DATA 3
>  #define SEEK_HOLE 4
> diff --git a/src/md5.c b/src/md5.c
> new file mode 100644
> index 00000000..b235e17a
> --- /dev/null
> +++ b/src/md5.c
> @@ -0,0 +1,291 @@
> +/*
> + * This is an OpenSSL-compatible implementation of the RSA Data Security, Inc.
> + * MD5 Message-Digest Algorithm (RFC 1321).
> + *
> + * Homepage:
> + * http://openwall.info/wiki/people/solar/software/public-domain-source-code/md5
> + *
> + * Author:
> + * Alexander Peslyak, better known as Solar Designer <solar at openwall.com>
> + *
> + * This software was written by Alexander Peslyak in 2001.  No copyright is
> + * claimed, and the software is hereby placed in the public domain.
> + * In case this attempt to disclaim copyright and place the software in the
> + * public domain is deemed null and void, then the software is
> + * Copyright (c) 2001 Alexander Peslyak and it is hereby released to the
> + * general public under the following terms:
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted.
> + *
> + * There's ABSOLUTELY NO WARRANTY, express or implied.
> + *
> + * (This is a heavily cut-down "BSD license".)
> + *
> + * This differs from Colin Plumb's older public domain implementation in that
> + * no exactly 32-bit integer data type is required (any 32-bit or wider
> + * unsigned integer data type will do), there's no compile-time endianness
> + * configuration, and the function prototypes match OpenSSL's.  No code from
> + * Colin Plumb's implementation has been reused; this comment merely compares
> + * the properties of the two independent implementations.
> + *
> + * The primary goals of this implementation are portability and ease of use.
> + * It is meant to be fast, but not as fast as possible.  Some known
> + * optimizations are not included to reduce source code size and avoid
> + * compile-time configuration.
> + */
> +
> +#ifndef HAVE_OPENSSL
> +
> +#include <string.h>
> +
> +#include "md5.h"
> +
> +/*
> + * The basic MD5 functions.
> + *
> + * F and G are optimized compared to their RFC 1321 definitions for
> + * architectures that lack an AND-NOT instruction, just like in Colin Plumb's
> + * implementation.
> + */
> +#define F(x, y, z)			((z) ^ ((x) & ((y) ^ (z))))
> +#define G(x, y, z)			((y) ^ ((z) & ((x) ^ (y))))
> +#define H(x, y, z)			(((x) ^ (y)) ^ (z))
> +#define H2(x, y, z)			((x) ^ ((y) ^ (z)))
> +#define I(x, y, z)			((y) ^ ((x) | ~(z)))
> +
> +/*
> + * The MD5 transformation for all four rounds.
> + */
> +#define STEP(f, a, b, c, d, x, t, s) \
> +	(a) += f((b), (c), (d)) + (x) + (t); \
> +	(a) = (((a) << (s)) | (((a) & 0xffffffff) >> (32 - (s)))); \
> +	(a) += (b);
> +
> +/*
> + * SET reads 4 input bytes in little-endian byte order and stores them in a
> + * properly aligned word in host byte order.
> + *
> + * The check for little-endian architectures that tolerate unaligned memory
> + * accesses is just an optimization.  Nothing will break if it fails to detect
> + * a suitable architecture.
> + *
> + * Unfortunately, this optimization may be a C strict aliasing rules violation
> + * if the caller's data buffer has effective type that cannot be aliased by
> + * MD5_u32plus.  In practice, this problem may occur if these MD5 routines are
> + * inlined into a calling function, or with future and dangerously advanced
> + * link-time optimizations.  For the time being, keeping these MD5 routines in
> + * their own translation unit avoids the problem.
> + */
> +#if defined(__i386__) || defined(__x86_64__) || defined(__vax__)
> +#define SET(n) \
> +	(*(MD5_u32plus *)&ptr[(n) * 4])
> +#define GET(n) \
> +	SET(n)
> +#else
> +#define SET(n) \
> +	(ctx->block[(n)] = \
> +	(MD5_u32plus)ptr[(n) * 4] | \
> +	((MD5_u32plus)ptr[(n) * 4 + 1] << 8) | \
> +	((MD5_u32plus)ptr[(n) * 4 + 2] << 16) | \
> +	((MD5_u32plus)ptr[(n) * 4 + 3] << 24))
> +#define GET(n) \
> +	(ctx->block[(n)])
> +#endif
> +
> +/*
> + * This processes one or more 64-byte data blocks, but does NOT update the bit
> + * counters.  There are no alignment requirements.
> + */
> +static const void *body(MD5_CTX *ctx, const void *data, unsigned long size)
> +{
> +	const unsigned char *ptr;
> +	MD5_u32plus a, b, c, d;
> +	MD5_u32plus saved_a, saved_b, saved_c, saved_d;
> +
> +	ptr = (const unsigned char *)data;
> +
> +	a = ctx->a;
> +	b = ctx->b;
> +	c = ctx->c;
> +	d = ctx->d;
> +
> +	do {
> +		saved_a = a;
> +		saved_b = b;
> +		saved_c = c;
> +		saved_d = d;
> +
> +/* Round 1 */
> +		STEP(F, a, b, c, d, SET(0), 0xd76aa478, 7)
> +		STEP(F, d, a, b, c, SET(1), 0xe8c7b756, 12)
> +		STEP(F, c, d, a, b, SET(2), 0x242070db, 17)
> +		STEP(F, b, c, d, a, SET(3), 0xc1bdceee, 22)
> +		STEP(F, a, b, c, d, SET(4), 0xf57c0faf, 7)
> +		STEP(F, d, a, b, c, SET(5), 0x4787c62a, 12)
> +		STEP(F, c, d, a, b, SET(6), 0xa8304613, 17)
> +		STEP(F, b, c, d, a, SET(7), 0xfd469501, 22)
> +		STEP(F, a, b, c, d, SET(8), 0x698098d8, 7)
> +		STEP(F, d, a, b, c, SET(9), 0x8b44f7af, 12)
> +		STEP(F, c, d, a, b, SET(10), 0xffff5bb1, 17)
> +		STEP(F, b, c, d, a, SET(11), 0x895cd7be, 22)
> +		STEP(F, a, b, c, d, SET(12), 0x6b901122, 7)
> +		STEP(F, d, a, b, c, SET(13), 0xfd987193, 12)
> +		STEP(F, c, d, a, b, SET(14), 0xa679438e, 17)
> +		STEP(F, b, c, d, a, SET(15), 0x49b40821, 22)
> +
> +/* Round 2 */
> +		STEP(G, a, b, c, d, GET(1), 0xf61e2562, 5)
> +		STEP(G, d, a, b, c, GET(6), 0xc040b340, 9)
> +		STEP(G, c, d, a, b, GET(11), 0x265e5a51, 14)
> +		STEP(G, b, c, d, a, GET(0), 0xe9b6c7aa, 20)
> +		STEP(G, a, b, c, d, GET(5), 0xd62f105d, 5)
> +		STEP(G, d, a, b, c, GET(10), 0x02441453, 9)
> +		STEP(G, c, d, a, b, GET(15), 0xd8a1e681, 14)
> +		STEP(G, b, c, d, a, GET(4), 0xe7d3fbc8, 20)
> +		STEP(G, a, b, c, d, GET(9), 0x21e1cde6, 5)
> +		STEP(G, d, a, b, c, GET(14), 0xc33707d6, 9)
> +		STEP(G, c, d, a, b, GET(3), 0xf4d50d87, 14)
> +		STEP(G, b, c, d, a, GET(8), 0x455a14ed, 20)
> +		STEP(G, a, b, c, d, GET(13), 0xa9e3e905, 5)
> +		STEP(G, d, a, b, c, GET(2), 0xfcefa3f8, 9)
> +		STEP(G, c, d, a, b, GET(7), 0x676f02d9, 14)
> +		STEP(G, b, c, d, a, GET(12), 0x8d2a4c8a, 20)
> +
> +/* Round 3 */
> +		STEP(H, a, b, c, d, GET(5), 0xfffa3942, 4)
> +		STEP(H2, d, a, b, c, GET(8), 0x8771f681, 11)
> +		STEP(H, c, d, a, b, GET(11), 0x6d9d6122, 16)
> +		STEP(H2, b, c, d, a, GET(14), 0xfde5380c, 23)
> +		STEP(H, a, b, c, d, GET(1), 0xa4beea44, 4)
> +		STEP(H2, d, a, b, c, GET(4), 0x4bdecfa9, 11)
> +		STEP(H, c, d, a, b, GET(7), 0xf6bb4b60, 16)
> +		STEP(H2, b, c, d, a, GET(10), 0xbebfbc70, 23)
> +		STEP(H, a, b, c, d, GET(13), 0x289b7ec6, 4)
> +		STEP(H2, d, a, b, c, GET(0), 0xeaa127fa, 11)
> +		STEP(H, c, d, a, b, GET(3), 0xd4ef3085, 16)
> +		STEP(H2, b, c, d, a, GET(6), 0x04881d05, 23)
> +		STEP(H, a, b, c, d, GET(9), 0xd9d4d039, 4)
> +		STEP(H2, d, a, b, c, GET(12), 0xe6db99e5, 11)
> +		STEP(H, c, d, a, b, GET(15), 0x1fa27cf8, 16)
> +		STEP(H2, b, c, d, a, GET(2), 0xc4ac5665, 23)
> +
> +/* Round 4 */
> +		STEP(I, a, b, c, d, GET(0), 0xf4292244, 6)
> +		STEP(I, d, a, b, c, GET(7), 0x432aff97, 10)
> +		STEP(I, c, d, a, b, GET(14), 0xab9423a7, 15)
> +		STEP(I, b, c, d, a, GET(5), 0xfc93a039, 21)
> +		STEP(I, a, b, c, d, GET(12), 0x655b59c3, 6)
> +		STEP(I, d, a, b, c, GET(3), 0x8f0ccc92, 10)
> +		STEP(I, c, d, a, b, GET(10), 0xffeff47d, 15)
> +		STEP(I, b, c, d, a, GET(1), 0x85845dd1, 21)
> +		STEP(I, a, b, c, d, GET(8), 0x6fa87e4f, 6)
> +		STEP(I, d, a, b, c, GET(15), 0xfe2ce6e0, 10)
> +		STEP(I, c, d, a, b, GET(6), 0xa3014314, 15)
> +		STEP(I, b, c, d, a, GET(13), 0x4e0811a1, 21)
> +		STEP(I, a, b, c, d, GET(4), 0xf7537e82, 6)
> +		STEP(I, d, a, b, c, GET(11), 0xbd3af235, 10)
> +		STEP(I, c, d, a, b, GET(2), 0x2ad7d2bb, 15)
> +		STEP(I, b, c, d, a, GET(9), 0xeb86d391, 21)
> +
> +		a += saved_a;
> +		b += saved_b;
> +		c += saved_c;
> +		d += saved_d;
> +
> +		ptr += 64;
> +	} while (size -= 64);
> +
> +	ctx->a = a;
> +	ctx->b = b;
> +	ctx->c = c;
> +	ctx->d = d;
> +
> +	return ptr;
> +}
> +
> +void MD5_Init(MD5_CTX *ctx)
> +{
> +	ctx->a = 0x67452301;
> +	ctx->b = 0xefcdab89;
> +	ctx->c = 0x98badcfe;
> +	ctx->d = 0x10325476;
> +
> +	ctx->lo = 0;
> +	ctx->hi = 0;
> +}
> +
> +void MD5_Update(MD5_CTX *ctx, const void *data, unsigned long size)
> +{
> +	MD5_u32plus saved_lo;
> +	unsigned long used, available;
> +
> +	saved_lo = ctx->lo;
> +	if ((ctx->lo = (saved_lo + size) & 0x1fffffff) < saved_lo)
> +		ctx->hi++;
> +	ctx->hi += size >> 29;
> +
> +	used = saved_lo & 0x3f;
> +
> +	if (used) {
> +		available = 64 - used;
> +
> +		if (size < available) {
> +			memcpy(&ctx->buffer[used], data, size);
> +			return;
> +		}
> +
> +		memcpy(&ctx->buffer[used], data, available);
> +		data = (const unsigned char *)data + available;
> +		size -= available;
> +		body(ctx, ctx->buffer, 64);
> +	}
> +
> +	if (size >= 64) {
> +		data = body(ctx, data, size & ~(unsigned long)0x3f);
> +		size &= 0x3f;
> +	}
> +
> +	memcpy(ctx->buffer, data, size);
> +}
> +
> +#define OUT(dst, src) \
> +	(dst)[0] = (unsigned char)(src); \
> +	(dst)[1] = (unsigned char)((src) >> 8); \
> +	(dst)[2] = (unsigned char)((src) >> 16); \
> +	(dst)[3] = (unsigned char)((src) >> 24);
> +
> +void MD5_Final(unsigned char *result, MD5_CTX *ctx)
> +{
> +	unsigned long used, available;
> +
> +	used = ctx->lo & 0x3f;
> +
> +	ctx->buffer[used++] = 0x80;
> +
> +	available = 64 - used;
> +
> +	if (available < 8) {
> +		memset(&ctx->buffer[used], 0, available);
> +		body(ctx, ctx->buffer, 64);
> +		used = 0;
> +		available = 64;
> +	}
> +
> +	memset(&ctx->buffer[used], 0, available - 8);
> +
> +	ctx->lo <<= 3;
> +	OUT(&ctx->buffer[56], ctx->lo)
> +	OUT(&ctx->buffer[60], ctx->hi)
> +
> +	body(ctx, ctx->buffer, 64);
> +
> +	OUT(&result[0], ctx->a)
> +	OUT(&result[4], ctx->b)
> +	OUT(&result[8], ctx->c)
> +	OUT(&result[12], ctx->d)
> +
> +	memset(ctx, 0, sizeof(*ctx));
> +}
> +
> +#endif
> diff --git a/src/md5.h b/src/md5.h
> new file mode 100644
> index 00000000..2da44bf3
> --- /dev/null
> +++ b/src/md5.h
> @@ -0,0 +1,45 @@
> +/*
> + * This is an OpenSSL-compatible implementation of the RSA Data Security, Inc.
> + * MD5 Message-Digest Algorithm (RFC 1321).
> + *
> + * Homepage:
> + * http://openwall.info/wiki/people/solar/software/public-domain-source-code/md5
> + *
> + * Author:
> + * Alexander Peslyak, better known as Solar Designer <solar at openwall.com>
> + *
> + * This software was written by Alexander Peslyak in 2001.  No copyright is
> + * claimed, and the software is hereby placed in the public domain.
> + * In case this attempt to disclaim copyright and place the software in the
> + * public domain is deemed null and void, then the software is
> + * Copyright (c) 2001 Alexander Peslyak and it is hereby released to the
> + * general public under the following terms:
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted.
> + *
> + * There's ABSOLUTELY NO WARRANTY, express or implied.
> + *
> + * See md5.c for more information.
> + */
> +
> +#ifdef HAVE_OPENSSL
> +#include <openssl/md5.h>
> +#elif !defined(_MD5_H)
> +#define _MD5_H
> +
> +/* Any 32-bit or wider unsigned integer data type will do */
> +typedef unsigned int MD5_u32plus;
> +
> +typedef struct {
> +	MD5_u32plus lo, hi;
> +	MD5_u32plus a, b, c, d;
> +	unsigned char buffer[64];
> +	MD5_u32plus block[16];
> +} MD5_CTX;
> +
> +extern void MD5_Init(MD5_CTX *ctx);
> +extern void MD5_Update(MD5_CTX *ctx, const void *data, unsigned long size);
> +extern void MD5_Final(unsigned char *result, MD5_CTX *ctx);
> +
> +#endif
> -- 
> 2.11.0.rc0.7.gbe5a750
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
