Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF80132111
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216181; cv=none; b=etYEOPyNScixD6YqijPML8pU6YbFwtACSiGwYBdpGOXnEUblmse6jtjAWZoQzlQp+N9g6347F2keTRc0ITGjWMC33j+kW+CvUL/7pvf1baLys6cRYpR5Di8HPB7iiCoRVNLHssf5IpfItKcEvEbN1cubOyUsl6HkBf/A7+IyXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216181; c=relaxed/simple;
	bh=tKQ9Nf2z8BAQF2pf2Qx0qe5NTfvVs1h2eYRYo9jV8QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiGiQRjdLZDQEsADz13NcfZ8NbCZxQJuIczwYjPoQoMDMSLYAw8gXNaTvTZFH5tKiNLqzTlbCvIUVx8DGj5dQGB6CrNUOl+aVFhrJLPzRXVh9kyI7gVHoc9XNljweHCY+MYaKx2LglHNyt2Rn3cn0MXc1gu42yKq8wJEOF6ReEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TKBSwLWF; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TKBSwLWF"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a8aed87a0dso49683035ab.3
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 18:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736216178; x=1736820978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKcN8G6vwXEiRUg1ibvtKdPImnTg9Ja4S5AkhQL04Bw=;
        b=TKBSwLWFtgCKNAvuq5jVk7ZE5H0TK6yNLVHnWkdflgjW65PGYe5BkRC5WEqzmOGN6x
         ebWqbDgWnxb9kxX6srNVpo63ITgFcDTJ0rj/HPTYdyfGAOo5rFUMgXClm6c3FNhWrCdz
         qbEuCNS9ZTvXBT+zTrzNWZJDLQvYG04J0JXF+xp02cVFlkp6WuPKKjE5B4UcLUyRwFTq
         HvxqlwWEitOyRLbtBN/whIPScOe+xMKrosCd4zeDIeF5P5WnzRuzioOmcLy7wezgga4G
         aBmVSKUGIZDJEbGsH6cDT0M880H4YXG+PJaBUJ9WHDIABWUVenjoq4B0hned8Eji3jKq
         xkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736216178; x=1736820978;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKcN8G6vwXEiRUg1ibvtKdPImnTg9Ja4S5AkhQL04Bw=;
        b=OXtk34HtdBXuqmas3Kp8ILPgPMc0zxmNv5p2VI6O5deQoEYn91n4F7f8r//nLb3UNr
         6X1s38H9oqlxMPJWWcUlyHBdSBknGrBjZfC6lgV2FjpghCADRiCfdq+GrDeGoTq/Ww2V
         UrtQ08hRmesEIkASEBxhGdBUnPEv3MI0yA2Sa/1T7f5XJqHbG6Spf+gV70sCV3HAjZGC
         GoXcoY2T4Km7BUFUUn8HO+0ILTmwdn7Wup3GgCzxGQ+TLi1Vml0WjVBtIR+/PmsCv91r
         CahvCH76mci0fZept88aObW/fvD5Y6UKE5uNLmmljYBigcB8KfK7QsWu+DBMUqH8A/ua
         j0iA==
X-Forwarded-Encrypted: i=1; AJvYcCVoYKr40Dmo04CbVlejlkLdJ3d2zvXQF3xJZBjrosbPtAZmG4lSuCJaGgzfYm93IPqwmmIdM0bs@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+R5wBtYVSvff2Zz4/BuHvGgI3aIo9oUebSlAz0vyEv0bkC/b
	Z0nzFeTes0hvBdiakx4er8+bbkK1Y0GwwO+Sws0Jpec5kdoJJB6I79BdBXQoIsI=
X-Gm-Gg: ASbGncvHNskAKFXTA65Jbd5NZH6h76SHeWX3EPNIlU0V8RUmhNCN3STJYC2UEgWU89u
	mFt/Tx8EsTC02Lr7AuGIMEdycYeotXH59BDy8OoJgYmgsFNIQxIFKNpNsdzBHJQtaSSxa4A2w/p
	aZWtVuwayqbz3vgkeZEQ8thVeKEJ1qS7eHDRGz1zqe2rL1HJaE4/RI5NdQC8uxPeXE6uivFtJh+
	hjafz4KdNrTLU3+yE1/2G4zHk8BCpjt6su06pIuCDFAYdKzvHqNmA==
X-Google-Smtp-Source: AGHT+IFbW/fTG4Uf60rZOZizoK5/6Bust3Hqljf7yzCqC1XkoD2j1atIzeyCpr6aq2q3jZp3xhp24A==
X-Received: by 2002:a05:6e02:b42:b0:3a7:e67f:3c58 with SMTP id e9e14a558f8ab-3c2d1aa2b80mr512308855ab.3.1736216178608;
        Mon, 06 Jan 2025 18:16:18 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c199c0esm9565050173.89.2025.01.06.18.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 18:16:17 -0800 (PST)
Message-ID: <32edc8e2-f338-44d3-9070-4be4b5fc99a2@kernel.dk>
Date: Mon, 6 Jan 2025 19:16:17 -0700
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fsstress: add support for RWF_DONTCACHE
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org
References: <20250106174919.103199-1-axboe@kernel.dk>
 <20250106174919.103199-2-axboe@kernel.dk>
 <20250107021102.GO6160@frogsfrogsfrogs>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250107021102.GO6160@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 7:11 PM, Darrick J. Wong wrote:
>> +void
>> +read_dontcache_f(opnum_t opno, long r)
>> +{
>> +	int		e;
>> +	pathname_t	f;
>> +	int		fd;
>> +	int64_t		lr;
>> +	off64_t		off;
>> +	struct stat64	stb;
>> +	int		v;
>> +	char		st[1024];
>> +	struct iovec	iov;
>> +	int flags;
>> +
>> +	init_pathname(&f);
>> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
>> +		if (v)
>> +			printf("%d/%lld: read - no filename\n", procid, opno);
>> +		free_pathname(&f);
>> +		return;
>> +	}
>> +	fd = open_path(&f, O_RDONLY);
>> +	e = fd < 0 ? errno : 0;
>> +	check_cwd();
>> +	if (fd < 0) {
>> +		if (v)
>> +			printf("%d/%lld: read - open %s failed %d\n",
>> +				procid, opno, f.path, e);
>> +		free_pathname(&f);
>> +		return;
>> +	}
>> +	if (fstat64(fd, &stb) < 0) {
>> +		if (v)
>> +			printf("%d/%lld: read - fstat64 %s failed %d\n",
>> +				procid, opno, f.path, errno);
>> +		free_pathname(&f);
>> +		close(fd);
>> +		return;
>> +	}
>> +	inode_info(st, sizeof(st), &stb, v);
>> +	if (stb.st_size == 0) {
>> +		if (v)
>> +			printf("%d/%lld: read - %s%s zero size\n", procid, opno,
>> +			       f.path, st);
>> +		free_pathname(&f);
>> +		close(fd);
>> +		return;
>> +	}
>> +	lr = ((int64_t)random() << 32) + random();
>> +	off = (off64_t)(lr % stb.st_size);
>> +	iov.iov_len = (random() % FILELEN_MAX) + 1;
>> +	iov.iov_base = malloc(iov.iov_len);
> 
> Should there be a check for null iov_base after the allocation?

Nothing else in fsstress seems to bother with malloc() failures, which
at least on Linux, is probably fair game.

>> +	flags = have_rwf_dontcache ? RWF_DONTCACHE : 0;
>> +	e = preadv2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
>> +	if (have_rwf_dontcache && e == EOPNOTSUPP)
> 
> ...and should this set have_rwf_dontcache = 0?

I don't think so? If we get EOPNOTSUPP and we don't have dontcache, then
it's a fatal condition. fsstress defaults to it being available, so we
may very well run into EOPNOTSUPP and then just do a regular read or
write for that case. We could probably do:

if (have_rwf_dontcache && e == EOPNOTSUPP) {
	have_rwf_dontcache = 0;
	e = preadv2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
}

here and on the write side, at least then we won't repeatedly try
RWF_DONTCACHE if we hit EOPNOTSUPP. But in terms of logic, it should be
correct as-is.

-- 
Jens Axboe
