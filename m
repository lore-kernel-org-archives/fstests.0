Received: from mx1.redhat.com ([209.132.183.28]:42722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756649AbdEORHk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 15 May 2017 13:07:40 -0400
Date: Tue, 16 May 2017 01:07:36 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] fsstress: add AIO read and write test
Message-ID: <20170515170736.GF19070@dhcp12-143.nay.redhat.com>
References: <1494685432-11360-1-git-send-email-zlang@redhat.com>
 <20170514042834.GB4514@birch.djwong.org>
 <20170514080141.GE19070@dhcp12-143.nay.redhat.com>
 <20170515160247.GC4514@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515160247.GC4514@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 15, 2017 at 09:02:47AM -0700, Darrick J. Wong wrote:
> On Sun, May 14, 2017 at 04:01:41PM +0800, Zorro Lang wrote:
> > On Sat, May 13, 2017 at 09:28:35PM -0700, Darrick J. Wong wrote:
> > > On Sat, May 13, 2017 at 10:23:52PM +0800, Zorro Lang wrote:
> > > > We found some bugs by aio read/write test, but there's not related
> > > > operations in fsstress. So add AIO read/write test into fsstress to
> > > > increase AIO stress test.
> > > 
> > > I bet you'd find even /more/ problems if you tried adding io_prep_fsync
> > > to fsstress. ;)
> > 
> > Good idea! How about add an afsync_f() likes fsync_f() in fsstress, likes:
> > 
> > void
> > afsync_f(int opno, long r)
> > {
> > #ifdef AIO
> >         int             e;
> >         pathname_t      f;
> >         int             fd;
> >         int             v;
> >         struct iocb     iocb;
> >         struct iocb     *iocbs[] = { &iocb };
> >         struct io_event event;
> > 
> >         init_pathname(&f);
> >         if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> >                 if (v)
> >                         printf("%d/%d: afsync - no filename\n", procid, opno);
> >                 free_pathname(&f);
> >                 return;
> >         }
> >         fd = open_path(&f, O_WRONLY | O_DIRECT);
> >         e = fd < 0 ? errno : 0;
> >         check_cwd();
> >         if (fd < 0) {
> >                 if (v)
> >                         printf("%d/%d: afsync - open %s failed %d\n",
> >                                procid, opno, f.path, e);
> >                 free_pathname(&f);
> >                 return;
> >         }
> > 
> >         io_prep_fsync(&iocb, fd);
> >         if (io_submit(io_ctx, 1, iocbs) != 1) {
> >                 if (v)
> >                         printf("%d/%d: afsync - io_submit %s %d\n",
> >                                procid, opno, f.path, errno);
> >                 free_pathname(&f);
> >                 close(fd);
> >                 return;
> >         }
> >         if (io_getevents(io_ctx, 1, 1, &event, NULL) != 1) {
> >                 if (v)
> >                         printf("%d/%d: afsync - io_getevents failed %d\n",
> >                                procid, opno, errno);
> 
> Uh... I think io_getevents passes negative error codes back via return
> value, not via errno.  Or so claims the manpage.
> 
> >                 free_pathname(&f);
> >                 close(fd);
> >                 return;
> >         }
> > 
> >         e = event.res < 0 ? errno : 0;
> 
> IO errors during the aio operation are returned via
> event.res/event.res2, but this drops both error codes entirely, right?
> I was expecting:
> 
> e = event.res < 0 ? event.res : event.res2;
> 
> Since the io_getevents manpage already states that libaio doesn't set
> errno unless you happen to be invoking the syscalls directly it via
> syscall().
> 
> (Apologies for doing this retroactively, but I think you had better
> check the aio read/write patch for this issue too.)

Thanks for your review so much. Sorry I'm not so familiar with libaio
things. I should read the manpage more carefully. I'm going to check
the RETURNVALUE and ERRNO things in libaio.

Thanks,
Zorro

> 
> --D
> 
> >         if (v)
> >                 printf("%d/%d: afsync %s %d\n", procid, opno, f.path, e);
> >         free_pathname(&f);
> >         close(fd);
> > #endif
> > }
> > 
> > Or do you have any other ideas?
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > > ---
> > > >  ltp/fsstress.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 157 insertions(+)
> > > > 
> > > > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > > > index 6d8f117..5d5c362 100644
> > > > --- a/ltp/fsstress.c
> > > > +++ b/ltp/fsstress.c
> > > > @@ -35,6 +35,10 @@
> > > >  #ifdef HAVE_SYS_PRCTL_H
> > > >  #include <sys/prctl.h>
> > > >  #endif
> > > > +#ifdef AIO
> > > > +#include <libaio.h>
> > > > +io_context_t	io_ctx;
> > > > +#endif
> > > >  
> > > >  #ifndef FS_IOC_GETFLAGS
> > > >  #define FS_IOC_GETFLAGS                 _IOR('f', 1, long)
> > > > @@ -52,8 +56,10 @@
> > > >  
> > > >  typedef enum {
> > > >  	OP_ALLOCSP,
> > > > +	OP_AREAD,
> > > >  	OP_ATTR_REMOVE,
> > > >  	OP_ATTR_SET,
> > > > +	OP_AWRITE,
> > > >  	OP_BULKSTAT,
> > > >  	OP_BULKSTAT1,
> > > >  	OP_CHOWN,
> > > > @@ -153,8 +159,10 @@ struct print_string {
> > > >  #define	MAXFSIZE32	((1ULL << 40) - 1ULL)
> > > >  
> > > >  void	allocsp_f(int, long);
> > > > +void	aread_f(int, long);
> > > >  void	attr_remove_f(int, long);
> > > >  void	attr_set_f(int, long);
> > > > +void	awrite_f(int, long);
> > > >  void	bulkstat_f(int, long);
> > > >  void	bulkstat1_f(int, long);
> > > >  void	chown_f(int, long);
> > > > @@ -195,8 +203,10 @@ void	write_f(int, long);
> > > >  opdesc_t	ops[] = {
> > > >       /* { OP_ENUM, "name", function, freq, iswrite }, */
> > > >  	{ OP_ALLOCSP, "allocsp", allocsp_f, 1, 1 },
> > > > +	{ OP_AREAD, "aread", aread_f, 1, 0 },
> > > >  	{ OP_ATTR_REMOVE, "attr_remove", attr_remove_f, /* 1 */ 0, 1 },
> > > >  	{ OP_ATTR_SET, "attr_set", attr_set_f, /* 2 */ 0, 1 },
> > > > +	{ OP_AWRITE, "awrite", awrite_f, 1, 1 },
> > > >  	{ OP_BULKSTAT, "bulkstat", bulkstat_f, 1, 0 },
> > > >  	{ OP_BULKSTAT1, "bulkstat1", bulkstat1_f, 1, 0 },
> > > >  	{ OP_CHOWN, "chown", chown_f, 3, 1 },
> > > > @@ -576,8 +586,20 @@ int main(int argc, char **argv)
> > > >  				}
> > > >  			}
> > > >  			procid = i;
> > > > +#ifdef AIO
> > > > +			if (io_setup(128, &io_ctx) != 0) {
> > > > +				perror("io_setup failed");
> > > > +				exit(1);
> > > > +			}
> > > > +#endif
> > > >  			for (i = 0; !loops || (i < loops); i++)
> > > >  				doproc();
> > > > +#ifdef AIO
> > > > +			if(io_destroy(io_ctx) != 0) {
> > > > +				perror("io_destroy failed");
> > > > +				return 1;
> > > > +			}
> > > > +#endif
> > > >  			return 0;
> > > >  		}
> > > >  	}
> > > > @@ -1730,6 +1752,133 @@ allocsp_f(int opno, long r)
> > > >  	close(fd);
> > > >  }
> > > >  
> > > > +#ifdef AIO
> > > > +void
> > > > +do_aio_rw(int opno, long r, int flags)
> > > > +{
> > > > +	__int64_t	align;
> > > > +	char		*buf;
> > > > +	struct dioattr	diob;
> > > > +	int		e;
> > > > +	pathname_t	f;
> > > > +	int		fd;
> > > > +	size_t		len;
> > > > +	__int64_t	lr;
> > > > +	off64_t		off;
> > > > +	struct stat64	stb;
> > > > +	int		v;
> > > > +	char		st[1024];
> > > > +	char		*dio_env;
> > > > +	struct iocb	iocb;
> > > > +	struct io_event	event;
> > > > +	struct iocb	*iocbs[] = { &iocb };
> > > > +	int		iswrite = (flags & (O_WRONLY | O_RDWR)) ? 1 : 0;
> > > > +
> > > > +	init_pathname(&f);
> > > > +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> > > > +		if (v)
> > > > +			printf("%d/%d: do_aio_rw - no filename\n", procid, opno);
> > > > +		free_pathname(&f);
> > > > +		return;
> > > > +	}
> > > > +	fd = open_path(&f, flags|O_DIRECT);
> > > > +	e = fd < 0 ? errno : 0;
> > > > +	check_cwd();
> > > > +	if (fd < 0) {
> > > > +		if (v)
> > > > +			printf("%d/%d: do_aio_rw - open %s failed %d\n",
> > > > +			       procid, opno, f.path, e);
> > > > +		free_pathname(&f);
> > > > +		return;
> > > > +	}
> > > > +	if (fstat64(fd, &stb) < 0) {
> > > > +		if (v)
> > > > +			printf("%d/%d: do_aio_rw - fstat64 %s failed %d\n",
> > > > +			       procid, opno, f.path, errno);
> > > > +		free_pathname(&f);
> > > > +		close(fd);
> > > > +		return;
> > > > +	}
> > > > +	inode_info(st, sizeof(st), &stb, v);
> > > > +	if (!iswrite && stb.st_size == 0) {
> > > > +		if (v)
> > > > +			printf("%d/%d: do_aio_rw - %s%s zero size\n", procid, opno,
> > > > +			       f.path, st);
> > > > +		free_pathname(&f);
> > > > +		close(fd);
> > > > +		return;
> > > > +	}
> > > > +	if (xfsctl(f.path, fd, XFS_IOC_DIOINFO, &diob) < 0) {
> > > > +		if (v)
> > > > +			printf(
> > > > +			"%d/%d: do_aio_rw - xfsctl(XFS_IOC_DIOINFO) %s%s failed %d\n",
> > > > +				procid, opno, f.path, st, errno);
> > > > +		free_pathname(&f);
> > > > +		close(fd);
> > > > +		return;
> > > > +	}
> > > > +	dio_env = getenv("XFS_DIO_MIN");
> > > > +	if (dio_env)
> > > > +		diob.d_mem = diob.d_miniosz = atoi(dio_env);
> > > > +	align = (__int64_t)diob.d_miniosz;
> > > > +	lr = ((__int64_t)random() << 32) + random();
> > > > +	len = (random() % FILELEN_MAX) + 1;
> > > > +	len -= (len % align);
> > > > +	if (len <= 0)
> > > > +		len = align;
> > > > +	else if (len > diob.d_maxiosz)
> > > > +		len = diob.d_maxiosz;
> > > > +	buf = memalign(diob.d_mem, len);
> > > > +
> > > > +	if (iswrite) {
> > > > +		off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
> > > > +		off -= (off % align);
> > > > +		off %= maxfsize;
> > > > +		memset(buf, nameseq & 0xff, len);
> > > > +		io_prep_pwrite(&iocb, fd, buf, len, off);
> > > > +	} else {
> > > > +		off = (off64_t)(lr % stb.st_size);
> > > > +		off -= (off % align);
> > > > +		io_prep_pread(&iocb, fd, buf, len, off);
> > > > +	}
> > > > +	if (io_submit(io_ctx, 1, iocbs) != 1) {
> > > > +		if (v)
> > > > +			printf("%d/%d: %s - io_submit failed %d\n",
> > > > +			       procid, opno, iswrite ? "awrite" : "aread",
> > > > +			       errno);
> > > > +		free_pathname(&f);
> > > > +		close(fd);
> > > > +		return;
> > > > +	}
> > > > +	if (io_getevents(io_ctx, 1, 1, &event, NULL) != 1) {
> > > > +		if (v)
> > > > +			printf("%d/%d: %s - io_getevents failed %d\n",
> > > > +			       procid, opno, iswrite ? "awrite" : "aread",
> > > > +			       errno);
> > > > +		free_pathname(&f);
> > > > +		close(fd);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	e = event.res < 0 ? errno : 0;
> > > > +	free(buf);
> > > > +	if (v)
> > > > +		printf("%d/%d: %s %s%s [%lld,%d] %d\n",
> > > > +		       procid, opno, iswrite ? "awrite" : "aread",
> > > > +		       f.path, st, (long long)off, (int)len, e);
> > > > +	free_pathname(&f);
> > > > +	close(fd);
> > > > +}
> > > > +#endif
> > > > +
> > > > +void
> > > > +aread_f(int opno, long r)
> > > > +{
> > > > +#ifdef AIO
> > > > +	do_aio_rw(opno, r, O_RDONLY);
> > > > +#endif
> > > > +}
> > > > +
> > > >  void
> > > >  attr_remove_f(int opno, long r)
> > > >  {
> > > > @@ -1834,6 +1983,14 @@ attr_set_f(int opno, long r)
> > > >  }
> > > >  
> > > >  void
> > > > +awrite_f(int opno, long r)
> > > > +{
> > > > +#ifdef AIO
> > > > +	do_aio_rw(opno, r, O_WRONLY);
> > > > +#endif
> > > > +}
> > > > +
> > > > +void
> > > >  bulkstat_f(int opno, long r)
> > > >  {
> > > >  	int		count;
> > > > -- 
> > > > 2.7.4
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
