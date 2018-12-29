Received: from mx1.redhat.com ([209.132.183.28]:44484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbeL2IAS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 29 Dec 2018 03:00:18 -0500
Date: Sat, 29 Dec 2018 16:03:15 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH 1/2] fsstress: add splice support
Message-ID: <20181229080315.GS30999@dhcp-12-149.nay.redhat.com>
References: <20181225085632.9875-1-zlang@redhat.com>
 <20181229074807.GE21777@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229074807.GE21777@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 29, 2018 at 03:48:07PM +0800, Eryu Guan wrote:
> On Tue, Dec 25, 2018 at 04:56:31PM +0800, Zorro Lang wrote:
> > Support the splice syscall in fsstress.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> 
> Thanks for adding the new syscall! Some comments inline.
> 
> > ---
> >  ltp/fsstress.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> > 
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 99a1d733..cdf73026 100644
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
> > @@ -2764,6 +2767,147 @@ setxattr_f(int opno, long r)
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
> > +	loff_t			off1;
> > +	loff_t			off2;
> > +	size_t			len;
> > +	size_t			total;
> > +	int			v1;
> > +	int			v2;
> > +	int			fd1;
> > +	int			fd2;
> > +	size_t			ret;
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
> > +	if (pipe(filedes) < 0) {
> > +		if (v1 || v2) {
> > +			printf("%d/%d: splice - pipe failed %d\n",
> > +			       procid, opno, errno);
> > +			goto out_fd2;
> > +		}
> > +	}
> > +
> > +	while (len > 0) {
> > +		/* move to pipe buffer */
> > +		ret = splice(fd1, &off1, filedes[1], NULL, len, 0);
> 
> ret is defined as size_t, but splice(2) returns ssize_t, and the return
> value is casted to size_t and can't be negative.
> 
> > +		if (ret < 0) {
> > +			break;
> > +		}
> 
> So this will never be true.
> 
> > +		/* move from pipe buffer to dst file */
> > +		ret = splice(filedes[0], NULL, fd2, &off2, len, 0);
> 
> We should splice 'ret' bytes as the length not 'len' here, otherwise we
> may request to splice more data to fd2 than the pipe actually holds and
> block on reading the pipe. I can hit fsstress 'hang' occasionally.
> 
> Also, off2 is used without being initialized.
> 
> > +		if (ret < 0) {
> > +			break;
> > +		}
> > +                len -= ret;
> > +                total += ret;
> > +	}
> > +
> > +	e = ret < 0 ? errno : 0;
> > +	if (v1 || v2) {
> > +		printf("%d/%d: splice %s%s [%lld,%lld] -> %s%s [%lld,%lld]",
> > +			procid, opno,
> > +			fpath1.path, inoinfo1, (long long)off1, (long long)len,
> > +			fpath2.path, inoinfo2, (long long)off2, (long long)len);
> 
> The values of off1 and off2 have been updated by splice(2) calls, and
> are not the initial value we requested. And 'len' is always '0' here as
> it's been adjusted in above while loop as well.
> 
> > +
> > +		if (ret < 0)
> > +			printf(" error %d", e);
> 
> Always print out errno even if it's 0 (and 'error' can be omitted), as
> other operations do.
> 
> > +		else if (len && ret > len)
> 
> Same here, 'len' is 0 and the if can never be true.

Thanks for your reviewing, looks like I was too hurry to send this patch out:)
I should do more self-check. I'm going to fix these problems and send V2 later.

Thanks,
Zorro

> 
> Thanks,
> Eryu
> 
> > +			printf(" asked for %lld, copied %lld??\n",
> > +				(long long)len, (long long)total);
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
