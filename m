Received: from mx1.redhat.com ([209.132.183.28]:45552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfBAFDm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 1 Feb 2019 00:03:42 -0500
Date: Fri, 1 Feb 2019 13:07:49 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v4 1/2] fsstress: add splice support
Message-ID: <20190201050748.GH2255@dhcp-12-149.nay.redhat.com>
References: <20190123073455.24539-1-zlang@redhat.com>
 <20190201021130.GA29630@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201021130.GA29630@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 31, 2019 at 06:11:30PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 23, 2019 at 03:34:54PM +0800, Zorro Lang wrote:
> > Support the splice syscall in fsstress.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  ltp/fsstress.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 173 insertions(+)
> > 
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 99a1d733..c04feb78 100644
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
> > @@ -2764,6 +2767,176 @@ setxattr_f(int opno, long r)
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
> > +		len = stat1.st_blksize;
> > +	if (len > stat1.st_size)
> > +		len = stat1.st_size;
> > +
> > +	lr = ((int64_t)random() << 32) + random();
> > +	if (stat1.st_size == len)
> > +		off1 = 0;
> > +	else
> > +		off1 = (off64_t)(lr % MIN(stat1.st_size - len, MAXFSIZE));
> > +	off1 %= maxfsize;
> > +
> > +	/*
> > +	 * splice can overlap write, so the offset of the target file can be
> > +	 * any number (< maxfsize)
> > +	 */
> 
> Er... sorry I've been offline for a couple of weeks due to illness and
> so was not able to comment on this patch until now, but I've had a
> problem with my overnight fstests runs:
> 
> > +	lr = ((int64_t)random() << 32) + random();
> 
> This generates a pseudorandom 64-bit candidate offset for the
> destination file where we'll land the splice data...
> 
> > +	off2 = (off64_t)(lr % maxfsize);
> 
> ...and this caps the offset at maxfsize (which is 2^63-	1 on x64), which
> effectively means that the data will appear at a very high file offset,
> which creates large (sparse) files very quickly.
> 
> Contrast this to other functions like clonerange_f, which add an
> additional clamp of 1024 blocks past the current dest file EOF:
> 
>  max_off2 = MIN(stat2.st_size + (1024ULL * stat2.st_blksize), MAXFSIZE);
>  do {
> 	lr = ((int64_t)random() << 32) + random();
> 	off2 = (off64_t)(lr % max_off2);
> 	off2 %= maxfsize;
> 	...
>  }
> 
> or truncate_f, which clamps to both 1MB past EOF and MAXFSIZE:
> 
>  lr = ((int64_t)random() << 32) + random();
>  off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
>  off %= maxfsize;
> 
> IOWs, I think we try to grow the fsstress file sizes fairly slowly so
> that gigantic files don't suddenly jump out of the bushes:
> 
> 0/487: splice d3/d9/f2c[6319385 1 0 0 176 1395200] [860317,88612] ->
> d3/d9/dd/d1c/d21/f4b[1111 1 0 0 0 1408811] [8492675175361853476,88612] 0
> 
> Yikes, it wrote 88,612 bytes of data at offset 8,492,675,175,361,853,476!
> 
> This causes shared/009 to take forever to run, because it runs fsstress
> to generate some files, and then uses md5sum to ensure that duperemove
> doesn't corrupt files.  Unfortunately it takes a very long time to
> read an entire 8500 petabyte file.

Wow, you're right! I didn't think that large sparse file will cause this
problem. This patch has been merged, I'll send another patch to fix it.

Thanks very much,
Zorro


> 
> --D
> 
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
> > +			}
> > +			bytes -= ret2;
> > +		}
> > +		if (ret2 < 0)
> > +			break;
> > +
> > +		len -= ret1;
> > +		total += ret1;
> > +	}
> > +
> > +	if (ret1 < 0 || ret2 < 0)
> > +		e = errno;
> > +	else
> > +		e = 0;
> > +	if (v1 || v2) {
> > +		printf("%d/%d: splice %s%s [%lld,%lld] -> %s%s [%lld,%lld] %d",
> > +			procid, opno,
> > +			fpath1.path, inoinfo1, (long long)offset1, (long long)length,
> > +			fpath2.path, inoinfo2, (long long)offset2, (long long)length, e);
> > +
> > +		if (length && length > total)
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
