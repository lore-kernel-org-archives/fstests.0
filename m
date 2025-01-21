Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695131B808
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737429130; cv=none; b=jLN9+dXNrFxS27DgLH8hFCuyF8+xWTN90u1RXdi2GahG8GRn0kajplJrpAobBFlq6Adc3icxZkS5Oa+vT4Zem4oTomwYIzX1JN+rzc1C0jKBl144/Kn8QmzLL7E9hKeFQjgkAV3O5YZGI1eBdm1dMgtbSoLlxKiUYnpz1FAZU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737429130; c=relaxed/simple;
	bh=jdBB3WcVAlLDR104nU0eZfrdYAP0wQ3R+T5Q0viMPx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1JB7wxPYYElc9bNRhanL+MqPIdgT879vTyEEMlAwAin2s+FtMTO9DMIiiUhX0zRtGFM9CLCZ96XBevq9tF2JeBfppxxegIuDVryEN+/ray8T0DGux5MVfAC4V1xHumUtWWVdLI5jpsfpLAQWnj3GypAOgmcrjl0O1rA3z0oIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=SZaWHE6H; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SZaWHE6H"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so9452139a91.0
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 19:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737429128; x=1738033928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2yfEyLgrQXxbc3ohBQkJp6FXL5SmdHTuhNk/dbJkOBA=;
        b=SZaWHE6HIFRCBq+m7fGj9yH+XVvRevJk2B/pq/VSLIVWsUzzr/T2gfY9Ck8nsS6iPJ
         WFPKJu+GZsowqrWCn8kS8xzpa9o8IaD92ER46kQYnHNyd3W/J3R+7nzc9iwPGumib9Fc
         FM4WyCNh/oRCAiXALTFR/jZRk7rf18E9uNFFf35tcF/Q06AOV5a6xqIXkOZqfBVhHt1j
         UXfhZneCElshanZ7DvPSe9xk6uY0TjiXWQjHvlamBb2RdttwN7wfvYt9hItxHszlWQZ7
         UtOi2vIgc394rQLvbh+s7Cxp52uzjL39NkLO0BXduMdS04VlN18HTOHyPHbfIU+7JD4t
         ApBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737429128; x=1738033928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yfEyLgrQXxbc3ohBQkJp6FXL5SmdHTuhNk/dbJkOBA=;
        b=Y1JFLBtzWsZrz+RgSNtz45akFo15WT3FySrDvIba4h6gmhKk0CteBX35wpfcHmeDo5
         3mie8EDahW4OpkPZBz3Ch988zAsTzj4syJQhOcLOrml/D+Vb1p4+JLsejm5YhAreYA+p
         NNN1BvRmePddhgfKADOOoYXFzEsrpzRIpBE0Ez3oeBF1xN5vd5hZWWD4rGba5aTtb6FG
         F9qNtPso14CR74LbzuXniJYIUy/pgX/D1vXJC+KhRYPg2PNgl/t1wioE2eGa39a+Wceh
         CJMCdEplrHCZdnGFMTaGGmt96DPCoqjzAUj0tPxRJjp9ZzfG/aVYbl7nnB2JI75k8zN+
         iJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKYmPsDvT1yTQLmm1egegrWjG8GNcJ4XCtfCqiU7XkxkctRWvNngkwhKKqTZPQysVYxnrW34Wq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZplKPBI9COqPs3tBTIw50f377G/MCgsp4ZqlTR+cjtLXSlKx
	rtT7Xg0Sq7l6hCogrAeFE6eJXotyIP5YXWHXWVx1jK9TUzfSqZg4U+k4j7FRx+ZIM4snFpku06o
	k
X-Gm-Gg: ASbGncuNrcNFjTBqVk4KhVgCLr3GeLo4qkHzfxbHIdp8B+IixnOmPoP8Rre6PBuqx7m
	093N7V/YzAetaDQPsDHQJqiR/lvDpP1i/lZ5jCli4eJLA12kYNU3E8J+U+DiqjZoZtIASH4qtPW
	b+IzWzU8lEjm+LwVEqEPAtmXQGZe2RRM9JNYMsFLj1h6ulsc05t5wP/PCF8l5H5Vl0Daokj1GOI
	89c/sf+Tom54Yb58ASd/bOgxtyAhwbLZEj22sDmObiXDc6OylL+D+CByK12Ve2G8CDaM5I72am7
	k1meCHxrSa00/KWO2BGj7mhBO/XnrvuhjQc=
X-Google-Smtp-Source: AGHT+IHhDHA/SNMmcNQAqXF/msD8RfM1bIYsgz6TlE2GwXTSan708AdG1E2mDRK7LyN6NVGe3rUYvA==
X-Received: by 2002:a05:6a00:3a09:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-72db1b605e4mr25046126b3a.4.1737429128586;
        Mon, 20 Jan 2025 19:12:08 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8e37sm7827143b3a.119.2025.01.20.19.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:12:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta4gP-00000008VDT-3NyC;
	Tue, 21 Jan 2025 14:12:05 +1100
Date: Tue, 21 Jan 2025 14:12:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/23] generic/482: _run_fsstress needs the test
 filesystem
Message-ID: <Z48QhXVLqwCO0KIQ@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974137.1927324.11572571998972107262.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173706974137.1927324.11572571998972107262.stgit@frogsfrogsfrogs>

On Thu, Jan 16, 2025 at 03:26:13PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The test filesystem is now a hard dependency of _run_fsstress because
> the latter copies the fsstress binary to a different name on the test
> filesystem:
> 
> generic/482       - output mismatch (see /var/tmp/fstests/generic/482.out.bad)
>     --- tests/generic/482.out   2024-02-28 16:20:24.262888854 -0800
>     +++ /var/tmp/fstests/generic/482.out.bad    2025-01-03 15:00:43.107625116 -0800
>     @@ -1,2 +1,3 @@
>      QA output created by 482
>     +cp: cannot create regular file '/mnt/482.fsstress': Read-only file system
>      Silence is golden
>     ...
>     (Run 'diff -u /tmp/fstests/tests/generic/482.out /var/tmp/fstests/generic/482.out.bad'  to see the entire diff)

Ah, because I hadn't added dm-logwrite support to check-parallel
this test wasn't being run....

However, this patch doesn't need to exist - this dependency is
removed  later in the series by using the changes to use a unique
session ID for each test and so the fsstress binary doesn't need to
be rename. The change in this patch is then reverted....

I'd just drop this patch (and the later revert).

-Dave.

> 
> Cc: <fstests@vger.kernel.org> # v2024.12.08
> Fixes: 8973af00ec212f ("fstests: cleanup fsstress process management")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/482 |    1 -
>  1 file changed, 1 deletion(-)
> 
> 
> diff --git a/tests/generic/482 b/tests/generic/482
> index 8c114ee03058c6..0efc026a160040 100755
> --- a/tests/generic/482
> +++ b/tests/generic/482
> @@ -68,7 +68,6 @@ lowspace=$((1024*1024 / 512))		# 1m low space threshold
>  
>  # Use a thin device to provide deterministic discard behavior. Discards are used
>  # by the log replay tool for fast zeroing to prevent out-of-order replay issues.
> -_test_unmount
>  _dmthin_init $devsize $devsize $csize $lowspace
>  _log_writes_init $DMTHIN_VOL_DEV
>  _log_writes_mkfs >> $seqres.full 2>&1
> 
> 
> 

-- 
Dave Chinner
david@fromorbit.com
