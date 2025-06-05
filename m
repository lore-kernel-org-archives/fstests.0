Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9621F4701
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143012; cv=none; b=eyaEBHR/cr1XBQUWBSAN2wtyazXYfYoDDApokCngwcqZ88cLPXDGylZLeEUJ1Aw3Dx17gMHwvsxiJrdBzp70ufF6q1MhW5EU4dmiSaUnsa16+CNVO7D55x7xFcCW1YhZF3IaiLDSq9eGygr3GF+nxxkOQJH8sJkWV3Px3noGV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143012; c=relaxed/simple;
	bh=uub5yAAUxua20JUrxMi+jZKpy1Tr98Zf23w32+mTc9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2Bg5mVsWOjcFHOSPVO79P9opg5sMrNy3KhQw0VxOWpaJy4euPdN5C/SJ+uxuUrdykfJ4TgjluRYGBXWjHNMol9dCrON7Ipw2t7Q9h89lNp9BTDkqmIzE5PVe2hJvxl6zBp+QdM0PHKMFiuNZpF4GyqKSw4r8asCy0+jDL35Ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRjRPUAA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRjRPUAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749143009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjmn9AcgUBT/6b0VbQZa8X06zBbschQpRkWsCTXTpE4=;
	b=NRjRPUAAF7Qp038snFpq2dwus763Rjwo69kHypKJyw6sDAfrylD2rOmsBJ32+IRaFOOfhB
	zsaAIV3RSpWzi9t5KLMASI4aq5XPTUKJvpozovCYDfyBhMfSBPo9+opER7wTOZ494EHH68
	eXFV7MXAQQrcUT7UiK0C7SXkWOAunUM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-JObqG8H0Na-0bjJY7iJIgA-1; Thu, 05 Jun 2025 13:03:27 -0400
X-MC-Unique: JObqG8H0Na-0bjJY7iJIgA-1
X-Mimecast-MFC-AGG-ID: JObqG8H0Na-0bjJY7iJIgA_1749143007
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-745e89b0c32so1636105b3a.3
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143006; x=1749747806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjmn9AcgUBT/6b0VbQZa8X06zBbschQpRkWsCTXTpE4=;
        b=cN5D1IcYryQE8Jfn72UzwIw5HllcLPUlBRSTmvz6kbziV5uyolqngk4JLGMm/50OWz
         gSfBcyt6i2aOd6401SvpQWdbOHMLJ9xdKKpjVZcSlmru46ogHokzOkgu5pggYjcG9HCx
         aaWB053LE7OUsm6PlHwcruT5RYM43F/V6Bqwdfjg7Bk2nhZmidSbhQmS2vqGC6XlkKiJ
         PIbgmqqZwZt8yGMfQGOg9yPFKvI1wSCT6BuYaxOiCCnz/nW3ivnvDbowdPtdoSsP5pYk
         Lv5PMZHBwvd2q5hJOJ4wr22u68UpkApYISOUsJMv1PmY9sTrF/0V6OyzgOBOzVnvZoVy
         ppiA==
X-Gm-Message-State: AOJu0YwuTszag5Ug59hF+EvFBr+Dw/H8+37EF1tKqPXgeztAokn7/Ivx
	1+Z0LvDyth35OaYLkISKuFlu07yf+CNH63nmF9+D5Z2N7w3SVzRWfMRLavSg+e/I7UdtQogfeQB
	GAgTn6zKcBCx7wie0wJecjQE9DdKBVpO6likDDodDSgELaaDJjJCLKCN+i1erGrj5wi4=
X-Gm-Gg: ASbGnctcFlCOq8Frshmmak2+u9C15k+g5D2uZcbmFbRU2N6qsrn5TcFsj15QGFNtrNt
	jbb2e6CaYS3sAKGuxYmTwQHKXRJSuloUec00Z9rqfdaxMpEz/mKH1TGfXu4TPgeHoDZB1Yf8y1c
	mf4NOuH9N33Cnehfx9XK3Kxjol5deNs2+oQwI5bDjbeP9Pd4wZNoexc9IYEe0AcrZUG436lcGTF
	zkbJfaLswhQAXKYY3itJ6GKGtDnvlTtLF3KQxOjd4i572jJDfTJYGORxWY++Oyw1KoTepPI7a3A
	hqyVJsW4q1HWWrjjC1eOhCGaOgtE6/DP8p+uxGfq5ANs2I0zi0Gg
X-Received: by 2002:a05:6a20:7484:b0:201:b65:81ab with SMTP id adf61e73a8af0-21d22bb59f7mr11309824637.23.1749143006526;
        Thu, 05 Jun 2025 10:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEHSR5XCjojLivT4QhhlMa+stNM64sElBlP0EwbjudYFFqwstpJBrLf5TyjQ8nmuYMkB35jg==
X-Received: by 2002:a05:6a20:7484:b0:201:b65:81ab with SMTP id adf61e73a8af0-21d22bb59f7mr11309798637.23.1749143006196;
        Thu, 05 Jun 2025 10:03:26 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafa42sm13460251b3a.92.2025.06.05.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:03:25 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:03:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fsstress: print syncfs() return value in verbose mode
Message-ID: <20250605170322.a2dforp6mfxypwgu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ef67a4bf8d93109a0493155252c9a3c903478388.1748020773.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef67a4bf8d93109a0493155252c9a3c903478388.1748020773.git.fdmanana@suse.com>

On Fri, May 23, 2025 at 06:20:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We aren't logging the syncfs() return value in case we are running in
> verbose mode, which is useful and it would help me immediately figuring
> out it was failing in a problem I was debugging with btrfs.
> 
> So log its return value, just like we do for every other fsstress command.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  ltp/fsstress.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index ed9d5fa1..8dbfb81f 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -5326,14 +5326,15 @@ void
>  sync_f(opnum_t opno, long r)
>  {
>  	int	fd;
> +	int	e;
>  
>  	fd = open(homedir, O_RDONLY|O_DIRECTORY);
>  	if (fd < 0)
>  		goto use_sync;
> -	syncfs(fd);
> +	e = syncfs(fd) < 0 ? errno : 0;
>  	close(fd);
>  	if (verbose)
> -		printf("%d/%lld: syncfs\n", procid, opno);
> +		printf("%d/%lld: syncfs %d\n", procid, opno, e);

OK, no objection from me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	return;
>  
>  use_sync:
> -- 
> 2.47.2
> 
> 

