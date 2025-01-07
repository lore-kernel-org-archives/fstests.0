Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B46F099
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215864; cv=none; b=jRCe/GgAtwRN3J8Ptr9pl9SjpCrLEj9dRt/g7OPpySXTaPt4qORewHOakdnDqLAfdO+jNS8TOmNyeZ86emaU0YMBm0hEqlbQJGbb71sZ/wZfm3KpE+2ZGPWYkzkrb3s/CVqSCzDME7BYnW529I/sE4unL3dyprL3h5Otl1/Bj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215864; c=relaxed/simple;
	bh=tYIyh1UgPC2mdXeSea/zlbXuZU6yoOkPmRCKVw2yWcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzotff0ghqUNM+43wTIFxnSe2YCFugD5+3Ak/njDFiRE3eRBc1yoaS9bb57HltyRPkxiNzgnbHy6Q+tLJqmRVkI2MbnUjJIjrtqm7E9B+qNfnrQpQsKJ3xyDpJJhAFNlZBj78n0a9OWcdJ7wMbAZw5Qn0aV1Eoh5nWo+4kloJbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU4kCBEN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU4kCBEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAC3C4CED2;
	Tue,  7 Jan 2025 02:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736215862;
	bh=tYIyh1UgPC2mdXeSea/zlbXuZU6yoOkPmRCKVw2yWcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jU4kCBENyewSE4gUjun1Ec1jtWfX8SN8hHJhH/GvzRUVaU81ugYrb90S12A6WwZIz
	 8dEIh5UpoD6FvPt5HwMGkj2JrbxbnG3z3Tzkccfwncpm2z/vHlSDy1VuxPsNzzvBB/
	 H2cZLW0tlODyaTK3tCZEx26FgqWImDE0fSKYKPVicDlpkYEzWr9EbiObOsquLNOR75
	 zRy5VEE68KxJ99UoR/K10IsH/EkNeM3cPLamVdD87SCaWGtpP9MLfKXr1W3ygu8JrT
	 +RBuLIHEwC/SsqYqKxwPZGsN+/BmZy84f3ZW1CAL3QIb4F1+AcRgXgsol52yYhe668
	 NdP2RGuthSRTg==
Date: Mon, 6 Jan 2025 18:11:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] fsstress: add support for RWF_DONTCACHE
Message-ID: <20250107021102.GO6160@frogsfrogsfrogs>
References: <20250106174919.103199-1-axboe@kernel.dk>
 <20250106174919.103199-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106174919.103199-2-axboe@kernel.dk>

On Mon, Jan 06, 2025 at 10:48:46AM -0700, Jens Axboe wrote:
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
> ---
>  ltp/fsstress.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 3d248ee25791..df9f6ffb86fc 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -82,6 +82,12 @@ static int renameat2(int dfd1, const char *path1,
>  #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
>  #endif
>  
> +#ifndef RWF_DONTCACHE
> +#define RWF_DONTCACHE		0x80
> +#endif
> +
> +static int have_rwf_dontcache = 1;
> +
>  #define FILELEN_MAX		(32*4096)
>  
>  typedef enum {
> @@ -117,6 +123,7 @@ typedef enum {
>  	OP_COLLAPSE,
>  	OP_INSERT,
>  	OP_READ,
> +	OP_READ_DONTCACHE,
>  	OP_READLINK,
>  	OP_READV,
>  	OP_REMOVEFATTR,
> @@ -143,6 +150,7 @@ typedef enum {
>  	OP_URING_READ,
>  	OP_URING_WRITE,
>  	OP_WRITE,
> +	OP_WRITE_DONTCACHE,
>  	OP_WRITEV,
>  	OP_EXCHANGE_RANGE,
>  	OP_LAST
> @@ -248,6 +256,7 @@ void	zero_f(opnum_t, long);
>  void	collapse_f(opnum_t, long);
>  void	insert_f(opnum_t, long);
>  void	unshare_f(opnum_t, long);
> +void	read_dontcache_f(opnum_t, long);
>  void	read_f(opnum_t, long);
>  void	readlink_f(opnum_t, long);
>  void	readv_f(opnum_t, long);
> @@ -273,6 +282,7 @@ void	unlink_f(opnum_t, long);
>  void	unresvsp_f(opnum_t, long);
>  void	uring_read_f(opnum_t, long);
>  void	uring_write_f(opnum_t, long);
> +void	write_dontcache_f(opnum_t, long);
>  void	write_f(opnum_t, long);
>  void	writev_f(opnum_t, long);
>  void	exchangerange_f(opnum_t, long);
> @@ -315,6 +325,7 @@ struct opdesc	ops[OP_LAST]	= {
>  	[OP_COLLAPSE]	   = {"collapse",      collapse_f,	1, 1 },
>  	[OP_INSERT]	   = {"insert",	       insert_f,	1, 1 },
>  	[OP_READ]	   = {"read",	       read_f,		1, 0 },
> +	[OP_READ_DONTCACHE] = {"read_dontcache", read_dontcache_f,	1, 0 },
>  	[OP_READLINK]	   = {"readlink",      readlink_f,	1, 0 },
>  	[OP_READV]	   = {"readv",	       readv_f,		1, 0 },
>  	/* remove (delete) extended attribute */
> @@ -346,6 +357,7 @@ struct opdesc	ops[OP_LAST]	= {
>  	[OP_URING_WRITE]   = {"uring_write",   uring_write_f,	1, 1 },
>  	[OP_WRITE]	   = {"write",	       write_f,		4, 1 },
>  	[OP_WRITEV]	   = {"writev",	       writev_f,	4, 1 },
> +	[OP_WRITE_DONTCACHE]= {"write_dontcache", write_dontcache_f,4, 1 },
>  	[OP_EXCHANGE_RANGE]= {"exchangerange", exchangerange_f,	2, 1 },
>  }, *ops_end;
>  
> @@ -4635,6 +4647,71 @@ readv_f(opnum_t opno, long r)
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

Should there be a check for null iov_base after the allocation?

> +	flags = have_rwf_dontcache ? RWF_DONTCACHE : 0;
> +	e = preadv2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
> +	if (have_rwf_dontcache && e == EOPNOTSUPP)

...and should this set have_rwf_dontcache = 0?

(Other than that, thanks for wiring this up...)

--D

> +		e = preadv2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
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
> @@ -5509,6 +5586,65 @@ writev_f(opnum_t opno, long r)
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
> +	if (have_rwf_dontcache && e == EOPNOTSUPP)
> +		e = pwritev2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
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
