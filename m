Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B721767C
	for <fstests@vger.kernel.org>; Tue,  4 Feb 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738703655; cv=none; b=GAxXTQneCoGA0hZAG0R5dhdxI5le3hQWqYkLRnNpafdT9BHz269nkewceo/tEMyw2v2W1SXLEj/IeDSgjTE5rFSkKf1DVVVrjQZ65EHNQqzlGZIkEQkdkzannY5Awg2GPGhM0y7aedVTjum7vr2oRM8pjMHibqVd+SrsuW8BTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738703655; c=relaxed/simple;
	bh=4Ylt8Ia7CQKA49AbgNdndRrwDPWJoIPKiRBrhvirnls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFhLEf9G5HWU1+fo+6XpcZyzJ2CeyPfQF8IBMH4s+1p61I+/DtgdBr6BXY6VLHOmW0/DmG+nsFeVjIBn9tznRTJbzYJiambMg9lQFFzJ7qDlOGCpdxja3f5F/MdffeD8Ee99hyCfWIk1mTQIlDW0YjVKsdMXaQ6FvLX6ZoiqIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=SkCQBDvr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SkCQBDvr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f05693a27so15408025ad.2
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 13:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738703652; x=1739308452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dTURmX0OMFrWDWZM1e7A94oGdcNwV3azk+DcaUDav5s=;
        b=SkCQBDvrHmpse+WZwaL1V+XZaxQIA5C4kJwlbTowY2sBDXB9QF1DjVlE9W3zhjRwBh
         rQ5febU23wSNSUG7IVctSUhDpd8j7SVILky708qBScKXHqbrFsntGZROZTsn0Tdp446I
         yqaxZOoBrMGvwAkYZ1OINRQwHiAri9MR/lQ8+PLShGKGiPhgd2Ta8iDQNcUJWdV6Jhlb
         HETKWez9z42jdzbLoAhWCa3KTVBQzkgvduS6ZCae0iwKiwlLMsm3TiT4u+TQWa80yt0w
         I+XBF1shdD6T0IGNVx6wqbW6ZcksjiGXRV0AyvlMXc5hfduoSWQPkGqe2LryoJfos3XB
         hlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738703652; x=1739308452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTURmX0OMFrWDWZM1e7A94oGdcNwV3azk+DcaUDav5s=;
        b=PV7TaA/mVxLRbWLFcHWKHxafyEBkAAHDRsjKmMs8tM2+kxFdSa8OVmBRQzZidL2Ac1
         yqqZWv5uxL9lZlD92wV2L/MrC2S9OOk3Oq0jRMIeSH6TcZctDuMaZtjfEg7VHLrI4zQY
         /xo7qMlNYXmXnvGnTp/zfDWpDEVaJfBWPc9Yi+ZGeWVGceYGSbYSeWWg5gzk/GpaK+UH
         HMBvXxcvKpKrbAY+YVVYM2E1vNRz3crKUwluijUydu4aD5QThnl5bQTExHEw0eBuB26r
         QyEgomt2Gmg9vekyVtPtNgOSqnd27uvFZ13EZq93lUxDZjtHKLYuzDmj2lZJ6Cn3oPN2
         M35w==
X-Forwarded-Encrypted: i=1; AJvYcCVA9NcLa4SN04BSI35Tq+BKFFCYbK9QEBKBnfWBRGlhId5BOqHLxmY0JVEIoRrWloPlmx37twpw@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9u39QoRtLvvcoVrUQmjeqykeeqphpJ+qsnqAIpxJkE19WVPO
	hDvivwomuaLGm+7J6NGDYSx1fjFeqvGNu3P2fa5sJwZcrFQD/fCUCfCHQeEiRjM=
X-Gm-Gg: ASbGncvH3Ze/aTeJxs5eAblq1KdczcAxfYCSHXWIXNCzHWKIEFl385byaYh5Qd+Q0/b
	+RAiXIGLcEhNRFRXdFna0fjmRXnEZPdOd+jmtnWZ3vCVjbCsCQLn4ppW0HwIZ/+N3Sb2T9ANmS1
	8JkKWVga3kUJDPoLMGrdynVqj5EUE7xwlqYNKnWas5CYblNrSB0PT1PX3WuAyOXJPifgu2poIDo
	Y0wCRLBH7jKGRbYTJUjX6efmhQgCZqxtrCoQIqCy+/GShMlYTqDXMZnRoUnrUbfqPvkrJzuzenr
	FRBlDLs0o31hVqfMn/0Z20k4A9sT6KtSNCEdpWwyHylQJFBfLbI/JJFF
X-Google-Smtp-Source: AGHT+IEeR++U0VebrZO3gKxUGf8OR+3CkpknBHWLWvvPOg70iSSUyhxQnEM//n5EmVFVV6MHIxL4qg==
X-Received: by 2002:a17:902:ccca:b0:216:431b:e577 with SMTP id d9443c01a7336-21f17ed2f4fmr5463175ad.51.1738703652539;
        Tue, 04 Feb 2025 13:14:12 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea893sm102752915ad.127.2025.02.04.13.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:14:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfQFF-0000000EfRd-1LO2;
	Wed, 05 Feb 2025 08:14:09 +1100
Date: Wed, 5 Feb 2025 08:14:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: Boris Burkov <boris@bur.io>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, fstests <fstests@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
Message-ID: <Z6KDIZ1theZm9rox@dread.disaster.area>
References: <20250203185519.GA2888598@zen.localdomain>
 <CAOQ4uxjiYQHUVkYnv5owPHHvs6BP128Zvuf_LGciENjyJkLa6w@mail.gmail.com>
 <Z6Fl5d34STRzC3K2@dread.disaster.area>
 <20250204195846.GB3657803@zen.localdomain>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204195846.GB3657803@zen.localdomain>

On Tue, Feb 04, 2025 at 11:58:46AM -0800, Boris Burkov wrote:
> On Tue, Feb 04, 2025 at 11:57:09AM +1100, Dave Chinner wrote:
> > > > - were able to reproduce the bugs with a predictable concoction of "run
> > > >   a workload and some known nasty btrfs operations in parallel". The most
> > > >   common form of this was running 'fsstress' and 'btrfs balance', but it
> > > >   wasn't quite universal. Sometimes we needed reflink threads, or
> > > >   drop_caches, or memory pressure, etc. to trigger a bug.
> > 
> > That's pretty much what check-parallel does to a system. Loads of
> > tests run things like drop_caches, memory compaction, CPU hotplug,
> > etc. check-parallel essentially exposes every test to these sorts
> > of background perturbations rather than just the one test that is
> > running that perturbation. IOWs, even the most basic correctness
> > test now gets exercised while cpu hotplug and memory compaction are
> > going on in the background....
> > 
> > Eventually, I plan to implement these background perturbations as
> > separate control tasks for check-parallel so we don't need specific
> > tests that run a background perturbation whilst the rest of the
> > system is under test.
> 
> I think that a framework for introducing background perturbations while
> running tests is definitely what I'm getting at. If check-parallel is a
> good version of that, then that sounds great to me. I am particularly
> excited about your point that it will smash together *every* stimulus
> with *every* test. I do have some questions in my head about how that
> would work in practice.
> 
> My main questions/concerns are:
> 
> How much do you randomize the interleaving of tests? Does
> check-parallel run them in a random order?

Same as check - the "-r" option will randomise the test run order.

The test run order is also somewhat randomised by default in that
it sorts the test run order based on the runtime of each test in
the previous test run. Hence test run order is not static - it
generally runs long running tests before slow running tests, but the
exact order is not fixed.

> Similarly, their durations are not at all tuned to maximize
> interesting interactions. If test X and test Y would collide on some
> faulty interaction, but test X runs once in 1 second, then you would
> likely never see test X interfere with some interesting moment during
> test Y. Are you considering feeding the tests back into the run-queue
> as they finish for these stress style runs?

Not yet - the infrastructure to directly manage and run tests from
check-parallel is not yet in place. It currently generates a test
list for each runner thread then executes that via a check instance
per runner thread.

I plan to have check-parallel execute tests individually itself by
factoring the run loop out of check (similar to how I'm doing the
test list parsing). Once there is direct control of the test
execution, stuff like dynamic test queues where runners just pull
the next test to run off the queue and they keep going until the
queue is empty will be possible.

> It seems that the two objectives of the test harness are sort of in
> tension with using check-parallel to stress things. On one hand you
> want tests to independently succeed or fail and on the other hand you
> want noise from one test to disturb the other.

Yes. Tests are largely written such that they don't interfere with
each other.

> I fear more of the
> failures will turn out to be "Oh, well, when THAT happens, we would
> expect this condition to be violated". Especially for the more "unit
> test" style fstests that carefully use sync to check specific conditions
> during a run.

That's why I currently have a "unreliable_in_parallel" test group
definition and check-parallel excludes that test group. There's
about 20 tests I've classified this way, most of them xfs specific
tests that are reliant on exact fragmentation patterns being
created. This tests are perturbed by things like sync(1) calls from
other tests which results in a different fragmentation pattern than
the test expects to see.

In each case, there is a comment in the test explaining the
condition that makes the test unreliable in parallel, and so we
have some idea of what needs fixing to be able to remove it from the
unreliable_in_parallel group.

Essentially, I'm using this as a marker and note for future
improvements once all the (more important) infrastructure work is
done and solid.

> This variant also feels like it would be at the extreme of difficulty
> for attempting to distill a failure into a reproducer.

It's pretty obvious when a test is doing something that is
influenced by an outside event. The biggest problem for debugging
them comes when the test failures appear to be real bugs (e.g. all
the weird and whacky off-by-one quota failures that check-parallel
triggers on XFS) but they cannot be reproduced when the tests are
run serially.

.....

> > > > And of course, I would love to discuss anything else of interest to
> > > > people who like stress testing filesystems!
> > 
> > Filesystem stress testing by itself isn't really interesting to me.
> > Using filesystem correctness tests to create massively stressful
> > workloads, OTOH, attacks the problem from multiple angles and
> > exercises the system well outside the bounds of just filesystem
> > code.
> 
> From what I see, today we have a handful of tests which race fsx or
> fsstress with 0-2 operations under test, and you are proposing using
> check-parallel to hammer the computer with the entirety of all 1000
> tests in parallel (awesome).

It's currently running one test per CPU in parallel, not all at
once. Many tests run lots of stuff in parallel themselves, too, and
some of them hammer large CPU count machines really hard just by
themselves, let alone when there's another 63 tests running
concurrently....

> I think I am proposing something in between
> where we run fsx AND fsstress AND ~10 known scary operations.

Write a set of tests that do this for btrfs and put them in the
auto/stress/soak groups. Then run 'check-parallel -g soak,stress
....'

-Dave.
-- 
Dave Chinner
david@fromorbit.com
