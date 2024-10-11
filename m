Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1B1F9A80
	for <fstests@vger.kernel.org>; Fri, 11 Oct 2024 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624104; cv=none; b=AQjioIRtvBDAVeuzdR3h83JPFS7E7TMvdPflOGjWFbnNDQ/qp4tZ1JmpiZSR5aLyYdoQE8nytJ295QSFkdo3x+CXsXdYIBOW4oF4v1tSkG5fkVYQldQxhqbjXA+mzehyoF4aEvg7O+jkMU3ykzGwepZ9Rd8JxOcP6lEc+ZDvjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624104; c=relaxed/simple;
	bh=QubF/GxoUn5Lnz6rl0PvIZ/WEmtyu8af19PSMrYCBqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr2h3cq1XOp3pwq3xhXJa86LipB910rLvQDTwBldWDDAM0wU5SFzp5GugdMwoCXVK4ZlDZPZY/LmOLSbjGZAUILuUfJRD8771E65Oo/5up6UrLta5rd+3UNitAEw7qUuorYC2tKgZvJgr+JS96miF8uFAuUaI/PYDcTuJBNjCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1MzleT8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1MzleT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728624101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbJa8qmVe75ls+K1cN1QH+9P61lRoEAFlStTGh/iiOw=;
	b=E1MzleT8e430LTGOF7l5pgWV+K+ReGSQyuoSpjgUmEhWmFLw2bstPGl8a3dyJDxdWrkqgf
	sJrVzkaSKxKUPdvcwIw5voyNFKf/iAYMjAOUr1MGGRk6mF/b/3fDepgiyDauuoWdVOAboQ
	Kua961mCLICk+wuKRwPpKWLGmjYkVN8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-8ZkOCa5sO7ixFCqbz-_2CQ-1; Fri, 11 Oct 2024 01:21:39 -0400
X-MC-Unique: 8ZkOCa5sO7ixFCqbz-_2CQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20c92707255so11568225ad.1
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 22:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728624098; x=1729228898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbJa8qmVe75ls+K1cN1QH+9P61lRoEAFlStTGh/iiOw=;
        b=FUwK/QiTgCaRmvbVJUzZK0Vw0/+XDZWrOmIMXZ4U56S4vQkauHSp6hdA4va3H6spkh
         IymhqO3qV9FAIERsu7wrJBN73tpAPEqVejmRCgkih+oA8sNQHd5Q+Gxjc3nNFK4CJH7P
         2JufUDFw9VVNLer5yM6b2m9HI1ybumEmCfO0oxjz7FftEBdXmIb5ZUwuDPElHlvXneAJ
         mHYedkiac1gHSqQXRpiNMwVn0itVXLhFJFn1RamUhPdFMo0btaduaF75d9a+GcsSIuwi
         5H/XV54h/TtlyS3JJYUr4ZXABRZ3z+eYXRiMcnUHngkETKwj/0p4wX50APS27EzxXwO2
         8/gQ==
X-Gm-Message-State: AOJu0Yxdw0NpJtWHxzhl4i1JU82dhXFZOxpXh4nn3fkJy7WtIzk0b1gz
	0aUgwWVfbDowazoN6WfEPa++kuEBO7BYkRDkwQx9V11gsePE4gnlATTfw22I0S0nS1OwmprpXV8
	QvAjs8g7EO6utcUCmff+gHTlOcvvhvFHFiloh2ajeoEeq7ncvxe0iXL2631hK9MGmWA==
X-Received: by 2002:a17:903:1c4:b0:20b:61ec:7d3c with SMTP id d9443c01a7336-20ca16d3b55mr25972465ad.49.1728624098051;
        Thu, 10 Oct 2024 22:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHff59HW09IUAisAu1bnsYlYsUWX9Vj3gjkiYDmyxygm148xWjL2IoUqZWEVnp8Nnz353yZaw==
X-Received: by 2002:a17:903:1c4:b0:20b:61ec:7d3c with SMTP id d9443c01a7336-20ca16d3b55mr25972195ad.49.1728624097693;
        Thu, 10 Oct 2024 22:21:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c34666bsm17244495ad.279.2024.10.10.22.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:21:37 -0700 (PDT)
Date: Fri, 11 Oct 2024 13:21:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] fsstress: add support for FALLOC_FL_UNSHARE_RANGE
Message-ID: <20241011052133.vrq3nzic5fpjkzvr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <172780126017.3586479.18209378224774919872.stgit@frogsfrogsfrogs>
 <20241003213714.GH21840@frogsfrogsfrogs>
 <20241011051356.mjaoarskwedmjs75@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011051356.mjaoarskwedmjs75@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Oct 11, 2024 at 01:13:56PM +0800, Zorro Lang wrote:
> On Thu, Oct 03, 2024 at 02:37:14PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Teach fsstress to try to unshare file blocks on filesystems, seeing how
> > the recent addition to fsx has uncovered a lot of bugs.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> 
> Thanks for this new test coverage on fsstress. Although it's conflict with
> current for-next branch, I've merged it manually, don't need one more
> version :)
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

And...

I'm not sure why this patch is contained in this patchset:
[PATCHSET v31.1 2/2] fstests: atomic file content commits

As that patchset still need change, I'll merge this patch singly this week.

Thanks,
Zorro

> 
> >  ltp/fsstress.c |   14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index b8d025d3a0..8cd45c7a85 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -139,6 +139,7 @@ typedef enum {
> >  	OP_TRUNCATE,
> >  	OP_UNLINK,
> >  	OP_UNRESVSP,
> > +	OP_UNSHARE,
> >  	OP_URING_READ,
> >  	OP_URING_WRITE,
> >  	OP_WRITE,
> > @@ -246,6 +247,7 @@ void	punch_f(opnum_t, long);
> >  void	zero_f(opnum_t, long);
> >  void	collapse_f(opnum_t, long);
> >  void	insert_f(opnum_t, long);
> > +void	unshare_f(opnum_t, long);
> >  void	read_f(opnum_t, long);
> >  void	readlink_f(opnum_t, long);
> >  void	readv_f(opnum_t, long);
> > @@ -339,6 +341,7 @@ struct opdesc	ops[OP_LAST]	= {
> >  	[OP_TRUNCATE]	   = {"truncate",      truncate_f,	2, 1 },
> >  	[OP_UNLINK]	   = {"unlink",	       unlink_f,	1, 1 },
> >  	[OP_UNRESVSP]	   = {"unresvsp",      unresvsp_f,	1, 1 },
> > +	[OP_UNSHARE]	   = {"unshare",       unshare_f,	1, 1 },
> >  	[OP_URING_READ]	   = {"uring_read",    uring_read_f,	-1, 0 },
> >  	[OP_URING_WRITE]   = {"uring_write",   uring_write_f,	-1, 1 },
> >  	[OP_WRITE]	   = {"write",	       write_f,		4, 1 },
> > @@ -3767,6 +3770,7 @@ struct print_flags falloc_flags [] = {
> >  	{ FALLOC_FL_COLLAPSE_RANGE, "COLLAPSE_RANGE"},
> >  	{ FALLOC_FL_ZERO_RANGE, "ZERO_RANGE"},
> >  	{ FALLOC_FL_INSERT_RANGE, "INSERT_RANGE"},
> > +	{ FALLOC_FL_UNSHARE_RANGE, "UNSHARE_RANGE"},
> >  	{ -1, NULL}
> >  };
> >  
> > @@ -4469,6 +4473,16 @@ insert_f(opnum_t opno, long r)
> >  #endif
> >  }
> >  
> > +void
> > +unshare_f(opnum_t opno, long r)
> > +{
> > +#ifdef HAVE_LINUX_FALLOC_H
> > +# ifdef FALLOC_FL_UNSHARE_RANGE
> > +	do_fallocate(opno, r, FALLOC_FL_UNSHARE_RANGE);
> > +# endif
> > +#endif
> > +}
> > +
> >  void
> >  read_f(opnum_t opno, long r)
> >  {
> > 

