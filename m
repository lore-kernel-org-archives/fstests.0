Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660461FE479
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716181; cv=none; b=YTjshmlVRD73VpNS7y8HDXC58p8e4XaR8n+/QK//rhaaxcr6btisOG2DC13Xc+w5QT1c014C/Us1xCQzKOlLaXiStm/3tUip8L+gvZH6EVurJVkiExKg0xSa4AP9I//kOP3kBFKtbdZIA5tJGTyROXYIl8ED+55aAFoyhvklEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716181; c=relaxed/simple;
	bh=P33HhQ5exX3hjmIscmxenCivfShCBFK3LSbU3lC5VV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSdPL7sfo9NwsmwyU6sT7cUx8/prEBTbUTiSLckLRFGhQxoFbCuccIBDFC20tH9P0VjDK7jwlhWE8pCaQxSd8BZ7ddqVDcCCrYGcR6geJiyKQfBIgflMzP/xlq/ElYeVJ7cFJS9tVllwwLPEMWt02PDUm4GAkUxxQMH4ZEw0Tg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gWVSL5Bb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gWVSL5Bb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f01fe1ce8so20159465ad.2
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738716179; x=1739320979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5kg3H6HL8o754rBW0YOFr5SCx8c7RwYcIDPTGJAHUY=;
        b=gWVSL5BbkgBEfsNcOahET6vDJUCg0GBKRECcv+6/ZXO4q9ekMKlRvPayydDSKLdz5x
         o5TaXvQKLogOxUsxKTqXWRPIVS7oP5uQVEpqlBbR692AnvKFIRJSv8aHLo4Jj3yPBgg8
         tOazNj87409eqOzwVl+enDfiS/v1s5UM3InCPLT4D2YiT+DiUzT4962PJLzrTRVmhHj1
         DyF8ZRYLnw+Ka7BdCjl08oUhlHjq+JiOw4e3hv0evUPRQNkQ78hInFamcSsLqs/cgBDb
         ZzEznzi6pvsVCtKxAhaZo7qBZC4guHXv1y/cI7A729QCqmLyEUiul6nTDPOq8jXFuJrW
         mePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716179; x=1739320979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5kg3H6HL8o754rBW0YOFr5SCx8c7RwYcIDPTGJAHUY=;
        b=LFda0q4nRDA6Ny/u/pD7lXGr14pdxiUMPJ/vaYKfITA3QBvs5/l75kdsBMLSe4zCol
         r2dvNE+mEnPFLc6Uwd30bXWCiCrJdpWSkvtF3rR1jMm1qfjzQd6SkDinMqAy6/j/0S7X
         T9cVx8kLSIgxesAFJwrC9st2q67jGrqIeZT1b4eySE8wlPlI+FeJu+JbnF6x6tHJG8kK
         0baifUQYNDktnx6AwgJNY/eo5fFEs2GrKyiPeEIPo1a8IPsR9qByEfRfjWikmLXMhPUm
         vSBYn0QfK+UnWV3CfAQocNdl9ATV9HFpvW+PNBZeI/GS5mokeLwJylKziRtXixDuQGjB
         zAgg==
X-Forwarded-Encrypted: i=1; AJvYcCWbrzDCHUInEw0SN8D/FTujx7BlAttPWfJAF7aNQaua4+7+HcylHC17fsJqbMrnIdeUIsvXLtpx@vger.kernel.org
X-Gm-Message-State: AOJu0YwXb85eLb30AJf+As6jyg7fMkcL+ZTlfnaEKMDJUOD3VaSBmD6r
	25c/CvIxDOFLkKjpsc/+BALBluwU49bQt3luxSJ6Lwf8moKFjGCTDNAuS5v1PF0=
X-Gm-Gg: ASbGncvNIYD96GXr5iQKcsqIAnJGcSIE6h7xSthGMpmuCZwlFP6U7hXKHfLAwZcT/ba
	egEik6lP72EXk95/UsWefZS3iDFA+/eVZsdyKNwBgpGV/op63NW8YtvmIF7TQ/7r1Sbsk9KsVeF
	WHDFCbjIy523qKUVMJQZfYmblrguCDdiHsLP0uvj47en2757/QNO9mlm5nUW9ISNHPFGQRMC1gw
	yrvtUEEcWmpEFF2Yfq8uFttO6AqwyZGjQZw57K0IUELCVMZqhOsYCYh/HcWepEJHQ+ntSoU4St9
	MzszyDs/hb58vsPG8GKx7CRpQqyStAzXYdiQlmrZ3ZIp5QzcvmcaVIHW
X-Google-Smtp-Source: AGHT+IGxUiOieMp79uApguEYeIuDLJwOd2I8PSClu9Pv4EGVwRv3e62vJxfnZTpJXrSof2sMrWqx/A==
X-Received: by 2002:a17:902:ced2:b0:21c:15b3:e3a8 with SMTP id d9443c01a7336-21f17f031bamr11512035ad.37.1738716179570;
        Tue, 04 Feb 2025 16:42:59 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5bbsm103699705ad.150.2025.02.04.16.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:42:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTVI-0000000EjMs-37WQ;
	Wed, 05 Feb 2025 11:42:56 +1100
Date: Wed, 5 Feb 2025 11:42:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 20/34] common/rc: return mount_ret in _try_scratch_mount
Message-ID: <Z6K0EF-wHqwN-68X@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406411.546134.11968180503485222405.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406411.546134.11968180503485222405.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:27:31PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make the _try_scratch_mount and _test_mount helpers return the exit code
> from mount, not _prepare_for_eio_shutdown.
> 
> Cc: <fstests@vger.kernel.org> # v2024.12.08
> Fixes: 1a49022fab9b4d ("fstests: always use fail-at-unmount semantics for XFS")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Ack, missed that. Though:

> ---
>  common/rc |    2 ++
>  1 file changed, 2 insertions(+)
> 
> 
> diff --git a/common/rc b/common/rc
> index 03603a5198e3b6..56b4e7e018a8e0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -440,6 +440,7 @@ _try_scratch_mount()
>  	[ $mount_ret -ne 0 ] && return $mount_ret
>  	_idmapped_mount $SCRATCH_DEV $SCRATCH_MNT
>  	_prepare_for_eio_shutdown $SCRATCH_DEV
> +	return $mount_ret

These could just be 'return 0' because we've already checked
for $mount_ret being non-zero.

Regardless, it gives the same result, so:

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
