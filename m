Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811025B69A
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822794; cv=none; b=An8nIAj9bGlDgNPjDYV6HW/R6/p0tqNnTnDKgbxni07wuWtdQveuww0jGXpX5aWEhx3XKmMr5WVptJhBMJxVIs750tGlptgxWgFZouhpW8qiRIMN//XMs7A7fFNtPITM0XNaFN2UvG+gv5cpamJL7+lfI04ls5HgXuO28oa00pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822794; c=relaxed/simple;
	bh=hdaD6souSMbKb+QEvGBY1s4mw/HLGrk/AEzUMUL7mjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3NMkfJM1Yjzvxr0kdXo949QjmD/rcay1kODZHmrUEE7zazAWfQx7YLVYjMKF8CH8l4hkUzmfNNUjkQEtLnzelOtOhTCJhTzUPcPWboa4j0bz1IfwTuXOh9VAc2xhnr2rYMd5HxCKWu3ktiN35VEKrjQmayWkeDfQAfbeCNwvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=U1J6St6v; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="U1J6St6v"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c9907967so3414151b3a.1
        for <fstests@vger.kernel.org>; Wed, 21 May 2025 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747822792; x=1748427592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aikFu/6NA96pT3373tnEFPPd5FOeerLlnLgyrRDudyQ=;
        b=U1J6St6vLxacMXmBmjOLoNqU8eefMHksEkCjp6W3jRzc1vF+OCs48tDNECKGpqZbwh
         D2Z8ruaO9pJMeOPenL8zp2QJlPMJnTb9mCNT3jC0Ve1YpcvJjdfKd4oitXD6Fr5jEokV
         aRqmC4FxF0JEdbDIMPL4fZc2awNWQC71jOEZDeRmz9QXejxT6VyUSK7NZc+SuiDjXxmz
         R2C5tHYUlKRzUQM8m8NgPaJAHdpRHrDWlyaPThg2GCSFYMGCyu7vHU2s5vcxssba6Mxs
         YJzvGni6GDcU8PuPeHooPKK0BK2QZl/sCLDvYpgT57b6LCRlsreCdDVpqdPUmNI4/a8z
         u11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822792; x=1748427592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aikFu/6NA96pT3373tnEFPPd5FOeerLlnLgyrRDudyQ=;
        b=i8pqLdeegWNw5N5afpwVr+QCdQJpMTojQ+gfWI9kRE++jIyveMZc0E6J1A0Yd43X9P
         70saV6+succhD3ySBS9jNv42FxJwZouCqhrg7tyKqafcV1T9olk/QNMKtcjtkHimKWlT
         l/f424di6CnO/d2wVgR7fPcKMFWoEJzQptm5m55KQ1SNtWxg2HTCUQZ49E5dubQIjkJb
         2JqeEzTa7zN/KBRxahF2icyovn8oOvcajjytIfr1Oqx7R5P+9eOFLCMwFNVJLVtZDCtK
         g8egZhWmKgtHHiOFI0JsfJNVr8zfvmFxa/lodD0S5K59S02aeqnQnlKSwykiSqTq/EVF
         qcbQ==
X-Gm-Message-State: AOJu0Yy1Okh8XhxQQorqaPuRdNoUjvLOSUrgePUk+U8kkYA0QFQlh+Sf
	WbuY+qRwRHrXFK4MR4J2U3jcBjjYRufSrrSukfHQYhteeq7Zauh+72bFnzfxtfTY0So=
X-Gm-Gg: ASbGncunViQymVoH0hbxlIO/iKnt6P5N2C8TZEb79iWjOQzCGo8q7TeJeElL34TWOXO
	DfROipu0SAS+oITkEUrrlO9RncZENQwTV+GE2hqDX7vOOIop6ZCoLF7axn2WWbHBVPLMgTFF8SM
	A3y9Dnl7MRoq5ZCF1YCb8nveCcEG1gbea0u0kduonMUVK2dDPyctJWccJeNsnwVDkD2UWNHkWSH
	zE3Yqnk1M7c6Hy3TM6XkENfto7TfmXCOrG0W6Yn9HaTMaRJTUPKD22j9pEimD0K9rZatWcbMEOn
	x9ZOpxpOY5/0OILkR1i+rsqnzODnkX3A+HvzzEtvu6/Z3+ZSz3HGl9kYZzVr/H7dMb2IbKmdFsf
	5JHi+wiWd5y+gIKcV
X-Google-Smtp-Source: AGHT+IHeECxOtPyI35T4FYzBHlkLjfeOza1Ffv6frDnNl7aMzTk8CB3i3r4iGcY7ieHSm6/hpZFxSg==
X-Received: by 2002:a05:6a00:4b08:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-742a97a720bmr29962321b3a.3.1747822792177;
        Wed, 21 May 2025 03:19:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97094desm9304558b3a.38.2025.05.21.03.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:19:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHgY9-00000006Gfx-1SIC;
	Wed, 21 May 2025 20:19:49 +1000
Date: Wed, 21 May 2025 20:19:49 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 10/28] check-parallel: use PID namespaces for runner
 process isolation
Message-ID: <aC2oxc6-f3J597f0@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-11-david@fromorbit.com>
 <0c40accd275f3fcdb9d00309159ecb9eb55335b9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c40accd275f3fcdb9d00309159ecb9eb55335b9.camel@gmail.com>

On Wed, May 07, 2025 at 02:32:29PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > This provides isolation between individual runners so that they
> > cannot see the processes that other test runners have created.
> > This means tools like pkill will only find processes run by the test
> > that is calling it, hence there is no danger that it might kill
> > processes owned by a different test in a different runner context.
> > 
> > This means we need to turn of private pid/mount namespaces inside
> > check itself - nesting private namespaces causes all sorts of weird
> > TEST_DIR mount issues with SELinux disallowing TEST_DIR mounts.
> > 
> > Note that this also regresses generic/504 for check-parallel,
> > because it triggers looking at the init namespace from
> > FSTESTS_ISOL=privatens and this variable is not exported to test
> > subprocesses anymore.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  check-parallel | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/check-parallel b/check-parallel
> > index 19f2d2b0c..aa88c681e 100755
> > --- a/check-parallel
> > +++ b/check-parallel
> > @@ -267,14 +267,18 @@ runner_go()
> >  	rm -f $RESULT_BASE/check.*
> >  
> >  	# Only supports default mkfs parameters right now
> > -	wipefs -a $TEST_DEV > /dev/null 2>&1
> > -	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV > /dev/null 2>&1
> > +	wipefs -a $TEST_DEV > $me/log 2>&1
> > +	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV >> $me/log 2>&1
> >  
> >  #	export DUMP_CORRUPT_FS=1
> >  
> >  	# Run the tests in it's own mount namespace, as per the comment below
> >  	# that precedes making the basedir a private mount.
> > -	./src/nsexec -m ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
> > +	#
> > +	# Similarly, we need to run check in it's own PID namespace so that
> > +	# operations like pkill only affect the runner instance, not globally
> > +	# kill processes from other check instances.
> > +	tools/run_privatens ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} >> $me/log 2>&1
> Why aren't we using -s $section and only using $section with check?

It is already encoded in $run_section - the CLI parsing adds the -s
for each section that is specified on the command line:

        -s)     run_section="$run_section -s $2"; shift ;;

-Dave.

-- 
Dave Chinner
david@fromorbit.com
