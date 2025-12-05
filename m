Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D835E52F
	for <fstests@vger.kernel.org>; Fri,  5 Dec 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919914; cv=none; b=ldBU+V8ZYv2r4tWqgMEYcnBZbUGMT6MUz+oHPhnyo+zlCtfQZrzkdAB79bti02HLU9adl81IGh8LHjR4MRF4FMaPQorPYPVCqMBBsFDkVhKNGSyuAxXDfX3htMJVanbN/iOkHuJ30Bo4T2B7zmvKvjtg/niMLjEZV6GBgskM7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919914; c=relaxed/simple;
	bh=cPVh4uGXO3JKn4X7MqDs89jrIQ8PgZgeS5FBaBbBu/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izH+dL/kSTmQGYJbLZ1YB1ndvKsLG+2bImM2G6eGKl7wss6hBWOQdmu++KZgnY4LiKSw9hWxquNT6DkMGjyUefbs6BaEjX/64guHnQCtuip5nWL2lefTo888PDOU0U9J5bJ4jNZcSN9YWKp6r54lNcdJJmZUjA46fA6PKOELGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StsFTZVL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Op/VgbYr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StsFTZVL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Op/VgbYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764919893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKF7QrOFWuELzP/P2olrzfa/3sHRV/+J1OT7rcGZ/xw=;
	b=StsFTZVLqQ0/blyacUr5hFAc7hF1ATkH32V0JRBD7Rgt9E8LCzpcehXvGtZeVwMQfiaInR
	oqPgmHn9TDUdQQJPbwymjzQc1gQbd7ZH0wvb+d/TBszM31PxcA1rK3W9oauAVTWRFDVU4F
	qoleIpZ5r8yyNxbKnFR4oYyGA26OG3c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-LLVM_qhJNaiWtwerWmdTbQ-1; Fri, 05 Dec 2025 02:31:32 -0500
X-MC-Unique: LLVM_qhJNaiWtwerWmdTbQ-1
X-Mimecast-MFC-AGG-ID: LLVM_qhJNaiWtwerWmdTbQ_1764919891
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3437863d0easo2913308a91.0
        for <fstests@vger.kernel.org>; Thu, 04 Dec 2025 23:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764919891; x=1765524691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKF7QrOFWuELzP/P2olrzfa/3sHRV/+J1OT7rcGZ/xw=;
        b=Op/VgbYrpRRQn7ELVYlbSO8txzgV3YCH0LgfkCCYgB1H7ZvcCxIesV23VTx/eOQ1IV
         CLDRZOScYTrLc2Tfi34xxEuIDQdxjx9JSbIEZ+pPzsJaQVSuynMG+xAbB+AH+mS5iXoN
         8I7UgKvzl+QCPhCvSp1H5yrihVB6lBLfecP5N9n0/QzRSyVKE22D5/guI4tp/AAIxhbI
         BZwRw1DZi6edP/VeThs37z2y/EyYZzBTjEzgZpuRuUcrGXGbWmkmZad2kAPh8HI4iMJi
         KoDh0AORNxSBJMNR0pDbBl/t1h+f31r5+rLMxg7oPfL1tMUfLp8ShF0GlXXTwronUAT3
         CfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764919891; x=1765524691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKF7QrOFWuELzP/P2olrzfa/3sHRV/+J1OT7rcGZ/xw=;
        b=d+cbYVIyw4JY7lbbbYGwLV+w+JIOWezThf/SJL9yK1Cm+ZGTQ9LqZcthLnTVTEOxUX
         hPe1eVS4MpaW8txw9Qh/LAGk/7MHeV+U2q0juj7shSJ9YsWI0L44G4q3Fh6m5hrziJpb
         nwN0ecJN1Kq88PG+bo3ZAVoM1rkpiLax5yi2/9SjADxo7jcKiItabyUF0DbbT6OQ+sld
         j6yPgn3XsrskItEYRZrJjpb+n0QdPmC8+dMKGqKOfDX/E3pStXsPKpZECuCtno3og8t9
         7R5RICKJ0nat/Qmuz62eigto2/0eaapJ992LwNFUwSAthhbBnlP/gS67gLJ5zaLLY+9n
         DvAw==
X-Forwarded-Encrypted: i=1; AJvYcCUcZm5cQwXnpyg6ZNVOeajCvDb57PidSlKyk7ZSqA5gEt7xYcwVtJGOsTRjbEwvUe8gC9qdGzLF@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhhCDCslo2Utfr2QZwIICGQsqSAvJPDfSQ3nbL34OmfiMFxCT
	XHHObLbFbx+6+YcVsn+UfqogoIiLm1CVcNqaCigdNFNZhyVsQ93So6KMdBEElGlLe9VDZGXL5nX
	4wraV8PCGE8nM/ZMJN4o/Oaw92BPrtXSZqKSklPg9/1KGc93ebrM+Imgb3SY=
X-Gm-Gg: ASbGnctZ7uwqKltfq0VtrHughiyK8wKtLGwqMJdVK341wRVSH/RR2+LBHgsh3z1OFOK
	zxdAbgOJvvJgDF3U3d8ZvBW2zkUQLLLGMKDlKTTwIPXG+Z1sNnD33Dv3oMJwnOQjgeIBxD8Xxm6
	IoGig+9fBPB9sORWRyqm7kMUC/aunyaMtGysCw8P16Xk8Gy4jFdUVwqsOYWoWFMaDyeUA6HM+Oh
	MdT92tQ8oTX5DRa2wpncdmJHwl1JrfbW9r3mF+TR94gVT43RvAL1ovTfgNI3MBXgz+z9XpZ1pXL
	eRrK//AGcFgukSP3Apr6QDmsLtCrSzMEw3vx/qPBlXmcFKfWf/StSHPy2NV1EaE7+ZqDGKor//f
	5ebWN0AByUUGbDk1wb5MmZR2P5ynGsfeOoCGLG6W420MqOJ+skQ==
X-Received: by 2002:a17:90b:5644:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-349126d0d0emr10240426a91.17.1764919890775;
        Thu, 04 Dec 2025 23:31:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHvKcw1J3JRbPRFVPumWJICvQTcnO2qIe0MHIwuvOTQvNgfh/ooO8rBUVWOHJdajlNoZP3ww==
X-Received: by 2002:a17:90b:5644:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-349126d0d0emr10240408a91.17.1764919890287;
        Thu, 04 Dec 2025 23:31:30 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494e84f577sm3876845a91.6.2025.12.04.23.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 23:31:29 -0800 (PST)
Date: Fri, 5 Dec 2025 15:31:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/158: _notrun when the file system can't be
 created
Message-ID: <20251205073125.tddypzbg7lyrzwna@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251121071013.93927-1-hch@lst.de>
 <20251121071013.93927-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121071013.93927-4-hch@lst.de>

On Fri, Nov 21, 2025 at 08:10:07AM +0100, Christoph Hellwig wrote:
> I get an "inode btree counters not supported without finobt support"
> with some zoned setups with the latests xfsprogs.  Just _notrun the
> test if we can't create the original file system feature combination
> that we're trying to upgrade from.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/158 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/158 b/tests/xfs/158
> index 89bf8c851659..02ab39ffda0b 100755
> --- a/tests/xfs/158
> +++ b/tests/xfs/158
> @@ -22,12 +22,14 @@ _scratch_mkfs -m crc=1,inobtcount=1,finobt=0 &> $seqres.full && \
>  	echo "Should not be able to format with inobtcount but not finobt."
>  
>  # Make sure we can't upgrade a filesystem to inobtcount without finobt.
> -_scratch_mkfs -m crc=1,inobtcount=0,finobt=0 >> $seqres.full
> +try_scratch_mkfs -m crc=1,inobtcount=0,finobt=0 || \
> +	_notrun "invalid feature combination" >> $seqres.full
>  _scratch_xfs_admin -O inobtcount=1 2>> $seqres.full
>  _check_scratch_xfs_features INOBTCNT
>  
>  # Format V5 filesystem without inode btree counter support and populate it.
> -_scratch_mkfs -m crc=1,inobtcount=0 >> $seqres.full
> +_scratch_mkfs -m crc=1,inobtcount=0 || \
> +	_notrun "invalid feature combination" >> $seqres.full

Hi Christoph,

BTW, shouldn't we do ">> $seqres.full" behind the _scratch_mkfs, why does that
for _notrun?

Two patches of this patchset have been acked. As this patchset is a random fix,
so I'd like to merge those 2 "acked" patches at first, then you can re-send
the 3rd patch with other patches later. Is that good to you?

Thanks,
Zorro

>  _scratch_mount
>  
>  mkdir $SCRATCH_MNT/stress
> -- 
> 2.47.3
> 

