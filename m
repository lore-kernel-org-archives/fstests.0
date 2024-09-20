Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25379C0
	for <fstests@vger.kernel.org>; Fri, 20 Sep 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844329; cv=none; b=gMK50YUKd9x32O171AbxsUCp8If7I90K/joPkQfzcXgV3yJOraXoYVtYWBdCscBp++3Z27NOObUev4IdHV35I9GxOwxiuPxypLf8YHRWkg9848Oq9j3Cxgp+Dim0NI4TAgD+YrhwSR6AXCotEWgKbnPCtlViGRQxUL6Tv2syEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844329; c=relaxed/simple;
	bh=z22SccxQo6c+sJ5cRZzcznInukioCzVtsGrt4+7NOpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGWFijbCfnv10FJ4g8qHfG2Jy8a5k9weVKhvyIBYqGCGVvkNqtxhv4VOjq9NTW8Yj6okS4TXQv6nl2Fnd7Q6BOkX5bswVV6NsJn3JrRbgurQbgsAXoCRWwUFTbduG4d0dx7Mjubt29Ew0M4Cext9yThi48e6UDLn74L/xuDcLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6RS2HJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6RS2HJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726844326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhKQhtBNDHC0jMrtHE94L1tVmdD3hqf8qm4R9eV9Oag=;
	b=h6RS2HJ871sTPdS1Ce95QwzD1y7iewlIki+qjFwtF1+xV3UDTu0iGonAEQ/8cpmoLBQ0zK
	lGovSU788n0v1zBeKITV33ZataspNcycU+4OvKfUDuh2zfZQp0B3LAuAys61RUbW6EAamn
	ZaMAxWOfJLuqCCLfsDD6RmnCsxnHh9I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-tfWGA4iKO9-87WzmwnBQUA-1; Fri, 20 Sep 2024 10:58:45 -0400
X-MC-Unique: tfWGA4iKO9-87WzmwnBQUA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2052a68430fso27732705ad.2
        for <fstests@vger.kernel.org>; Fri, 20 Sep 2024 07:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726844324; x=1727449124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhKQhtBNDHC0jMrtHE94L1tVmdD3hqf8qm4R9eV9Oag=;
        b=kRbfAoARvBwddrPW4oABlUrJepfeHZl9CQsa4/EBWL139Ypls3lOovb+/xcmfvVGaS
         oBBMWX4HLauUe7XkfML/nrkTsNcb+TVNRGcUUN/n0Szh2r1JQ+CCb1DmXi0cpd6AJ3ED
         3Lj//OOuu61Oi7FQ4iCOMDdbRV4Cn/Vw5BSDc2Lj407BwqUVRUVTtnz1PU+ybwVVDuZG
         ji1aGBuQNE0DbyAZqvhmp6aUBem18mtxxASGTtYCfkWSNGc8wJVfxJR7Q1RRYnUTmYUY
         9NU9WKShQU+qRJtSIav/6TCPrOAM6pTVGMYgmV88+qKCU2axjJ69X6OqJ0xch62GBUpW
         N47w==
X-Gm-Message-State: AOJu0YwK4e7Ac6CtveM1j6PSWDmCAAyMJKYzYmBy6uJaBClDJ3E5p5/Q
	uEDxjhyUz0b9lRRGwdFvk0F0U3kN10aaRtwq6ezl+hwJfSjWo/CcXGhCjHH9wxGSKM9mNazdsLI
	xaG/zhpInsK2E1FKM9kINpu/rXMiyvuae5pZxr8LgKrjcUXECBSyBy0vjdiSMHpKoGw==
X-Received: by 2002:a17:902:d2c1:b0:1fc:4940:d3ad with SMTP id d9443c01a7336-208d856abcfmr38706565ad.59.1726844323664;
        Fri, 20 Sep 2024 07:58:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEewzcre0ZxqYNgbUjVDdzpQBi6Q38ykHRRiZgoYpZSnnCQJldf8AAa4pElzOapY7g2EABRzA==
X-Received: by 2002:a17:902:d2c1:b0:1fc:4940:d3ad with SMTP id d9443c01a7336-208d856abcfmr38706245ad.59.1726844323156;
        Fri, 20 Sep 2024 07:58:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946017b6sm95932135ad.101.2024.09.20.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:58:42 -0700 (PDT)
Date: Fri, 20 Sep 2024 22:58:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH RFC] fsx: support unshare range fallocate mode
Message-ID: <20240920145839.vphm5uoiptfgnad5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240906185606.136402-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906185606.136402-1-bfoster@redhat.com>

On Fri, Sep 06, 2024 at 02:56:06PM -0400, Brian Foster wrote:
> The fallocate unshare mode flag modifies traditional preallocate
> mode to unshare any shared extents backing the target range. Without
> the unshare flag, preallocate mode simply assures that blocks are
> physically allocated, regardless of whether they might be shared.
> Unshare mode behaves the same as preallocate mode outside of the
> shared extent case.
> 
> Since unshare is fundamentally a modifier to preallocate mode,
> enable it via an operation flag. Similar to keep size mode, select
> it randomly for fallocate operations and track it via a flag and
> string combination for operation logging and replay.
> 
> Unshare is mainly used for filesystems that support reflink, but the
> operation is equivalent to preallocate mode for non-shared ranges,
> so enable it by default. Filesystems that do not support the
> fallocate flag (such as those that might not support reflink) will
> fail the test operation and disable unshare calls at runtime. Also
> provide a new command line option to explicitly disable unshare
> calls.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> Hi all,
> 
> A couple quick notes..
> 
> First, this applies on top of the currently pending EOF pollution
> patches [1] to fsx.

The patchset [1] has been merged, thanks for doing that.

> 
> Second, this triggers multiple new test failures in my initial tests
> that I've not fully diagnosed. I'm not necessarily sure that we want to
> hold off on added test coverage for that reason, but I'd like to at
> least be sure this isn't due to this patch doing something blatantly
> wrong.
> 
> That said, this has also uncovered one or two unshare related issues, so
> I'm posting this slightly prematurely in order to share it and hopefully
> get some review..
> 
> Brian
> 
> [1] https://lore.kernel.org/fstests/20240828181534.41054-1-bfoster@redhat.com/
> 
>  ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 14 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 1ba1bf65..003990db 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -45,9 +45,14 @@
>  
>  #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
>  
> -/* Operation flags */
> -
> -enum opflags { FL_NONE = 0, FL_SKIPPED = 1, FL_CLOSE_OPEN = 2, FL_KEEP_SIZE = 4 };
> +/* Operation flags (bitmask) */
> +enum opflags {
> +	FL_NONE = 0,
> +	FL_SKIPPED = 1,
> +	FL_CLOSE_OPEN = 2,
> +	FL_KEEP_SIZE = 4,
> +	FL_UNSHARE = 8
> +};
>  
>  /*
>   *	A log entry is an operation and a bunch of arguments.
> @@ -167,6 +172,7 @@ int	seed = 1;			/* -S flag */
>  int     mapped_writes = 1;              /* -W flag disables */
>  int     fallocate_calls = 1;            /* -F flag disables */
>  int     keep_size_calls = 1;            /* -K flag disables */
> +int	unshare_calls = 1;		/* -u flag disables */
>  int     punch_hole_calls = 1;           /* -H flag disables */
>  int     zero_range_calls = 1;           /* -z flag disables */
>  int	collapse_range_calls = 1;	/* -C flag disables */
> @@ -543,6 +549,8 @@ logdump(void)
>  				fprintf(logopsf, " keep_size");
>  			if (lp->flags & FL_CLOSE_OPEN)
>  				fprintf(logopsf, " close_open");
> +			if (lp->flags & FL_UNSHARE)
> +				fprintf(logopsf, " unshare");
>  			if (overlap)
>  				fprintf(logopsf, " *");
>  			fprintf(logopsf, "\n");
> @@ -1879,15 +1887,25 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
>  #ifdef HAVE_LINUX_FALLOC_H
>  /* fallocate is basically a no-op unless extending, then a lot like a truncate */
>  void
> -do_preallocate(unsigned offset, unsigned length, int keep_size)
> +do_preallocate(unsigned offset, unsigned length, int keep_size, int unshare)
>  {
>  	unsigned end_offset;
> +	enum opflags opflags = FL_NONE;
> +	int mode = 0;
> +
> +	if (keep_size) {
> +		opflags |= FL_KEEP_SIZE;
> +		mode |= FALLOC_FL_KEEP_SIZE;
> +	}
> +	if (unshare) {
> +		opflags |= FL_UNSHARE;
> +		mode |= FALLOC_FL_UNSHARE_RANGE;

The FALLOC_FL_UNSHARE_RANGE is not a new flag, but it might be not old enough.
The first commit about the FALLOC_FL_UNSHARE_RANGE is:

  commit 409332b65d3ed8cfa7a8030f1e9d52f372219642
  Author: Lukas Czerner <lczerner@redhat.com>
  Date:   Thu Mar 13 19:07:42 2014 +1100

      fs: Introduce FALLOC_FL_ZERO_RANGE flag for fallocate

So "#ifdef FALLOC_FL_UNSHARE_RANGE" maybe needed.

Thanks,
Zorro


> +	}
>  
>          if (length == 0) {
>                  if (!quiet && testcalls > simulatedopcount)
>                          prt("skipping zero length fallocate\n");
> -                log4(OP_FALLOCATE, offset, length, FL_SKIPPED |
> -		     (keep_size ? FL_KEEP_SIZE : FL_NONE));
> +                log4(OP_FALLOCATE, offset, length, FL_SKIPPED | opflags);
>                  return;
>          }
>  
> @@ -1905,8 +1923,7 @@ do_preallocate(unsigned offset, unsigned length, int keep_size)
>  	 * 	1: extending prealloc
>  	 * 	2: interior prealloc
>  	 */
> -	log4(OP_FALLOCATE, offset, length,
> -	     keep_size ? FL_KEEP_SIZE : FL_NONE);
> +	log4(OP_FALLOCATE, offset, length, opflags);
>  
>  	if (end_offset > file_size) {
>  		memset(good_buf + file_size, '\0', end_offset - file_size);
> @@ -1921,7 +1938,7 @@ do_preallocate(unsigned offset, unsigned length, int keep_size)
>  		      end_offset <= monitorend)))
>  		prt("%lld falloc\tfrom 0x%x to 0x%x (0x%x bytes)\n", testcalls,
>  				offset, offset + length, length);
> -	if (fallocate(fd, keep_size ? FALLOC_FL_KEEP_SIZE : 0, (loff_t)offset, (loff_t)length) == -1) {
> +	if (fallocate(fd, mode, (loff_t)offset, (loff_t)length) == -1) {
>  	        prt("fallocate: 0x%x to 0x%x\n", offset, offset + length);
>  		prterr("do_preallocate: fallocate");
>  		report_failure(161);
> @@ -1929,7 +1946,7 @@ do_preallocate(unsigned offset, unsigned length, int keep_size)
>  }
>  #else
>  void
> -do_preallocate(unsigned offset, unsigned length, int keep_size)
> +do_preallocate(unsigned offset, unsigned length, int keep_size, int unshare)
>  {
>  	return;
>  }
> @@ -2095,6 +2112,8 @@ read_op(struct log_entry *log_entry)
>  				log_entry->flags |= FL_KEEP_SIZE;
>  			else if (strcmp(str, "close_open") == 0)
>  				log_entry->flags |= FL_CLOSE_OPEN;
> +			else if (strcmp(str, "unshare") == 0)
> +				log_entry->flags |= FL_UNSHARE;
>  			else if (strcmp(str, "*") == 0)
>  				;  /* overlap marker; ignore */
>  			else
> @@ -2161,6 +2180,7 @@ test(void)
>  	unsigned long	rv;
>  	unsigned long	op;
>  	int		keep_size = 0;
> +	int		unshare = 0;
>  
>  	if (simulatedopcount > 0 && testcalls == simulatedopcount)
>  		writefileimage();
> @@ -2190,6 +2210,7 @@ test(void)
>  			offset2 = log_entry.args[2];
>  			closeopen = !!(log_entry.flags & FL_CLOSE_OPEN);
>  			keep_size = !!(log_entry.flags & FL_KEEP_SIZE);
> +			unshare = !!(log_entry.flags & FL_UNSHARE);
>  			goto have_op;
>  		}
>  		return 0;
> @@ -2219,8 +2240,12 @@ test(void)
>  			size = random() % maxfilelen;
>  		break;
>  	case OP_FALLOCATE:
> -		if (fallocate_calls && size && keep_size_calls)
> -			keep_size = random() % 2;
> +		if (fallocate_calls && size) {
> +			if (keep_size_calls)
> +				keep_size = random() % 2;
> +			if (unshare_calls)
> +				unshare = random() % 2;
> +		}
>  		break;
>  	case OP_ZERO_RANGE:
>  		if (zero_range_calls && size && keep_size_calls)
> @@ -2334,7 +2359,7 @@ have_op:
>  
>  	case OP_FALLOCATE:
>  		TRIM_OFF_LEN(offset, size, maxfilelen);
> -		do_preallocate(offset, size, keep_size);
> +		do_preallocate(offset, size, keep_size, unshare);
>  		break;
>  
>  	case OP_PUNCH_HOLE:
> @@ -2469,6 +2494,7 @@ usage(void)
>  	-r readbdy: 4096 would make reads page aligned (default 1)\n\
>  	-s style: 1 gives smaller truncates (default 0)\n\
>  	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
> +	-u Do not use unshare range\n\
>  	-w writebdy: 4096 would make writes page aligned (default 1)\n\
>  	-x: preallocate file space before starting, XFS only\n\
>  	-y: synchronize changes to a file\n"
> @@ -2853,7 +2879,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:w:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'b':
> @@ -2952,6 +2978,9 @@ main(int argc, char **argv)
>  			if (truncbdy <= 0)
>  				usage();
>  			break;
> +		case 'u':
> +			unshare_calls = 0;
> +			break;
>  		case 'w':
>  			writebdy = getnum(optarg, &endp);
>  			if (writebdy <= 0)
> @@ -3242,6 +3271,8 @@ main(int argc, char **argv)
>  		fallocate_calls = test_fallocate(0);
>  	if (keep_size_calls)
>  		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> +	if (unshare_calls)
> +		unshare_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
>  	if (punch_hole_calls)
>  		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
>  	if (zero_range_calls)
> -- 
> 2.45.0
> 
> 

