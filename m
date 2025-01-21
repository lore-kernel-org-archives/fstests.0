Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7552F88
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497754; cv=none; b=KHLpYE14LHQY5TJotVVwf29FeRumsuVAiw9aFa0YTwIt65V9Ipk5rmcwmS7uf/33FCTN34mqScWHriKgaV8YhDKwDXfQmbBfUJum8Kz+PcewixoDl8vIOfkpZRWzN7qX7TTPzsXXwe22A0EvWcMm/NCueRgv9fLf2X7/ep8oooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497754; c=relaxed/simple;
	bh=wOKnpM0rCeuEJ5oSvWXjYctlha1rR4dtPXFQDXqU2u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZOjSBX9otd3EeZ/xC+t1wG61b09soeHFHaw0r+usz2p5XdKGYC88ZO7rF2waAk2aUx+8UnWBIZi96ug132Wb5mBeUe3ambB8Gq+Zpsov6soPNt2Rh9t5zEhcAxmP6g1HAOQRoz2R1h/PKMbbtOkoSX14EWW+4z7qdx6ULocLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xtP+Q1PZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xtP+Q1PZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so8175600a91.2
        for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737497752; x=1738102552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2idnuqvnzBG2uUIdY29IiLN1rd1Cwpouvbx9H/vumSo=;
        b=xtP+Q1PZ9C0U1ciG7GcWXt7wyUxRX8bqNY/rqFtRs9ak530EMW2h5pKgki2jractsS
         cWFZ1er19mH94P0rFNsnl+B8vk9aM2nHpqDpmEnSGSkbpSRB306LIHt/dgi4cN2BvRDV
         4J2xYCwIxY/GL3RiApbBvVaWzce06JSIM7o+k7tDMfFpPWCAFBpBIk8V7S121NUc5/ph
         mfpllCHHj1kFtWp6IAhdHoo8KPwtjZDuG1FUMk29LT8Mvl9YkqebgGG6CzHgjTD3jhXa
         HxIBloUx39A/mh0A8sS/6Sopn04XccXFD9cEtaaOgq37RTJmUxhMh1dMmMrpF63RBkdy
         vOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737497752; x=1738102552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2idnuqvnzBG2uUIdY29IiLN1rd1Cwpouvbx9H/vumSo=;
        b=TPcDfBT9CgxBMCoeNiaRpIK3/I4DQP63B/UhJTRRcmKlInNj7OD0FP687iQcesLkFT
         XIUT5dEPhi2795+vIDewtKpbw2FsN3Ry3xVe5kXqH93Ni+jUe8c3Tv9ocmqiC9ThWlY9
         ZAL4XVB/X2yznf3JmK3OgWssDKmFNMNbDJzd8JykWp/Po1rDyKGzD4ZjWPkYOwsRz+dr
         OENQEjfUpewYnaqaXiX3TCk8UJlsJKXM+TUf0+62DmHcc3+gU7/HtnkvMiZKm8lGPexa
         hsY+Ngp7EMcVLlAfXYRMPiQydXOEpa48xP/RbvpL+7RVaDa6yF4oY8omtbV4NXAokLRp
         1PJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRkwgjjukVShsesrgGX9RWKJbI1Ly91L86VHtc6UPXyXtm6O1EXhXCfBoKy/D8EqK16uHBfbmZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzFl8A3e4jHKvT0CsKxQK1okgm2BdPhP24j8fwzAg7H1C9O/fMA
	ivw7xCvReoSDYBDkEvtXikQcSmTyx2uu1U9hTM3IULzuGBi957h97OhGSNvcnfM=
X-Gm-Gg: ASbGncvoARPAQyA5M0wHazC/PR3c8E2zLC03leDHODhz7mKRKw9kQuvTUFlpP7sxFx4
	0wqMnP2N54e01Pguhs3BkvYWrQQJwlXHza/oWYfxHNcefccgNf7Doy6ctBhQeHhbSx/sqNQ6eg3
	MTYizPHmwz/IBUNQw66a4ubQwIiCSVuHtWB3aZX/k1/pCqIo2u/wx/DJ7APYleDabt2YUrRyike
	XRqqAcg9GXsh9H6aUAlLKndijNzAmaFLIPKfqDnGtZ4qls3fu/VXrBqC5RcKxOrayo3cp/1Vy3K
	3nHb0kG80rREcanTKLRc1Ib2XwM5+Px5cKhPj+p6xHJkvQ==
X-Google-Smtp-Source: AGHT+IHsnJTpwN7dGdf8N1oDnF5a+ReCkjhS8PZ9BDoK8GVwNkmrnBbdggAxWBWZKc2YqghFsu2a4Q==
X-Received: by 2002:a05:6a00:84f:b0:725:df1a:288 with SMTP id d2e1a72fcca58-72dafaf8ab3mr32413124b3a.24.1737497752073;
        Tue, 21 Jan 2025 14:15:52 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9d5335sm9566491b3a.110.2025.01.21.14.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 14:15:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1taMXE-00000008phL-344j;
	Wed, 22 Jan 2025 09:15:48 +1100
Date: Wed, 22 Jan 2025 09:15:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com, hch@lst.de,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/23] generic/650: revert SOAK DURATION changes
Message-ID: <Z5AclEe71PIikAnH@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974273.1927324.11899201065662863518.stgit@frogsfrogsfrogs>
 <Z48pM9GEhp9P_VLX@dread.disaster.area>
 <20250121130027.GB3809348@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121130027.GB3809348@mit.edu>

On Tue, Jan 21, 2025 at 08:00:27AM -0500, Theodore Ts'o wrote:
> On Tue, Jan 21, 2025 at 03:57:23PM +1100, Dave Chinner wrote:
> > I probably misunderstood how -n nr_ops vs --duration=30 interact;
> > I expected it to run until either were exhausted, not for duration
> > to override nr_ops as implied by this:
> 
> There are (at least) two ways that a soak duration is being used
> today; one is where someone wants to run a very long soak for hours
> and where if you go long by an hour or two it's no big deals.  The
> other is where you are specifying a soak duration as part of a smoke
> test (using the smoketest group), where you might be hoping to keep
> the overall run time to 15-20 minutes and so you set SOAK_DURATION to
> 3m.

check-parallel on my 64p machine runs the full auto group test in
under 10 minutes.

i.e. if you have a typical modern server (64-128p, 256GB RAM and a
couple of NVMe SSDs), then check-parallel allows a full test run in
the same time that './check -g smoketest' will run....

> (This was based on some research that Darrick did which showed that
> running the original 5 tests in the smoketest group gave you most of
> the code coverage of running all of the quick group, which had
> ballooned from 15 minutes many years ago to an hour or more.  I just
> noticed that we've since added two more tests to the smoketest group;
> it might be worth checking whether those two new tests addded to thhe
> smoketest groups significantly improves code coverage or not.  It
> would be unfortunate if the runtime bloat that happened to the quick
> group also happens to the smoketest group...)

Yes, and I've previously made the point about how check-parallel
changes the way we should be looking at dev-test cycles. We no
longer have to care that auto group testing takes 4 hours to run and
have to work around that with things like smoketest groups. If you
can run the whole auto test group in 10-15 minutes, then we don't
need "quick", "smoketest", etc to reduce dev-test cycle time
anymore...

> The bottom line is in addition to trying to design semantics for users
> who might be at either end of the CPU count spectrum, we should also
> consider that SOAK_DURATION could be set for values ranging from
> minutes to hours.

I don't see much point in testing for hours with check-parallel. The
whole point of it is to enable iteration across the entire fs test
matrix as fast as possible.

If you want to do long running soak tests, then keep using check for
that. If you want to run the auto group test across 100 different
mkfs option combinations, then that is where check-parallel comes in
- it'll take a few hours to do this instead of a week.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
