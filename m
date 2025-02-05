Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C3224FA
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716320; cv=none; b=uvN424/mAkP1kn41WgFs9cR+dGWf8OZVp3qO7NqtrjXc1ZC+vgHk5IOOP3W9KBdXBX3Vqt+yqf+68Z8kqZCRbg4tzTWP7y0EDwMGp3pAGvF2Aul9MxqjQYCX33MhDfDfeEtx6Q3GLCvbVbc+Bgnl+Zkeor4SFxwMs++yu+0zma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716320; c=relaxed/simple;
	bh=JnzRfT8Pl6m5C05+NLm82M5ZyuQ3MSUrRC8I2RGV8JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1nWATgxeYCFQ1feQShw9zpJDNE7PJXMb0AjVWwweDX2ZNafF5XidOERKYKsmBPYFiVkTRLZM0SsKRnS9mxnbqizRJsMiPScX2F4vshz6Fi8jQIMlMtc3o00x+Umi6AaQGP9tvzhks8zHGDB7IYVfn43+eKZV0y+mLvtIpzLeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MwqC9I+K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MwqC9I+K"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21ddab8800bso88574245ad.3
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738716318; x=1739321118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfhhPB8LfKNXn/Xk/9Go0pNeibPdkH9oO7F8BYqN4Vs=;
        b=MwqC9I+KC8yX/iAQf+F1RCc3X9eWycNso3DNrJ8TV4JEx44zoNmi5GBhlhMYYL0IaZ
         w72Lt8u79M/sK/ZfYB6dbYaNgl5/0J91AH7rt0VdgG/2BLWNSFenj2GiSYsoNqWEQq0V
         4Tuy2Zfb9ly48A7UjzoHMzYv6adczdbDSQy8BNsAyvkyCAW3w0vN4kE0Lu7VdMWvUaY2
         0WqooIqrPUoxT8x+2FWYL1pQWgxLdr9l97oQAlJ4CtXJ+5GE+8c3YQWk6jmYZqV5U9Nm
         GPfhRVgZE6Kvf7fd7YrRndkfFkC1rTaHYz+oeQHVK6Fcz8JmZGMhfoqOA00X01Y4TY/l
         S83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716318; x=1739321118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfhhPB8LfKNXn/Xk/9Go0pNeibPdkH9oO7F8BYqN4Vs=;
        b=m3jsExN3dyRHhRjR2RbuXH+btIFwNX4NUUk7/f+IxTEzWzDJjb1UTns+JvTTldf1oa
         QaVazqyXvkSyYhhjedPYtQZL8yk3n1XH+jtN+J9qE7ikfIMxmctoLEh7fzLg8pd9sI2n
         VHQeatKs4dGBDF5y/D+Z0zAUKjgIvwPnidZjdGnnQ4Hvf62kCKAZFwXGs1hnZGxKyHPi
         g6EGrTtKwbuXqFL5ngp7/c7r7pTn0UjAtMXIXxzRs/QgOG+Gku2F4GH2zqQHYIG3Lt+j
         PCjUM4Ws0HihnTCVXQfANMdpOLnlanmsXxroESDEVe4OqrY6TOze9k3GoMyLz/JKO7Y0
         LUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN6MLquJhiSnVH6DyqsElJU6IOyfOj5Q7yEhmT1XkqlK0sTj1oE3O/6Fi56JQ18ugC77S6LkUI@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQ/6jJbqk3LJJ8Lc86Zsj2zBByWGMGcvuZ2B3ioBBtzLrDPZA
	XL1bDIyX5KC6K7i5BCDAUGwHHrjj3aju/ApLqyaFWmmAJE+aijvgdvWIrg87sBU=
X-Gm-Gg: ASbGncsWsjgIAbq0hOuj8HNUarM3Bb5FvmPB+k2aKFULMuas/560Bhbc+JiH0wKoV1c
	dnXMaXIcYba3g5zpDnHFWu0AmNV7lADFGHCYKcx04xxGVLIyJtmYSACT1U4zrnKEoBhTaFuubXB
	UHcM3+rw1DKTSeC/CC2CEAcxAcNzR90LWFZEgkf1SKHjOk45HRaVJtXzMZIZbUvDLZszXSgj8SB
	tSUE5F/Q0dsMXO+/E4IFTk1z7qEtY0qtJPSX3o3EJFIdowWRtb8cW1nDIYgP5L0yRrpIkJSb+/G
	e4B+2zRDsYdxYBTIogkyiQay2Tj4KiVcbGTaqZNjQQiKPtMZOZ+0s8EH
X-Google-Smtp-Source: AGHT+IHedJP8mu5dcs/0rul82v9NDa6bM1ra0dx55AilFfnDW4pRgDmtkz1+X1B3WVTuWxJS68Afog==
X-Received: by 2002:a05:6a00:3a1d:b0:725:f1b1:cb9f with SMTP id d2e1a72fcca58-7303520e7f3mr1553553b3a.20.1738716318132;
        Tue, 04 Feb 2025 16:45:18 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba428sm11559290b3a.94.2025.02.04.16.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:45:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTXX-0000000EjP9-2YCR;
	Wed, 05 Feb 2025 11:45:15 +1100
Date: Wed, 5 Feb 2025 11:45:15 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 26/34] fuzzy: always stop the scrub fsstress loop on error
Message-ID: <Z6K0m8emjZCWFl3F@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406503.546134.2486707064611332584.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406503.546134.2486707064611332584.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:29:05PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Always abort the non-remount scrub fsstress loop in
> __stress_scrub_fsstress_loop if fsstress returns a nonzero exit code.
> 
> Cc: <fstests@vger.kernel.org> # v2023.01.15
> Fixes: 20df87599f66d0 ("fuzzy: make scrub stress loop control more robust")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/fuzzy |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
