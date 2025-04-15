Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A52DFA36
	for <fstests@vger.kernel.org>; Tue, 15 Apr 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744760207; cv=none; b=Extc3WXemZuZ8gu1zFTlN2lhJ6tXDfFp/nFFNPt/c6v3GJuuVA6k5qJrnENK17tlutxmaUBAwCoJkDXQlrope0La4E69NXVKRcscv+LZF7RE9S2J+EzxdbnHnLfqm0FnyJi2KzDN1mjR0MnqogKqZ87RHIqkVjB7zIIqvdz7Wr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744760207; c=relaxed/simple;
	bh=2eD+e+Gkgfa3+iC+m53ODqWHhNzh+/uSSsCY3/smqRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPtMkKeElcve/ZyRuIeIxZb6N7Q+ZwiUybAkofkjsCZ9ByNXmkpMYbFeOfU4kUIDtgYMU1CmuKN5lsvnGhN49sxO55YJczE4y78jFN2Hua5BF1+BP03ABcImVV0VJKZF9ATRF/KNY1RbPG/5h/Ga3Bsj4goPtE0uv1ybUrmxa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=agkioEpg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="agkioEpg"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af579e46b5dso4457209a12.3
        for <fstests@vger.kernel.org>; Tue, 15 Apr 2025 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744760206; x=1745365006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+OMw6IT7RHvpGFrBvPfdlWEgNAsFgA/CYElM1NFdIY=;
        b=agkioEpgNE0F/jK+MRIoqx0NAVYTeoUPUJKQRlODSQy3AFMPuZMB73xKd2/RxQLxKK
         Y0niKFsBmw26KPhqcuwteAzlGVzzMcFD5KaYNVVnui1OqIEMvOvAC3aQMWwbJFD6PAym
         lHGP3YdG7MPAxfAt+TvDxoSG2IxY1cdjJ2S/2Kivy42UMED9elnThDNRSmwjE8LOJyP5
         sIcGZTYxBXFgBZp6za8L59mlUNpp7nrBK5oIVvvY13i/71crxwf9oIGWjXH+GVkseFg4
         zP5y0t4esMXcBtAHcwAHBMujuOnI3A5mqSAOafCzwRiz+uEbeuzCZ+NIC1hvwHYbmTkX
         /gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744760206; x=1745365006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+OMw6IT7RHvpGFrBvPfdlWEgNAsFgA/CYElM1NFdIY=;
        b=S0/7Nh/y8odNOiryYQmrbL3t/cTRWd5b8MbrRxoGH5acpn7SuW+uqV1dug+7DimCUw
         MQXjzkfTxEbh/z4SQyp5T4WA/YPhEvDbAU6pEzYMTcD8NKlDZIA2qu7gQgWgYKyIP7nF
         x3X7vcWkRZMT80jlLtmb7aUu6ORSL3IUtPLjCGEcp4NpOD2jR6NWWhn2yFmEXHtybavS
         KR2Gl/SzC2bL67apY8PC+36xMIRaRiOz2c4GQwTAnUol2MkKIKndGcS5eL8mDKLvJrNW
         pwsUvrCoJ+0VVqOsnn+jBn3CUwEhj0xrypGBgUf07wVdJKhlw8hjIEL71PdExrndA6Cb
         GKzA==
X-Forwarded-Encrypted: i=1; AJvYcCXZdPyrY6eZtaBGna3KV1i/tWqcdO9+KmX2iDLSb69CUmf0/5WqQTN7DJ0Tgw9gT3AgToXhY3N1@vger.kernel.org
X-Gm-Message-State: AOJu0YwZk/d9J87QR7GF9MPGzI4jXNu2DIUUogASUdNZeA4+bDIjLGJy
	EeIUa16+f4qZpkJWcrBIl2iQi/y5emu6tEGKCIksJZFWkMmm8rkEZ5Z/oQSFlUqoC3V+Le+ML27
	4
X-Gm-Gg: ASbGnctTQut71yHxx4xsR5n6a7Zc8BpXyNhi59JE2tVtV8yTd1dQDnQIX2x+/1I07vr
	u2Ioum4CA0hqsas50Wd9eeZhRgVd0pjh5xnPjcDyr6T+1NsWzp20Y0tLYkyBIove51LFAo5zmj3
	P1X/j8WRSTIkflo/kLNw5TxM5Zine8luiAQXm2iapGMc874UffBy53oZ23jGmBzdC/90VqZ1MWg
	iG6iU4Yi9c8PX3Au4UNNKZM88J12tyeeUzcZKydbkDy3GYuBNMNzzXcbH4Yz1uy7Mb7hbSONHRm
	cJhth/yKZai6pNT6gkEZ+px3pNarjQn5hNqWD3El3cAdW4MAz0lB2yT6wcPyK912/RQ9OrEzzG/
	LjMl9ewrGg2YIxQ==
X-Google-Smtp-Source: AGHT+IGT6/zZzWQq7U30e4Mav9AFMxOMf9Upt4/koNxvykTkSnfdOa8SPwd7SKuV1um3ZKHXSwIMTA==
X-Received: by 2002:a17:90b:3c90:b0:2ff:5ec1:6c6a with SMTP id 98e67ed59e1d1-3085ef17d3dmr1638762a91.18.1744760205808;
        Tue, 15 Apr 2025 16:36:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613b3849sm173097a91.38.2025.04.15.16.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 16:36:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u4ppa-000000095Ld-1az4;
	Wed, 16 Apr 2025 09:36:42 +1000
Date: Wed, 16 Apr 2025 09:36:42 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] common: remove USE_EXTERNAL
Message-ID: <Z_7tirRVx9Bt60si@dread.disaster.area>
References: <20250414054205.361383-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414054205.361383-1-hch@lst.de>

On Mon, Apr 14, 2025 at 07:42:05AM +0200, Christoph Hellwig wrote:
> The USE_EXTERNAL variable indicates that dedicated log or RT devices are
> in use for the scratch and possibly test device.  It gets automatically
> set when needed

No it isn't - it's explicitly controlled by config file parsing
and/or config env variable setup.

> and generally does not provide any benefit over simply
> testing the SCRATCH_LOGDEV and SCRATCH_RTDEV variables.
> 
> Remove it and replace that test with test for SCRATCH_LOGDEV and
> SCRATCH_RTDEV, using the more readable if-based syntaxt for all tests
> touched by this change.

This breaks the way I've set up check-parallel devices. I always
create the external devices, and then trigger where they are in use
by config sections that define USE_EXTERNAL.

Hence changing all this code to check if SCRATCH_LOGDEV and/or
SCRATCH_RTDEV are defined instead of gating them on USE_EXTERNAL
breaks any test environment that has those devices defined but does
not set USE_EXTERNAL....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
