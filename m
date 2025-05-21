Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE95DDCD
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747794626; cv=none; b=pBxGZDcaT7qvJCV2+qmIwnDWxKWKeOkJH8GVPqOJWXHSzFiAQWeCXiJDm1opBvmrxqfID3oopaGJDoCnEFylKUqxugabQcVUq8alFyyRygVpNw5IZTVcl6dpB2k1V9rZg3whvlsAMnGQ5cS2KbUoizbVedRJOTwf65OkMfgmff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747794626; c=relaxed/simple;
	bh=EuVi113LfA9+5Y7RJJliio3MSOdwUpnbGT7fQFF6O88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iom9A6ELxse52LPriVvc87fB1rraIWzYGQ5sZ3R5uRJK+PWZXwEMaQdARQqdOliEt08RI9zdbGXTPgKr5Anodn8GN8S+VpnR3zqcTR7avVs3k/Dx0E6wLhsm1WnYQEnXplGwKBrS+MJUvzQ112havnep4hYafZhbOhmBAkK4RC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wwQuA1vi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wwQuA1vi"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30e9b0f374fso4881195a91.3
        for <fstests@vger.kernel.org>; Tue, 20 May 2025 19:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747794624; x=1748399424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYHIo0jG1BLXoymsszaGf14US148fSn/3tJiZXrEVAY=;
        b=wwQuA1viwE+MTjAtpv2RLqHSI3R6PU56GEvqjLevKUJxAUh0GZt60m756/7FyXjzp/
         Kkm/uLJDWo/rrmtaO8BEYOT2ZTLle5Biq877/vFumBxZxDsHRvb7O1PXathz6eryv5HB
         1OUxqCkaDEFXEoJHg0R0WGx05o/oDO1dC46myCfyyHLrUZLuIv2jfKyZ9EhBrRWIjge7
         Ba+Ube7I9Ol9rbH7ZYq32BhTEM1iv6u797eWbyd492vVxv5WUS6bsJDOo5XFUWoTKxVm
         JQTpvyrMO2t0mv+xqLXrOqG29UieL+xbqZ+CAcqtXlGi6Y5CCxA7aFkt1GRmLRojXKNk
         yYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747794624; x=1748399424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYHIo0jG1BLXoymsszaGf14US148fSn/3tJiZXrEVAY=;
        b=jbfv7UNrVwN7/9zJiNtbHjbdr62FryNIlLXAW/j69taKia8grmQtxzahF9oKwKowXG
         Dq1zdbKyzoZ988i03iIGfnGwT2mZ2+kB9gS8GlIxDvKboEnmKVr7QArpKHojDbSq2SBi
         xs6YghytGYVeJFwxuDajhlp5b8YMnUJZ9v266MdmMRH41iFbSrWIaeV+MEt/2DxE6rwM
         W5vS7pRtuWh6DLn+Utu6hNUSNKbhQ0ljGqRRN6dPvOBL8ywQRTyHxTRpn2nteMVHUjE0
         Z6ZazfSAvHofhn3rQV7tCg7hmVm9XPL8UOvQtX8toOTrMaJEPyXBe0QZGiiLPCZu/Tie
         iWDQ==
X-Gm-Message-State: AOJu0Yx5+Msae8N5am5m0OEXK48aiFfv6eVIUggIATej2K4iHPxHD4xY
	qBhBFu5ypNeeGiipQe5vtirNEEGFi9wFk03I14DCQWDDfucG/wX0xnVrZ6ofcW2ayVQ=
X-Gm-Gg: ASbGnctaFRgec640SKBG6mWyr1VMd9Up1rmo362YxG+8klOCMXMhsLOxRIVf/6jODJ0
	CF6KGWj8Pie72cl2iJBA03uHHYfAtlMvsGhQWY1Yjbf+OXO3RzKfPXKXrttWN75nrbM9Lk4F8Up
	zGSWsPSNbUa6gV8ljukyIEzk6hl92LeFmm7L1/V1r+2nCZasxq9pwIZXukNZy7cUbR0OlpmNrew
	y0CC8+iI2BlRNLmgduRRLKMftcWUbXfBOoqVQqMJEJatnMOrYnONq+rpoCx8zHkkaqRbzJkiYoG
	2tq52lukTHeqfroaX9UGrk20idTAPVd6gGzCQBGMOO/5x0sH7cq4lnOIUkYFxzcnq5h2UlpksVV
	J+i3IHqGGcvRPMcRoO+WVmBxjiavSW+tSo5i+lA==
X-Google-Smtp-Source: AGHT+IElMozf6bXAJWqFpX50KRkQZNZnSUBvyaVHMA1WOpNr1uCSnxP8SkFC2aD1NnO6Q0irELxPQA==
X-Received: by 2002:a17:90b:394d:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-30e7d5bb433mr34690569a91.33.1747794623676;
        Tue, 20 May 2025 19:30:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm8749752a12.72.2025.05.20.19.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:30:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHZDn-000000068V3-2Wph;
	Wed, 21 May 2025 12:30:19 +1000
Date: Wed, 21 May 2025 12:30:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 24/28] open-by-handle.c: use syncfs() rather than sync()
Message-ID: <aC06u4BelSuGE8iA@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-25-david@fromorbit.com>
 <31048aeecaf4cb1622fe3a2b18f6a7d921175fa8.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31048aeecaf4cb1622fe3a2b18f6a7d921175fa8.camel@gmail.com>

On Wed, Apr 30, 2025 at 02:26:28PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > xfs/183 runs bulkstat_unlink_test to create 100 inodes, unlink on
> > and bulkstat them. It takes a ridiculously long time to run under
> > check-parallel because it runs sync() multiple times per iteration:
> > 
> > Ten slowest tests - runtime in seconds:
> > .....
> > xfs/183 328
> > 
> > When running check-parallel, sync() can take a -long- time to
> > run as there can be dozens of filesystems that need to be synced,
> > not to mention sync getting hung up behind all the mount and
> > unmounts that are also being run.
> > 
> > Convert the sync() calls to syncfs() so that they only try to sync
> > the filesystem under test and not the entire system. This avoids
> > interactions and delays with other tests and mount/unmount
> > operations, hence allowing both the test and the overall
> > check-parallel operation to run faster:
> > 
> > xfs/183        4s
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  src/bulkstat_unlink_test.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/src/bulkstat_unlink_test.c b/src/bulkstat_unlink_test.c
> > index d78cc2ac2..62e5bb978 100644
> > --- a/src/bulkstat_unlink_test.c
> > +++ b/src/bulkstat_unlink_test.c
> > @@ -88,7 +88,7 @@ main(int argc, char *argv[])
> >  		}
> >  
> >  		if (chknb) { /* Get the original number of inodes
> > (lazy) */
> > -			sync();
> > +			syncfs(fd[nfiles]);
> This looks good to me. 
> Minor: Is it safe to use int fd[nfiles + 1];

Yes, it is. Variable size array declarations like this have
been supported by C and C compilers for a long time.

> Isn't it better to use
> malloc()?

See my previous comments about stack usage in userspace test code. :)

-Dave.

-- 
Dave Chinner
david@fromorbit.com
