Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E763230D35
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800795; cv=none; b=TZyxXF2FS0aXNJ4tFYkG4kdL70Z3nJZKBU936vZ1Tk5f8EBXm1j/fvYW/yE0VDLl01BDBArA5lOrxotydtVyLiC8hh0pVe5VdwanW9xtzmaf444GYtyma6jUR0CBSzc1imuRJx0NmERWEnk9H3lrHiBBbj+Ae0/GbI+fSh4v66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800795; c=relaxed/simple;
	bh=28f/LSidCSpTAE4wklfA3yjxNN20ofhnteHcO6s+83A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr/ok94tUSKfUjxBCxQuMbaBJvqswRl6KcPm8TFBS4drq42OHra4TmiPiEh4vii/X4VtnMIFMvMoH9Y5OyeSrVjXxidSgu2XodjzssMSJMQRJioHWP7xfWw3DVEMtIGfsl9pp8fyTLRqu0h+wxP2KuPUSA06nLfwrmd2BLQcQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aLhdeYlB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aLhdeYlB"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-afc857702d1so5611779a12.3
        for <fstests@vger.kernel.org>; Tue, 20 May 2025 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747800793; x=1748405593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEd8cFEDsBdN8VLxCZ4I4C4431lgWrIMiC/hzcDK3cw=;
        b=aLhdeYlBxLQ3xzW5hUghZvstAVBgPhMr1D++PglOGB2LCdbzI4CGkxtnQDMvDMCqqv
         KX/8cXVBpRoSBLGdH/hJcjluy15tPQGKu5viG0Zb2U1JXUqPcunsuMKd7inZRKAy+Z28
         w83mj6Qhdk1DgPvbLV6qbhfaUKnaPOkVygMy4DaNe+d1sxe75iDX5pjIvVUlAEnOtOU8
         61nremulVKM9lDeVCjb3PrHoU7A0cvBV/WHnyNJCcJ9KULWekwhl69dHy8jkWcasp3dU
         m8m/b/NhzEVvH6t53jMATzT1LVOb0V0upItaeVBMOoZb5xwDRWptxZe61167vMZUzHOv
         kIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747800793; x=1748405593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEd8cFEDsBdN8VLxCZ4I4C4431lgWrIMiC/hzcDK3cw=;
        b=jihmDm/YV3yk1+1GD1fWK+mh1KLpArt1uDDOJT5zXNU0gS4YkVB8K8sr07JA754m+a
         pZNyJrqhSQ0jIXhSnnR4Hk/eTTAxZyxEv84T3IEMQa9MvTiChX32TxZPcLKKGQb0d/6Y
         8/uP6kMu8uAXzvuHxzLJW57EQf5VyIlDs/mZMzO0yHYYHAvFhjeCDH+AKyP98chgImMB
         JnPeUC2nFZY+jB9gzVvqeecXSdzDt8TnhLMU3dcYVAmIZ+1PT91Pq+dPYXvIvdv8YP/9
         6BE3+1VrHzg41e3i4HnScq5MpZcros7nK40leKsZLma3HWicYfMpzmDh4o++EILVwBmZ
         tNgw==
X-Gm-Message-State: AOJu0YwQczgZY9fxcFVfqWaiTWQigSsiQkkkRye2gTTH7ju1flbh1k3A
	PfrnAWfI5MFMqsjVQjF+E1jaNS9uJ14kyiL4rV85T6p+gtvBqVUw5THkYXxkv9XmyzM=
X-Gm-Gg: ASbGncsLAGushGFp5ZXco8VqINkreq5oGuZhwXdwOhZ/A0vYPeTF2JbY117iObwlUgI
	FzfkYzUpcbs6mVdcJBi2qsnAGxeaTTmnp0+q2M+wdHTbehIMFvdaG2s/LpEECb5iYGdUtEBXDnU
	TWIrQkax3Ml73ToFPjhkEis9DYCkrKor9XYZL4Dq5ovaJ8/QWRZicUD2E/gSRzXTrdC7PiaSLZU
	uG12NYqQ89dDcU//P6+TY2+eTNuGB/tVKVfy4ZGPLF6MmkWNjULqgh3iXbTocxkaaJYTgUOOeiC
	s6EaeSf2D6ykpSD5fa+88RHwija+VbYnG4OwYCop1079LKTsuRA/igT8Jya3znvzy8mN2w2+QLC
	yjghK3kh8KIoOTMaith0M+jVGo73O88zB+rdZBQ==
X-Google-Smtp-Source: AGHT+IGdzdxgTJP10WazOBQjl9o3S7+vOqmm4JP/hdyH3JBZn2+cWKq/OfWSt7P1DplxpbISLho6Yg==
X-Received: by 2002:a05:6a21:8ccb:b0:203:bb65:995a with SMTP id adf61e73a8af0-216219b251amr31036664637.30.1747800792692;
        Tue, 20 May 2025 21:13:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36368b82sm2619678a91.9.2025.05.20.21.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 21:13:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHapJ-00000006AEM-2HwG;
	Wed, 21 May 2025 14:13:09 +1000
Date: Wed, 21 May 2025 14:13:09 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 06/28] check-parallel: use common group list parsing code
Message-ID: <aC1S1c-YcOivGRVx@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-7-david@fromorbit.com>
 <39c2355dea38ef102f7a6c930f14f0cd14e6bbdc.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c2355dea38ef102f7a6c930f14f0cd14e6bbdc.camel@gmail.com>

On Tue, May 06, 2025 at 09:26:37PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Build the test list directly from command line prompts, rather
> > than hard coding the tests and using the check infrastructure to
> > filter that list.
> > 
> > We still pass exact test lists to check to execute the tests that
> > each runner needs to execute, but all other test list commands
> > are no longer passed to check.
> > 
> > As a result of this change, check-parallel no longer passes unknown
> > CLI parameters through to the internal check invocations. At this
> > point, the only non test-list related option is config file section
> > selection; more of the check options will be brought across as
> > needed in future patches.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>

.....
> > +usage()
> > +{
> > +    echo "Usage: $0 [options] [testlist]"'
> > +
> > +check options
> > +    -D <dir>		Directory to run in
> > +    -n			Output test list, do not run tests
> > +    -r			randomize test order
> > +    --exact-order	run tests in the exact order specified
> > +    -s section		run only specified section from config file
> > +
> > +testlist options
> > +    -g group[,group...]	include tests from these groups
> > +    -x group[,group...]	exclude tests from these groups
> > +    -X exclude_file	exclude individual tests
> > +    -e testlist         exclude a specific list of tests
> > +    -E external_file	exclude individual tests
> > +    [testlist]		include tests matching names in testlist
> > +
> > +testlist argument is a list of tests in the form of <test dir>/<test name>.
> > +
> > +<test dir> is a directory under tests that contains a group file,
> > +with a list of the names of the tests in that directory.
> > +
> > +<test name> may be either a specific test file name (e.g. xfs/001) or
> > +a test file name match pattern (e.g. xfs/*).
> > +
> > +group argument is either a name of a tests group to collect from all
> > +the test dirs (e.g. quick) or a name of a tests group to collect from
> > +a specific tests dir in the form of <test dir>/<group name> (e.g. xfs/quick).
> > +If you want to run all the tests in the test suite, use "-g all" to specify all
> > +groups.
> > +
> > +exclude_file argument refers to a name of a file inside each test directory.
> > +for every test dir where this file is found, the listed test names are
> > +excluded from the list of tests to run from that test dir.
> > +
> > +external_file argument is a path to a single file containing a list of tests
> > +to exclude in the form of <test dir>/<test name>.
> > +
> > +examples:
> > + check-parallel -D /mnt xfs/001
> > + check-parallel -D /mnt -g quick
> > + check-parallel -D /mnt -g xfs/quick
> > + check-parallel -D /mnt -x stress xfs/*
> > + check-parallel -D /mnt -X .exclude -g auto
> > + check-parallel -D /mnt -E ~/.xfstests.exclude
> > +'
> > +	    exit 1
> _fatal ?

This is a common usage() function pattern in shell scripts. It's
clear that it exits with a non-zero error status when someone gets a
command line parameter wrong.

Also, check-parallel does not have a status variable that needs to
be set to propagate exit values, nor does it have any traps set up
at this point to need exit value propagation.

Hence calling exit directly is really the right thing to do here.

> > @@ -198,7 +310,7 @@ grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\)
> >  echo
> >  
> >  echo Ten slowest tests - runtime in seconds:
> > -cat $basedir/*/results/check.time | sort -k 2 -nr | head -10
> > +cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
> Maybe have this default to top 10 list but make it parameterized, just
> like we do it for DIFF_LENGTH (# number of diff lines from a failed
> test, 0 for whole output)? Do you think that would be useful?

Not at this point in time. This is largely initial debug
information; it tells me which test(s) are consuming all the time,
and how close the overall runtime is to being bound by single test
runtime.  I only put this here because I was running that command on
the CLI after a test run frequently, and generally I was only
looking at the top 2 or 3 tests in the list....

e.g. if the whole auto group test run takes 9 minutes, and the
longest test takes 8m30s, then it is clear that total runtime is
bound by the slowest test. Make that test run faster, and
overall auto group test time will run faster, too.

This tells me what tests I need to focus on for runtime optimisation
(e.g. sync -> syncfs conversions). Once all the low hanging fruit is
gone, it won't tell us anything useful and I'll remove it...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
