Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8099B228385
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738717207; cv=none; b=eIFDQu2Jrw8KEsK4dtijxgrBgY6s85P/kNdzzk8rW52NmBUSGHkNfiU+Mu2KEfe3MH801MqNv1xw/Wu8Tr4PtP6v9h/DRChJoBajgGtn0Sd8aXJvLr9vaeHthNNijDhqdN/Ivur1oZqOzAPYII3QaixqXBxaz5+TY5POuRADK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738717207; c=relaxed/simple;
	bh=nzjRtf1WAiexdB/ajtmqF89gdESzZrw6ttcYJFcwlog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDCJRTBo+9iuB5k92y+ZlOlrlXnVieC0Bx0pLi9EEqlrN0wcrvZrk0+afy4BO2vglkqU+PROeoekBKNo3Del1tvYHrNp2dXEmKo9jfAHd2fk1Moyon6yACbw3CeR/9zUGWApV2L/nJZUiz+8+mFR9T0CxJGuUGco3c7LWmSK9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=g/DYjbuu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="g/DYjbuu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166f1e589cso52321545ad.3
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 17:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738717205; x=1739322005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SA4xxFJ1fFHvi78tiKlbbCreFct/HQHRlhZTgDuSLLo=;
        b=g/DYjbuur0o2lL5+cp6+Pm1FTmSh1vhVpkJc3L5g6GUQKqgNtZsrnkKgwFh3/RnMTJ
         3Su1jAaTaxBtWUG9Ivxgvg9xhmEtmhTIJU6meIbAG7OrGaOHSnJKCxH26ylEiSZvmSh2
         6o7eSjrnFjUvHQU5E8rNx1drANhfoPsd2eChDLvnRsz2fJ6X7x351ryMik6IIzx8hdSE
         gQKvcoyxNpbbUD/83ZDNddnir5j2BeXTeRIj6uKTUwyHIui1aC/iL0pVQO09uDf70qcU
         Mfeijdxd6PXzT9v9sm3M6h6hTWqGUFwuO3WBZ98NScS6708A4KFFjlllrLx07sckUg73
         nl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738717205; x=1739322005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA4xxFJ1fFHvi78tiKlbbCreFct/HQHRlhZTgDuSLLo=;
        b=AU4k88W5RQdrDujs62VZzUZwBOGQWQqQh9M98CzeWK6T7oBUk+5fI8BMAqyzNDCICM
         JAz4wXy8fwRYcuAG4tb7Lt9LoyCwaQOdUMnzI/RQTZhfXFjOCT5i+4EbCW/JcquZM40t
         5xvCfO46goOYdcHoan1gZCbKE1N0vMJO1Vax+CJgRZbxUf1u5CQPgkLR1OT5UqLgdq/0
         FogNqv+KHA/yRNuVuPLGBDhb+oH/xCm2K/u+KE4lyWwLCVKkHV47fjzJfHyCod/OTsDZ
         UMmPou+GtkGD2dyOykdUCwUqjRq2A0QsFtduxMD8GuM133eVMKzyNqP0m0roQwrk23Kh
         prwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpKGEBIyDQmX6AmFWGhVLCSf7x3pGZxGicRJMZv1yBc/cMoma05QJY8wj8YFSuIGR9ykQdSbmj@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwr1TZg5t9BMeGSN/0FsqtPYNJeTDjIugalUk5/2S4Yr4OjJd
	VfLDx9nyyOGwIIC4/HrJ6CWkDGetB5eUIQTcKwYBk3u3mJw5CJbGnqI5rCtYj12kB3mw/3f/OtE
	9
X-Gm-Gg: ASbGnctMaGt7s6kaEJfYcX4GQ7Ndp0PRRcLuOAoUvQMiC7zGLLusvGc9dNxLUxDzleN
	TcLEIFgjKcZrKsLwYVsTsA34QyOWdVVCyFcfcVGPQ3IulkSHbfkwTrVdEjHT2zj5wTVB2Nb4Mzp
	somQcARl50KQa/mrj50o1QFNLpPOvH33Ao1TKHAGVKWCwK9LpBaA9PMStLyMvdd7HrY2zXzlro0
	9H77It4XQk+7soGiQpBe0BcvttSmy3kg8Hlpr7g0A5gUDBbD6gGNWbLUJzAKmaY2g1TibOcgBDp
	H5vedGlxUqTZqfAdZ1Jt8YZm0evhO9KtL0REqby4DfKHkUFxBj7xSyYa
X-Google-Smtp-Source: AGHT+IGqIlChry9kWPE+vpvtNP2Hyo53FwLt9xc8W3HwTJ3n7doMo2sKdLeUtF+9BVgK0ZvbnxFL3Q==
X-Received: by 2002:a05:6a21:648c:b0:1e1:d26:6657 with SMTP id adf61e73a8af0-1ede88b887emr1189397637.42.1738717204729;
        Tue, 04 Feb 2025 17:00:04 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe64267a1sm11242238b3a.40.2025.02.04.17.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:00:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTlq-0000000EjoE-0ROG;
	Wed, 05 Feb 2025 12:00:02 +1100
Date: Wed, 5 Feb 2025 12:00:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 31/34] misc: don't put nr_cpus into the fsstress -n
 argument
Message-ID: <Z6K4EoAftsPFVgcz@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406579.546134.8370679231649475524.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406579.546134.8370679231649475524.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:30:23PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> fsstress -n is the number of fs operations per process, not the total
> number of operations.  There's no need to factor nr_cpus into the -n
> argument because that causes excess runtime as core count increases.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/476 |    2 +-
>  tests/generic/642 |    2 +-
>  tests/generic/750 |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Looks good. That'll certainly help keep runtime down on large
machines.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
