Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4602594B4
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271096; cv=none; b=LT6iR4o2090xPIOkheymPzTXU6/dEHhOjxoSRxY5tlcZ/zk9+Tqc9NXZh/p6B6kLBH8RAOkGvB3illJj91BJZuX1SI9lvXM4VeqTvkcGP43aBHN51F9Uy96cot5Bc/9gLGfyhJardvsmhEhudfIxf9VjLjELBwIR49f+jDHeh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271096; c=relaxed/simple;
	bh=juy6b0E6XGC7m0qhoUiaseHll8b00JMtnNc5HeyN5Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKaOe3cVqWhgG7vkRA/zRfRl9KcbVw6rvkoh47de+sY9ngIXRJDw8mxWf6S/DOdClLTni5+8KNgSZDREIVGk6kzdycU8xYTrW7WiSu+LFRoMAketTb7blwylEVqPfWhynxSIDnQDs5Hx/8+uRgu3YCsziKyAME2/B0AgDSSXvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b13SeTTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b13SeTTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BB2C4CED6;
	Tue,  7 Jan 2025 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736271095;
	bh=juy6b0E6XGC7m0qhoUiaseHll8b00JMtnNc5HeyN5Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b13SeTToUz6uBaKvP6o2wKjrZl6oup5oFKzt5UvccmSGBA4Djw2h2GvShvCILlhgE
	 SpqOv3GVRKaI9Akux8wSuLRExGXLa2AcbtdRo6ATmoFHB/g7bSuZBy/qc0T8xai9mH
	 DnxVBMs9BKq4RBaYtUdKtTDxTQqhIAnNojdE7hCMg/u7XwKquDgfhNNtsmMbvA81RW
	 YfQiOp5HCJH7bfoWLnLWCYKHOCdd9fEyEEklebF1V/sSLVU0qgZL1HHc+68xUe/+Yj
	 h8l8bJpBnvMQ5jbafQYg1aLdlxHGas7IYdL3EzPS3QNl7JMQwuKyrnyh6uEDJcVyKr
	 VrxIaRhFsvSqQ==
Date: Tue, 7 Jan 2025 09:31:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] fsstress: add support for RWF_DONTCACHE
Message-ID: <20250107173135.GR6160@frogsfrogsfrogs>
References: <20250107160617.222775-1-axboe@kernel.dk>
 <20250107160617.222775-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107160617.222775-2-axboe@kernel.dk>

On Tue, Jan 07, 2025 at 09:05:14AM -0700, Jens Axboe wrote:
> Using RWF_DONTCACHE tells the kernel that any page cache instantiated
> by this operation should get pruned once the operation completes. If
> data is in cache prior to the operation it will remain there.
> 
> Add ops for testing both the read and write side of this. If the kernel
> being tested doesn't support RWF_DONTCACHE, then operations are performed
> with regular read/write buffered IO.
> 
> See the kernel posting adding support:
> 
> https://lore.kernel.org/linux-fsdevel/20241220154831.1086649-1-axboe@kernel.dk/
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  ltp/fsstress.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 3d248ee25791..c5554d651b67 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -82,6 +82,16 @@ static int renameat2(int dfd1, const char *path1,
>  #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
>  #endif
>  
> +#ifndef RWF_DONTCACHE
> +#define RWF_DONTCACHE		0x80
> +#endif
> +
> +/*
> + * Default to RWF_DONTCACHE being available, turn it off if -EOPNOTSUPP
> + * is seen during issue.
> + */
> +static int have_rwf_dontcache = 1;
> +
>  #define FILELEN_MAX		(32*4096)
>  
>  typedef enum {
> @@ -117,6 +127,7 @@ typedef enum {
>  	OP_COLLAPSE,
>  	OP_INSERT,
>  	OP_READ,
> +	OP_READ_DONTCACHE,
>  	OP_READLINK,
>  	OP_READV,
>  	OP_REMOVEFATTR,
> @@ -143,6 +154,7 @@ typedef enum {
>  	OP_URING_READ,
>  	OP_URING_WRITE,
>  	OP_WRITE,
> +	OP_WRITE_DONTCACHE,
>  	OP_WRITEV,
>  	OP_EXCHANGE_RANGE,
>  	OP_LAST
> @@ -248,6 +260,7 @@ void	zero_f(opnum_t, long);
>  void	collapse_f(opnum_t, long);
>  void	insert_f(opnum_t, long);
>  void	unshare_f(opnum_t, long);
> +void	read_dontcache_f(opnum_t, long);
>  void	read_f(opnum_t, long);
>  void	readlink_f(opnum_t, long);
>  void	readv_f(opnum_t, long);
> @@ -273,6 +286,7 @@ void	unlink_f(opnum_t, long);
>  void	unresvsp_f(opnum_t, long);
>  void	uring_read_f(opnum_t, long);
>  void	uring_write_f(opnum_t, long);
> +void	write_dontcache_f(opnum_t, long);
>  void	write_f(opnum_t, long);
>  void	writev_f(opnum_t, long);
>  void	exchangerange_f(opnum_t, long);
> @@ -315,6 +329,7 @@ struct opdesc	ops[OP_LAST]	= {
>  	[OP_COLLAPSE]	   = {"collapse",      collapse_f,	1, 1 },
>  	[OP_INSERT]	   = {"insert",	       insert_f,	1, 1 },
>  	[OP_READ]	   = {"read",	       read_f,		1, 0 },
> +	[OP_READ_DONTCACHE] = {"read_dontcache", read_dontcache_f,	1, 0 },
>  	[OP_READLINK]	   = {"readlink",      readlink_f,	1, 0 },
>  	[OP_READV]	   = {"readv",	       readv_f,		1, 0 },
>  	/* remove (delete) extended attribute */
> @@ -346,6 +361,7 @@ struct opdesc	ops[OP_LAST]	= {
>  	[OP_URING_WRITE]   = {"uring_write",   uring_write_f,	1, 1 },
>  	[OP_WRITE]	   = {"write",	       write_f,		4, 1 },
>  	[OP_WRITEV]	   = {"writev",	       writev_f,	4, 1 },
> +	[OP_WRITE_DONTCACHE]= {"write_dontcache", write_dontcache_f,4, 1 },
>  	[OP_EXCHANGE_RANGE]= {"exchangerange", exchangerange_f,	2, 1 },
>  }, *ops_end;
>  
> @@ -4635,6 +4651,73 @@ readv_f(opnum_t opno, long r)
>  	close(fd);
>  }
>  
> +void
> +read_dontcache_f(opnum_t opno, long r)
> +{
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	int64_t		lr;
> +	off64_t		off;
> +	struct stat64	stb;
> +	int		v;
> +	char		st[1024];
> +	struct iovec	iov;
> +	int flags;
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%lld: read - no filename\n", procid, opno);
> +		free_pathname(&f);
> +		return;
> +	}
> +	fd = open_path(&f, O_RDONLY);
> +	e = fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%lld: read - open %s failed %d\n",
> +				procid, opno, f.path, e);
> +		free_pathname(&f);
> +		return;
> +	}
> +	if (fstat64(fd, &stb) < 0) {
> +		if (v)
> +			printf("%d/%lld: read - fstat64 %s failed %d\n",
> +				procid, opno, f.path, errno);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	inode_info(st, sizeof(st), &stb, v);
> +	if (stb.st_size == 0) {
> +		if (v)
> +			printf("%d/%lld: read - %s%s zero size\n", procid, opno,
> +			       f.path, st);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	lr = ((int64_t)random() << 32) + random();
> +	off = (off64_t)(lr % stb.st_size);
> +	iov.iov_len = (random() % FILELEN_MAX) + 1;
> +	iov.iov_base = malloc(iov.iov_len);
> +	flags = have_rwf_dontcache ? RWF_DONTCACHE : 0;
> +	e = preadv2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
> +	if (have_rwf_dontcache && e == EOPNOTSUPP) {
> +		have_rwf_dontcache = 0;
> +		e = preadv2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
> +	}
> +	free(iov.iov_base);
> +	if (v)
> +		printf("%d/%lld: read dontcache %s%s [%lld,%d] %d\n",
> +		       procid, opno, f.path, st, (long long)off,
> +		       (int)iov.iov_len, e);
> +	free_pathname(&f);
> +	close(fd);
> +}
> +
>  void
>  removefattr_f(opnum_t opno, long r)
>  {
> @@ -5509,6 +5592,67 @@ writev_f(opnum_t opno, long r)
>  	close(fd);
>  }
>  
> +void
> +write_dontcache_f(opnum_t opno, long r)
> +{
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	int64_t		lr;
> +	off64_t		off;
> +	struct stat64	stb;
> +	int		v;
> +	char		st[1024];
> +	struct iovec	iov;
> +	int flags;
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGm, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%lld: write - no filename\n", procid, opno);
> +		free_pathname(&f);
> +		return;
> +	}
> +	fd = open_path(&f, O_WRONLY);
> +	e = fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%lld: write - open %s failed %d\n",
> +				procid, opno, f.path, e);
> +		free_pathname(&f);
> +		return;
> +	}
> +	if (fstat64(fd, &stb) < 0) {
> +		if (v)
> +			printf("%d/%lld: write - fstat64 %s failed %d\n",
> +				procid, opno, f.path, errno);
> +		free_pathname(&f);
> +		close(fd);
> +		return;
> +	}
> +	inode_info(st, sizeof(st), &stb, v);
> +	lr = ((int64_t)random() << 32) + random();
> +	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
> +	off %= maxfsize;
> +	iov.iov_len = (random() % FILELEN_MAX) + 1;
> +	iov.iov_base = malloc(iov.iov_len);
> +	memset(iov.iov_base, nameseq & 0xff, iov.iov_len);
> +	flags = have_rwf_dontcache ? RWF_DONTCACHE : 0;
> +	e = pwritev2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
> +	if (have_rwf_dontcache && e == EOPNOTSUPP) {
> +		have_rwf_dontcache = 0;
> +		e = pwritev2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
> +	}
> +	free(iov.iov_base);
> +	if (v)
> +		printf("%d/%lld: write dontcache %s%s [%lld,%d] %d\n",
> +		       procid, opno, f.path, st, (long long)off,
> +		       (int)iov.iov_len, e);
> +	free_pathname(&f);
> +	close(fd);
> +}
> +
>  char *
>  xattr_flag_to_string(int flag)
>  {
> -- 
> 2.47.1
> 
> 
