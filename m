Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B92147F9
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790022; cv=none; b=fYFJJsBNeiWmQJd09OnP1MALeBxsFxjVAVW5E03Dl4m3rw6BmaU1tFkIS4uhcrmq/ves6j47i/IaJRgvmk6jejtr2aREPhntARcWBCWZx1HEM6zl4YXhgrSVoBwP575ufRj9pE2X0mneG8wU9oPWEzcGb7pvxk2UBGgu+4QQIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790022; c=relaxed/simple;
	bh=ho8HADNRzF9kUQpnLLOZO5Qgx0/gFmGprNXyMnSU+rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfdAa4XKubQ9zoX9lYHdL/SqePgE9HNuMpyNo/dTG7k7ty2pq7zJkmp8yWVlMZZ0dXBqx4HBFLxH4AiQVJbJYx8+qIvVWzswVEwPUlnIYhBbtcEvvPmge54IvvS15suUqo4txvGg6wU2LYyd3C9P3MtHG8lUdSeYjTwmfT7Rpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HOGvImEA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HOGvImEA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f20666e72so5419435ad.1
        for <fstests@vger.kernel.org>; Wed, 05 Feb 2025 13:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738790020; x=1739394820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57335S6mpHTrZHgMlox7oo8dpO4CvdNzpGIpMwj9RE0=;
        b=HOGvImEAijwBsMqzY0yZogwuCa1dcT5ftwywMU5H8lxh69ckBitMHmUuoCW6iskhSr
         PEZ8YObgotUfTeDAkB3Fxtw0A6yQ8tjYYtJ2ieZJi0WyQwyNtVFzDmsvW7hyY3ab5MhK
         G6svkcjIIF2rIZ7Vd96/5a9voW0X1VsatA8iJBdI5HKIlDQa+u58BRkq4eUCKkvlxduf
         Cy8o9QdLLBOS4g/L21NutVSZjzsX63C4HDmZ9LforgyKUA+LzSqTdsYe52vsdtJhs6+g
         m1S8JIIZzRahTRNJXAfw0aekimkwFFZtNM3wbZJr6Bw77xyPnOesjVJzyG2w1zHqha3t
         dWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790020; x=1739394820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57335S6mpHTrZHgMlox7oo8dpO4CvdNzpGIpMwj9RE0=;
        b=iu9oyG3Q48BUC8MStyg2LBblyheWwIEAq3/iTPzvVEuAaBxkpQOxT+oSCmcooTghDO
         REiYQPLr4kMIUXkUbZHS3AG31SEwHNkQNp89bEF2/F5c8FsCd5mKVfpP5wavhqmAu0qy
         lwaf4MDLpBUz2REkiJ3xwSHpKj4YkgM+3/2FhMcUxmR6zQMhGV4eYmJk95OL6u12qhuF
         uCqzAusqLhXt0lPn5m5AQxjFeM/Bw9jRCmck+Jaafdr3DkR1Y1XTfq5Jq3yRHkbwrcHI
         MgCB8mYWaj0NWweaIDDBCoIVMmk2fh4hD20utrQ13uo2aLgYVihX5W9nBT0cJ3hWBZt6
         Wcrg==
X-Forwarded-Encrypted: i=1; AJvYcCVmwhibv18ZRjJPviSvPfPDy4rsVm4020BU7atLwj4UxnpjrpfWxlOz2RVdfIeeS2bFhYoyOdQE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Mih9hyKbhTsj0woJMnwFZrHn0bEti9Oe5WFQ4lP7EhjCmo33
	9EeVZ4Pc/PDkDOXea1LEYcXphIXLpQKuchtl1P6UbXvD7DSHy/6LjBR70UYk2dU=
X-Gm-Gg: ASbGnctw3LTkC2jhYeZllAqyW392YLxolmJxqkgPV0zv8qmBoGLP2L4eB4lYKeajvuQ
	gxQpAC4f0lzR5l4F+cEPgg12MRPIl7fEpl3k2TcZ7aKbNxDgdGthb0B+L4vH4n2OkHP0SH7iLsP
	4EeNkwGGPVQyBFsPNdEqtRaeemgTX/EsFWwRnXJHrQ4UwJXv9i0of4ZdwyoNH4XqZoi6EcMqG6G
	kusLbdiRvVOHLdZG5LXtyTXfngBYq8RNjzCnh/lhPZ+RyPwF2D/ao/xgRIiWlTG8BVmgDRi9pmJ
	/FX07NTmKWu5/kRZFppSaJZM0Rq0y8SXe8bPWGkuVmBpX3QFsjLqltyp
X-Google-Smtp-Source: AGHT+IF2BsThX+mdEviygmn+ZP39V0wH6HsDdie/ol0M/7CJS8zgFcPiDfpf5OwpuP5tH1o0RlSHVQ==
X-Received: by 2002:a17:902:d4c7:b0:216:779a:d5f3 with SMTP id d9443c01a7336-21f17e45b8amr65935985ad.14.1738790020624;
        Wed, 05 Feb 2025 13:13:40 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e40ab8sm2059259a91.42.2025.02.05.13.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:13:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfmiG-0000000F5rF-2SVA;
	Thu, 06 Feb 2025 08:13:36 +1100
Date: Thu, 6 Feb 2025 08:13:36 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/34] check: run tests in a private pid/mount namespace
Message-ID: <Z6PUgAIQ6qYM3Zgt@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406337.546134.5825194290554919668.stgit@frogsfrogsfrogs>
 <Z6KyrG6jatCgmUiD@dread.disaster.area>
 <20250205180048.GH21799@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205180048.GH21799@frogsfrogsfrogs>

On Wed, Feb 05, 2025 at 10:00:48AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 05, 2025 at 11:37:00AM +1100, Dave Chinner wrote:
> > On Tue, Feb 04, 2025 at 01:26:13PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > As mentioned in the previous patch, trying to isolate processes from
> > > separate test instances through the use of distinct Unix process
> > > sessions is annoying due to the many complications with signal handling.
> > > 
> > > Instead, we could just use nsexec to run the test program with a private
> > > pid namespace so that each test instance can only see its own processes;
> > > and private mount namespace so that tests writing to /tmp cannot clobber
> > > other tests or the stuff running on the main system.
> > > 
> > > However, it's not guaranteed that a particular kernel has pid and mount
> > > namespaces enabled.  Mount (2.4.19) and pid (2.6.24) namespaces have
> > > been around for a long time, but there's no hard requirement for the
> > > latter to be enabled in the kernel.  Therefore, this bugfix slips
> > > namespace support in alongside the session id thing.
> > > 
> > > Declaring CONFIG_PID_NS=n a deprecated configuration and removing
> > > support should be a separate conversation, not something that I have to
> > > do in a bug fix to get mainline QA back up.
> > > 
> > > Cc: <fstests@vger.kernel.org> # v2024.12.08
> > > Fixes: 8973af00ec212f ("fstests: cleanup fsstress process management")
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  check               |   34 +++++++++++++++++++++++-----------
> > >  common/rc           |   12 ++++++++++--
> > >  src/nsexec.c        |   18 +++++++++++++++---
> > >  tests/generic/504   |   15 +++++++++++++--
> > >  tools/run_seq_pidns |   28 ++++++++++++++++++++++++++++
> > >  5 files changed, 89 insertions(+), 18 deletions(-)
> > >  create mode 100755 tools/run_seq_pidns
> > 
> > Same question as for session ids - is this all really necessary (or
> > desired) if check-parallel executes check in it's own private PID
> > namespace?
> > 
> > If so, then the code is fine apart from the same nit about
> > tools/run_seq_pidns - call it run_pidns because this helper will
> > also be used by check-parallel to run check in it's own private
> > mount and PID namespaces...
> 
> I prefer to name it tools/run_privatens since it creates more than just
> a pid namespace.

I'm fine with that. It was only the "seq" part of the name that
triggered me.

> At some point we might even decide to privatize more
> namespaces (e.g. do we want a private network namespace for nfs?) and I
> don't want this to become lsfmmbpfbbq'd, as it were.

*nod*

-Dave.

-- 
Dave Chinner
david@fromorbit.com
