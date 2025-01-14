Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DFE7E105
	for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865075; cv=none; b=qXdH1zAQb+IEg7PC9o6X885jeDF+eaZIMpaU7hZIpbIAzcSx62NN+dlKIWrdZ+MzTPOnsE8yvcStetEW63oP7aSv0KnUXr9MyQOPq6TLM6ZmeN7VCr24+esB6SafqhUODdS2I+1mWh+mJ0UTubojO8L7umcdIbQIbKD52tQl6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865075; c=relaxed/simple;
	bh=i7SGow3s9JPSYAe3fYZRgBzSgXOWGiCUh27CmFkmVIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uuNSazGPoyijzFa1lnvC/1+HysnzClSV8rrp93cfdYFQnlC0ybIzCVyWlMZfqVfshvIqoPKnkJL/kogo16cHO1dwqhha5v1z7KOT7nQlAeiJCD3yOj8mgNnlc76ddLgRd8rzVuR4DAdxq9sFzgT0Hw/uPgmvFa/SrcjYpvuBni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n/40SvVV; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n/40SvVV"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so424177639f.0
        for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736865072; x=1737469872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GeXhWjiR6gP9oY+0EZL92w+YXvQWxT8KBvHfhq/VdJU=;
        b=n/40SvVVtlUQF1VdV/XyZeg0jNZz+5sX0FgTzq4aJL6WL3ZT/rLUP+1SuTkFridf5X
         WSjDgGj7T6kq4IdUvUJ3bu1zXp3u7R88D30+rk9sf+0Hqu4ne7Vyi7OmEdTTfP/LqrUs
         vFbUGgq8iXmjX3A9yip4W8YyrGM6XOGrdnr7R6Gzt4Kw8E2MG8IwvagpVlZGIzaM0EG6
         C5HnEjwwkyRPYCIyyHS/iLpOXYz7WJy4Vt0aWEJyrXOiL0OXgUP0k04PvkqqaliZ0uI6
         sSSiAGpcYreiDYVVhpdTnb+ojQQLmvS8Nw3WPj3I/5QQAHC93lq6/WHgPkSnwjQ8IP0Y
         ZDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865072; x=1737469872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeXhWjiR6gP9oY+0EZL92w+YXvQWxT8KBvHfhq/VdJU=;
        b=NqFrG1oSpQvvfvwuV3tptM6/Uuwn54ihKR/xSZLPr4W5vCb/kWjPkIvHpMQ+KsbMoq
         8N1yHm5yUXyTsv4+ROmOaJVA4ppMW+8dG2s2egOGq/5DM//r7YhMCSVAIB3urtDSaloc
         HO7T0kpI1F6ymZ/aEYeYKMTm0hK1qh8k7ye/vQOxoZK2rXPeYRzleRQdLKz2sd3E6kHX
         0KFx0pmXHgzwBKFLpjRsyTSJiLvW7Ti3onpGp7lu+IGeg03oWTzU5n5msSMJJGZovnU4
         CmpV+hgEW6FbPoALbe0DXsJiceYQ4p4ZfsO4qIb32I8kYgGDnbgFOIN+Tffa3i4Emjuv
         yXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVttJRwgxw+SRDLJQDx9Hlrh+0hqDtn10+fst9letaP10oJ6OO8NOODP8KhVhYOOC2Mc4wIOwY7@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfkIcd/Db2yaZhTn0F0/lm5mH1RJpj2QiHk448x3vcFxtSRXE
	YT6wx0bU/Zbfpq7VNSIJFTkPlcUoK1pmOAGZYS/G2D8sBw59b6d3ivfM2QC/3s1n+DZsEPK3e8J
	P
X-Gm-Gg: ASbGncvx0eCcridS21Hj+GnNrm+1EQcLxdVakc36FQMviegf3/dzvmgpzFSoUzASTLr
	r4ZhHV5ptD2hBYbQaWK4u4AkFfveda/l/oBWAT2KIb8zE0q5S+Wc3Sq3YFpcSx4APlH9RsZ5rsZ
	Uhdnkk3JjhnmLxrp3EvFuPFMaHOYfzYBumh0aW3nkMC/FvRX0tW+C8k861uljfowNOKkc5nvtI1
	q3iYH2PEFpAQ+yIYUI6BATDc6U/0p662zXT6Xd/5kdJUkmyOkir
X-Google-Smtp-Source: AGHT+IGi/LaNmGBTuxQrUFeVCdExztKplentmzqAt/Kjseiv8OeVolF0wZQKl1xWaoAWxZzv2g+cTg==
X-Received: by 2002:a6b:7c47:0:b0:849:c82e:c039 with SMTP id ca18e2360f4ac-84f3c295d6cmr908579339f.6.1736865072505;
        Tue, 14 Jan 2025 06:31:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b62921esm3480242173.69.2025.01.14.06.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 06:31:11 -0800 (PST)
Message-ID: <ccbb5800-edc8-4aac-af57-80447b0a1ee6@kernel.dk>
Date: Tue, 14 Jan 2025 07:31:11 -0700
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsx: fix compile error for preadv2()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 fstests@vger.kernel.org
References: <20250114034831.1128945-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250114034831.1128945-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 8:48 PM, Shin'ichiro Kawasaki wrote:
> Commit d6b9d8eff076 ("fsx: add support for RWF_DONTCACHE") introduced
> preadv2() calls in ltp/fsx.c. However, sys/uio.h is not included to the
> source file, which causes compile errors with the gcc option
> -Werror-implicit-function-declaration:
> 
> fsx.c: In function 'test_dontcache_io':
> fsx.c:1956:15: error: implicit declaration of function 'preadv2'; did you mean 'pread64'? [-Wimplicit-function-declaration]
>  1956 |         ret = preadv2(fd, &iov, 1, 0, RWF_DONTCACHE);
>       |               ^~~~~~~
>       |               pread64
> fsx.c: In function 'fsx_rw':
> fsx.c:2836:31: error: implicit declaration of function 'pwritev2'; did you mean 'pwrite64'? [-Wimplicit-function-declaration]
>  2836 |                         ret = pwritev2(fd, &iov, 1, offset, flags);
>       |                               ^~~~~~~~
>       |                               pwrite64
> 
> To fix it, add the include directive.

Looks good, thanks for catching that.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

