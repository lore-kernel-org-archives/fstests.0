Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB51E7C31
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934857; cv=none; b=VJGlPw4xTCB6srEXnOunsH1O3BVvgN0k7Jl8S/kQQEd8QChDMGW66U5KCZnWlWursZYYJEeypZ/B1+MAoxN4KQsQ+Y0sPA6BEqhgnLkFE6qcFSvu+2FCC0L+uWMWeGDXyBl44TZgKyMQHkhYOOIuLNCqWOwlnn5iEcSa8cd0rSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934857; c=relaxed/simple;
	bh=/GxHNeK9zA8F+RRVMi7l8qpA8e05b5ElDgKJh6Ve8hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqjuo/FG3cD+6gnWBM85ffWu45hZrPDnalPFO8pRaT0KUJigzy0h2rTMEzy05JSoB3fNCcPdZZxuON7CzFjA+/EDuRJCW77ubnRL/bKFMWB7dr1wwza5dOQvoVhkE5hCwfb0cX/juH1VlFdRuSe7LOGLGHGT9qfPmI26eF9AIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RYR386iS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RYR386iS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21654fdd5daso110567865ad.1
        for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736934854; x=1737539654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdbKs+zjGkXLz5QD2m3fZGKorkscW0QHmFziqMcHpsY=;
        b=RYR386iS5m3Z8S31Jdi32zAphNmCew8OyZudEHIBkIJojHhBU4IiF/+fz7dgSVIsSM
         3eK2ZODJO6Pj7e5iY+zb5kEBJD/0lr/pPPmbbE+9e4bS/Jk6dw6Eknm5usUwSXLx9ljC
         7tsmjaLwIB3peP7cLjr9H6ELYTyILoQCEhtBhDIGBpni5NeDELkUTO6vhQaztFC91Ug0
         ajrofLW70TBAYydyY9Vy4DeuQjKaNoRFY3UFFE6kvsotAD1BdwTZwk1TtHAmvSwXTlsi
         KlSo/q4pqFU25kqyBG1XBrhMNTx+kUVZlkbJEKEuCUIEP9sWgyAo/dBQOQTd6WWT1n+Q
         YYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736934854; x=1737539654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdbKs+zjGkXLz5QD2m3fZGKorkscW0QHmFziqMcHpsY=;
        b=A/OsbPObkKOnCGdxrB6jDOsMUJAJnEeN9eAFlEoG8HYliABxVjumPIRhoB8vXiAmaf
         qfq8PNo0xRqNiaqTMs5swDIJQ1O577o1lnDTZjWHASmV+KNwVEcHJ1d29D7MVSF/MHuk
         UR3/5DFcFKdSP22Nt3VX9DhQj5YzH2fGCshlbkN83+j+h+o8h0FYPyfkJAMLsJQZm13W
         lsttpxgF9QcL4HcrPB8vNB/mvzS6wyffmXa+cLqyyFPXSriDsSnCFzPThOGeAR9XY6h+
         yOqSxNoOMA3KEnaudOC2UBPBrUMZMimDuyJCxU1abjt5WhQoTmn2s3zZU7KYVWc4EZyF
         rLgA==
X-Gm-Message-State: AOJu0Yx+PJZtXePoWrer1+Iwo1Z0yb+hMLQVfRbCgQm8hepH8RhTSNZb
	PqMjXuK0vzxSJzu/cfyBRFnVBE62BHX2pUYOweDII3WeVgA3FwWuSGoL6hQHWcw=
X-Gm-Gg: ASbGnctX4epmHlX/MVXg17m6SyKTTR9P77C1t+9TWoi9mcRj4Y0oJ2VY1l+cX9Fz3+m
	3ClBfq0JxJ0XXD3NRnQyCFgM98myeZTdg2g+QS9qAw5pMWE1APINYxjhQQ8gOav2ZT8a5QjjMJH
	1TkrsxOw6hIV3oe73+MNFki8o+eGQ41naFIsN1C/ePz3YYMG1Ogw6b0AucrBU1sD3MlU1KFdkFv
	IdjIPzYMUVZnowKlw4hHcWM2O4UnbRGsMMlJ/660KTFnZnMwSSNmTLt5yl0RzfVt5HiYR5KpZOM
	fZf8Ixu6eoxQtXPIXkc3VDJo7jrdgiJJ
X-Google-Smtp-Source: AGHT+IFgsUHgtuYGP6nqCq6jAFVlW7N+0/gC9qRooPLppLMgVr4s4+u758uuFYx1XjcTnQJxBB0QDw==
X-Received: by 2002:a17:903:11d0:b0:215:65f3:27f2 with SMTP id d9443c01a7336-21a83f43abamr355322905ad.8.1736934854059;
        Wed, 15 Jan 2025 01:54:14 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10dd84sm79462255ad.14.2025.01.15.01.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:54:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tY06E-0000000680R-3doZ;
	Wed, 15 Jan 2025 20:54:10 +1100
Date: Wed, 15 Jan 2025 20:54:10 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/5]: CLI and feature improvements for check-parallel
Message-ID: <Z4eFwhJvCo-oh7UT@dread.disaster.area>
References: <20250115060258.3951185-1-david@fromorbit.com>
 <20250115062916.GC3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115062916.GC3557695@frogsfrogsfrogs>

On Tue, Jan 14, 2025 at 10:29:16PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 15, 2025 at 04:51:11PM +1100, Dave Chinner wrote:
> > Hi folks,
> > 
> > This patchset brings some new functionality to check-parallel to
> > make it easier to run across different machines and filesystems.
> > The patch seti adds these features:
> > 
> > - auto-adjusts concurrency for the machine it is running on.
> > - adds CLI support of selection of tests. These CLI parameters are
> >   identical to the check CLI parameters and the test lists are built
> >   using the same code.
> > - adds support for logwrites devices so that all the test that use
> >   dm-logwrites are now enabled
> > - adds support for specifying the initial filesystem type to test
> >   on the CLI. This makes it easy to select xfs, btrfs, ext4, etc as
> >   the target filesystem type that is to be tested.
> > - Only block device based filesystems can be used with
> >   check-parallel, and this is now enforced at FSTYP selection time.
> 
> Can you please add a --help so that curious users don't have to go find
> the calling conventions by reading the bash? :)

Already implemented:

$ ./check-parallel --help
Usage: ./check-parallel [options] [testlist]

check options
    -D <dir>            Directory to run in
    -n                  Output test list, do not run tests
    -r                  randomize test order
    --exact-order       run tests in the exact order specified
    -s section          run only specified section from config file
    -f <FSTYPE>         specify the filesystem type to test

testlist options
    -g group[,group...] include tests from these groups
    -x group[,group...] exclude tests from these groups
    -X exclude_file     exclude individual tests
    -e testlist         exclude a specific list of tests
    -E external_file    exclude individual tests
    [testlist]          include tests matching names in testlist

testlist argument is a list of tests in the form of <test dir>/<test name>.

<test dir> is a directory under tests that contains a group file,
with a list of the names of the tests in that directory.

<test name> may be either a specific test file name (e.g. xfs/001) or
a test file name match pattern (e.g. xfs/*).

group argument is either a name of a tests group to collect from all
the test dirs (e.g. quick) or a name of a tests group to collect from
a specific tests dir in the form of <test dir>/<group name> (e.g. xfs/quick).
If you want to run all the tests in the test suite, use "-g all" to specify all
groups.

exclude_file argument refers to a name of a file inside each test directory.
for every test dir where this file is found, the listed test names are
excluded from the list of tests to run from that test dir.

external_file argument is a path to a single file containing a list of tests
to exclude in the form of <test dir>/<test name>.

examples:
 check-parallel -f xfs -D /mnt xfs/001
 check-parallel -f ext4 -D /mnt -g quick
 check-parallel -D /mnt -g xfs/quick
 check-parallel -D /mnt -x stress xfs/*
 check-parallel -f btrfs -D /mnt -X .exclude -g auto
 check-parallel -f udf -D /mnt -E ~/.xfstests.exclude
$

-Dave.

-- 
Dave Chinner
david@fromorbit.com
