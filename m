Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1E1422D3
	for <fstests@vger.kernel.org>; Wed, 22 May 2024 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412479; cv=none; b=s7Bj6nI15S+isqAehDLsBjkOZB+GgbXPNllPOwEne1NtlH8JxVdNP93iF/WdinzOEgsiC10GjLEvPTraXb4HZJ9yK5cLPm83i7Vk3m8oNcrCdimV/W+RO6j6rFa537LH47ir0c72O4PL3q630V+2XQRQzf3CHOU5IsAReCxQs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412479; c=relaxed/simple;
	bh=9hhu19l6Tibe9dCBv+75UPZ1RJi472SyGoP7inIIObo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=mT+wXIVPFrkZMMqh/DMadD4ikYoSf1P6vQeQUm0euazGDfeWBW4I12TVG5p3w1Q2hmMPWpTn9hwFKprXA90wh3vLN5zwO1q85QHaDJ5TUe1p3WJ+fQPO57QAIeZV6au/Tp4HCzdcha/0ZMBNcua6oMRLMqKdpgoO7Aaj48/RIPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOz1zdAt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOz1zdAt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f693306b7cso2230840b3a.1
        for <fstests@vger.kernel.org>; Wed, 22 May 2024 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716412477; x=1717017277; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6o3TjEpXc4tM5DhVm69vl/YhKN0gViPNosikqlLpRxs=;
        b=cOz1zdAtvdSbTEND/yaYWclsWKRunXdpJqpNm389QsgxV1LWg34bGS8nFYPk1QHi1j
         yBx1qPtNNeczcU7tdZUsK8l/htt3xsFfniEqGs6Q7pnBTDkL1X3bV2ilvlCqOCTa+mb7
         C9g5hN0oslZ7JF8ItAqxXcOZC/95GsUkLwk8GPk/pmgoS6Hz+ihhu1LkxKtG3+Uf4asf
         9TqiqgJRKUB50K8rH9KLuk2uXaBLParSzhvnPWAY7JqMvPYIhEKZFndAi+cbrwV5R+6n
         3j106m9U9VH1VpPG66ti6WQDT5wNk68GTZa/nJVWL+s83mHhSYOEKPt57TvcbE52aP2F
         HXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716412477; x=1717017277;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6o3TjEpXc4tM5DhVm69vl/YhKN0gViPNosikqlLpRxs=;
        b=nDGZTr4ptS99VinFM1zSDat1x6GkVnlNCI2IfvChnQ++wWTYBkWm3ADfAEPl+vI486
         E0AOUqn08glFuYrbs+Otr6VakKaakflKhbJcWeXBQCUQSAGhDMILnKrTKNMj+/0B5Cfv
         DJPjzSsEjTPkEYEWoXJtSUhHiaanDtIDO3iJzq3rLOZZK+ds+o4oDL5HnP8ojh8BstyE
         YwImAKEvcglocjs2+w8iF0I3oUfCjA+XL335cZAvvCBuhTpT+ELpWwp5wj7yeCPvql3T
         asryilj5i1vNXx0/xNaDTH+6bV58MHL4NqLr1QyMBdj2l1qfUiY/mstYC0EUlMNUkUnq
         AmTw==
X-Forwarded-Encrypted: i=1; AJvYcCUEvwtlhz4G+idTRyEtkY52ChPJS92sdAv+Se7qvXjfsaQmoKuBCuj+InFapko7FMP9zw4m2KW4QNITJ1RJGLg36vaZmDNbFw==
X-Gm-Message-State: AOJu0Yyjl7XmfOlxO1TvN9y50pEkv5FRKvMKQ6xlypn2NTV0K9tH56MW
	0gK7ZAPBX+b9s89I8SnReZWLUokc56XazQK31/a+azC4kjESI5BuxTewEg==
X-Google-Smtp-Source: AGHT+IHaWX9hKu5KZ4plaB2IJjK7Us9a6qXDE6C4kkIhYKkME8Pyd0zgRbV5EnNGnn+bDrAY4SietQ==
X-Received: by 2002:a05:6a00:2e95:b0:6f0:b53c:dfb4 with SMTP id d2e1a72fcca58-6f6d616ad9bmr3791565b3a.22.1716412476910;
        Wed, 22 May 2024 14:14:36 -0700 (PDT)
Received: from dw-tp ([171.76.81.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665ccsm22875004b3a.23.2024.05.22.14.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:14:36 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, fstests@vger.kernel.org
Cc: kernel@pankajraghav.com, gost.dev@samsung.com, mcgrof@kernel.org, djwong@kernel.org, zlang@redhat.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 2/3] generic/436: round up bufsz to nearest filesystem blksz
In-Reply-To: <20240513131254.92412-3-kernel@pankajraghav.com>
Date: Thu, 23 May 2024 02:18:21 +0530
Message-ID: <87wmnlshd6.fsf@gmail.com>
References: <20240513131254.92412-1-kernel@pankajraghav.com> <20240513131254.92412-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> SEEK_HOLE and SEEK_DATA work in filesystem block size granularity. So
> while filling up the buffer for test 13 - 16, round up the bufsz to the
> closest filesystem blksz.
>
> As we only allowed blocksizes lower than the pagesize, this was never an
> issue and it always aligned. Once we have blocksize > pagesize, this
> assumption will break.
>
> Fixes the test for LBS configuration.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  src/seek_sanity_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

The change looks logical to me to align the bufsz to blocksize rather
than pagesize for bs > ps. roundup() will not have any effect on bs ==
ps or bs < ps.

Also IIUC for LBS, even the page cache will have large folios. So
essentially the folio's folio_size() that we have in the pagecache
matches it's FS blocksize. (So blocksize = folio_size() is anyway true
for LBS). I was curious about this because SEEK_HOLE/SEEK_DATA can query
the pagecache if the filesystem has unwritten extents.

So this make sense that rather than aligning bufsz with base pagesize,
it should be rounded up to FS blocksize to make SEEK_HOLE/SEEK_DATA work
with LBS.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
