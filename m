Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD44689
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737429193; cv=none; b=N0SdCvI8zt3i8XjvJVZpLdSKmv9glYrUBzPOQFU11TgCdjzmp9UggrT4cDhqwOmSFTsenBo4XTw1TB2mjpcKEXUUlmXpBrqtoeM36C/50km1oFPbfgHNT3uIM631C1H2kX1NIuECbUm4KS5qpywZdcdMxnVsFfo9m3kZ9ObilWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737429193; c=relaxed/simple;
	bh=Jt1qrsYnrFKo3qyOZSGS86VLMEbrpWC2Z7gbEPW5JuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OprGHX8VuiEpN1wiBYZaFDc09sZ+DkeYE/Gpl2EgTa8KaT6qsUA2SoNFYUfum9XM3qO4ehzwm7AKzPvN65l6GI9oOWXSZFEoIYaIR9Z6TLf7lpKq9spSUQcK9JaVY/4wgXwQhjdLGzDhhYhxJTvzl1DBSdQ/6BjoXsltVh2WZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LLjqCow5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LLjqCow5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso6499424a91.2
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 19:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737429191; x=1738033991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3eFsJv1yMkw5wZx9VHrhoVD7BDSdw8GpTeTu+vdZs8=;
        b=LLjqCow5yA8kQt5uDzRVm2bb2paaYa8H3CWgWP1Bmh9hJTTT/5TTxDcRuLk8u63Xrq
         vLRAKNuZpJuYsDHI4IgIj/Gx8l1jOHkNzVh9ua00R4SHjS22WadJOeJUBvikSV0c7hJL
         K+mc9q38pnWBxsZK5RGovf1zc0UnTZTCXRRCm6/0hHjzW0LLJs6AeuqCWSTAFYifufvt
         MKZ9Wg/oq6Y5sGoTPYe4fZLncQFpc1zpr3OMsC0KdzxVksj5lA6e2Jqn3MdBz+aVMMRY
         Dvvl5P0U1CQjpZuOKUqT/77mIBG4rjeQrJ2PWHL+U5K8XeS5WrhA+1vt0R8Egophi2lQ
         hvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737429191; x=1738033991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3eFsJv1yMkw5wZx9VHrhoVD7BDSdw8GpTeTu+vdZs8=;
        b=XCXNO1ikcjaKMcnea8m73wA4WHUEh9z83cQ4g0nfsCdO6NX+2ayFUyySHUS+SEhEM5
         KpiKCW28gNmOqrwgD7/hqcdmPBI8diHrjOi1ZcSQw74ykhaBwa0kJ46CSgY5DVSQWNI+
         V6EAy8esvTURFaMwLzk2gMlKfEoMBrWt3KNqVrDELODJ4Zq7Tnx0Tzfsam1TMI++JOHO
         X4aBSJo/SqTMu+exlDMPLJfnM/6+9h3xFEXPrOBOgBFQMLkTPkmZpp9TrnvkJVFqukJm
         5ohTxNK91/wDD9/NgOsZBMi+FdYda+xW8kcYJGsdxuUh9JnTqlyB4IeAOBwu1RYm8urz
         S6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVTza5UPnU/twcp07c7MoK4eObom+OvOy1jNFqLgUb+AkHPugcvaNOG37+WiDoFxeTunWW1pNMF@vger.kernel.org
X-Gm-Message-State: AOJu0YybHhUNT/WBNC6OKPJ5NNeDCnMr+gyHVr0d4A9rlqBGsCVZ5nVW
	gLJtXdWmQKkBW/tbketOYp+fHbBGdvJoDsNVejaw0qTP946AHvpVfdtFlc3/6oI=
X-Gm-Gg: ASbGncuCU1QE9qF7cm/PFgMiJv9GFJY8/Teq/FX8ioa4PbYR7hjNOeQ0/bZa59HQs8Y
	LTwCykXfTsCJH/h/TPPv8i3oBQz43M4DpfINvpco3WWkK6mkq1BdM0KeKJUvLhR1IKfUBrj6gnY
	/soPzxkSIZmTr1+dY4DOiG27f1wzq7ATYIjIEXkHMlTk3InEv1P2b+u4s/FEJAHTLQtIdXMFUMX
	LCzSR25bsJ4czhztxT6KNlrsc8/GguBtsUdSxD2HSqjdSEQcahJtbtrnnxfx4Dh0Hg2z+DN5SNQ
	xTfwphMKu7uWuiD4JfKGar8wSY7VcxFb9I4=
X-Google-Smtp-Source: AGHT+IEjXFXUByp/QJRgGNSGPJeQQAFNhs5sIg1sfosk5hFjcKA8V55Q+99B3xbE9EWONISlrFViKA==
X-Received: by 2002:a05:6a00:4089:b0:726:41e:b313 with SMTP id d2e1a72fcca58-72dafa68ecemr21946793b3a.16.1737429191285;
        Mon, 20 Jan 2025 19:13:11 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48d61sm7924739b3a.126.2025.01.20.19.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:13:10 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta4hQ-00000008VEL-1J2h;
	Tue, 21 Jan 2025 14:13:08 +1100
Date: Tue, 21 Jan 2025 14:13:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/23] fuzzy: do not set _FSSTRESS_PID when exercising fsx
Message-ID: <Z48QxDWM2VTzeGyw@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974167.1927324.3074850676975765263.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173706974167.1927324.3074850676975765263.stgit@frogsfrogsfrogs>

On Thu, Jan 16, 2025 at 03:26:44PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If we're not running fsstress as the scrub exerciser, don't set
> _FSSTRESS_PID because the _kill_fsstress call in the cleanup function
> will think that it has to wait for a nonexistant fsstress process.
> This fixes the problem of xfs/565 runtime increasing from 30s to 800s
> because it tries to kill a nonexistent "565.fsstress" process and then
> waits for the fsx loop control process, which hasn't been sent any
> signals.
> 
> Cc: <fstests@vger.kernel.org> # v2024.12.08
> Fixes: 8973af00ec212f ("fstests: cleanup fsstress process management")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/fuzzy |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/common/fuzzy b/common/fuzzy
> index 534e91dedbbb43..0a2d91542b561e 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -1392,7 +1392,11 @@ _scratch_xfs_stress_scrub() {
>  
>  	"__stress_scrub_${exerciser}_loop" "$end" "$runningfile" \
>  			"$remount_period" "$stress_tgt" &
> -	_FSSTRESS_PID=$!
> +	# The loop is a background process, so _FSSTRESS_PID is set in that
> +	# child.  Unfortunately, this process doesn't know about it.  Therefore
> +	# we need to set _FSSTRESS_PID ourselves so that cleanup tries to kill
> +	# fsstress.
> +	test "${exerciser}" = "fsstress" && _FSSTRESS_PID=$!

Yup, looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
