Received: from userp1040.oracle.com ([156.151.31.81]:33579 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdFARMZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Jun 2017 13:12:25 -0400
Date: Thu, 1 Jun 2017 10:12:20 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] fsstress: add AIO read/write and fsync test
Message-ID: <20170601171220.GT4521@birch.djwong.org>
References: <1496332870-22354-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496332870-22354-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 02, 2017 at 12:01:10AM +0800, Zorro Lang wrote:
> We found some bugs by aio read/write and fsync test, but there's
> not related operations in fsstress. So add AIO test into fsstress to
> increase AIO stress test.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> V2 did below changes:
> 1) add aio fsync test.
> 2) Turn to checking the return vaule of libaio functions, not errno.
> 
> 
> Hi Darrick,
> 
> As your suggestion, I've add io_prep_fsync to fsstress in this V2 patch.
> But by my testing, it always return EINVAL, due to linux doesn't support
> aio fsync.
> 
> And I've asked AIO maintainer, he said there's not a plan to support that
> until now.

Undoubtedly a side effect of:
https://patchwork.kernel.org/patch/8012401/
and:
http://oss.sgi.com/archives/xfs/2014-06/msg00214.html

> So do you think we need to keep this io_prep_fsync test in
> fsstress and set the frequency to 0 by default?

Eh, I guess. :)

Someone should make a xfstest case specifically for io_prep_fsync just
so we'll continue to bang into this broken bit of userland interface...
I know of various projects (postgres being one of them) that would like
an asynchronous fsync but have clunky workarounds in place because we've
never supported it.

--D

> 
> Thanks,
> Zorro
> 
>  ltp/fsstress.c | 214 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 214 insertions(+)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index e9fd276..da4f749 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -35,6 +35,10 @@
>  #ifdef HAVE_SYS_PRCTL_H
>  #include <sys/prctl.h>
>  #endif
> +#ifdef AIO
> +#include <libaio.h>
> +io_context_t	io_ctx;
> +#endif
>  
>  #ifndef FS_IOC_GETFLAGS
>  #define FS_IOC_GETFLAGS                 _IOR('f', 1, long)
> @@ -51,9 +55,12 @@
>  #define FILELEN_MAX		(32*4096)
>  
>  typedef enum {
> +	OP_AFSYNC,
>  	OP_ALLOCSP,
> +	OP_AREAD,
>  	OP_ATTR_REMOVE,
>  	OP_ATTR_SET,
> +	OP_AWRITE,
>  	OP_BULKSTAT,
>  	OP_BULKSTAT1,
>  	OP_CHOWN,
> @@ -152,9 +159,12 @@ struct print_string {
>  #define	MAXFSIZE	((1ULL << 63) - 1ULL)
>  #define	MAXFSIZE32	((1ULL << 40) - 1ULL)
>  
> +void	afsync_f(int, long);
>  void	allocsp_f(int, long);
> +void	aread_f(int, long);
>  void	attr_remove_f(int, long);
>  void	attr_set_f(int, long);
> +void	awrite_f(int, long);
>  void	bulkstat_f(int, long);
>  void	bulkstat1_f(int, long);
>  void	chown_f(int, long);
> @@ -194,9 +204,12 @@ void	write_f(int, long);
>  
>  opdesc_t	ops[] = {
>       /* { OP_ENUM, "name", function, freq, iswrite }, */
> +	{ OP_AFSYNC, "afsync", afsync_f, 1, 1 },
>  	{ OP_ALLOCSP, "allocsp", allocsp_f, 1, 1 },
> +	{ OP_AREAD, "aread", aread_f, 1, 0 },
>  	{ OP_ATTR_REMOVE, "attr_remove", attr_remove_f, /* 1 */ 0, 1 },
>  	{ OP_ATTR_SET, "attr_set", attr_set_f, /* 2 */ 0, 1 },
> +	{ OP_AWRITE, "awrite", awrite_f, 1, 1 },
>  	{ OP_BULKSTAT, "bulkstat", bulkstat_f, 1, 0 },
>  	{ OP_BULKSTAT1, "bulkstat1", bulkstat1_f, 1, 0 },
>  	{ OP_CHOWN, "chown", chown_f, 3, 1 },
> @@ -577,8 +590,20 @@ int main(int argc, char **argv)
>  				}
>  			}
>  			procid = i;
> +#ifdef AIO
> +			if (io_setup(128, &io_ctx) != 0) {
> +				perror("io_setup failed");
> +				exit(1);
> +			}
> +#endif
>  			for (i = 0; !loops || (i < loops); i++)
>  				doproc();
> +#ifdef AIO
> +			if(io_destroy(io_ctx) != 0) {
> +				perror("io_destroy failed");
> +				return 1;
> +			}
> +#endif
>  			return 0;
>  		}
>  	}
> @@ -1698,6 +1723,62 @@ void inode_info(char *str, size_t sz, struct stat64 *s, int verbose)
>  }
>  
>  void
> +afsync_f(int opno, long r)
> +{
> +#ifdef AIO
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	int		v;
> +	struct iocb	iocb;
> +	struct iocb	*iocbs[] = { &iocb };
> +	struct io_event	event;
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%d: afsync - no filename\n", procid, opno);
> +		free_pathname(&f);
> +		return;
> +	}
> +	fd = open_path(&f, O_WRONLY | O_DIRECT);
> +	e = fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%d: afsync - open %s failed %d\n",
> +			       procid, opno, f.path, e);
> +		free_pathname(&f);
> +		return;
> +	}
> +
> +	io_prep_fsync(&iocb, fd);
> +	if ((e = io_submit(io_ctx, 1, iocbs)) != 1) {
> +		if (v)
> +			printf("%d/%d: afsync - io_submit %s %d\n",
> +			       procid, opno, f.path, e);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
> +		if (v)
> +			printf("%d/%d: afsync - io_getevents failed %d\n",
> +			       procid, opno, e);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +
> +	e = event.res2;
> +	if (v)
> +		printf("%d/%d: afsync %s %d\n", procid, opno, f.path, e);
> +	free_pathname(&f);
> +	close(fd);
> +#endif
> +}
> +
> +void
>  allocsp_f(int opno, long r)
>  {
>  	int		e;
> @@ -1751,6 +1832,131 @@ allocsp_f(int opno, long r)
>  	close(fd);
>  }
>  
> +#ifdef AIO
> +void
> +do_aio_rw(int opno, long r, int flags)
> +{
> +	__int64_t	align;
> +	char		*buf;
> +	struct dioattr	diob;
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	size_t		len;
> +	__int64_t	lr;
> +	off64_t		off;
> +	struct stat64	stb;
> +	int		v;
> +	char		st[1024];
> +	char		*dio_env;
> +	struct iocb	iocb;
> +	struct io_event	event;
> +	struct iocb	*iocbs[] = { &iocb };
> +	int		iswrite = (flags & (O_WRONLY | O_RDWR)) ? 1 : 0;
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%d: do_aio_rw - no filename\n", procid, opno);
> +		free_pathname(&f);
> +		return;
> +	}
> +	fd = open_path(&f, flags|O_DIRECT);
> +	e = fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%d: do_aio_rw - open %s failed %d\n",
> +			       procid, opno, f.path, e);
> +		free_pathname(&f);
> +		return;
> +	}
> +	if (fstat64(fd, &stb) < 0) {
> +		if (v)
> +			printf("%d/%d: do_aio_rw - fstat64 %s failed %d\n",
> +			       procid, opno, f.path, errno);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	inode_info(st, sizeof(st), &stb, v);
> +	if (!iswrite && stb.st_size == 0) {
> +		if (v)
> +			printf("%d/%d: do_aio_rw - %s%s zero size\n", procid, opno,
> +			       f.path, st);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	if (xfsctl(f.path, fd, XFS_IOC_DIOINFO, &diob) < 0) {
> +		if (v)
> +			printf(
> +			"%d/%d: do_aio_rw - xfsctl(XFS_IOC_DIOINFO) %s%s failed %d\n",
> +				procid, opno, f.path, st, errno);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	dio_env = getenv("XFS_DIO_MIN");
> +	if (dio_env)
> +		diob.d_mem = diob.d_miniosz = atoi(dio_env);
> +	align = (__int64_t)diob.d_miniosz;
> +	lr = ((__int64_t)random() << 32) + random();
> +	len = (random() % FILELEN_MAX) + 1;
> +	len -= (len % align);
> +	if (len <= 0)
> +		len = align;
> +	else if (len > diob.d_maxiosz)
> +		len = diob.d_maxiosz;
> +	buf = memalign(diob.d_mem, len);
> +
> +	if (iswrite) {
> +		off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
> +		off -= (off % align);
> +		off %= maxfsize;
> +		memset(buf, nameseq & 0xff, len);
> +		io_prep_pwrite(&iocb, fd, buf, len, off);
> +	} else {
> +		off = (off64_t)(lr % stb.st_size);
> +		off -= (off % align);
> +		io_prep_pread(&iocb, fd, buf, len, off);
> +	}
> +	if ((e = io_submit(io_ctx, 1, iocbs)) != 1) {
> +		if (v)
> +			printf("%d/%d: %s - io_submit failed %d\n",
> +			       procid, opno, iswrite ? "awrite" : "aread", e);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
> +		if (v)
> +			printf("%d/%d: %s - io_getevents failed %d\n",
> +			       procid, opno, iswrite ? "awrite" : "aread", e);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +
> +	e = event.res != len ? event.res2 : 0;
> +	free(buf);
> +	if (v)
> +		printf("%d/%d: %s %s%s [%lld,%d] %d\n",
> +		       procid, opno, iswrite ? "awrite" : "aread",
> +		       f.path, st, (long long)off, (int)len, e);
> +	free_pathname(&f);
> +	close(fd);
> +}
> +#endif
> +
> +void
> +aread_f(int opno, long r)
> +{
> +#ifdef AIO
> +	do_aio_rw(opno, r, O_RDONLY);
> +#endif
> +}
> +
>  void
>  attr_remove_f(int opno, long r)
>  {
> @@ -1855,6 +2061,14 @@ attr_set_f(int opno, long r)
>  }
>  
>  void
> +awrite_f(int opno, long r)
> +{
> +#ifdef AIO
> +	do_aio_rw(opno, r, O_WRONLY);
> +#endif
> +}
> +
> +void
>  bulkstat_f(int opno, long r)
>  {
>  	int		count;
> -- 
> 2.7.4
> 
