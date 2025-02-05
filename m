Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129F214A91
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790108; cv=none; b=tdr7BjoBduCdN2JL7uPsG2VarPVECiWKkEvmg2Q16H81c6rmn892dnnLHn5lYxmr6uayBCBKhx8QGiNBbmBfFAOwWMKJjeej5yESHZOH28I4mc1MMRNTwnKo+diz3HT/2/B0onUwRv3L+RbstRq+KTaCjVsji7S+jirzKy8AjUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790108; c=relaxed/simple;
	bh=f3kzSJ34z6Opi72Eq+p+B00CSmDxGtkmCwQnPmLlwD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYPVEPrem1QWuQE1Aoz4NRAMtx++A/a7Panttz0V65HngiKx4dIapXjNlDHXS2zF0v6kSypcKiopd6R/z9akr0w6uTqLIjEn33ja1llzJTrcHETInja5us08bdauaGH9u8Dp9rZYotKGFgap9JtDWbLVOs+qP4MxqyBnPUWYNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=3gSlz+05; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="3gSlz+05"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f2f09865bso4730835ad.0
        for <fstests@vger.kernel.org>; Wed, 05 Feb 2025 13:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738790106; x=1739394906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmfYzaS7fplhvkUsxjdMvDYBw3INXo7EA0Wa6z1WvkI=;
        b=3gSlz+0519dm1cU8DtgWBATVMcJ52m+PPpTMuLaqfUcyyrheg251e+ZVg1XmRK5Fc2
         X9XzQyjMjspLd9sVoLtdIUHWMNStcTR0drYKmsPKG1CZ1IyH4881Kc0y5I3a8s14kTr4
         Pel40BYliQsGAIUU9LZoIoaqHyOTMaVWjUEI7dwe0F78+DNZJs3acE7Y+Ua5JEgj1Mwf
         TeP+Jo6ncvKzBR5dCPRRZ1gQ6O8R7Tnz0GaycM3Saf9PoHdde/jmGg6if+dA0Yo00Z7P
         jYNjYhioPHLxZpPQcLg6Ky+LOXg9iy67zFVaTPOfUkAZTB8CoLDFUI9hUd6BnoxDqeAj
         9KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790106; x=1739394906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmfYzaS7fplhvkUsxjdMvDYBw3INXo7EA0Wa6z1WvkI=;
        b=d91GqJgg1BcQFeFC0Ob5waJi4o2FiG5rRtBfeY0FZfg+518fojYnyW6v0ypGPGPlMU
         v2PlWjBRpovmPJXBbpidg85+h/0xC5+w4aLBzgrEh6XE8jYkW6n6CJp8LGIInJxax/bX
         Vo1nYe/L4KoSGyfuRC2DbwN5KVGGXQdCUE6Jc7thXw/Eh0OdbYCKscEGRkETb9dwiktg
         nydJ1NExTGjRpN99Ow119vGRiO6EXXvLQQxoCb8kt4s430iYUcHvl/REfXYEv3zViowA
         mVfGRXRmGOfYPban2a01ayIoCLSfQKHudNED5k7DPQ1bWQsyNAw9cuKkhzXxtL+gLguc
         ZIIw==
X-Forwarded-Encrypted: i=1; AJvYcCUX11ocA+daWPPsL6EhwZp0+6kqFu/l8lBw0JFBPRK/vrKwOkTL8qEkxdtNAkiM4lFMnUgBjNht@vger.kernel.org
X-Gm-Message-State: AOJu0YyU0RwLyWNFcBnZsp3z8AC0Y+hKcnCmSZbhpk6WQ4rST6+e/DBr
	xStf8H3JwIZM5zWlh3/zTkX0Rmuat/YIRpgo8MNl3eJNWFUGMTljxU+BvlVlv+XMVIRjF/wPZnK
	i
X-Gm-Gg: ASbGncspQAoevxbOphz0Q8etx/+jgsb2874RG4IOxKHZPXuhWPh16xocwaXh29GWNGs
	r8bYLmw4M4+FNwv3AAoPBc286vndymgUDP/EUznWqQaiUjvZhqtltevm/Ld31Qh+wMLmVlCDwLC
	6TBiH4xz99+12hVzIhfUG+3s2qcSf9nT/heofo2HeXZO/TzkxcWGWvCDEefjnqu25gUSWcrG3Un
	fpsodtylsi5WyZ+anaMihLtCqWQdVrL+q61djAlH6AoNOEjK6re91ccHT5yYQR6exu5F8veuCld
	+6IbYVAivVxpzC8TELbyivhYoCuo48+rSgvvXAn/iEogt8lAEvU14gnB
X-Google-Smtp-Source: AGHT+IHlUl861ATS+5lGde1exQNbdlSZqu2v6KhlcyRXUnn6a3smR1byIDnkb0bs4C4wb0TnugzyDg==
X-Received: by 2002:a05:6a00:8d8a:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-73042aa9c5bmr1574969b3a.5.1738790106622;
        Wed, 05 Feb 2025 13:15:06 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdfecsm13313563b3a.133.2025.02.05.13.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:15:06 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfmjf-0000000F5sf-4Bfa;
	Thu, 06 Feb 2025 08:15:04 +1100
Date: Thu, 6 Feb 2025 08:15:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/34] check: run tests in a private pid/mount namespace
Message-ID: <Z6PU11K25tADRy4i@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406337.546134.5825194290554919668.stgit@frogsfrogsfrogs>
 <Z6KyrG6jatCgmUiD@dread.disaster.area>
 <20250205180048.GH21799@frogsfrogsfrogs>
 <20250205181959.GL21799@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205181959.GL21799@frogsfrogsfrogs>

On Wed, Feb 05, 2025 at 10:19:59AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 05, 2025 at 10:00:48AM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 05, 2025 at 11:37:00AM +1100, Dave Chinner wrote:
> > > On Tue, Feb 04, 2025 at 01:26:13PM -0800, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > As mentioned in the previous patch, trying to isolate processes from
> > > > separate test instances through the use of distinct Unix process
> > > > sessions is annoying due to the many complications with signal handling.
> > > > 
> > > > Instead, we could just use nsexec to run the test program with a private
> > > > pid namespace so that each test instance can only see its own processes;
> > > > and private mount namespace so that tests writing to /tmp cannot clobber
> > > > other tests or the stuff running on the main system.
> > > > 
> > > > However, it's not guaranteed that a particular kernel has pid and mount
> > > > namespaces enabled.  Mount (2.4.19) and pid (2.6.24) namespaces have
> > > > been around for a long time, but there's no hard requirement for the
> > > > latter to be enabled in the kernel.  Therefore, this bugfix slips
> > > > namespace support in alongside the session id thing.
> > > > 
> > > > Declaring CONFIG_PID_NS=n a deprecated configuration and removing
> > > > support should be a separate conversation, not something that I have to
> > > > do in a bug fix to get mainline QA back up.
> > > > 
> > > > Cc: <fstests@vger.kernel.org> # v2024.12.08
> > > > Fixes: 8973af00ec212f ("fstests: cleanup fsstress process management")
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  check               |   34 +++++++++++++++++++++++-----------
> > > >  common/rc           |   12 ++++++++++--
> > > >  src/nsexec.c        |   18 +++++++++++++++---
> > > >  tests/generic/504   |   15 +++++++++++++--
> > > >  tools/run_seq_pidns |   28 ++++++++++++++++++++++++++++
> > > >  5 files changed, 89 insertions(+), 18 deletions(-)
> > > >  create mode 100755 tools/run_seq_pidns
> > > 
> > > Same question as for session ids - is this all really necessary (or
> > > desired) if check-parallel executes check in it's own private PID
> > > namespace?
> 
> Forgot to respond to this question --
> 
> Because check-parallel runs (will run?) each child ./check instance in a
> private namepsace, each of those instances will be isolated from the
> others.  So no, it's probably not absolutely necessary.
> 
> However, there are a couple of reasons to let it happen: (a) the private
> ns that ./check creates in _run_seq() isolates the actual test code from
> its parent ./check process; and (b) the process started by nsexec is
> considered to be the "init" process for that namespace, so when it dies,
> the kernel will kill -9 all other processes in that namespace, so we
> won't have any stray fsstress processes that bleed into the next test.

Ok - that might be worth adding to the commit message so that anyone
looking at it in a few months time doesn't need to remember this
detail.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
