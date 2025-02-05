Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B49227BB1
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716224; cv=none; b=TizeTtbm0xu8jLf/n4pC2WkezFelKxrWlVFTqoSGTTeS+Ad1VaXHXjjWoUAKis0tFLLPs5H+tAWC3eI6alnZWH7ojtCS6+mxT3K9JARozM7kfUQgpp3FhrPITHsI2PSF/KZxwV96KUMZe7cv04X+/iuHGXqPzgNJE3/0tHBKd0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716224; c=relaxed/simple;
	bh=zh/qXK+ak8PwgHAAqFK4hNz61S60TCjTxw7qLtxWF4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3fb0Bz4h4PlLK4mMsjK3zNuXEuG1NQ+0xrP301NBVopkVj6B4BIthEtwNXeUT4LMNepCwbgK6bSQP0oeb4pZ12/gjzyt01Rk9+xCMlRE1IDfueLmUcQiMpDfVqI+NZeiLUukIP560G1NqFpTExyj/1fx/Q/a44WKXnJUpXbAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CoV3NlSg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CoV3NlSg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21628b3fe7dso115716085ad.3
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738716222; x=1739321022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0iRm9x2LMXl7kJy/z60Aj584XIH4WOLVzd+nGN7624=;
        b=CoV3NlSg6ErlOuRiA+rm8zjy1kTcOaO4K2pf94bU9rQeOyAFybOdoLA9rqRyQcMewz
         wZmaYjD4+ZAJd3R2wXnfIWZUpUjLKTF3deXshvzOMpBhEigzzfLgKQcH5aaCt9mOriko
         DjmQWWagCAATuJ4H1+LER3bYEx+/cOEvmHwcFOKr0mJ5BQOw8D8JteAvJmEdnG3RtEOy
         Fms9O8pRlELnaHTvef4S3SJ7cYASDdjQ7fqLcyZt77dZ+oCH1scqAbMVYlRbYwbFhdGr
         mDpUuzkw3Ryd6JAo/Z5OapXhthGzXbMGh1xX/EgalYJb/qRcygtb9F1jXxUXrky6xX5C
         IR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716222; x=1739321022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0iRm9x2LMXl7kJy/z60Aj584XIH4WOLVzd+nGN7624=;
        b=YcxhFBdC6kjYCUQ4Fk8EuQm11Wwm5+AQpEWbRCEzgWQBGKXhJKWXPoR0GZdlZFHP+G
         uERn8y6s1ZrLB0A0j8dAN0RHRN1ClHzGxlBo3+0o8+SBv4hzYMIfVXZDNy6scRd1Mgcx
         3SuA5OFe/GbJkb0M+ScXY+yrF9JS6vBvsQOyRuWvPO4l7aThcc7f2FIc2lGrEJoySQOo
         rmsxdaL0YzXL8t58ZQNpZ4IhUXYZ+jDS9XnUuiuapEqgjJkYpBwoor4OQkbZTdpki0wB
         NI6PBESVz7+2Fw1Q7OOn2RW4Zi6xl9LDxofHNlQtEvkQvBAHhGzhCfAj9YzdS8umTJLZ
         NbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNZN1Xx/iWJoaD0gtEiU1fL3FrE5slZ49jejSfwol4Hksv8zqquRGeio2vwpI1IWQi4ckkxtDI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7x/8PotdDZW1hiFbIy7HdWcLS7zdfFcPkmj+F1eDGPVReNUBv
	coC/E5BbaeyYYmf+/1dyTKHSH7aTS5oEBilpNESj0wd5psxP/KMDyNj2s4q4lm4=
X-Gm-Gg: ASbGncstiYAQEyaPVCM4LLBjIjOfT/IHX+VQFxmN/rdUHOMySaURPH841hFfeHu3ASd
	A6pMu4e1105Ty7BCTzV54P9XUfPgl9/UtpO5z5ubHyyu+ZxdWCTlBPfedOb3jEOXm2PP2VEyUCq
	Z/+1SysRposvyD9oljkaG/MviKn3aXu4I6kPVebIRk9MiHns2Bl8rdepLYBXcsoOwNVnyTh76YF
	ZesX/JYLYOsAdE2z1pBFx6B9ww6jEVt6ZvYc+C0t/PkjqCWxztkZnjxnan+b26LajlGmCIxHy/I
	oMeaznSv1TKlrjKUPApI5dxbeFA3K8hEhSTQQ/LarulQXPvjj8iAjz7a
X-Google-Smtp-Source: AGHT+IHc47nqoA1L7H0418ID+lzLwiPTkUuy4rsOahnwRbDH6WrXPtvEc9ERGpg5MrMlxEaglgcgiw==
X-Received: by 2002:a17:902:ced1:b0:216:69ca:7714 with SMTP id d9443c01a7336-21f17e2bfecmr15168365ad.11.1738716222360;
        Tue, 04 Feb 2025 16:43:42 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f01fb52efsm22688315ad.74.2025.02.04.16.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:43:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTVz-0000000EjNc-2o6q;
	Wed, 05 Feb 2025 11:43:39 +1100
Date: Wed, 5 Feb 2025 11:43:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 22/34] generic/650: revert SOAK DURATION changes
Message-ID: <Z6K0OxHiHMeqoRmL@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406442.546134.7449017953421049612.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406442.546134.7449017953421049612.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:28:02PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Prior to commit 8973af00ec21, in the absence of an explicit
> SOAK_DURATION, this test would run 2500 fsstress operations each of ten
> times through the loop body.  On the author's machines, this kept the
> runtime to about 30s total.  Oddly, this was changed to 30s per loop
> body with no specific justification in the middle of an fsstress process
> management change.
> 
> On the author's machine, this explodes the runtime from ~30s to 420s.
> Put things back the way they were.
> 
> Cc: <fstests@vger.kernel.org> # v2024.12.08
> Fixes: 8973af00ec212f ("fstests: cleanup fsstress process management")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/650 |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/tests/generic/650 b/tests/generic/650
> index 60f86fdf518961..2e051b73156842 100755
> --- a/tests/generic/650
> +++ b/tests/generic/650
> @@ -68,11 +68,11 @@ test "$nr_cpus" -gt 1024 && nr_cpus="$nr_hotplug_cpus"
>  fsstress_args+=(-p $nr_cpus)
>  if [ -n "$SOAK_DURATION" ]; then
>  	test "$SOAK_DURATION" -lt 10 && SOAK_DURATION=10
> +	fsstress_args+=(--duration="$((SOAK_DURATION / 10))")
>  else
> -	# run for 30s per iteration max
> -	SOAK_DURATION=300
> +	# run for 3s per iteration max for a default runtime of ~30s.
> +	fsstress_args+=(--duration=3)

Works for me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
