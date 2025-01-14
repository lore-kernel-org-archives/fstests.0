Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8EB14A609
	for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874985; cv=none; b=alvFBfUfe4Jl8h9oAdA4VtWI7sF5AFVa2IwNR7iwnsoY/hfwziJEZouzarektVo2R/Ka5CxH3hGivATwp11ax5j/jxJl3AICdyTXX4r77uSwjiQsvvDz1WpsXmHYF3eH3noGoG9xOcqetqzuX6KYbWelDqss45QnAb2PdIk/ZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874985; c=relaxed/simple;
	bh=mi5E/ZHz2q/fl8pvKX4+YEmAcf6/XLeXJ8iCf9MPjFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu7KAJZrRB3tWWWvBY/6VEQ4d+K9SeZLZap5q0jqWjf04bb/VbXeYnb0Acwgun2CW6OkuMzCd3P6w59CBrCoK2yws9ICpMROojRBHYXbyEWBLSBulrNo2b96P9/omjU1H0Ky72tqe5dAtwysmq1KWHmH55tU9MaYdwjwyH4Xur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzNSc2fo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzNSc2fo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736874982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPTTZuNsCe89G7u8xA4zsRu6Fcavb1xricJk8a6YESE=;
	b=ZzNSc2foLaNYw9nyW3xNRaHxMDqGvQbvQc6BiO+otfDcxfTMaugv4iSc6Q2ym6DIPtwHfW
	jPCP/Yj+ElC2oA6Y7zr24EG46sJH3mokM0XgeK/RJ6EK7aIfn3rsnzIoz8h59JgBEzPP3B
	dnF+2a2v2hJzfBtyZOy4YNnJumUS4UU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-ojwIE2ptPqe3jlD1hNgyIg-1; Tue, 14 Jan 2025 12:16:21 -0500
X-MC-Unique: ojwIE2ptPqe3jlD1hNgyIg-1
X-Mimecast-MFC-AGG-ID: ojwIE2ptPqe3jlD1hNgyIg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso10485831a91.1
        for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 09:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736874980; x=1737479780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPTTZuNsCe89G7u8xA4zsRu6Fcavb1xricJk8a6YESE=;
        b=s0uCuTztNCKtdNTgnI4Fj4yDlwzQpWJ14eu3+3WND0FjhG3L5Cyy2AneK3SBzf3SS3
         Hgl8jENI5W2JTIlBUqXq06toXqPI3tIJxQ16ZYzUwmkWuv5X8wwxWggTrpZBFwTZO6HA
         WbaJZsVbBLDtRtGosHzW8j+gzg+m9slvcO1aw1ykSIwtaK+UguGu3+jB/+5pDwPUWJbb
         /JkZcu/or7cBIkEEFyHAYRT6cyJrcI483OrEZkU7nFbNiEVsj+d032CoFtzmblb04Cpz
         uMKwdwL6FpZBuKnYte0lMArkxNwO0isQeKrdH/O7sNRQGEDoypOtr43Tv/3PY9B6ECae
         sa+Q==
X-Gm-Message-State: AOJu0YzVD2DgGbiKKmXkCsUiBC1ZcvO0IqVTrmHdOCptgnZuxw0ZE0+z
	/tBzu6tst699/sH5s/w8q9prfuFbNoVgz2axnHui1QFflnCeZir0r6+xSv29jglSz88r2sC0/Hz
	fRVTrl5g4EhkMISApAHgBE9FqrrLVb107rz7SC0vmU5KVu9iskMmTwuZKYp1LqJwxrw==
X-Gm-Gg: ASbGncsVKnZn00mNIzkpCJl/++ptIOun5cvXFx+PA3CLNd2gi0NDJuoiXmEL6HBxfw0
	3Glf5uA5ETQy+JnY7Hd2mm7xWmRtClT5Gt5BaWbvaFEjkHkQg3oN9f+lR2fEQ8fQKV82h8oVogY
	bbmXziV6+Eps9kXjlaDl9Jw4PUJD8LVO6Gx3WfWbIcnwHgLBtwTZBPgwZUzxADSPITP1fMjkxwU
	aWIrrTMXixrUTrp9ZAkRNwZQ2tuA0J40R0j9jBSNH5g6riPsyyBh7CHqB1J78P5BkEQVjmfHjJ4
	CTOAVGxfA+LI/5bKDN4Q+w==
X-Received: by 2002:a05:6a00:1414:b0:728:e40d:c5fc with SMTP id d2e1a72fcca58-72d21ff814fmr36933356b3a.22.1736874980286;
        Tue, 14 Jan 2025 09:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHyQdEwjsmVTkvRlLdgvZUZJbjx5mfOFnBYhBLATl6STd9zGKtsZQRAmKNavepCHDYgBJlRA==
X-Received: by 2002:a05:6a00:1414:b0:728:e40d:c5fc with SMTP id d2e1a72fcca58-72d21ff814fmr36933316b3a.22.1736874979943;
        Tue, 14 Jan 2025 09:16:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067edf0sm7885464b3a.133.2025.01.14.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:16:19 -0800 (PST)
Date: Wed, 15 Jan 2025 01:16:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: fstests@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fsx: fix compile error for preadv2()
Message-ID: <20250114171614.y2ub632vcckq3qxy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250114034831.1128945-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114034831.1128945-1-shinichiro.kawasaki@wdc.com>

On Tue, Jan 14, 2025 at 12:48:31PM +0900, Shin'ichiro Kawasaki wrote:
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

I didn't hit this issue when I test it. Thanks for catching it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Fixes: d6b9d8eff076 ("fsx: add support for RWF_DONTCACHE")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  ltp/fsx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 9efd2f5c..3e89d570 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -20,6 +20,7 @@
>  #include <strings.h>
>  #include <sys/file.h>
>  #include <sys/mman.h>
> +#include <sys/uio.h>
>  #include <stdbool.h>
>  #ifdef HAVE_ERR_H
>  #include <err.h>
> -- 
> 2.47.0
> 
> 

