Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947568467
	for <fstests@vger.kernel.org>; Wed, 22 Jan 2025 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737519137; cv=none; b=RjLsjIak4/KA9dwZ0/jFPA1dDugKSCVKjjvvRVseTzTBRE0jopmJFiu03UfYmGuULJQ4CNEjSOj4NpWic8BrsDWySCjCFtSkGplFIBRM9HL1hHNeMYLxlK1Thhm+SHVyzRKQ/n3OVHysQFCjy0mZGSWNVqQhtiR9TieEtezzn0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737519137; c=relaxed/simple;
	bh=P9Ov4Px9oBRh9XzWojXq/K6uJD+gCDAt93LjuA4QWwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3WnjWe+ZgpB1NSDpCSPsF7MfZVQeY7Qw5tA3nICgdx5UqZ6+7LEfl1uR7/bE1kuOxtqEv067yJikABJSzSSvsucvA447s9FSdIwBbcGsw1KxbugMKHJuXWA7RoZ0CZJosvjWO4h7euiB6k0rFaYvCTasoH1nAYNn3fmfjhCuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1+mbwipv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1+mbwipv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2167141dfa1so8204595ad.1
        for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 20:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737519135; x=1738123935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFVZB5FaMISWLHki7WyPInxNBUdbkD5mHv69/3iDKn4=;
        b=1+mbwipv4eczwKvGdzls/CLJMAgh/kdAhu53ZcrohBhUD1DRSV3iHKdo6ZFHRSf+Mn
         JvYw96vACvcqVYssoSpk7Z+eG49oyEAKcaoVV7mgvAd3fRZBPU/WYl45bbUgGz0JIu/f
         yPUjdwK2O5TyVK5q/8GdLL4D7xrqyRfdIO+I+155FjLhx84eQ+jM+n9EZIMB2gqjqKd5
         Sex3slfpCFvsf/lmaCWIgLSiMyffjaY+tGFP5XX4fdEjN5Nb8j7SJgWJ/de5EN9ECsHs
         r3JND2pCWq5Vf/9ZnE/u/DnPoLiw6xAgrQT+1RaCca01H64eRg6ImqvTq3400N86gGeg
         fa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737519135; x=1738123935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFVZB5FaMISWLHki7WyPInxNBUdbkD5mHv69/3iDKn4=;
        b=HZYKaZ3GeYomH4ylJL7ROC35ahnI9/lLcf0QsYMijUMp3pjzDkvsH3qa+ZqrJkZIMO
         m96yJAY7S21qIVNTg2SGYGX1V8SIuz7Vu9k3MmaXa8llWGkwKTOGMNj/KAfLksYkBJqw
         dr3fyMMvr0+u3xhDovepSP+pqbACCgWsHqpDsHa0akGmuL0fTgBswzVGyhv725RQwbzL
         qhYKnk6wuQ5YOU6vv5HEI5PmV9DcrYJX9LKQETlEQfEHOaPed1uFDEuD+Xj1pV9+ak9h
         eGmcz9LzG2NvQRqbeVSAQzrJDE9X/sBRR9G8RyvP6eBeNlxqCVcKSK30waAHLKk/7yc4
         VH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXvIfVp/5jTfnE2OkA/32jke8HjG0wZ7ICmel3eFxOMB70rQnDuyPGi+G+Tjjn3W3VX3G6kf1c@vger.kernel.org
X-Gm-Message-State: AOJu0YxmjCr50A/7zLjECYoWu4EeuGC13xYN5yLN7JKbeGmbROCzPC26
	eetrO80gNvmOgtJzt5H9tbrWfmjtL17Ig96M/4opN0fVxGzlCKnGV5ZerX2pG6lCfPKBxaI3E8s
	T
X-Gm-Gg: ASbGnctu+BgymtKOPmb8TFVmh+RU8JT3Pt8i1UnthSMFr+5u3cP0lEzM35BKAWJtegt
	3XkbrQBo0PQ1ZNivObJhhiL+V+m8x2Fae9HNMGgrYXDTUdid80CK2X6OPkvSMG6zvAANGw9tIkY
	WBR73+DhG1FFLBg7kmdVIYXd+ABAhRNRK3kWm6PoURa2aU75/nQ8NwitYJ9GhZlKnXWMDy1DT86
	CudWnNejuQcKdOZ9MnzMh9oylAYLuqETLZyL+KrE1MIzXq2yCsS7/BfTfhAnSM4BqKNkUSw2wrI
	noekVb+HrtdaVEbDmVdkEg+Z1tPZ/1+DmnFRU9z+Y3ihGw==
X-Google-Smtp-Source: AGHT+IGSx2HrbJNxcB3zckZw7AwAGwNRu9wF7Dy+Al4+oPC8JWG59ZhasBfDOoI5PNWsRso2L2allA==
X-Received: by 2002:a17:902:db08:b0:215:7287:67bb with SMTP id d9443c01a7336-21c35b16c8cmr326689165ad.0.1737519134736;
        Tue, 21 Jan 2025 20:12:14 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d42b8e1sm86277325ad.250.2025.01.21.20.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 20:12:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1taS67-00000008wGg-1C57;
	Wed, 22 Jan 2025 15:12:11 +1100
Date: Wed, 22 Jan 2025 15:12:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/23] generic/650: revert SOAK DURATION changes
Message-ID: <Z5BwGzOfPaSzXyQ3@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974273.1927324.11899201065662863518.stgit@frogsfrogsfrogs>
 <Z48pM9GEhp9P_VLX@dread.disaster.area>
 <20250122034944.GS1611770@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122034944.GS1611770@frogsfrogsfrogs>

On Tue, Jan 21, 2025 at 07:49:44PM -0800, Darrick J. Wong wrote:
> On Tue, Jan 21, 2025 at 03:57:23PM +1100, Dave Chinner wrote:
> > On Thu, Jan 16, 2025 at 03:28:33PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Prior to commit 8973af00ec21, in the absence of an explicit
> > > SOAK_DURATION, this test would run 2500 fsstress operations each of ten
> > > times through the loop body.  On the author's machines, this kept the
> > > runtime to about 30s total.  Oddly, this was changed to 30s per loop
> > > body with no specific justification in the middle of an fsstress process
> > > management change.
> > 
> > I'm pretty sure that was because when you run g/650 on a machine
> > with 64p, the number of ops performed on the filesystem is
> > nr_cpus * 2500 * nr_loops.
> 
> Where does that happen?
> 
> Oh, heh.  -n is the number of ops *per process*.

Yeah, I just noticed another case of this:

Ten slowest tests - runtime in seconds:
generic/750 559
generic/311 486
.....

generic/750 does:

nr_cpus=$((LOAD_FACTOR * 4))
nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)

So the actual load factor increase is exponential:

Load factor	nr_cpus		nr_ops		total ops
1		4		100k		400k
2		8		200k		1.6M
3		12		300k		3.6M
4		16		400k		6.4M

and so on.

I suspect that there are other similar cpu scaling issues
lurking across the many fsstress tests...

> > > On the author's machine, this explodes the runtime from ~30s to 420s.
> > > Put things back the way they were.
> > 
> > Yeah, OK, that's exactly waht keep_running() does - duration
> > overrides nr_ops.
> > 
> > Ok, so keeping or reverting the change will simply make different
> > people unhappy because of the excessive runtime the test has at
> > either ends of the CPU count spectrum - what's the best way to go
> > about providing the desired min(nr_ops, max loop time) behaviour?
> > Do we simply cap the maximum process count to keep the number of ops
> > down to something reasonable (e.g. 16), or something else?
> 
> How about running fsstress with --duration=3 if SOAK_DURATION isn't set?
> That should keep the runtime to 30 seconds or so even on larger
> machines:
> 
> if [ -n "$SOAK_DURATION" ]; then
> 	test "$SOAK_DURATION" -lt 10 && SOAK_DURATION=10
> 	fsstress_args+=(--duration="$((SOAK_DURATION / 10))")
> else
> 	# run for 3s per iteration max for a default runtime of ~30s.
> 	fsstress_args+=(--duration=3)
> fi

Yeah, that works for me.

As a rainy day project, perhaps we should look to convert all the
fsstress invocations to be time bound rather than running a specific
number of ops. i.e. hard code nr_ops=<some huge number> in
_run_fstress_bg() and the tests only need to define parallelism and
runtime.

This would make the test runtimes more deterministic across machines
with vastly different capabilities and and largely make "test xyz is
slow on my test machine" reports largely go away.

Thoughts?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
