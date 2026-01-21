Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F132FA2D
	for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010907; cv=none; b=MZZJJU88Xa4ywh3DavfwYCKJXYviRkgeYdpQzAhAWHv5XsQUl/8uo7JfrKei4aZ/WpgqPT+c75hxdnCssBFRD3ylLr9PEtTCaY1SHXoFAEnXj5fB732gPsrNL7TKRQu4anod+hcJ+PwMYS7OUTJ17YoJFiuvoUUB60pN7eH1+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010907; c=relaxed/simple;
	bh=YM3NH93xYXj9sUhVNH9M9Yb1Vj4QuP/NFYtUFkeACZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg61SiVXP3jVaeyQyQ1IelxCsc+h0ro4zxlz6A05vnAcP5dZ9fu6PjXlYuaFs0LaK3bjeItwFOHtiZmZewRztlUQvuCvaNK/1lFywdaDDdR9T3su781S512UXnOu4vltaMXN3phGRKOEOGHoaQ5qekdPv0UnTcfdtxK/obuPo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkT1pWvg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsawmIvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkT1pWvg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsawmIvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769010904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NcuqY+HviRhw9xk3P1lll77IB09Wj9BycPhi1D64cSI=;
	b=EkT1pWvgYf/0wHgIu1od0LJxeYalA5K2zPrpxwdtGDqzpVWG67MIWPxWflSqu9eF46W9PL
	CfbmD1Jt/BDdLAH2h1LsXLvGvqN56KYPE2XKnR24y5zou6FlQe4YRpK3/v+hE6zGII5Cfv
	3eT7xKvbYZz8juDOPcMe3tLFcQZWtWA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-sFyQjd1TPGOKcH8pPFcrqw-1; Wed, 21 Jan 2026 10:55:02 -0500
X-MC-Unique: sFyQjd1TPGOKcH8pPFcrqw-1
X-Mimecast-MFC-AGG-ID: sFyQjd1TPGOKcH8pPFcrqw_1769010902
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a77040ede0so16967805ad.2
        for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769010901; x=1769615701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcuqY+HviRhw9xk3P1lll77IB09Wj9BycPhi1D64cSI=;
        b=WsawmIvxmybDwqdY8BVKUjBMwP+b9Ezynw2XjUuMfMdO0a8AitCas+vuGwX8S+J1ml
         1xJ2W/10dkiMiYPg5st02xgS1HeFLpwSJpoTuy/WK5fpJwqZuiv0SG8bpekWeQ4IcDrD
         5xYlfh3ksKK0WB1GuHBRwBvLbucJnfohE4JDsgj7NaWVREUb7SNFSjpc4FbnJhJbe59U
         iLZTM4T0f5cNn8Z4cWRYX0uYJYEpp7HKcb/X1Je/V6oOEUyE1s4a8OFo/83MwhP3iz7P
         rNsB+/5HexIQrGrnhqzgSg2axmODKl9KoDy5+4CmJK75bZbVrrBW5/6m1rWMRfeZXU0J
         LOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010901; x=1769615701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcuqY+HviRhw9xk3P1lll77IB09Wj9BycPhi1D64cSI=;
        b=WLORgCx4Dd37/QJs/OqjWfkQviJ3O+3fnxKlZmtwaMdFvShf5AjMT3ySgQgtScU83s
         624K/buWd037nKppIKMQZNtHlQ4d41OVDtxNyuj28z82TvJStXJunqkMH5BwbaAiV2om
         2zlRRZIY03G3Ba1o3+9IWv7Q9VGAW6oAcNclczw6XkYZ8pwlqvdrhFigSs0efI9cVI9m
         Q7/8TLa2FR+94uau/ufa3B0eBDQSuUuZIWrET5ooc7PElgvJb0d5P3OCZ7US0n5A07KI
         Ty8QqWwa25Nk6UG65RGskCooa9Go5agi3orFqGIpqyIPXpvUWg/n8K+P3ByJAGIpRccb
         63BA==
X-Gm-Message-State: AOJu0YxZB3thVlL1PgI0TS8cl6qxRi/oatLhIAUxGCNrvNaVY9wiuCk3
	D0/eG2xPgiyXFESnWDz7Zzoyxq/EXsfGEb/UpCJ4mjlEfljU+kPz+z+2/tNZPOgc+++KaCJ2UI2
	tb08ySww9Y6EJpGvgiT7sIjD9EmxXIeV6uhC9cur0875+3wvfwgHMd3xqx+0=
X-Gm-Gg: AZuq6aLcxzRdiP6Nx3gu3h13mTXYCnVyz1jc4eLW3gzjYwbp6cdOcsMYT1bAcRQudrx
	PRfJMqWzmZjTZyjlekZ4qhhe0oIPE+6N6Yg0gFrNfOPR20P4/XMGU7+qH4lTo83sjk5+zzasjjv
	6oalR4naSRTWGJ+UZTAJBFOHepZwxSzF08JYBrWKexM1QErbQXKmJa4G5Ik+RyWdEwPsSEmtqUR
	YJ4y3JyWK42CV8QlvqQvk6AfvyWgMfRtIeBdzIFiNDq3iP5Nk3lcLnnNZAvSFEUVEtxlJItmLRc
	xMPu/32UnyRsmIJ1fgw+NIUfRIZBYI8/Umgn9WrG1zAIbpqe8zm+BX6a5r3N3vm8JlUxUlXEdR2
	mjNItfnSaDJwWYCy0VlCTL1YAV+K0CzveIqmhbSZ5UacFcVmY9g==
X-Received: by 2002:a17:903:1a0b:b0:29e:bf76:2d91 with SMTP id d9443c01a7336-2a76b05f199mr56501505ad.42.1769010901518;
        Wed, 21 Jan 2026 07:55:01 -0800 (PST)
X-Received: by 2002:a17:903:1a0b:b0:29e:bf76:2d91 with SMTP id d9443c01a7336-2a76b05f199mr56501355ad.42.1769010900953;
        Wed, 21 Jan 2026 07:55:00 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbb7fsm159634955ad.64.2026.01.21.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:55:00 -0800 (PST)
Date: Wed, 21 Jan 2026 23:54:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] misc: allow zero duration for fsstress and fsx
Message-ID: <20260121155456.pf6jeprhzua3rdl3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260121012621.GE15541@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121012621.GE15541@frogsfrogsfrogs>

On Tue, Jan 20, 2026 at 05:26:21PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Occasionally the common/fuzzy fuzz test helpers manage to time
> something just right such that fsx or fsstress get invoked with a zero
> second duration.  It's harmless to exit immediately without doing
> anything, so allow this corner case.

Sure, duration=0 is harmless, I'm good with this patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Please excuse my nitpicking. I'm curious about the semantics of "--duration=0".
Looking at the output of `fsstress -v --duration=0`, it doesn't actually
'do nothing.' Instead, it behaves similarly to duration=1, where fsstress
attempts to execute operations before timing out and exiting :-D

Thanks,
Zorro

> 
> Cc: <fstests@vger.kernel.org> # v2023.05.01
> Fixes: 3e85dd4fe4236d ("misc: add duration for long soak tests")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  ltp/fsstress.c |    2 +-
>  ltp/fsx.c      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index c17ac440414325..b51bd8ada2a3be 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -645,7 +645,7 @@ int main(int argc, char **argv)
>  				exit(87);
>  			}
>  			duration = strtoll(optarg, NULL, 0);
> -			if (duration < 1) {
> +			if (duration < 0) {
>  				fprintf(stderr, "%lld: invalid duration\n", duration);
>  				exit(88);
>  			}
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 626976dd4f9f27..4f8a2d5ab1fc08 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -3375,7 +3375,7 @@ main(int argc, char **argv)
>  				exit(87);
>  			}
>  			duration = strtoll(optarg, NULL, 0);
> -			if (duration < 1) {
> +			if (duration < 0) {
>  				fprintf(stderr, "%lld: invalid duration\n", duration);
>  				exit(88);
>  			}
> 

