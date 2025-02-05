Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559032F43
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716845; cv=none; b=sRAyJdNyDHh/oYhp7cCu6W7s7KxDE2LONH6tG0xVRAlmnwaebqGLOLx+bujhwuatHZYSD/x2Tw4ofS1hmOziQEz6dJxK7siCX/1b+bAfnB+Tqa6YWz6Cnt3Vlrc2MyKmnGdu57GQcy+v8Se0xHVFteGRoZUSl7TKrLclBTigPfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716845; c=relaxed/simple;
	bh=+/yXL1wJjz02eN3Kdm9jfohg/apEqr1UJyYMFxthR5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auzIn9QcyKwkp4VXlmGU2w/FgRPzJs1Q5tYSIdYIKqWMGI17eIJfkSrhMb7osTUsz3NpUxzsHymBVbw2T77SgGYhl5ZuqmnRnh/K8TXnEH4W3Y2VPuuHjOCIFHz10AvG3PyR68Y0b2/1puAIAjoN7w5yDx+yi6b1t5ZCpaEPanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1cMC+XV0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1cMC+XV0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216426b0865so108826135ad.0
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738716843; x=1739321643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WPDP7sJdW1xJL8Urv0i9q5ki8dF4HNWDbOOYdyAh0o=;
        b=1cMC+XV0PVCCTaL3nbSfXHNtrfxtdvw8gGDWCNYKxBfkOFlmPw5uSy2p9VidKooJxI
         o+zYpQxkE59E3+RZa/LyDA/QhMaV4XgvxIeI2ojLLQPYkmPbPmBh4vEjdA3YuzD30xbX
         uueGHUFHWRKARWyNJ0WuTtl+4cYyydEngC0l2NN2Zd5v6wFrhbqgIf0li7fkK8+GoDzY
         X1Tg/5ib/rcGlClaBC08hMlgOW1bz+AaoycqFJ8AEjQaa2wdC7GnZT7oy6pcRetPDiV5
         7l9Oy/gRMsRIMFw4j1zBqwU8G+FMoh+HcApSLhwcv07L0g/iQvcd++lcKSuTMkhuzXfW
         LoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716843; x=1739321643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WPDP7sJdW1xJL8Urv0i9q5ki8dF4HNWDbOOYdyAh0o=;
        b=miA5/1uQe4IFFTgUcwTm9mbImN0Su5xXZdJzCZ9/fQednTNbDgmbw6fRb5eLSUqIXC
         Vl1M7c0ZkzSbplXFePxgcQp7xucVQp9LbzRpF3gVp0AQ6VrF69nScCXFipRgWjxZ8fHn
         w0mtuo7D3HTSpENrvoVpq9Y37dJmoNZfWTe8zy0ra8Y3+XmOMuX+ius1ZJ5Zv3uCEZJj
         toxtACN5tgKSZJhzUCH02aOI53wCmesyFEiJ1o+uklHy0yHP0Jy9fjsKuGIXx67R8Qk/
         PocZAdxP2h3d3/IvQRKCq2mQa+qAOwTOgNJ1fyvL1a8zxTZYMN8TToLKWijeTfSB/hVB
         U3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQSuHDuXSGW9dB7hY5n8BcT6AX4hNNc9dHgEKWYXSy8BL7IKHHzR/EIhAlhGKpa9s0V0jyb42I@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/TvZTSahNx2Z+HROJTe+fDWfU4bXelqd0TxbIWOpPnkXcQX5i
	G9RRhE2vxWiwG6nQ05yRgnMICQkYJtyjWM+MN7Rsl25Kl98k9xG6Av5Xqf1dtCc=
X-Gm-Gg: ASbGncuvbZtihWtRnuC2DYNlnbZbjpDto/ScU2MP94ftbru9E/YH5uqgZniN8Zcy9OW
	ydHPzUdaGK8KuxupjENv+upv1G7/NKlCbnDHNDJhGEpf9/Nr2Ko/k1fzeFsdranGuYrQqAkVckL
	wtJjZP9QoMbG6HbiZjznx6GOMp+ov3PjkoVQaZd7UHOV7UsCfD/hRNA2BIMbgzWgNOGk+Hmmz3u
	XlN623dfbAtsVVWx7HAizUW0LcEuH9+r5HEiKWHDP+IPmXrjBaRWqLZAXzC7iupjRKCt40mkzil
	bNCLnE3ro9i1J6K29ZeGruTRNLTgKgYFbutWvZ7QKPwUIcwk2OIy68Ob
X-Google-Smtp-Source: AGHT+IEt8BHfdLB1kFIXC6sxuzMiU8rE28EguFSG/rsOx2Vu09UfWIviVCPiXWtqDz2h95NhKkPZ5A==
X-Received: by 2002:a05:6a20:9d8f:b0:1e1:bd5b:b82a with SMTP id adf61e73a8af0-1ede88d589cmr1640894637.40.1738716843703;
        Tue, 04 Feb 2025 16:54:03 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0477a9dsm10661363a12.50.2025.02.04.16.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:54:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTg0-0000000EjUm-1fay;
	Wed, 05 Feb 2025 11:54:00 +1100
Date: Wed, 5 Feb 2025 11:54:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 29/34] fsstress: fix a memory leak
Message-ID: <Z6K2qJO0cHZu0gmB@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406549.546134.4341905130116308600.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406549.546134.4341905130116308600.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:29:52PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Someone forgot to free the iovec that readv_f allocates.
> 
> Fixes: 80499d8f5f251e ("fsstress: new writev and readv operations test")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  ltp/fsstress.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 9e8eaa6d8656da..14c29921e8b0f8 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -4652,6 +4652,7 @@ readv_f(opnum_t opno, long r)
>  	}
>  
>  	e = readv(fd, iov, iovcnt) < 0 ? errno : 0;
> +	free(iov);
>  	free(buf);
>  	if (v)
>  		printf("%d/%lld: readv %s%s [%lld,%d,%d] %d\n",

looks good - writev_f() frees the iov, so this now matches.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
