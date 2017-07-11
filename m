Received: from mx1.redhat.com ([209.132.183.28]:60772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754680AbdGKDuA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Jul 2017 23:50:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0C77C049D57
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2017 03:49:59 +0000 (UTC)
Date: Tue, 11 Jul 2017 11:49:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/4] fsstress: new writev and readv operations test
Message-ID: <20170711034954.GL29475@eguan.usersys.redhat.com>
References: <1497629466-22647-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497629466-22647-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jun 17, 2017 at 12:11:03AM +0800, Zorro Lang wrote:
> We found some bugs by writev operations recently, writev can cover
> different test than normal write operation, so add writev and
> readv operations into fsstress.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Sorry for the so late response..

> ---
>  ltp/fsstress.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index e9fd276..67cdb2f 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -18,6 +18,7 @@
>  
>  #include <linux/fs.h>
>  #include <setjmp.h>
> +#include <sys/uio.h>
>  #include "global.h"
>  
>  #ifdef HAVE_ATTR_XATTR_H
> @@ -47,6 +48,9 @@
>  #define XFS_ERRTAG_MAX		17
>  #define XFS_IDMODULO_MAX	31	/* user/group IDs (1 << x)  */
>  #define XFS_PROJIDMODULO_MAX	16	/* project IDs (1 << x)     */
> +#ifndef IOV_MAX
> +#define IOV_MAX 1024
> +#endif
>  
>  #define FILELEN_MAX		(32*4096)
>  
> @@ -78,6 +82,7 @@ typedef enum {
>  	OP_INSERT,
>  	OP_READ,
>  	OP_READLINK,
> +	OP_READV,
>  	OP_RENAME,
>  	OP_RESVSP,
>  	OP_RMDIR,
> @@ -90,6 +95,7 @@ typedef enum {
>  	OP_UNLINK,
>  	OP_UNRESVSP,
>  	OP_WRITE,
> +	OP_WRITEV,
>  	OP_LAST
>  } opty_t;
>  
> @@ -179,6 +185,7 @@ void	collapse_f(int, long);
>  void	insert_f(int, long);
>  void	read_f(int, long);
>  void	readlink_f(int, long);
> +void	readv_f(int, long);
>  void	rename_f(int, long);
>  void	resvsp_f(int, long);
>  void	rmdir_f(int, long);
> @@ -191,6 +198,7 @@ void	truncate_f(int, long);
>  void	unlink_f(int, long);
>  void	unresvsp_f(int, long);
>  void	write_f(int, long);
> +void	writev_f(int, long);
>  
>  opdesc_t	ops[] = {
>       /* { OP_ENUM, "name", function, freq, iswrite }, */
> @@ -221,6 +229,7 @@ opdesc_t	ops[] = {
>  	{ OP_INSERT, "insert", insert_f, 1, 1 },
>  	{ OP_READ, "read", read_f, 1, 0 },
>  	{ OP_READLINK, "readlink", readlink_f, 1, 0 },
> +	{ OP_READ, "readv", readv_f, 1, 0 },

This should be OP_READV.

>  	{ OP_RENAME, "rename", rename_f, 2, 1 },
>  	{ OP_RESVSP, "resvsp", resvsp_f, 1, 1 },
>  	{ OP_RMDIR, "rmdir", rmdir_f, 1, 1 },
> @@ -233,6 +242,7 @@ opdesc_t	ops[] = {
>  	{ OP_UNLINK, "unlink", unlink_f, 1, 1 },
>  	{ OP_UNRESVSP, "unresvsp", unresvsp_f, 1, 1 },
>  	{ OP_WRITE, "write", write_f, 4, 1 },
> +	{ OP_WRITEV, "writev", writev_f, 4, 1 },
>  }, *ops_end;
>  
>  flist_t	flist[FT_nft] = {
> @@ -2948,6 +2958,84 @@ readlink_f(int opno, long r)
>  }
>  
>  void
> +readv_f(int opno, long r)
> +{
> +	char		*buf;
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	size_t		len;
> +	__int64_t	lr;
> +	off64_t		off;
> +	struct stat64	stb;
> +	int		v;
> +	char		st[1024];
> +	struct iovec	*iov = NULL;
> +	int		iovcnt;
> +	size_t		iovb;
> +	size_t		iovl;
> +	int		i;
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%d: readv - no filename\n", procid, opno);
> +		free_pathname(&f);
> +		return;
> +	}
> +	fd = open_path(&f, O_RDONLY);
> +	e = fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%d: readv - open %s failed %d\n",
> +				procid, opno, f.path, e);
> +		free_pathname(&f);
> +		return;
> +	}
> +	if (fstat64(fd, &stb) < 0) {
> +		if (v)
> +			printf("%d/%d: readv - fstat64 %s failed %d\n",
> +				procid, opno, f.path, errno);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	inode_info(st, sizeof(st), &stb, v);
> +	if (stb.st_size == 0) {
> +		if (v)
> +			printf("%d/%d: readv - %s%s zero size\n", procid, opno,
> +			       f.path, st);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	lr = ((__int64_t)random() << 32) + random();
> +	off = (off64_t)(lr % stb.st_size);
> +	lseek64(fd, off, SEEK_SET);
> +	len = (random() % FILELEN_MAX) + 1;
> +	buf = malloc(len);

Check if malloc succeeded?

> +
> +	iovcnt = (random() % MIN(len, IOV_MAX)) + 1;
> +	iov = malloc(sizeof(struct iovec) * iovcnt);
> +	for (i=0; i<iovcnt; i++) {
> +		iovb = random() % len;
> +		iovl = random() % (len - iovb) + 1;
> +		(iov + i)->iov_base = (buf + iovb);
> +		(iov + i)->iov_len  = iovl;

Hmm, this reads random bytes from a random offset iovcnt times (within
the [off, off+len] range), so the total bytes it reads is not 'len', and
possibly some ranges are not read at all.

It's better to read exact len bytes once, as what you log below.

> +	}
> +
> +	e = read(fd, buf, len) < 0 ? errno : 0;

Forgot to update this read to readv call?

> +	free(buf);
> +	if (v)
> +		printf("%d/%d: readv %s%s [%lld,%d,%d] %d\n",
> +		       procid, opno, f.path, st, (long long)off, (int)len,
> +		       iovcnt, e);
> +	free_pathname(&f);
> +	close(fd);
> +}
> +
> +void
>  rename_f(int opno, long r)
>  {
>  	fent_t		*dfep;
> @@ -3379,3 +3467,76 @@ write_f(int opno, long r)
>  	free_pathname(&f);
>  	close(fd);
>  }
> +
> +void
> +writev_f(int opno, long r)
> +{
> +	char		*buf;
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	size_t		len;
> +	__int64_t	lr;
> +	off64_t		off;
> +	struct stat64	stb;
> +	int		v;
> +	char		st[1024];
> +	struct iovec	*iov = NULL;
> +	int		iovcnt;
> +	size_t		iovb;
> +	size_t		iovl;
> +	int		i;
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGm, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%d: writev - no filename\n", procid, opno);
> +		free_pathname(&f);
> +		return;
> +	}
> +	fd = open_path(&f, O_WRONLY);
> +	e = fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%d: writev - open %s failed %d\n",
> +				procid, opno, f.path, e);
> +		free_pathname(&f);
> +		return;
> +	}
> +	if (fstat64(fd, &stb) < 0) {
> +		if (v)
> +			printf("%d/%d: writev - fstat64 %s failed %d\n",
> +				procid, opno, f.path, errno);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	inode_info(st, sizeof(st), &stb, v);
> +	lr = ((__int64_t)random() << 32) + random();
> +	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
> +	off %= maxfsize;
> +	lseek64(fd, off, SEEK_SET);
> +	len = (random() % FILELEN_MAX) + 1;
> +	buf = malloc(len);
> +	memset(buf, nameseq & 0xff, len);
> +
> +	iovcnt = (random() % MIN(len, IOV_MAX)) + 1;
> +	iov = malloc(sizeof(struct iovec) * iovcnt);
> +	for (i=0; i<iovcnt; i++) {
> +		iovb = random() % len;
> +		iovl = random() % (len - iovb) + 1;
> +		(iov + i)->iov_base = (buf + iovb);
> +		(iov + i)->iov_len  = iovl;

Same here, write the range all and once.

Thanks,
Eryu

> +	}
> +
> +	e = writev(fd, iov, iovcnt) < 0 ? errno : 0;
> +	free(buf);
> +	free(iov);
> +	if (v)
> +		printf("%d/%d: writev %s%s [%lld,%d,%d] %d\n",
> +		       procid, opno, f.path, st, (long long)off, (int)len,
> +		       iovcnt, e);
> +	free_pathname(&f);
> +	close(fd);
> +}
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
