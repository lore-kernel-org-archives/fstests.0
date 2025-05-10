Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F920F060
	for <fstests@vger.kernel.org>; Sat, 10 May 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746882923; cv=none; b=nz2EkuzOQ8Rkz0/Hpws70ISmtWc5h1l5atDwv8Bk7I2RYM358vXpy2qRRmM3mMVPwffdF92h8kZJnvilRpO/QWuNCYwalUenPs7cRMdSy6585ondWlxbsaGueK5m2Lh6i+do2xljhblZe71UGU61wddoxZe+rb/UaQMVp0zFHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746882923; c=relaxed/simple;
	bh=4wlYYnn07Dg/uCLdTviljjg0ieOpQcX8jZpIezndf5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=gtcPre98ROpuNVm9WB9CwfVFhvaYYBgBAQIHdc/Ydqq20DG1wTbC2O8fLLt6lXY5RMVbeXysR3ZW4/idz1bSg0SFig4y05r2Qvut0KJPjnqOjCDBr/kcsWvkvrwAprV1bMcV8eIuKz91otDmqNW8UpGadAMZit3MzlBpLSZ4BqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbePUly1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbePUly1"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736e52948ebso3595846b3a.1
        for <fstests@vger.kernel.org>; Sat, 10 May 2025 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746882921; x=1747487721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIzFtM0hZlyRlxHsB3F8+MVODxzDxI6hpZZaSqMAAMY=;
        b=jbePUly1u0Br0tIOsAWNi5T6juCb20zr6fptqWb+8B5nFYvt+L9hNLlyWE9MrRXtX8
         CPMYTVFlgtepUxArmODJ/m0PNPNdVqgY8q4FqIuXHWOl/7R5VM9ii47O+puZBa5dn6fy
         5YCOoBrKgTjyNAZ4VLk+n321uUfk/UpcbPkcKN40qTROWoyZy67MCqWs45gCJxvUEZ98
         U7rsXaCyi3/15oX5A6xjQM8ZaJKT2d19CaA4W7I5ePI753NK7iuv4eurp31nNVwWY1+N
         DsH6B4G3ANjQHq6/Xya28ziNylvT/FKvUgmEcYPAhgJLlPWysnBHBAZ76aqAQKsxp7Yn
         LE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746882921; x=1747487721;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IIzFtM0hZlyRlxHsB3F8+MVODxzDxI6hpZZaSqMAAMY=;
        b=PVIfcUywZ3HN5MolAh0YRWSUQu+9AR5uLkk0hbC3cEag1Uwo5uhZ+ycenZGMl20HJQ
         52n4HkTh5RcZFjDlyrl27KyVBZCF6EdNUR8GRJYjC2HCgVlRoDRtjPabLoQPFxnuwzl9
         YqHi/HFCBsy86AvfoyufKQtcwplKcar9bHDZ7c9iYjLK6v9ru7vl30mcJhZWLI0cZ7aP
         mNkWQBH1Ab1WVemfolgHy8bIjOVZ/wY5odxMsQxCEBZWC1Jybqqh+4juuluO2w3mZqdz
         /gkS8bmz53S42M5BC3W3tZWjWx01PfNBGAKBFPGScu8czKNiNT7VFY/LFADA16gz4OxJ
         9GRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIdpQlYCbsap7R457s+KDFVhyAtGn29eOOyknCOOh38Uddxg8BsLnrzM13dLNBsuG5i7rwqwX2@vger.kernel.org
X-Gm-Message-State: AOJu0YwguDSGo3Asp70bMul6+rUMbjkwrXekdbZw7oOJXrLwvFwQ6ele
	3oLt1+oZMY7Dfg1kfFpKoKcE2dQlNHIFHwPIIHtjZS2NdCoETsmY
X-Gm-Gg: ASbGncswMsyFwJlDk8T6wxeZKIB7QO/87ENfD9l0clUp06bGYpQ6SrmiOyoDyufpf5i
	svO2NByAJtQo+9ekTz82mxCcrck1YX5Ej1hJRzJ0bP4VBkiDoHab5b0U7Bdrq75v53llGCI2FYP
	2juBNBczZwh6ludeIz8uViG7ui9G5riSFyfmpMWmDOi/wcGBGIs9fiaAH/lB6qYoGPDK4vydTVb
	TZIL2TY0etzH/iVGiAjP55XwtlfIY5y6NgQ5HOABBUxk+h8FxJ58FPxg6+HV04AblbQ7BJkAwXF
	jLk2GBnqahxvV0d8qjfuowDsJisQ/M6c4y3xQGlb5Ckjj+rddhZCKTMZP8zsQAbNEjFvRvipeTg
	Ewu8rk1i2UXyL24jwz2Ou4a9efTo2
X-Google-Smtp-Source: AGHT+IFM/kOiOU6IdcBZdYys/fRdXzNfB1hMvCKpsZBnUbk/wlvZZcxgyogbjKcrrs1qUAlMlFvx8A==
X-Received: by 2002:a05:6a00:1253:b0:740:aa33:c6f8 with SMTP id d2e1a72fcca58-7423bc062dcmr10781798b3a.7.1746882920732;
        Sat, 10 May 2025 06:15:20 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8f520sm3295575b3a.172.2025.05.10.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:15:20 -0700 (PDT)
Message-ID: <f58c07aca54891cfa56a6c42ee62a59c02eb19ea.camel@gmail.com>
Subject: Re: [PATCH 21/28] generic/531: limit max files per CPU
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Sat, 10 May 2025 18:45:17 +0530
In-Reply-To: <20250417031208.1852171-22-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-22-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Currently g/531 runs t_open_files on every CPU, and with default
> kernel settings that means 50,000 files per CPU are tested. On 64p
> machines this means the test tries to create and unlink over 3
> million files. This takes a long time:
> 
> Ten slowest tests - runtime in seconds:
> generic/531 534
> .....
> 
> Yet generic/531 is included in the 'quick' test group. It is
> anything but "quick" on large CPU count systems.
> 
> Further, small filesystems  like are typically used for fstests do
> not have the inherent concurrency to scale out this workload
> effectively. Even using the mkfs.xfs concurrency options requires
> using >250GB scratch devices on 64p machines because it won't make
> AGs smaller than 4GB. Hence to get 64-way concurrency in the
> filesystem, we need huge devices to be set up, and that's not really
> practical for check-parallel.
> 
> Hence limit the total number of files this test will create
> to a sane number, and distribute them over all the CPUs so that
> the test runtime does not blow out on big systems. LOAD_FACTOR can
> still be used to increase runtime of the test by increasing the
> total number of files created.
> 
> Limiting the total number of files created brings g/531
> system back into the "quick" test range on a 64p system:
> 
> generic/531        5s
Right, on my system with 16p, I too noticed the reduced test time. 
generic/531 24s ...  199s (24s with this change, 199s on for-next)
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
--NR
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/531 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/531 b/tests/generic/531
> index 07dffd9fd..3f691c0f8 100755
> --- a/tests/generic/531
> +++ b/tests/generic/531
> @@ -29,13 +29,13 @@ _scratch_mount
>  # Try to load up all the CPUs, two threads per CPU.
>  nr_cpus=$(( $(getconf _NPROCESSORS_ONLN) * 2 ))
>  
> -# Set ULIMIT_NOFILE to min(file-max / $nr_cpus / 2, 50000 files per LOAD_FACTOR)
> +# Set ULIMIT_NOFILE to min(file-max / 2, 100000) / $nr_cpus files per LOAD_FACTOR)
>  # so that this test doesn't take forever or OOM the box
> -max_files=$((50000 * LOAD_FACTOR))
> -max_allowable_files=$(( $(cat /proc/sys/fs/file-max) / $nr_cpus / 2 ))
> +max_files=$((100000 * LOAD_FACTOR))
> +max_allowable_files=$(( $(cat /proc/sys/fs/file-max) / 2 ))
>  test $max_allowable_files -gt 0 && test $max_files -gt $max_allowable_files && \
>  	max_files=$max_allowable_files
> -ulimit -n $max_files
> +ulimit -n $((max_files / nr_cpus))
>  
>  # Open a lot of unlinked files
>  echo create >> $seqres.full

