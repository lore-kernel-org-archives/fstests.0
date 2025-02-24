Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19591EE7B3
	for <fstests@vger.kernel.org>; Mon, 24 Feb 2025 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434670; cv=none; b=DN0GVsA7e/Opyp/FiCyhyZwyHfSPv5KIckrk+mruk3hpU3GPiYTH7hkaR6ngnEJWQHR+i3odhbzMibx2U80OfVrizoxQrs8EoRJlPiNaZM6gdJBqkc12WJ5eqFdW4u0cBI/3o/kS83JOgDU4VCZBZIoiIM4MTK7MJ1tOcetyreE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434670; c=relaxed/simple;
	bh=I4lTQmRD+sF9I+FPJ6q8AW6McyNMfF7w0eSIKj4/idc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqbO+RDBke5D8lZ4PNu3fbSkZRol9HxDuixp0MlUjKKA8nlSM4UL94WrWOjMczTylsxM0rvPnwQHF5bZb3kQJVgImNF0QfFEm1k/MX08QQlDoZcl2cqi6v22M1RnKKKha5ZC7p7cA5d01k7eaDN/5ECq3c/Pvi12rATAkR2g6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fLMB+Wq9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fLMB+Wq9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220f048c038so93502765ad.2
        for <fstests@vger.kernel.org>; Mon, 24 Feb 2025 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740434668; x=1741039468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z2MNLjquR69PKEnx/Ch1WDyJZ5J2812SGcYp+IDUTM=;
        b=fLMB+Wq9DaSPvn08ahL9ufN38QMIzbGWWeiS7tdN81yA9FBk3WxglrSXJ+XrrAxV9p
         x+vIOByhvaiG7Qfp+DGWxU1rA9hHAZFb5d9UW5Im/01weCNu+NWQg5by4U6tyJq2Hg7n
         STN2AU//hGXzecT8PVY+YOF15ZPbYiTB1l3HHncNDxZ7LHVph3Dprr/s+dVObxFbwfAr
         DwfhqdlpEViULJY6ICxtp25UznQ3O6W2iAf+Dutxqzn9dUI4Jc949hEvIeuSEq6MTkqD
         RopQiUDb/vnSRYjyEDdGF4rZN6rNHJc2POkX8mIsIttt5oOULNEDH6SzEq/jdA4a3TYA
         45Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434668; x=1741039468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z2MNLjquR69PKEnx/Ch1WDyJZ5J2812SGcYp+IDUTM=;
        b=GJssGLb34zwQseGFGMfblT42JadHtosbamix8QM9ZNow23oBIdI8eYyXUqC/29HOD3
         DXXhw8nXnhI0TqQMRssv0XsdXa6Z+6AqPj84N0CkWvaJgefqzR0eWJN4av2eX2xv4V9+
         zrSZka0BniAxxCl0ykP7aWqzOO/pb7nZWWBWe0QUu/FRfaaEZcj9a8iBBhZYxellf4pT
         GgFkbzqupJVguxK1aRU315Z8L5mg+V3JVu5NGf7q0PsadjioHJHsbe6MGvky8g+k83gV
         NtrfJCXIy3PU6TDFv4E0zXy7zCmL9a6SNi9EqpZr9iG1KAYDs+pwNzHshRoSF24kcYBB
         1xBw==
X-Forwarded-Encrypted: i=1; AJvYcCVyH8gzNLPKT/VMUmYOJUF5G5CLZcFqO+tKlMAI78tQDUaTvoa0lt2DOB2eS8bh4o4fbch7Kdsy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3nmtw3bCL8O44X2OUOQvYyBVFDFivoBYTnAqzqmzg9Km1L3M
	V5ivf+WRELWuyxIPQY2t9QcADOMUPVrU6b2jIcMvIT+hWnhVgF1Xx+EcxlQmQSA=
X-Gm-Gg: ASbGnctIXtKSL6fT92RL4O7ut4NzFB+7zi9wLYuac1HFlqWbqFY6joXcKQyau1t0zrD
	it7RABMrzy/jp66/aAajwfH26vVyvp4fhqbw6zLgX2rj+zCv60ix9ngTJeYPK7Se/enBu80WIYu
	eWC1VAbXIIGW7noyGorIL+EOUr0R1Ik8eQUZrlY8+8cljbFUdqnlHkGmJPWKm8v2RZQUj3hGKZO
	v+mxMpiEfVwZkEJ/loSoegqg+pJ/Jsvp2d0oVFOWklhcGlX+m9mjb2+mjcob/02WRKqwlBmipTD
	I61aUzHyiz1quRTSKlhxzT+ggukG6DjGvvJ8tPGHcC3YUj1U2knk5xs+G1xQ2QwmKuI=
X-Google-Smtp-Source: AGHT+IGLPPnK38cPrC2GfCMN/t2LqgNDK3BIpAL127Rjuvi8ZNeJE7RSu08huIExa8sflUXEtq2ASA==
X-Received: by 2002:a17:902:dad2:b0:21f:c67:a68a with SMTP id d9443c01a7336-22307b5b07cmr10947665ad.31.1740434667948;
        Mon, 24 Feb 2025 14:04:27 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00080asm1035265ad.21.2025.02.24.14.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 14:04:27 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tmgYr-00000005WFJ-1ynJ;
	Tue, 25 Feb 2025 09:04:25 +1100
Date: Tue, 25 Feb 2025 09:04:25 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <Z7zs6bqldp38_5Sn@dread.disaster.area>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250223193040.GA21799@frogsfrogsfrogs>
 <20250224054839.zne2pykkrm2nll5d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224054839.zne2pykkrm2nll5d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Feb 24, 2025 at 01:48:39PM +0800, Zorro Lang wrote:
> On Sun, Feb 23, 2025 at 11:30:40AM -0800, Darrick J. Wong wrote:
> > On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > > Hi all,
> > > 
> > > The for-next branch of the xfstests repository at:
> > > 
> > > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > 
> > > has just been updated and tagged as v2025.02.23 release.
> > > 
> > > Release Notes:
> > > 1) There's not new test cases in this release, this's a release for bug fixes
> > >    particularly.
> > > 2) Reiserfs part is removed from fstests.
> > > 3) ltp/growfiles is removed too, I think no one needs it.
> > > 
> > > I can't list all updates at here, more details please refer to below.
> > > Thanks for all these contributions!
> > 
> > Thanks, Zorro.  I know the last few months have been rough. :/
> 
> Thank *you* help a lot, and always be patiented to take review points to
> your patchset, finally we got these patches in :)
> 
> Next, I'm going to deal with your 10 PRs (73 patches), and another patchset
> about the check-parallel ([PATCH 0/5]: CLI and feature improvements for
> check-parallel). Will talk details with you after my testing.

No, please do not pull those check-parallel patches or waste time
trying to apply/review them right now. I have rebased and updated
versions locally that I'm getting ready to send out - this has been
waiting on Darrick's namespace helper fixes to land so I can test
things with those patches in place...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
