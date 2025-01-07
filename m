Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA72594A3
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215779; cv=none; b=u/2q/DXwzmGFYrRK4+pvnfee9gUjnwZfUydbc9saIbhks/lxZ19cWJQMBpjo0AtII9mmdFM+R3x8zQCVHW7/JCCeIcP5AvDH+T5R7rXWHgJ78iyitK6XdMJqqrQhLh46/lsW7thQB4zebkdD7hDLXmrM3xgSZQXt4PrTqTsD4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215779; c=relaxed/simple;
	bh=5l/rMGaahZUiHpwzOhsXub63GZmJV26OKw3ZfovQzZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4svztTWUWaCuqRQ9shcotC4liNzL6NWAk14U6gxzlb3yea48a27+OENrqRFETbD+Vd9CqHMa+ekAtSUrqqdc/wYeQbMwLFwx+N0D9y/0VS6u1M7KQwPMcrt+RodDZItgNuTr9F27KS2DZAnIktpqfZFcJuvjsE42A6Kc6tqP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMId8KEG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMId8KEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82420C4CED2;
	Tue,  7 Jan 2025 02:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736215778;
	bh=5l/rMGaahZUiHpwzOhsXub63GZmJV26OKw3ZfovQzZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMId8KEG6Dqyprsdl/g0IU6ZpPpfGkENGCZ6UGjulv3cGo5kQGBP8tpRlnPNLBr0O
	 cnYIJKEwjRNrn630vD02EemsqzKy3j1Kg9zmKLdX/051TwBH69xFJAG+5nSG9wmZcj
	 JKATNv9+FNrggS5Ygc0zl8GZyaf2MRSHrvbS8mfkDyjNX9fh6NTxwYIkJiWhcgjroH
	 l6fXSFddWcmKnyl4pfNvGPxQ3ekFviarsG6ivk/ST2+5p6f4IDn1TFvViDemQ43RgL
	 nJQksZCdi4okS1ochAB40xb4s2+M4Oa+dTgiFQ3klzKPAdRbLz1EMbY40tcBln2d+w
	 skLfq3+2zqTtg==
Date: Mon, 6 Jan 2025 18:09:38 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add support for RWF_DONTCACHE
Message-ID: <20250107020938.GN6160@frogsfrogsfrogs>
References: <20250106174919.103199-1-axboe@kernel.dk>
 <20250106174919.103199-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106174919.103199-3-axboe@kernel.dk>

On Mon, Jan 06, 2025 at 10:48:47AM -0700, Jens Axboe wrote:
> Using RWF_DONTCACHE tells the kernel that any page cache instantiated
> by this operation should get pruned once the operation completes. If
> data is in cache prior to the operation it will remain there.
> 
> Add ops for testing both the read and write side of this. At startup,
> kernel support for this feature is probed. If support isn't available,
> uncached/dontcache IO is performed as regular buffered IO. If -Z is
> used to turn on O_DIRECT, then uncached/dontcache IO isn't performed.
> Defaults to on if available, and adds a -T parameter to turn it off.
> 
> See the kernel posting adding support:
> 
> https://lore.kernel.org/linux-fsdevel/20241220154831.1086649-1-axboe@kernel.dk/
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  ltp/fsx.c | 115 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 77 insertions(+), 38 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 41933354328a..7c996026157d 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -43,6 +43,10 @@
>  # define MAP_FILE 0
>  #endif
>  
> +#ifndef RWF_DONTCACHE
> +#define RWF_DONTCACHE	0x80
> +#endif
> +
>  #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
>  
>  /* Operation flags (bitmask) */
> @@ -101,7 +105,9 @@ int			logcount = 0;	/* total ops */
>  enum {
>  	/* common operations */
>  	OP_READ = 0,
> +	OP_READ_DONTCACHE,
>  	OP_WRITE,
> +	OP_WRITE_DONTCACHE,
>  	OP_MAPREAD,
>  	OP_MAPWRITE,
>  	OP_MAX_LITE,
> @@ -190,15 +196,16 @@ int	o_direct;			/* -Z */
>  int	aio = 0;
>  int	uring = 0;
>  int	mark_nr = 0;
> +int	dontcache_io = 1;
>  
>  int page_size;
>  int page_mask;
>  int mmap_mask;
> -int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset);
> +int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags);
>  #define READ 0
>  #define WRITE 1
> -#define fsxread(a,b,c,d)	fsx_rw(READ, a,b,c,d)
> -#define fsxwrite(a,b,c,d)	fsx_rw(WRITE, a,b,c,d)
> +#define fsxread(a,b,c,d,f)	fsx_rw(READ, a,b,c,d,f)
> +#define fsxwrite(a,b,c,d,f)	fsx_rw(WRITE, a,b,c,d,f)
>  
>  struct timespec deadline;
>  
> @@ -266,7 +273,9 @@ prterr(const char *prefix)
>  
>  static const char *op_names[] = {
>  	[OP_READ] = "read",
> +	[OP_READ_DONTCACHE] = "read_dontcache",
>  	[OP_WRITE] = "write",
> +	[OP_WRITE_DONTCACHE] = "write_dontcache",
>  	[OP_MAPREAD] = "mapread",
>  	[OP_MAPWRITE] = "mapwrite",
>  	[OP_TRUNCATE] = "truncate",
> @@ -393,12 +402,14 @@ logdump(void)
>  				prt("\t******WWWW");
>  			break;
>  		case OP_READ:
> +		case OP_READ_DONTCACHE:
>  			prt("READ     0x%x thru 0x%x\t(0x%x bytes)",
>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
>  			    lp->args[1]);
>  			if (overlap)
>  				prt("\t***RRRR***");
>  			break;
> +		case OP_WRITE_DONTCACHE:
>  		case OP_WRITE:
>  			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> @@ -784,9 +795,8 @@ doflush(unsigned offset, unsigned size)
>  }
>  
>  void
> -doread(unsigned offset, unsigned size)
> +doread(unsigned offset, unsigned size, int flags)
>  {
> -	off_t ret;
>  	unsigned iret;
>  
>  	offset -= offset % readbdy;
> @@ -818,12 +828,7 @@ doread(unsigned offset, unsigned size)
>  			(monitorend == -1 || offset <= monitorend))))))
>  		prt("%lld read\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
>  		    offset, offset + size - 1, size);
> -	ret = lseek(fd, (off_t)offset, SEEK_SET);
> -	if (ret == (off_t)-1) {
> -		prterr("doread: lseek");
> -		report_failure(140);
> -	}
> -	iret = fsxread(fd, temp_buf, size, offset);
> +	iret = fsxread(fd, temp_buf, size, offset, flags);
>  	if (iret != size) {
>  		if (iret == -1)
>  			prterr("doread: read");
> @@ -870,7 +875,6 @@ check_contents(void)
>  	unsigned map_offset;
>  	unsigned map_size;
>  	char *p;
> -	off_t ret;
>  	unsigned iret;
>  
>  	if (!check_buf) {
> @@ -885,13 +889,7 @@ check_contents(void)
>  	if (size == 0)
>  		return;
>  
> -	ret = lseek(fd, (off_t)offset, SEEK_SET);
> -	if (ret == (off_t)-1) {
> -		prterr("doread: lseek");
> -		report_failure(140);
> -	}
> -
> -	iret = fsxread(fd, check_buf, size, offset);
> +	iret = fsxread(fd, check_buf, size, offset, 0);
>  	if (iret != size) {
>  		if (iret == -1)
>  			prterr("check_contents: read");
> @@ -1064,9 +1062,8 @@ update_file_size(unsigned offset, unsigned size)
>  }
>  
>  void
> -dowrite(unsigned offset, unsigned size)
> +dowrite(unsigned offset, unsigned size, int flags)
>  {
> -	off_t ret;
>  	unsigned iret;
>  
>  	offset -= offset % writebdy;
> @@ -1099,14 +1096,9 @@ dowrite(unsigned offset, unsigned size)
>  		       (monitorstart == -1 ||
>  			(offset + size > monitorstart &&
>  			(monitorend == -1 || offset <= monitorend))))))
> -		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
> -		    offset, offset + size - 1, size);
> -	ret = lseek(fd, (off_t)offset, SEEK_SET);
> -	if (ret == (off_t)-1) {
> -		prterr("dowrite: lseek");
> -		report_failure(150);
> -	}
> -	iret = fsxwrite(fd, good_buf + offset, size, offset);
> +		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
> +		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
> +	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
>  	if (iret != size) {
>  		if (iret == -1)
>  			prterr("dowrite: write");
> @@ -1954,6 +1946,26 @@ do_preallocate(unsigned offset, unsigned length, int keep_size, int unshare)
>  }
>  #endif
>  
> +int
> +test_dontcache_io(void)
> +{
> +	char buf[4096];
> +	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
> +	int ret, e;
> +
> +	ret = preadv2(fd, &iov, 1, 0, RWF_DONTCACHE);
> +	e = ret < 0 ? errno : 0;
> +	if (e == EOPNOTSUPP) {
> +		if (!quiet)
> +			fprintf(stderr,
> +				"main: filesystem does not support "
> +				"dontcache IO, disabling!\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  void
>  writefileimage()
>  {
> @@ -2337,12 +2349,28 @@ have_op:
>  	switch (op) {
>  	case OP_READ:
>  		TRIM_OFF_LEN(offset, size, file_size);
> -		doread(offset, size);
> +		doread(offset, size, 0);
> +		break;
> +
> +	case OP_READ_DONTCACHE:
> +		TRIM_OFF_LEN(offset, size, file_size);
> +		if (dontcache_io)
> +			doread(offset, size, RWF_DONTCACHE);
> +		else
> +			doread(offset, size, 0);
>  		break;
>  
>  	case OP_WRITE:
>  		TRIM_OFF_LEN(offset, size, maxfilelen);
> -		dowrite(offset, size);
> +		dowrite(offset, size, 0);
> +		break;
> +
> +	case OP_WRITE_DONTCACHE:
> +		TRIM_OFF_LEN(offset, size, maxfilelen);
> +		if (dontcache_io)
> +			dowrite(offset, size, RWF_DONTCACHE);
> +		else
> +			dowrite(offset, size, 0);
>  		break;
>  
>  	case OP_MAPREAD:
> @@ -2538,6 +2566,7 @@ usage(void)
>  "	-0: Do not use exchange range calls\n"
>  #endif
>  "	-K: Do not use keep size\n\
> +	-T: Do not use dontcache IO\n\
>  	-L: fsxLite - no file creations & no file size changes\n\
>  	-N numops: total # operations to do (default infinity)\n\
>  	-O: use oplen (see -o flag) for every op (default random)\n\
> @@ -2546,7 +2575,7 @@ usage(void)
>  	-S seed: for random # generator (default 1) 0 gets timestamp\n\
>  	-W: mapped write operations DISabled\n\
>  	-X: Read file and compare to good buffer after every operation\n\
> -	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> +	-Z: O_DIRECT (use -R, -W, -r and -w too, excludes dontcache IO)\n\
>  	--replay-ops=opsfile: replay ops from recorded .fsxops file\n\
>  	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
>  	--duration=seconds: ignore any -N setting and run for this many seconds\n\
> @@ -2702,7 +2731,7 @@ uring_setup()
>  }
>  
>  int
> -uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
> +uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
>  {
>  	struct io_uring_sqe     *sqe;
>  	struct io_uring_cqe     *cqe;
> @@ -2733,6 +2762,7 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  		} else {
>  			io_uring_prep_writev(sqe, fd, &iovec, 1, o);
>  		}
> +		sqe->rw_flags = flags;
>  
>  		ret = io_uring_submit_and_wait(&ring, 1);
>  		if (ret != 1) {
> @@ -2781,7 +2811,7 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  }
>  #else
>  int
> -uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
> +uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
>  {
>  	fprintf(stderr, "io_rw: need IO_URING support!\n");
>  	exit(111);
> @@ -2789,19 +2819,21 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  #endif
>  
>  int
> -fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
> +fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
>  {
>  	int ret;
>  
>  	if (aio) {
>  		ret = aio_rw(rw, fd, buf, len, offset);
>  	} else if (uring) {
> -		ret = uring_rw(rw, fd, buf, len, offset);
> +		ret = uring_rw(rw, fd, buf, len, offset, flags);
>  	} else {
> +		struct iovec iov = { .iov_base = buf, .iov_len = len };
> +
>  		if (rw == READ)
> -			ret = read(fd, buf, len);
> +			ret = preadv2(fd, &iov, 1, offset, flags);
>  		else
> -			ret = write(fd, buf, len);
> +			ret = pwritev2(fd, &iov, 1, offset, flags);
>  	}
>  	return ret;
>  }
> @@ -3065,6 +3097,9 @@ main(int argc, char **argv)
>  			if (seed < 0)
>  				usage();
>  			break;
> +		case 'T':
> +			dontcache_io = 0;
> +			break;
>  		case 'W':
>  		        mapped_writes = 0;
>  			if (!quiet)
> @@ -3076,6 +3111,7 @@ main(int argc, char **argv)
>  		case 'Z':
>  			o_direct = O_DIRECT;
>  			o_flags |= O_DIRECT;
> +			dontcache_io = 0;
>  			break;
>  		case 254:  /* --duration */
>  			if (!optarg) {
> @@ -3293,6 +3329,9 @@ main(int argc, char **argv)
>  		copy_range_calls = test_copy_range();
>  	if (exchange_range_calls)
>  		exchange_range_calls = test_exchange_range();
> +	if (dontcache_io)
> +		dontcache_io = test_dontcache_io();
> +	printf("Dontcache_io=%d\n", dontcache_io);

Is this a debug printf that got left in by mistake?

(Everything else in here looks fine to me...)

--D

>  
>  	while (keep_running())
>  		if (!test())
> -- 
> 2.47.1
> 
> 
