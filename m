Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B122FF42
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881942; cv=none; b=b66JbYokPPOEb85MK44cEd6vNWSU42Ki+QN3KGC6Ob44wyvxiIy4vBKqdvL05Oj0C7JLUgKqXpXJD5LgL459Wp3jKKYXvLlYnW1uDevkPZ+gXeL5UwFZiVHlXXKNs7cC1YU8k9KnDWzM1+njbb1uqoYaisitzA3QWub9RbLNzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881942; c=relaxed/simple;
	bh=puMKiB1EO4sqBjqGL2YVd6nwSYhZuBynLKD3HiI/P34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcMtvChv6NSnFG0FB4PjBMJ6vjMdd72j6T+3SYJbqGyYNan7Dws2tSkZrkg+MdfCeqHgJy/53Kr+A3q5t1miom77DZsnJOPELVyh1Lnddf3pP17geOi+2QBS6fWlU7Wv2aSXMYzC6VriKScSQayIcgErUOWcLnyYLgUMkF3PdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hav5ZYw9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hav5ZYw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327D2C4CEE3;
	Thu,  6 Feb 2025 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738881942;
	bh=puMKiB1EO4sqBjqGL2YVd6nwSYhZuBynLKD3HiI/P34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hav5ZYw9DkC5wXatK3ZPzbX8iIA4yDBKWsE1xCtdwh3fGs6aFdnE1d1X+5xYTEIBb
	 XEAE0TBEYypdFP15qtbZF1a9dOxgzvsowd50hPWRSWvJu7lXr3RVm28hh0uOcX81eq
	 cNP26fTN6fuTQ8ZWAC1R3WZRiomjGcyiUI/dP6Cqpqhtm447FbH6Cu79536JZed1lz
	 ZnKBS4lehjAABM+inaOjkEliHF7LyqUFKe/XFpsLNt2zlwgQJFBppaasncR6C0Md1a
	 K1LF9187popXSirQZwRooT4HY5n1RvOVtQ463wsk28uFl+8wRU6CWEhurv25hJIxL5
	 UfhWJlgmpU4fg==
Date: Thu, 6 Feb 2025 14:45:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 4/7] lib: fix empty arg function prototypes
Message-ID: <20250206224541.GQ21799@frogsfrogsfrogs>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-5-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-5-sandeen@redhat.com>

On Thu, Feb 06, 2025 at 03:19:59PM -0600, Eric Sandeen wrote:
> Several function prototypes used () when in fact they take
> arguments. Fix those to make sparse happy.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  include/random_range.h | 2 +-
>  include/write_log.h    | 2 +-
>  lib/random_range.c     | 6 ++----
>  lib/string_to_tokens.c | 1 -
>  lib/tlibio.c           | 2 +-
>  lib/write_log.c        | 2 +-
>  6 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/include/random_range.h b/include/random_range.h
> index b47aef9e..c352c5a9 100644
> --- a/include/random_range.h
> +++ b/include/random_range.h
> @@ -6,7 +6,7 @@
>  #ifndef _RANDOM_RANGE_H_
>  #define _RANDOM_RANGE_H_
>  
> -int       parse_ranges     ( char *, int, int, int, int (*)(), char **, char ** );
> +int       parse_ranges     ( char *, int, int, int, int (*)(char *, int *), char **, char ** );
>  int       range_min        ( char *, int );
>  int       range_max        ( char *, int );
>  int       range_mult       ( char *, int );
> diff --git a/include/write_log.h b/include/write_log.h
> index 025ebac0..d02f898a 100644
> --- a/include/write_log.h
> +++ b/include/write_log.h
> @@ -125,7 +125,7 @@ extern int	wlog_close(struct wlog_file *wfile);
>  extern int	wlog_record_write(struct wlog_file *wfile,
>  				  struct wlog_rec *wrec, long offset);
>  extern int	wlog_scan_backward(struct wlog_file *wfile, int nrecs,
> -				   int (*func)(struct wlog_rec *rec),
> +				   int (*func)(struct wlog_rec *rec, long data),

This is a very similar version to what's in
testcases/kernel/fs/doio/write_log.c in the LTP source.

Maybe it's time to clean up both versions?

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  				   long data);
>  #else
>  int	wlog_open();
> diff --git a/lib/random_range.c b/lib/random_range.c
> index 680bf71c..0b38eb7f 100644
> --- a/lib/random_range.c
> +++ b/lib/random_range.c
> @@ -69,7 +69,7 @@ struct range {
>   * parse_range() returns -1 on error, or the number of ranges parsed.
>   */
>  
> -static int       str_to_int();
> +static int       str_to_int(char *str, int *ip);
>  static long long divider(long long, long long, long long, long long);
>  
>  int
> @@ -78,7 +78,7 @@ parse_ranges(
>  	int defmin,
>  	int defmax,
>  	int defmult,
> -	int (*parse_func)(),
> +	int (*parse_func)(char *str, int *ip),
>  	char **rangeptr,
>  	char **errptr)
>  {
> @@ -570,8 +570,6 @@ printf("   diff = %lld, half = %lld,   med = %lld\n", diff, half, med);
>  void
>  random_range_seed(long s)
>  {
> -    extern void srand48();
> -
>      srand48(s);
>  }
>  
> diff --git a/lib/string_to_tokens.c b/lib/string_to_tokens.c
> index 08df9fcc..8383ed4c 100644
> --- a/lib/string_to_tokens.c
> +++ b/lib/string_to_tokens.c
> @@ -54,7 +54,6 @@ int
>  string_to_tokens(char *arg_string, char *arg_array[], int array_size, char *separator)
>  {
>     int num_toks = 0;  /* number of tokens found */
> -   char *strtok();
>  	
>     if ( arg_array == NULL || array_size <= 1 || separator == NULL )
>  	return -1;
> diff --git a/lib/tlibio.c b/lib/tlibio.c
> index 3c23bf4d..19192b38 100644
> --- a/lib/tlibio.c
> +++ b/lib/tlibio.c
> @@ -75,7 +75,7 @@
>  
>  
>  #ifndef linux
> -static void lio_async_signal_handler();
> +static void lio_async_signal_handler(int sig);
>  #endif
>  
>  /*
> diff --git a/lib/write_log.c b/lib/write_log.c
> index c82cc1f4..e04fed4b 100644
> --- a/lib/write_log.c
> +++ b/lib/write_log.c
> @@ -217,7 +217,7 @@ int
>  wlog_scan_backward(
>  	struct wlog_file	*wfile,
>  	int 			nrecs,
> -	int 			(*func)(),
> +	int 			(*func)(struct wlog_rec *, long data),
>  	long			data)
>  {
>  	int			fd, leftover, nbytes, offset, recnum, reclen;
> -- 
> 2.48.0
> 
> 
