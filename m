Received: from mx1.redhat.com ([209.132.183.28]:48304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758419AbdCVG6p (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Mar 2017 02:58:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA73D61D01
        for <fstests@vger.kernel.org>; Wed, 22 Mar 2017 06:58:45 +0000 (UTC)
Date: Wed, 22 Mar 2017 14:58:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v5 1/2] fsstress: add mwrite/mread into test operation
 list
Message-ID: <20170322065844.GE14226@eguan.usersys.redhat.com>
References: <1490087883-24453-1-git-send-email-zlang@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490087883-24453-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 05:18:02PM +0800, Zorro Lang wrote:
> mmap as a popular and basic operation, most of softwares use it to
> access files. More and more customers report bugs related with
> mmap/munmap and other stress conditions.
>=20
> So add mmap read/write test into fsstress to increase mmap related
> stress to reproduce or find more bugs easily.
>=20
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>=20
> Nothing changed from V4. Send V5 for fixing xfs/068 failure together.
>=20
> Thanks,
> Zorro
>=20
>  ltp/fsstress.c | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/global.h   |   4 ++
>  2 files changed, 191 insertions(+)
>=20
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 7e7cf60..e341aa1 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -69,6 +69,8 @@ typedef enum {
>  	OP_LINK,
>  	OP_MKDIR,
>  	OP_MKNOD,
> +	OP_MREAD,
> +	OP_MWRITE,
>  	OP_PUNCH,
>  	OP_ZERO,
>  	OP_COLLAPSE,
> @@ -168,6 +170,8 @@ void	getdents_f(int, long);
>  void	link_f(int, long);
>  void	mkdir_f(int, long);
>  void	mknod_f(int, long);
> +void	mread_f(int, long);
> +void	mwrite_f(int, long);
>  void	punch_f(int, long);
>  void	zero_f(int, long);
>  void	collapse_f(int, long);
> @@ -208,6 +212,8 @@ opdesc_t	ops[] =3D {
>  	{ OP_LINK, "link", link_f, 1, 1 },
>  	{ OP_MKDIR, "mkdir", mkdir_f, 2, 1 },
>  	{ OP_MKNOD, "mknod", mknod_f, 2, 1 },
> +	{ OP_MREAD, "mread", mread_f, 4, 0 },
> +	{ OP_MWRITE, "mwrite", mwrite_f, 4, 1 },

I don't think mread/mwrite are widely used as read/write, so freq 4
seems a bit high, freq 2 should be OK.

>  	{ OP_PUNCH, "punch", punch_f, 1, 1 },
>  	{ OP_ZERO, "zero", zero_f, 1, 1 },
>  	{ OP_COLLAPSE, "collapse", collapse_f, 1, 1 },
> @@ -2656,6 +2662,187 @@ mknod_f(int opno, long r)
>  }
>=20=20
>  void
> +mread_f(int opno, long r)
> +{
> +	char		*addr;
> +	char		*buf;
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	size_t		len;
> +	__int64_t	lr;
> +	off64_t		off;
> +	int		flags;
> +	struct stat64	stb;
> +	int		v;
> +	char		st[1024];
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%d: mread - no filename\n", procid, opno);
> +		free_pathname(&f);
> +		return;
> +	}
> +	fd =3D open_path(&f, O_RDONLY);
> +	e =3D fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%d: mread - open %s failed %d\n",
> +			       procid, opno, f.path, e);
> +		free_pathname(&f);
> +		return;
> +	}
> +	if (fstat64(fd, &stb) < 0) {
> +		if (v)
> +			printf("%d/%d: mread - fstat64 %s failed %d\n",
> +			       procid, opno, f.path, errno);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	if (stb.st_size =3D=3D 0) {
> +		if (v)
> +			printf("%d/%d: mread - %s%s zero size\n", procid, opno,
> +			       f.path, st);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +
> +	inode_info(st, sizeof(st), &stb, v);
> +	lr =3D ((__int64_t)random() << 32) + random();
> +	off =3D (off64_t)(lr % stb.st_size);
> +	off &=3D (off64_t)(~(sysconf(_SC_PAGE_SIZE) - 1));
> +	len =3D (size_t)(random() % MIN(stb.st_size - off, FILELEN_MAX)) + 1;
> +
> +	/* try private file mappings with 20% rate */
> +	flags =3D (random() % 20) ? MAP_SHARED : MAP_PRIVATE;

This is not 20%, it's 5%. But I think 50%:50% should be OK?

> +	do {
> +		addr =3D mmap(NULL, len, PROT_READ, flags, fd, off);
> +		e =3D (addr =3D=3D MAP_FAILED) ? errno : 0;
> +		if (errno =3D=3D ENOMEM && flags & MAP_PRIVATE) {
> +		/* turn to shared mapping if memeory is not enough for private mapping=
 */
> +			flags =3D MAP_SHARED;
> +		} else if (errno =3D=3D ENOMEM && len > sysconf(_SC_PAGE_SIZE)) {
> +		/* reduce mapping length, if memeory is not enough for shared mapping =
*/
> +			len /=3D 2;
> +		}
> +	} while (errno =3D=3D ENOMEM && len > sysconf(_SC_PAGE_SIZE));

No need to retry on mmap, just let it fail and print out failure
message.

> +	if (e && v)
> +		printf("%d/%d: mread - mmap failed %s%s [%lld,%d,%s] %d\n",
> +		       procid, opno, f.path, st, (long long)off, (int)len,
> +		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);
> +
> +	if (addr !=3D MAP_FAILED) {
> +		if ((buf =3D malloc(len)) !=3D NULL) {
> +			memcpy(buf, addr, len);
> +			free(buf);
> +		}
> +		e =3D munmap(addr, len) < 0 ? errno : 0;
> +		if (e && v)
> +			printf("%d/%d: mread - munmap failed %s%s [%lld,%d] %d\n",
> +			       procid, opno, f.path, st, (long long)off,
> +			       (int)len, e);
> +	}
> +	if (v)
> +		printf("%d/%d: mread %s%s [%lld,%d,%s] %d\n",
> +		       procid, opno, f.path, st, (long long)off, (int)len,
> +		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);
> +
> +	free_pathname(&f);
> +	close(fd);
> +}
> +
> +void
> +mwrite_f(int opno, long r)
> +{
> +	char		*addr;
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	size_t		len;
> +	__int64_t	lr;
> +	off64_t		off;
> +	int		flags;
> +	struct stat64	stb;
> +	int		v;
> +	char		st[1024];
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%d: mwrite - no filename\n", procid, opno);
> +		free_pathname(&f);
> +		return;
> +	}
> +	fd =3D open_path(&f, O_WRONLY);
> +	e =3D fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%d: mwrite - open %s failed %d\n",
> +			       procid, opno, f.path, e);
> +		free_pathname(&f);
> +		return;
> +	}
> +	if (fstat64(fd, &stb) < 0) {
> +		if (v)
> +			printf("%d/%d: mwrite - fstat64 %s failed %d\n",
> +			       procid, opno, f.path, errno);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	inode_info(st, sizeof(st), &stb, v);
> +	lr =3D ((__int64_t)random() << 32) + random();
> +	off =3D (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
> +	off %=3D maxfsize;
> +	off &=3D (off64_t)(~(sysconf(_SC_PAGE_SIZE) - 1));
> +	len =3D (size_t)(random() % MIN(maxfsize - off, FILELEN_MAX)) + 1;
> +
> +	/*
> +	 * truncate file to the size we need to map and access,
> +	 * keep away SIGBUS / SIGSEGV killing this process
> +	 */
> +	e =3D truncate64_path(&f, off + len) < 0 ? errno : 0;

This implies a truncate(2) operation in mwrite. I don't think we need
this. Just mwrite within file size, let other operations like truncate
and write to extend file size.

> +	/* try private file mappings with 20% rate */
> +	flags =3D (random() % 20) ? MAP_SHARED : MAP_PRIVATE;

Again, this is 5%.

> +	do {
> +		addr =3D mmap(NULL, len, PROT_WRITE, flags, fd, off);
> +		e =3D (addr =3D=3D MAP_FAILED) ? errno : 0;
> +		if (errno =3D=3D ENOMEM && flags & MAP_PRIVATE) {
> +		/* turn to shared mapping if memeory is not enough for private mapping=
 */
> +			flags =3D MAP_SHARED;
> +		} else if (errno =3D=3D ENOMEM && len > sysconf(_SC_PAGE_SIZE)) {
> +		/* reduce mapping length, if memeory is not enough for shared mapping =
*/
> +			len /=3D 2;
> +		}
> +	} while (errno =3D=3D ENOMEM && len > sysconf(_SC_PAGE_SIZE));

And again, no need to retry on mmap failure, IMO, just let it fail.

> +	if (e && v)
> +		printf("%d/%d: mwrite - mmap failed %s%s [%lld,%d,%s] %d\n",
> +		       procid, opno, f.path, st, (long long)off, (int)len,
> +		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);

Consider putting this flag translation into a "struct print_flags"? See
struct print_flags falloc_flags [].

Thanks,
Eryu

> +
> +	if (addr !=3D MAP_FAILED) {
> +		memset(addr, nameseq & 0xff, len);
> +		e =3D munmap(addr, len) < 0 ? errno : 0;
> +		if (e && v)
> +			printf("%d/%d: mwrite - munmap failed %s%s [%lld,%d] %d\n",
> +			       procid, opno, f.path, st, (long long)off,
> +			       (int)len, e);
> +	}
> +	if (v)
> +		printf("%d/%d: mwrite %s%s [%lld,%d,%s] %d\n",
> +		       procid, opno, f.path, st, (long long)off, (int)len,
> +		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);
> +
> +	free_pathname(&f);
> +	close(fd);
> +}
> +
> +void
>  punch_f(int opno, long r)
>  {
>  #ifdef HAVE_LINUX_FALLOC_H
> diff --git a/src/global.h b/src/global.h
> index f63246b..51d1e94 100644
> --- a/src/global.h
> +++ b/src/global.h
> @@ -178,4 +178,8 @@
>=20=20
>  #endif /* HAVE_LINUX_FALLOC_H */
>=20=20
> +#ifndef HAVE_SYS_MMAN_H
> +#include <sys/mman.h>
> +#endif
> +
>  #endif /* GLOBAL_H */
> --=20
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZ=
YR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&=
m=3DsRjm768aU_r6WAYkhCVs84Q0mbTl9Ls2luPcA_M2yfg&s=3DpLoANwaLvp5MiCf2M6V3Cqw=
COor767PphRpNErnuz9E&e=3D=20
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DsRjm768aU_r6WAYkhCVs84Q0mbTl9Ls2luPcA_M2yfg&s=3DpLoANwaLvp5MiCf2M6V3CqwC=
Oor767PphRpNErnuz9E&e=3D=20
