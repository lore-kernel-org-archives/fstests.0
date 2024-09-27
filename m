Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514254279
	for <fstests@vger.kernel.org>; Fri, 27 Sep 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727408438; cv=none; b=hwhJ4vWMHXH3da3+UaSgiKWuIz+zVMSelhfRPoIP0tMfm53YoqKwZP3ymnoCAbiV2dI6xskYb0tNQ9l7tiMATN5p2rwn3+WWCTUCDlPJvWpFsDSd3ltEgCjiiMoJfY34q3Oiy/vfvBtuqyGpO18YGAtEleL3gWtf+gr7BMMlIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727408438; c=relaxed/simple;
	bh=62q4do6nacvT3GFEYyiNuN9VGutlb/JrITMgRB6lNHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsik2mmjfDkCREn86iS6pRPuj6HRFF6nYsEv91gsCb6nUbm12v2fuKDT+lDLYGkx+BGNSrHRLqVsX03rhwtGXVbwvfCGXIog6y3kBS9w5TjYHcrVmZM9wNJflW0iogqTxoKLSA4Af8yknR0VXsOQVY7IJJtXXJnZg1nJwYfK++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU4F9U43; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU4F9U43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727408434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Y4sZUUfXkNi6EuRu5ljWDD6YWiPNRQq5tHcjx/gDbA=;
	b=aU4F9U43B8PKFXFEQjLPSn+DhgQ4dO5A1BbOpCbAHU6Yv87L5EyPTCCG3qFzryvMHkPtYf
	INWMOnTEKYAho7DCKpq9gOtUEKWxkCgNEOYXVqo0h1Nlozl8yjnELNKdEbCPfJMuq3ZlOo
	B6Tg53riSs76LpxIRXc3MdtrSfucuko=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-aKuz2PCpP3SinXguqSlpxg-1; Thu, 26 Sep 2024 23:40:33 -0400
X-MC-Unique: aKuz2PCpP3SinXguqSlpxg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-718e34530dfso2533484b3a.3
        for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 20:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727408432; x=1728013232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y4sZUUfXkNi6EuRu5ljWDD6YWiPNRQq5tHcjx/gDbA=;
        b=WTlLvPUMYgg8oAmzvv4kt8YqZU74UxpIYcUcwMBoYVF+Z7DzfpRCd3o0KQx3gW5B6F
         RHxMJOOsKgcbz+JQiKclpMt3fHXeXSwBUsS8th4qS7IcAbBz51EOYOY58D2nXmgEM5xD
         84fLMXw6WN5HjPdizGHgBxtuSnZFIGGaS3nHLiQoDkRWTruJ0q6awhF5jUYjmgdxAhLV
         CiJ0vFcIu7+iEmkmpbuyjzR/pmuXtmrmtGEHCDAtMq/jet+INRcs6RFjba1BBMuWL3Hc
         dsU2zbTDgYh/7DUEWLIaiPBzorBvrWzCQhzB9mO1CmOMFaBdyoIADPLz7L1DQbzMZPnz
         Qcvw==
X-Forwarded-Encrypted: i=1; AJvYcCXKool2bdwzxkshUFZUXo1XwhBDT4PKw08JOOlII5DoxZ5M9AQR3NteUaRKlQ9pjuszKBoUMqF6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4d4BGfFGZjAWEbhI+53d2LtNwNaypbGV0H4+YKqtOeQuMcg2
	0Zq7XjP4w0QTWU3hJk9PhUDzxIXGW2M9HDo4PTcovcTmdeF8ywoIGpJZdzHU1PJyigKfLYNKmm7
	r+2eVIi7eORnrVZ4maUIEOAPk+O+MvJ89PTiQVMWsl0V5PPDzycz0+O4=
X-Received: by 2002:a05:6a00:2d29:b0:714:1f6d:11e5 with SMTP id d2e1a72fcca58-71b25f6efb0mr3163513b3a.12.1727408432089;
        Thu, 26 Sep 2024 20:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTPw9VuM6nMLWMglr2eyn5qpzVGDeMWi+iUTlMDYxChiYMaSN14wr8+vuJbYev4haX6lk2OQ==
X-Received: by 2002:a05:6a00:2d29:b0:714:1f6d:11e5 with SMTP id d2e1a72fcca58-71b25f6efb0mr3163210b3a.12.1727408428233;
        Thu, 26 Sep 2024 20:40:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26538a3esm628785b3a.208.2024.09.26.20.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 20:40:25 -0700 (PDT)
Date: Fri, 27 Sep 2024 11:40:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] fsx: support unshare range fallocate mode
Message-ID: <20240927034022.2jv46dpfdtatzv47@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240926144147.106685-1-bfoster@redhat.com>
 <20240926144147.106685-2-bfoster@redhat.com>
 <20240926144802.GB21840@frogsfrogsfrogs>
 <ZvWDYneNjRx7qUki@bfoster>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvWDYneNjRx7qUki@bfoster>

On Thu, Sep 26, 2024 at 11:53:06AM -0400, Brian Foster wrote:
> On Thu, Sep 26, 2024 at 07:48:02AM -0700, Darrick J. Wong wrote:
> > On Thu, Sep 26, 2024 at 10:41:46AM -0400, Brian Foster wrote:
> > > The fallocate unshare mode flag modifies traditional preallocate
> > > mode to unshare any shared extents backing the target range. Without
> > > the unshare flag, preallocate mode simply assures that blocks are
> > > physically allocated, regardless of whether they might be shared.
> > > Unshare mode behaves the same as preallocate mode outside of the
> > > shared extent case.
> > > 
> > > Since unshare is fundamentally a modifier to preallocate mode,
> > > enable it via an operation flag. Similar to keep size mode, select
> > > it randomly for fallocate operations and track it via a flag and
> > > string combination for operation logging and replay.
> > > 
> > > Unshare is mainly used for filesystems that support reflink, but the
> > > operation is equivalent to preallocate mode for non-shared ranges,
> > > so enable it by default. Filesystems that do not support the
> > > fallocate flag (such as those that might not support reflink) will
> > > fail the test operation and disable unshare calls at runtime. Also
> > > provide a new command line option to explicitly disable unshare
> > > calls.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  ltp/fsx.c | 67 ++++++++++++++++++++++++++++++++++++++++++-------------
> > >  1 file changed, 51 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 1ba1bf65..677f8c9f 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -45,9 +45,14 @@
> > >  
> > >  #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
> > >  
> > > -/* Operation flags */
> > > -
> > > -enum opflags { FL_NONE = 0, FL_SKIPPED = 1, FL_CLOSE_OPEN = 2, FL_KEEP_SIZE = 4 };
> > > +/* Operation flags (bitmask) */
> > > +enum opflags {
> > > +	FL_NONE = 0,
> > > +	FL_SKIPPED = 1,
> > > +	FL_CLOSE_OPEN = 2,
> > > +	FL_KEEP_SIZE = 4,
> > > +	FL_UNSHARE = 8
> > > +};
> > >  
> > >  /*
> > >   *	A log entry is an operation and a bunch of arguments.
> > > @@ -167,6 +172,7 @@ int	seed = 1;			/* -S flag */
> > >  int     mapped_writes = 1;              /* -W flag disables */
> > >  int     fallocate_calls = 1;            /* -F flag disables */
> > >  int     keep_size_calls = 1;            /* -K flag disables */
> > > +int	unshare_range_calls = 1;	/* -u flag disables */
> > 
> > Broken indentation (you used tab, existing code uses space).
> > 
> 
> Will fix if I end up with reason to send a v2, otherwise I'll assume
> Zorro can make that tweak. Thanks.

I'll do that :)

Thanks,
Zorro

> 
> Brian
> 
> > With that fixed, this look ok to me
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > --D
> > 
> > >  int     punch_hole_calls = 1;           /* -H flag disables */
> > >  int     zero_range_calls = 1;           /* -z flag disables */
> > >  int	collapse_range_calls = 1;	/* -C flag disables */
> > > @@ -543,6 +549,8 @@ logdump(void)
> > >  				fprintf(logopsf, " keep_size");
> > >  			if (lp->flags & FL_CLOSE_OPEN)
> > >  				fprintf(logopsf, " close_open");
> > > +			if (lp->flags & FL_UNSHARE)
> > > +				fprintf(logopsf, " unshare");
> > >  			if (overlap)
> > >  				fprintf(logopsf, " *");
> > >  			fprintf(logopsf, "\n");
> > > @@ -1879,15 +1887,27 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
> > >  #ifdef HAVE_LINUX_FALLOC_H
> > >  /* fallocate is basically a no-op unless extending, then a lot like a truncate */
> > >  void
> > > -do_preallocate(unsigned offset, unsigned length, int keep_size)
> > > +do_preallocate(unsigned offset, unsigned length, int keep_size, int unshare)
> > >  {
> > >  	unsigned end_offset;
> > > +	enum opflags opflags = FL_NONE;
> > > +	int mode = 0;
> > > +
> > > +	if (keep_size) {
> > > +		opflags |= FL_KEEP_SIZE;
> > > +		mode |= FALLOC_FL_KEEP_SIZE;
> > > +	}
> > > +#ifdef FALLOC_FL_UNSHARE_RANGE
> > > +	if (unshare) {
> > > +		opflags |= FL_UNSHARE;
> > > +		mode |= FALLOC_FL_UNSHARE_RANGE;
> > > +	}
> > > +#endif
> > >  
> > >          if (length == 0) {
> > >                  if (!quiet && testcalls > simulatedopcount)
> > >                          prt("skipping zero length fallocate\n");
> > > -                log4(OP_FALLOCATE, offset, length, FL_SKIPPED |
> > > -		     (keep_size ? FL_KEEP_SIZE : FL_NONE));
> > > +                log4(OP_FALLOCATE, offset, length, FL_SKIPPED | opflags);
> > >                  return;
> > >          }
> > >  
> > > @@ -1905,8 +1925,7 @@ do_preallocate(unsigned offset, unsigned length, int keep_size)
> > >  	 * 	1: extending prealloc
> > >  	 * 	2: interior prealloc
> > >  	 */
> > > -	log4(OP_FALLOCATE, offset, length,
> > > -	     keep_size ? FL_KEEP_SIZE : FL_NONE);
> > > +	log4(OP_FALLOCATE, offset, length, opflags);
> > >  
> > >  	if (end_offset > file_size) {
> > >  		memset(good_buf + file_size, '\0', end_offset - file_size);
> > > @@ -1921,7 +1940,7 @@ do_preallocate(unsigned offset, unsigned length, int keep_size)
> > >  		      end_offset <= monitorend)))
> > >  		prt("%lld falloc\tfrom 0x%x to 0x%x (0x%x bytes)\n", testcalls,
> > >  				offset, offset + length, length);
> > > -	if (fallocate(fd, keep_size ? FALLOC_FL_KEEP_SIZE : 0, (loff_t)offset, (loff_t)length) == -1) {
> > > +	if (fallocate(fd, mode, (loff_t)offset, (loff_t)length) == -1) {
> > >  	        prt("fallocate: 0x%x to 0x%x\n", offset, offset + length);
> > >  		prterr("do_preallocate: fallocate");
> > >  		report_failure(161);
> > > @@ -1929,7 +1948,7 @@ do_preallocate(unsigned offset, unsigned length, int keep_size)
> > >  }
> > >  #else
> > >  void
> > > -do_preallocate(unsigned offset, unsigned length, int keep_size)
> > > +do_preallocate(unsigned offset, unsigned length, int keep_size, int unshare)
> > >  {
> > >  	return;
> > >  }
> > > @@ -2095,6 +2114,8 @@ read_op(struct log_entry *log_entry)
> > >  				log_entry->flags |= FL_KEEP_SIZE;
> > >  			else if (strcmp(str, "close_open") == 0)
> > >  				log_entry->flags |= FL_CLOSE_OPEN;
> > > +			else if (strcmp(str, "unshare") == 0)
> > > +				log_entry->flags |= FL_UNSHARE;
> > >  			else if (strcmp(str, "*") == 0)
> > >  				;  /* overlap marker; ignore */
> > >  			else
> > > @@ -2161,6 +2182,7 @@ test(void)
> > >  	unsigned long	rv;
> > >  	unsigned long	op;
> > >  	int		keep_size = 0;
> > > +	int		unshare = 0;
> > >  
> > >  	if (simulatedopcount > 0 && testcalls == simulatedopcount)
> > >  		writefileimage();
> > > @@ -2190,6 +2212,7 @@ test(void)
> > >  			offset2 = log_entry.args[2];
> > >  			closeopen = !!(log_entry.flags & FL_CLOSE_OPEN);
> > >  			keep_size = !!(log_entry.flags & FL_KEEP_SIZE);
> > > +			unshare = !!(log_entry.flags & FL_UNSHARE);
> > >  			goto have_op;
> > >  		}
> > >  		return 0;
> > > @@ -2219,8 +2242,12 @@ test(void)
> > >  			size = random() % maxfilelen;
> > >  		break;
> > >  	case OP_FALLOCATE:
> > > -		if (fallocate_calls && size && keep_size_calls)
> > > -			keep_size = random() % 2;
> > > +		if (fallocate_calls && size) {
> > > +			if (keep_size_calls)
> > > +				keep_size = random() % 2;
> > > +			if (unshare_range_calls)
> > > +				unshare = random() % 2;
> > > +		}
> > >  		break;
> > >  	case OP_ZERO_RANGE:
> > >  		if (zero_range_calls && size && keep_size_calls)
> > > @@ -2334,7 +2361,7 @@ have_op:
> > >  
> > >  	case OP_FALLOCATE:
> > >  		TRIM_OFF_LEN(offset, size, maxfilelen);
> > > -		do_preallocate(offset, size, keep_size);
> > > +		do_preallocate(offset, size, keep_size, unshare);
> > >  		break;
> > >  
> > >  	case OP_PUNCH_HOLE:
> > > @@ -2468,8 +2495,11 @@ usage(void)
> > >  	-q: quieter operation\n\
> > >  	-r readbdy: 4096 would make reads page aligned (default 1)\n\
> > >  	-s style: 1 gives smaller truncates (default 0)\n\
> > > -	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
> > > -	-w writebdy: 4096 would make writes page aligned (default 1)\n\
> > > +	-t truncbdy: 4096 would make truncates page aligned (default 1)\n"
> > > +#ifdef FALLOC_FL_UNSHARE_RANGE
> > > +"	-u Do not use unshare range\n"
> > > +#endif
> > > +"	-w writebdy: 4096 would make writes page aligned (default 1)\n\
> > >  	-x: preallocate file space before starting, XFS only\n\
> > >  	-y: synchronize changes to a file\n"
> > >  
> > > @@ -2853,7 +2883,7 @@ main(int argc, char **argv)
> > >  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> > >  
> > >  	while ((ch = getopt_long(argc, argv,
> > > -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:w:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > +				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > >  				 longopts, NULL)) != EOF)
> > >  		switch (ch) {
> > >  		case 'b':
> > > @@ -2952,6 +2982,9 @@ main(int argc, char **argv)
> > >  			if (truncbdy <= 0)
> > >  				usage();
> > >  			break;
> > > +		case 'u':
> > > +			unshare_range_calls = 0;
> > > +			break;
> > >  		case 'w':
> > >  			writebdy = getnum(optarg, &endp);
> > >  			if (writebdy <= 0)
> > > @@ -3242,6 +3275,8 @@ main(int argc, char **argv)
> > >  		fallocate_calls = test_fallocate(0);
> > >  	if (keep_size_calls)
> > >  		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > +	if (unshare_range_calls)
> > > +		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > >  	if (punch_hole_calls)
> > >  		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > >  	if (zero_range_calls)
> > > -- 
> > > 2.46.1
> > > 
> > > 
> > 
> 
> 

