Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639CD134BD
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747801953; cv=none; b=YDPzvFKXTW4dGD5R/jxS9fnI4oREASeK2gu67UYX6+hYacjfdFoUUzQ2SFUOTiCfS+/f6OcLDYV5WtgY9igiXwR8SwM508bXSftiTCLBSjerugQPOS5nAQGw9DlbUlYTHazLqLaaIH3L0PpBvkLZ08Q+GDV972xEp1070iw+z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747801953; c=relaxed/simple;
	bh=ZSZRZjt1Qkd4IhzO7PdARrJl95qrK3t+7Kz2SgabQvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNnNmQW+Yrqod6jK6UVykDiRPVC3YMCdxgubPNAUOQiQi7TQ27GXmJsmE2umG5nVsHoWmydJeJlHPU3b8LCa5a9gSHqJXoMJ5+asUPyTogZ5oZKE12fHDTJXyJqF6Cz3VfA3igQKTJxj8ADLpYDieYzPjCsEAgUF3bScAD83HIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=qBv44HKd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="qBv44HKd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-232059c0b50so34902775ad.2
        for <fstests@vger.kernel.org>; Tue, 20 May 2025 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747801950; x=1748406750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLQguKgSnYArRgihq6BDuk7LDrB/G4SegNE1x0MO0h4=;
        b=qBv44HKdPPfF/gVsNcQWCo25/556PoyHyB6RVnQCYitu5V4SKxo74U5416u4jq+q4A
         QWxKIPn6dE/B/e1fp0Epq/iG14XhLc5j19mSdB2IFXtgJpfxAaSARf7pqY+WOaJGLpyV
         UOan6WBwzmitnRHlZIKgvSyeOpWsnIX7Qhfgg9n5MjgYfkGPzxiI759m1pyxnLl+p5Ot
         oJpQ4+5ezOGuKc4GTuDg16XbqICGB6vV2QtK7twRlJD8y7ZxQ3ZiTl+DKo3NCYEKonqt
         H9kwdWXenomBs8Hgd30BN5NAYyKIs2D9S+mCN0EpQCt0Dvxml2UYV6Sgi7wZY1XPfUdi
         MjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747801950; x=1748406750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLQguKgSnYArRgihq6BDuk7LDrB/G4SegNE1x0MO0h4=;
        b=YWxmmSt1BcEpcNooayGtLmb0LM+pqer0oRy20O2nL9f6tMMEIAfrA7pcKkcAq8z/XQ
         hOTjxsP/zn9nAihSpzz/9744wqLsC9I+Xj8tlJfzmxJTB/4o+bX+sf6Les0SP/gh5QcE
         kmzv0sl0FMjfigBhmJtX+s11co3SHvnilgaOZYHUVPm44eTksGerO+ICBrSmMHHo8crR
         tMqFZnYDCUzrR6p5T1DmuRPtyXs4ZMFAnkwD2/gl0GSGHK6aJXEEjXXDgXBV+tGZVad+
         URwrBw8pGoZHCelY5KaBYQPuzegkMmZsd4nmxsod9KV4XhOn8+6DZQAA9KYJS9J/SQK9
         UZbw==
X-Gm-Message-State: AOJu0YwANRT22fG+DjEgJkd9uJH0i8xy9KuuFjgHeUqaJlHAT4PlgQlW
	PhTNzN26laGDFRd5CDh7mtAxaf6K3iAyhUGt3TFaAh+q7dXIRS2WT62KNfr24a7wUNU=
X-Gm-Gg: ASbGncsv20vwVH3LvGrhzhCQrOGaias3MkhLpbHVJtWI9MDAaIeL1rhYdbOPmzjddwh
	1cg4bXWybnXKmjL11K5P0D4lvc/kCHnPBEr0o7WXItXLIpeet6ENDMLv4eVMx/89F/19WSLkEg2
	JsV3TiQPxaGMhmqd/ZLd2maifEbcTX2pKK3dWt4XQcaKDvTUm2nC78RQIYHNFehLFCcf1su1F5X
	Ym+yHMnj2KTcCkWakxdfEkO1qX7cWodRgUSP0rVUSeSfPePuyFDftpEBaCqv4fohFogU0W9a8nE
	u/L1JWNTEETbFC2NPlFm0dINUmCtB03A2+Drm0wBdJl2fhmRDjQhQU8rCBm6P9XmM0jxjaiRlUX
	rB1dP12/EfvSnulLwqFIPlFQeMi8=
X-Google-Smtp-Source: AGHT+IGS3DqsXeYBBqL7bW4HR4NdXOXJDtdfHf4cFJ1o4GjGMpaasnRHHqgikH2BJZKe+czju8Kj6w==
X-Received: by 2002:a17:902:ea0c:b0:22e:61b2:5eb6 with SMTP id d9443c01a7336-231de3030bemr270343535ad.15.1747801950500;
        Tue, 20 May 2025 21:32:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebba01sm84201175ad.208.2025.05.20.21.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 21:32:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHb7z-00000006AeH-1TuS;
	Wed, 21 May 2025 14:32:27 +1000
Date: Wed, 21 May 2025 14:32:27 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 07/28] check-parallel: adjust concurrency according to
 CPU count
Message-ID: <aC1XWzTFPUa_7WS_@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-8-david@fromorbit.com>
 <e434a271402602fa7ec5efbcd9d92329ecdd4614.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e434a271402602fa7ec5efbcd9d92329ecdd4614.camel@gmail.com>

On Wed, May 07, 2025 at 12:15:09PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Concurrency is currently hard coded at 64 worker threads. This is
> > too many for small CPU count machines; the idea is to create a
> > sustained load of roughly one test per CPU as they are mostly single
> > threaded/single process tests. The number "64" was chosen because
> > I've been developing this functionality on a 64p VM.
.....
> > diff --git a/check-parallel b/check-parallel
> > index cb5d6aedf..0649a417f 100755
> > --- a/check-parallel
> > +++ b/check-parallel
> > @@ -10,7 +10,7 @@
> >  # the loop devices.
> >  
> >  basedir=""
> > -runners=64
> > +runners=$(getconf _NPROCESSORS_CONF)
> Minor: Not related to this change. Maybe we should have a _get_nproc()
> just like 
> _get_page_size()
> {
> 	echo $(getconf PAGE_SIZE)
> }
> _get_nproc()
> {
> 	echo $(getconf _NPROCESSORS_CONF)
> }
> and replace all the $(getconf _NPROCESSORS_CONF) with $(_get_nproc)

I have thoughts on that.

I think determining test scaling based on the number of CPUs in the
machine is wrong. If I run in a cgroup that limits tests to 4p on a
64p machine, then fstests will think it is running on a 64p machine
rahter than on 4p. That's ... not ideal.

I think there should be a global variable that defines the
concurrency that tests should use to scale load/processes rather
than use the CPU count. Then check/check-parallel can set the
concurrency as they desire and we no longer have to worry about
tests creating excesively huge loads on high CPU count machines
because they were sized to load a small, low concurrency test
system.

i.e. I intend to separate the concurrency with which check-parallel
runs from the concurrency that individual tests use to scale. For
check-parallel, I am thinking of fixing test concurrency scaling at
something like min(nr_cpus, 8), whilst the check-parallel harness
itself uses nr_cpus to determine how many concurrent runners to
instantiate.

> >  runtimes=()
> >  show_test_list=
> > @@ -30,6 +30,7 @@ usage()
> >  
> >  check options
> >      -D <dir>		Directory to run in
> > +    -t <n>		Number of concurrent tests to  run
> Minor: Maybe we should mention the valid range of <n> i.e, 0 to 1024?
> >      -n			Output test list, do not run tests
> 
> Nit: Maybe there is some spacing issue here? "Number of concurrent ..."
> and "Output test..." don't begin together.

Not that I can see, I think this is just email quoting and tabs
doing funky stuff.

> >      -r			randomize test order
> >      --exact-order	run tests in the exact order specified
> > @@ -81,6 +82,7 @@ while [ $# -gt 0 ]; do
> >  	-\? | -h | --help) usage ;;
> >  
> >  	-D)	basedir=$2; shift ;;
> > +	-t)	runners=$2; shift ;;
> >  	-g)	_tl_setup_group $2 ; shift ;;
> >  	-e)	_tl_setup_exclude_tests $2 ; shift ;;
> >  	-E)	_tl_setup_exclude_file $2 ; shift ;;
> > @@ -111,6 +113,11 @@ if [ ! -d "$basedir" ]; then
> >  	echo "Invalid basedir specification"
> >  	usage
> >  fi
> > +if [[ $runners -le 0 || $runners -gt 1024 ]]; then
> > +	echo "Invalid thread specificaton: $runners"
> Minor: Maybe we should mention the valid range of "runners" in this
> error message (0 to 1024)?

/me shrugs.

It's an arbitrary "check-parallel won't ever scale past this" limit
because the diminishing returns from added concurrency that Amdahl's
Law define is already kicking in at 64 threads. If you are running
check-parallel on a >1024p machine, you already know enough to be
able to look at the source code to determine why the error is being
emitted. :)

-Dave.
-- 
Dave Chinner
david@fromorbit.com
