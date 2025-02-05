Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436A2F43
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738717455; cv=none; b=Q0zkr5CX2Aj9mQMjjDI/8g/PhsALO2CKFFutyATlsoaoU2be0v2YiVXe5Jp1/PVnKFwnz+ZkJr1um7rUgoOswuHT/JLNg3tW3CzrM3rWcFwIhj4Cp370RuSYrun3m3vBBApnagzSmjUZ4tcxBOmjkLGCya+6H2D0F+0v9c4B2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738717455; c=relaxed/simple;
	bh=iQiWZzHq+VnHd2eFtcKYzSx2CAoHVWDcGiqJvA1y680=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmtmgubliUtwUVbUyb+Jsr/dBoqmcb1CkvoTbsO6xl3EaEITK8IAkIapt6Sw1njV6WPbiJNZgHShqhVl5ikhGCuslPfO9qsGrvEUtqBjQDt5ftuLQMOc7iYWuRXaLhMSP5p5SczfWEXVK3fvyk8dM27M1+Hk4z7DxcyEuNyNY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YKNOW/g0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YKNOW/g0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166f1e589cso52386045ad.3
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 17:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738717453; x=1739322253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=131VXCd3DyCBoUTJvkFjQ2Us8KE87IYvOqnMFKAGTpg=;
        b=YKNOW/g0pt9CN7nmrj739fIC0RBEfS88o+LHIf0G7kS5UrOrr57Blbx4znImJWAPfU
         riAbTK86VmTPEcnW1LSgv6ULPeKY5iEYotsnK720V9jM/gjnXkIAthCFpAf7D1EcnAPa
         fEF32MNX4d3sFzEnrz7FuvzLGhWZjSxIVrHN8WWCQ2df22NdaSOEd8q7xa+mhuTr3xUs
         Dhz56uhj4QQmpqBZ44CsEhNN7r/O9sZsNScYYdX6v0pbO5Rp49SD2h9YfgihIhyHafFu
         9MgovWH7b1wURF1aK+isOMJJFB3TVonCKYpaOakl6sv4opc+KyXDoFuWl81kKun+mVRa
         U8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738717453; x=1739322253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=131VXCd3DyCBoUTJvkFjQ2Us8KE87IYvOqnMFKAGTpg=;
        b=CLq5czJBLEokbXoitSrFAOQanK9P+CJSnozXrbPXTZ3BvcApXZiUo/aX+lV8vAo1nq
         kMaLXvK8/EqRKh9rTJjrf+FMyQvj/i5MnAvWYrXBcQffYYCVxYlFKVoXbRePA4GUSkUm
         zIq3IwgjamM8fq61HFqxIuhwRDKydwuyLD6suivhSEdraEY3CaRiPgh2ddu2W9Z5eRGt
         hKJR7hehFmJOPNNc4cGR1ckC/EHdEim6rquXGCD7wKkl3nka7ZP/x+4GQRNCX+I5VE1t
         xuOiK3WCmvqOjf5F0YNogM9fNbeRBUBtKSrAvoDUZCSFWhF0fv4Lz0dCcbhmD24OuyvK
         r3lA==
X-Forwarded-Encrypted: i=1; AJvYcCWqSHTeOzT1Lppc0oIXL3if3qreHK+teYjby3oTbFUWIZUlmS+Ji4m3lM9UJvznLoG3lVaI9ALJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUZQGpEN5IPatkScTBBSOsw2zZf3lZdi6TTPLlBlAwTpmiBBR
	GXMK+86wxg7dg12p4hLY7xpA53o+fKoQj1ORBO+huavQIDkG2WXH45OKzG8ttu8=
X-Gm-Gg: ASbGnctyFXqKMuc0tZNJ6BVY42DTkG0vEh6Vf7hyxWoo88ng/XLNyzuHpSjSfvmYHOI
	MgIc5uaMWrO4daV3ge+xEYx1IPL6N9OGXB1iqCZurJObHNaK/qZZhzp1uVut/ovHkmBmpWK10Oo
	TSZoVSzrPaOc2msilMiGKDGIiA9JcAcHPaf3nUEDsa2RtiDyFtxunwZdyow51r/lyPA9jNlzR52
	XtvlgW2uBWUGFT27A95Cys9MRIdkXSARiOWP7Zu+0MEkHUutEmPIB5Rz54b5b3EXL+cndAMusUG
	YLG1jip1er1017mdIX504JCDCWl1eSKPXrBOBySaMkkwlJJdDROYTVaao0OEqlJKX6I=
X-Google-Smtp-Source: AGHT+IE1+NbBtaC5Zo9pot2K9Qly1igSv3weL0+Ef9M5h5IhvdrkpwqDefXaIlyVxicOw8/AaqqGiQ==
X-Received: by 2002:a05:6a00:3c82:b0:725:936d:4187 with SMTP id d2e1a72fcca58-730351ead53mr1307186b3a.17.1738717452812;
        Tue, 04 Feb 2025 17:04:12 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe653ab2fsm11020959b3a.79.2025.02.04.17.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:04:12 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTpp-0000000Ejr3-2mTO;
	Wed, 05 Feb 2025 12:04:09 +1100
Date: Wed, 5 Feb 2025 12:04:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 33/34] config: add FSX_PROG variable
Message-ID: <Z6K5CSMRKbRXsi8w@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406610.546134.4973885259368864546.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406610.546134.4973885259368864546.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:30:54PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Replace the open-coded $here/ltp/fsx and ./ltp/fsx variants with a
> single variable.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/config     |    3 +++
>  common/fuzzy      |    6 +++---
>  common/rc         |    4 ++--
>  tests/generic/075 |    2 +-
>  tests/generic/112 |    2 +-
>  tests/generic/127 |   16 ++++++++--------
>  tests/generic/231 |    4 ++--
>  tests/generic/455 |    2 +-
>  tests/generic/456 |    2 +-
>  tests/generic/457 |    2 +-
>  tests/generic/469 |    2 +-
>  tests/generic/499 |    2 +-
>  tests/generic/511 |    2 +-
>  13 files changed, 26 insertions(+), 23 deletions(-)

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>


-- 
Dave Chinner
david@fromorbit.com
