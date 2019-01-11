Received: from mx1.redhat.com ([209.132.183.28]:39202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfAKD1y (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 10 Jan 2019 22:27:54 -0500
Date: Fri, 11 Jan 2019 11:31:17 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v2 1/2] fsstress: add splice support
Message-ID: <20190111033117.GV30999@dhcp-12-149.nay.redhat.com>
References: <20190110082516.22526-1-zlang@redhat.com>
 <20190110140113.GA2713@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110140113.GA2713@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 10, 2019 at 10:01:13PM +0800, Eryu Guan wrote:
> On Thu, Jan 10, 2019 at 04:25:15PM +0800, Zorro Lang wrote:
> > Support the splice syscall in fsstress.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > Thanks Eryu reviewed my v1 patch, this patch has below changes:
> > 1) Set random off2 properly.
> > 2) Improve splice read and write logic (in while loop).
> > 3) Bring in length, offset1 and offset2 for proper output at the end.
> > 4) Judge the return value (ret1 and ret2) properly.
> > 
> > Thanks,
> > Zorro
> > 
> >  ltp/fsstress.c | 171 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 171 insertions(+)
> > 
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 99a1d733..e477d0ef 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -85,6 +85,7 @@ typedef enum {
> >  	OP_RMDIR,
> >  	OP_SETATTR,
> >  	OP_SETXATTR,
> > +	OP_SPLICE,
> >  	OP_STAT,
> >  	OP_SYMLINK,
> >  	OP_SYNC,
> > @@ -194,6 +195,7 @@ void	resvsp_f(int, long);
> >  void	rmdir_f(int, long);
> >  void	setattr_f(int, long);
> >  void	setxattr_f(int, long);
> > +void	splice_f(int, long);
> >  void	stat_f(int, long);
> >  void	symlink_f(int, long);
> >  void	sync_f(int, long);
> > @@ -244,6 +246,7 @@ opdesc_t	ops[] = {
> >  	{ OP_RMDIR, "rmdir", rmdir_f, 1, 1 },
> >  	{ OP_SETATTR, "setattr", setattr_f, 0, 1 },
> >  	{ OP_SETXATTR, "setxattr", setxattr_f, 1, 1 },
> > +	{ OP_SPLICE, "splice", splice_f, 1, 1 },
> >  	{ OP_STAT, "stat", stat_f, 1, 0 },
> >  	{ OP_SYMLINK, "symlink", symlink_f, 2, 1 },
> >  	{ OP_SYNC, "sync", sync_f, 1, 1 },
> > @@ -2764,6 +2767,174 @@ setxattr_f(int opno, long r)
> >  #endif
> >  }
> >  
> > +void
> > +splice_f(int opno, long r)
> > +{
> > +	struct pathname		fpath1;
> > +	struct pathname		fpath2;
> > +	struct stat64		stat1;
> > +	struct stat64		stat2;
> > +	char			inoinfo1[1024];
> > +	char			inoinfo2[1024];
> > +	loff_t			lr;
> > +	loff_t			off1, off2;
> > +	size_t			len;
> > +	loff_t			offset1, offset2;
> > +	size_t			length;
> > +	size_t			total;
> > +	int			v1;
> > +	int			v2;
> > +	int			fd1;
> > +	int			fd2;
> > +	ssize_t			ret1 = 0, ret2 = 0;
> > +	size_t			bytes;
> > +	int			e;
> > +	int			filedes[2];
> > +
> > +	/* Load paths */
> > +	init_pathname(&fpath1);
> > +	if (!get_fname(FT_REGm, r, &fpath1, NULL, NULL, &v1)) {
> > +		if (v1)
> > +			printf("%d/%d: splice read - no filename\n",
> > +				procid, opno);
> > +		goto out_fpath1;
> > +	}
> > +
> > +	init_pathname(&fpath2);
> > +	if (!get_fname(FT_REGm, random(), &fpath2, NULL, NULL, &v2)) {
> > +		if (v2)
> > +			printf("%d/%d: splice write - no filename\n",
> > +				procid, opno);
> > +		goto out_fpath2;
> > +	}
> > +
> > +	/* Open files */
> > +	fd1 = open_path(&fpath1, O_RDONLY);
> > +	e = fd1 < 0 ? errno : 0;
> > +	check_cwd();
> > +	if (fd1 < 0) {
> > +		if (v1)
> > +			printf("%d/%d: splice read - open %s failed %d\n",
> > +				procid, opno, fpath1.path, e);
> > +		goto out_fpath2;
> > +	}
> > +
> > +	fd2 = open_path(&fpath2, O_WRONLY);
> > +	e = fd2 < 0 ? errno : 0;
> > +	check_cwd();
> > +	if (fd2 < 0) {
> > +		if (v2)
> > +			printf("%d/%d: splice write - open %s failed %d\n",
> > +				procid, opno, fpath2.path, e);
> > +		goto out_fd1;
> > +	}
> > +
> > +	/* Get file stats */
> > +	if (fstat64(fd1, &stat1) < 0) {
> > +		if (v1)
> > +			printf("%d/%d: splice read - fstat64 %s failed %d\n",
> > +				procid, opno, fpath1.path, errno);
> > +		goto out_fd2;
> > +	}
> > +	inode_info(inoinfo1, sizeof(inoinfo1), &stat1, v1);
> > +
> > +	if (fstat64(fd2, &stat2) < 0) {
> > +		if (v2)
> > +			printf("%d/%d: splice write - fstat64 %s failed %d\n",
> > +				procid, opno, fpath2.path, errno);
> > +		goto out_fd2;
> > +	}
> > +	inode_info(inoinfo2, sizeof(inoinfo2), &stat2, v2);
> > +
> > +	/* Calculate offsets */
> > +	len = (random() % FILELEN_MAX) + 1;
> > +	if (len == 0)
> > +		len = MIN(stat1.st_blksize, stat2.st_blksize);
> 
> I don't think it's necessary to take MIN here, the two st_blksize should
> be the same.

Sure

> 
> > +	if (len > MIN(stat1.st_size, stat2.st_size))
> > +		len = MIN(stat1.st_size, stat2.st_size);
> 
> Seems not necessary to take MIN either, just let len = stat1.st_size?

Yeah, we don't need target file size > len.

> 
> > +
> > +	lr = ((int64_t)random() << 32) + random();
> > +	if (stat1.st_size == len)
> > +		off1 = 0;
> > +	else
> > +		off1 = (off64_t)(lr % MIN(stat1.st_size - len, MAXFSIZE));
> > +	off1 %= maxfsize;
> > +
> > +	if (stat2.st_size == len)
> > +		off2 = 0;
> > +	else
> > +		off2 = (off64_t)(lr % MIN(stat2.st_size - len, MAXFSIZE));
> > +	off2 %= maxfsize;
> > +
> > +	/*
> > +	 * Due to len, off1 and off2 will be changed later, so record the
> > +	 * original number at here
> > +	 */
> > +	length = len;
> > +	offset1 = off1;
> > +	offset2 = off2;
> > +
> > +	/* Pipe initialize */
> > +	if (pipe(filedes) < 0) {
> > +		if (v1 || v2) {
> > +			printf("%d/%d: splice - pipe failed %d\n",
> > +				procid, opno, errno);
> > +			goto out_fd2;
> > +		}
> > +	}
> > +
> > +	bytes = 0;
> > +	total = 0;
> > +	while (len > 0) {
> > +		/* move to pipe buffer */
> > +		ret1 = splice(fd1, &off1, filedes[1], NULL, len, 0);
> > +		if (ret1 < 0) {
> > +			break;
> > +		}
> > +		bytes = ret1;
> > +
> > +		/* move from pipe buffer to dst file */
> > +		while (bytes > 0) {
> > +			ret2 = splice(filedes[0], NULL, fd2, &off2, bytes, 0);
> > +			if (ret2 < 0) {
> > +				break;
> 
> Should break the outer while loop too.

Yes, that's my mistake.

> 
> > +			}
> > +			bytes -= ret2;
> > +		}
> > +		len -= ret1;
> > +		total += ret1;
> > +	}
> > +
> > +	if (ret1 < 0 || ret2 < 0)
> > +		e = errno;
> > +	else
> > +		e = 0;
> > +	if (v1 || v2) {
> > +		printf("%d/%d: splice %s%s [%lld,%lld] -> %s%s [%lld,%lld]",
> 
> Better to print out error number on success (0) too, to be consistent
> with other operations.

Hmm... it's not consistent for all, likes clonerange_f, copyrange_f and
deduperange_f don't print out error number on success (0), do you need I change
them to keep consistent too, as you're asking for that now?

Thanks,
Zorro

> 
> Thanks,
> Eryu
> 
> > +			procid, opno,
> > +			fpath1.path, inoinfo1, (long long)offset1, (long long)length,
> > +			fpath2.path, inoinfo2, (long long)offset2, (long long)length);
> > +
> > +		if (ret1 < 0 || ret2 < 0)
> > +			printf(" error %d", e);
> > +		else if (length && length > total)
> > +			printf(" asked for %lld, spliced %lld??\n",
> > +				(long long)length, (long long)total);
> > +		printf("\n");
> > +	}
> > +
> > +	close(filedes[0]);
> > +	close(filedes[1]);
> > +out_fd2:
> > +	close(fd2);
> > +out_fd1:
> > +	close(fd1);
> > +out_fpath2:
> > +	free_pathname(&fpath2);
> > +out_fpath1:
> > +	free_pathname(&fpath1);
> > +}
> > +
> >  void
> >  creat_f(int opno, long r)
> >  {
> > -- 
> > 2.17.2
> > 
