Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E351684AC
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706705; cv=none; b=psSBuk75cHsg53B9TzK6WuJxToIby/qrc7ZXXeF2eNocTES3QvyJDu1ro5Kswvy4yUxOWkAOUj3Gw4NW9iVJNcsF64vKt0TT9INMSSJ52qmWYyFd/6z3SnpqcU+EpGbZpp8bZOgfb+AqIBJEJVmARleVsZQzh8Fc3CuQm5kBkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706705; c=relaxed/simple;
	bh=Hj7qVfWTrPMSP2i25w8TiVv9tP5kXzO302sQueLSi9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzYnZNqbtcpkvWtXvweswPPbWSw084YXdSt9vr3ulQ87QMSuFgT+mjBmbPaL14GBbeKhIpHUMmHuKNEs1MZtwF5RCXJrueBEYL8/ihZJDmy5huB7ZRXwtQcEEnTd0b5gt4f2+McdOoWlyh/ptV96Tk7cPNRQ+u363v8bTo87xLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aShWBHGV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aShWBHGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E49C4CEE9;
	Tue, 11 Mar 2025 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741706705;
	bh=Hj7qVfWTrPMSP2i25w8TiVv9tP5kXzO302sQueLSi9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aShWBHGVvCvQMvZnmEM26Qy9yAz/+BS8+WxdugYh3346U6yVwIFlbgVHwVos1wsWb
	 mB3G/a3X3Zl+wvebeumkXFnYf/myzxRcfOYuKeVUGbBP7lFDiWgTrs/nA72hFEzcHF
	 CyEShBBGFV5wiaAENlAQTR5lFJJSPUKO8ssNGfmvd/eVoG64C9xSmYfLTtlUHXN/No
	 6GvUHJTE36Ews2mNrQrnv4Bz2YHB/CPDJJGzvwh6ojVgIQtMwKmupKmQXOk6/Rpqel
	 dtfwkFnxaw4nLCwJIMg57m+MjURcuSfrdIQlE4tzBd14XJE5VNTrkArsoDjGx6NI4m
	 8lHGpckuGCofw==
Date: Tue, 11 Mar 2025 08:25:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH 2/7 V3] treewide: check for #ifdef __linux__ not linux
Message-ID: <20250311152504.GH2803740@frogsfrogsfrogs>
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-3-sandeen@redhat.com>
 <290f4825-dc3c-405f-a306-49a978fa2597@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290f4825-dc3c-405f-a306-49a978fa2597@sandeen.net>

On Tue, Mar 11, 2025 at 08:46:48AM -0500, Eric Sandeen wrote:
> There are several #ifdef linux guards in the code, which caused
> a few sparse warnings, because while gcc defines both linux
> and __linux__, sparse defines only __linux__. So, switch our
> guards to check for __linux__ which is defined by both gcc
> and sparse.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  include/tlibio.h    |  6 +++---
>  include/write_log.h |  2 +-
>  lib/str_to_bytes.c  |  2 +-
>  lib/tlibio.c        | 12 ++++++------
>  lib/write_log.c     |  2 +-
>  ltp/doio.c          |  8 ++++----
>  ltp/iogen.c         |  6 +++---
>  7 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/include/tlibio.h b/include/tlibio.h
> index 12649cf5..4f462ff1 100644
> --- a/include/tlibio.h
> +++ b/include/tlibio.h
> @@ -11,7 +11,7 @@
>  #define LIO_IO_SYNCV            00020   /* single-buffer readv/writev */
>  #define LIO_IO_SYNCP            00040   /* pread/pwrite */
>  
> -#ifdef linux
> +#ifdef __linux__
>  #define LIO_IO_TYPES            00021   /* all io types */
>  #endif /* linux */
>  
> @@ -21,14 +21,14 @@
>  #define LIO_WAIT_SIGPAUSE       00100000 /* call pause */
>  #define LIO_WAIT_SIGACTIVE      00200000 /* spin waiting for signal */
>  
> -#ifdef linux
> +#ifdef __linux__
>  #define LIO_WAIT_TYPES          00300000 /* all wait types, except nowait */
>  #endif /* linux */
>  
>  /* meta wait io  */
>  /*  00  000 0000 */
>  
> -#ifdef linux
> +#ifdef __linux__
>  /* all signal wait types */
>  #define LIO_WAIT_SIGTYPES	(LIO_WAIT_SIGPAUSE)
>  #endif /* linux */
> diff --git a/include/write_log.h b/include/write_log.h
> index 025ebac0..6b088416 100644
> --- a/include/write_log.h
> +++ b/include/write_log.h
> @@ -79,7 +79,7 @@ struct wlog_rec {
>   */
>  
>  struct wlog_rec_disk {
> -#ifdef linux
> +#ifdef __linux__
>      uint    w_offset    : 32;	    /* file offset  	    	    */
>      uint    w_extra0    : 32;       /* EXTRA BITS IN WORD 0         */
>  #endif
> diff --git a/lib/str_to_bytes.c b/lib/str_to_bytes.c
> index 2f6b2b92..89bc7d31 100644
> --- a/lib/str_to_bytes.c
> +++ b/lib/str_to_bytes.c
> @@ -31,7 +31,7 @@
>   *
>   ****************************************************************************/
>  
> -#if linux
> +#ifdef __linux__
>  #define B_MULT	DEV_BSIZE	/* block size */
>  #endif
>  
> diff --git a/lib/tlibio.c b/lib/tlibio.c
> index 5b810059..ae936f41 100644
> --- a/lib/tlibio.c
> +++ b/lib/tlibio.c
> @@ -74,7 +74,7 @@
>  #endif
>  
>  
> -#ifndef linux
> +#ifndef __linux__
>  static void lio_async_signal_handler();
>  #endif
>  
> @@ -351,7 +351,7 @@ lio_help2(char *prefix)
>      return;
>  }
>  
> -#ifndef linux
> +#ifndef __linux__
>  /***********************************************************************
>   * This is an internal signal handler.
>   * If the handler is called, it will increment the Received_signal
> @@ -453,7 +453,7 @@ char **errmsg;	/* char pointer that will be updated to point to err message */
>  long wrd;	/* to allow future features, use zero for now */
>  {
>      int ret = 0;	/* syscall return or used to get random method */
> -#ifndef linux
> +#ifndef __linux__
>      int omethod = method;
>      int listio_cmd;		/* Holds the listio/lio_listio cmd */
>  #endif
> @@ -650,7 +650,7 @@ char **errmsg;	/* char pointer that will be updated to point to err message */
>  long wrd;	/* to allow future features, use zero for now */
>  {
>      int ret = 0;	/* syscall return or used to get random method */
> -#ifndef linux
> +#ifndef __linux__
>      int listio_cmd;		/* Holds the listio/lio_listio cmd */
>      int omethod = method;
>  #endif
> @@ -797,7 +797,7 @@ long wrd;	/* to allow future features, use zero for now */
>  }	/* end of lio_read_buffer */
>  
>  
> -#ifndef linux
> +#ifndef __linux__
>  /***********************************************************************
>   * This function will check that async io was successful.
>   * It can also be used to check sync listio since it uses the
> @@ -998,7 +998,7 @@ lio_wait4asyncio(int method, int fd, aiocb_t *aiocbp)
>  
>  } /* end of lio_wait4asyncio */
>  
> -#endif /* ifndef linux */
> +#endif /* ifndef __linux__ */
>  
>  #if UNIT_TEST
>  /***********************************************************************
> diff --git a/lib/write_log.c b/lib/write_log.c
> index cdc72593..7c58a95f 100644
> --- a/lib/write_log.c
> +++ b/lib/write_log.c
> @@ -49,7 +49,7 @@
>  #include "write_log.h"
>  
>  #ifndef BSIZE
> -#ifdef linux
> +#ifdef __linux__
>  #define BSIZE DEV_BSIZE
>  #else
>  #define BSIZE BBSIZE
> diff --git a/ltp/doio.c b/ltp/doio.c
> index fd64df0f..ba080a0b 100644
> --- a/ltp/doio.c
> +++ b/ltp/doio.c
> @@ -222,7 +222,7 @@ int     parse_cmdline( int, char **, char * );
>  int     lock_file_region( char *, int, int, int, int );
>  struct	fd_cache *alloc_fdcache(char *, int);
>  int     aio_register( int, int, int );
> -#ifndef linux
> +#ifndef __linux__
>  int aio_wait(int);
>  #endif
>  
> @@ -1990,7 +1990,7 @@ do_rw(req)
>  		/*
>  		 * If the syscall was async, wait for I/O to complete
>  		 */
> -#ifndef linux
> +#ifndef __linux__
>  		if(sy->sy_flags & SY_ASYNC) {
>  			for(i=0; i < nents; i++) {
>  				aio_wait(s->aioid[i]);
> @@ -2425,7 +2425,7 @@ int nbytes;
>  	static int	mturn = 0;	/* which memory type to use */
>  	struct memalloc	*M;
>  	char		filename[255];
> -#ifdef linux
> +#ifdef __linux__
>  	struct shmid_ds shm_ds;
>  	bzero( &shm_ds, sizeof(struct shmid_ds) );
>  #endif
> @@ -2997,7 +2997,7 @@ int	aio_id;
>  	return 0;
>  }
>  
> -#ifndef linux
> +#ifndef __linux__
>  int
>  aio_wait(aio_id)
>  int	aio_id;
> diff --git a/ltp/iogen.c b/ltp/iogen.c
> index 0c8b97e9..416dedbc 100644
> --- a/ltp/iogen.c
> +++ b/ltp/iogen.c
> @@ -128,7 +128,7 @@ void	startup_info(FILE *stream, int seed);
>   */
>  
>  struct strmap	Aio_Strat_Map[] = {
> -#ifndef linux
> +#ifndef __linux__
>  	{ "poll",	A_POLL		},
>  	{ "signal",	A_SIGNAL	},
>  #else
> @@ -1610,7 +1610,7 @@ FILE	*stream;
>  {
>      usage(stream);
>      fprintf(stream, "\n");
> -#ifndef linux
> +#ifndef __linux__
>      fprintf(stream, "\t-a aio_type,...  Async io completion types to choose.  Supported types\n");
>      fprintf(stream, "\t                 are:  poll, signal, suspend, and callback.\n");
>      fprintf(stream, "\t                 Default is all of the above.\n");
> @@ -1643,7 +1643,7 @@ FILE	*stream;
>      fprintf(stream, "\t-q               Quiet mode.  Normally iogen spits out info\n");
>      fprintf(stream, "\t                 about test files, options, etc. before starting.\n");
>      fprintf(stream, "\t-s syscall,...   Syscalls to do.  Supported syscalls are\n");
> -#ifdef linux
> +#ifdef __linux__
>      fprintf(stream, "\t                 read, write, pread, pwrite, readv, writev,\n");
>      fprintf(stream, "\t                 mmread, mmwrite, fsync2, fdatasync,\n");
>      fprintf(stream, "\t                 Default is 'read,write,readv,writev,mmread,mmwrite'.\n");
> -- 
> 2.48.0
> 
> 
> 
