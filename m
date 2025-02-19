Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F3253F32
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998833; cv=none; b=M7oI1Zf00pCY2uO8nHBaHdxm8s7WqiAm5f4o9UobIVxV3LMUZTwaRSTOkFdRiAHnDNGHUZo3jdYNyZv5A6lRl494vBf3cb1oYPDdDbg2yElOtoGM5cyJzt3L0zBRxb7kAOURy3KAvz+BDBcJMYV8RnyM9kT5GeXqXxrsBTLbFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998833; c=relaxed/simple;
	bh=mdhYEU7lwRItL3slLK7KpVhHctyGhm7caHwk5Baa7Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r75leP/FsiI+OrApObuMFPJo5ErTx88g3MRPgeB2mDwxlUlpZf2IX3qu8M2Sh7Fujb6cUlFy2LQ7fFp9+kMXOqwNUjpxFYn42nVvbhj/bSPts1ACsuSQ4RahnEISIfp7tMvpzU1gNYGwe7l6RgvdoE4Hdvvdum2g+EAlZdgU/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=VlsWTNCN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="VlsWTNCN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22113560c57so3082445ad.2
        for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 13:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739998831; x=1740603631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79KArqS6AJ4P9+GXU4S7RU+mXAsnC56JZ2ETqnlDjgg=;
        b=VlsWTNCN1E7yMios0oFFvsVvcQRsfqrS37NwBPs6NqmKibwWyz8pgFrlgWkZnqzOeX
         zX1ZiZ8yLwIxQE9wNp1yNBNr2R+fKJ5OtbaVFx6vWhcX6NCozgMaFHPp/jxKp+KUmMe2
         sC13mjWGigDHttT+1BV/MqBhMdI+5+ATHs8YE6q1jdg83edl70ir/zVN6L9+DzFejDAV
         9VlrWhEjwGQpPAvGtSfJ1fR4HeRbgb/D2Zr1G5k5+FGQ0p2bZmTTpuZvErpxBULD8eBi
         GNdE5lYHAayt6NIIxGG5QuNB5mB4DNbYBiGwdmN3rRW5c8Da340nPlEF1GgI0yLHz5rJ
         ej7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998831; x=1740603631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79KArqS6AJ4P9+GXU4S7RU+mXAsnC56JZ2ETqnlDjgg=;
        b=FCJyT9mTgbQT6DGKheeddswCZ4D4lUc6ZtnUMaVfUaHolCS/GkxvkY4T3kcYP76UnZ
         4BU3qmNerh+PmCmZBLltuv80sbEiulWRzkxXFU9nn/kZ/OQF3LSP0BW520U2HrP3MqMn
         xbI7pPozrXH+GSlM/2+BaC7x9abiXOzE6FhWjADzLH8hnCI3LcWCFotm3vycMt29pnrL
         Yh8NEwsAHDOXupoJXunUkmGGTCc6wTkfgZhqkSiKh6TP17kbXw2VoF8qiAxRYujZrzWZ
         77zaebX4EoOdsp7V4yjpvTmlhUftjKOMxDgmVo3GXbWTvkCRihfqeTZVtZq28NeHLtl0
         p1dw==
X-Gm-Message-State: AOJu0Yw60pTtFpAVepe+ffQR9uju3topjazCOZY0pBAYVw0UnsZnzpQM
	y0CuUCjly40kF24ieRS4+KLs2aVw0AdD8qYciccmCKicid99CjK295jIxsC4Ns8M+WaJ583FzEX
	i
X-Gm-Gg: ASbGncuyM5jr4bfX/Py6TNrnslYIZMqBK7wvsL1ySeCziIJqf9BWKkgv4YjgmxGB+6P
	MAQmtweC8MgAQOWDOwGubPlOCgGuXGcvt33EAqOYY6mJdhP2RFStqZPeDR9zGzn9CScG/oE3+m+
	ZFCP0kVRw25iiGZru0FG5T9dngOJhnZM3Jjvlcs2rmpfPlKUC0HfVEoMHRag/R8PqHTmguVVLtF
	/pTRDa4EdlojpL6hzHOVtObhpuRIYLKOKQFXgQxbVvXRC7BBiuU1L1zwdjTo7/4w7G7v1Wp9CRb
	XCvb6zLUpqrASYEF9+rEDRvhy/YFLZB4ECs94JOHCOiQf5B8ir79D3zS4eqrSiJxdjo=
X-Google-Smtp-Source: AGHT+IEH1BPGzpr0ZMG8CTwFi3C78j5V0WcoMpLVjGHV8+20hfL9OOTf/oPFx/VKSgzE7Er9WAJwag==
X-Received: by 2002:a05:6a21:6004:b0:1ee:e4f0:62a with SMTP id adf61e73a8af0-1eee4f008a3mr214936637.20.1739998831006;
        Wed, 19 Feb 2025 13:00:31 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73275615173sm6998733b3a.168.2025.02.19.13.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 13:00:30 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkrBC-00000003O9S-3OM4;
	Thu, 20 Feb 2025 08:00:26 +1100
Date: Thu, 20 Feb 2025 08:00:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH fstests] generic/126: run it inside its own subdirectory
Message-ID: <Z7ZGaiALPEtm_hJb@dread.disaster.area>
References: <20250219-generic126-v1-1-018e4e60c811@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-generic126-v1-1-018e4e60c811@kernel.org>

On Wed, Feb 19, 2025 at 11:50:03AM -0500, Jeff Layton wrote:
> I had been seeing some failures in generic/126 when running on NFS under
> kdevops.
> 
> The problem turned out to be that kdevops makes the root of the NFS
> export mode 01777 by default (i.e. with the sticky bit set). This causes
> some of these permission tests to fail because the open() is called with
> the O_CREAT bit set.
> 
> Make the outcome of this test not depend on the permissions on
> $TEST_DIR. Create a new directory to do these tests in, and clean it up
> when done.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  tests/generic/126 | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/126 b/tests/generic/126
> index 142d2bb97db706bafd2152856ef0993c5c273441..fe0d6db1b6bd85d4942333fdf04d23a63c4052ec 100755
> --- a/tests/generic/126
> +++ b/tests/generic/126
> @@ -23,7 +23,13 @@ _require_chown
>  
>  QA_FS_PERMS=$here/src/fs_perms
>  
> -cd $TEST_DIR
> +testdir="$TEST_DIR/generic-126.$$"
> +
> +mkdir $testdir
> +chown 0:0 $testdir
> +chmod 0755 $testdir
> +cd $testdir

Comment explaining why this weird setup step is done, please!

> +
>  cp $here/src/testx ./testx.file
>  
>  # file_perm owner_uid owner_gid tester_uid tester_gid perm_to_test expected_result pass=1
> @@ -46,7 +52,8 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
>  $QA_FS_PERMS 040 99 99 99 500 r 1
>  $QA_FS_PERMS 400 99 99 200 99 r 1
>  
> -rm -f ./testx.file
> +cd /
> +rm -rf $testdir

belongs in _cleanup(), not here.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
