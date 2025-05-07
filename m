Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8581D9346
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600323; cv=none; b=d7fZeeoqMNM+ZeTslB5jTUZ1ImSNYbCucNMuHh+mISVe8OKwUsUdHxV59cOTXA90SgTrPyv1DdCwX1whPd0BIRrMmSJtoRdNL8C5uYPpjJQ6G3q5X3MxISCZ4WspYPjxZOywQc0laxHGfuegntNDyxxLjw8KybEeYVyRvNf3Yi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600323; c=relaxed/simple;
	bh=BpKTJL8/dcmE59KnxPWUi6Gb8Um7v4qmvTQkP9RLhBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=X+x2bSka3BsexKXhuCdG8jYpVFh0+8JJ48JOV6Mc+AAUx3+NJbe+jYMA9w2AZb8m0NiCyBe1ywJTUDEB4ax/ANSTI2TIdsf6XN+7aD6lKd79D7RCYrK9NwwqGPebGvnXB/QHBvl3nZAMgoZ9BoKthOlHRYu9BClJk2OXJIB6PB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3Ta/Roh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3Ta/Roh"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af50f56b862so4539747a12.1
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746600314; x=1747205114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbSOVpHX9ONGo+6W040E+iDbvkzuPBXxFfDQCihqk0g=;
        b=j3Ta/RohGN5m9aOgEh+D9V5xbBMk9kXyPdveQqr1V9NCR72ktwgUTMqCEQDsUjLfwd
         LGRnP7DSvM1ynjz0Z0UcMGhr4W99xeKrAxgClyL8PfVeWFqMH/P1xfaK4m/Qo32rJiZ4
         l7qwBy9QgkfcsfOZWk5Gcsd2mjeLZi/l2gZAbD9/s9bIwL8B+Xzfg737XKO8kodZeLPV
         X8FKuSxhKz7reAGwFiA1XyJQAPQqDA+xAb5gGUgSEwYdK0l6ZdoYUiEdjnBPiSLPkS1z
         8QibyiKLAzc0UAFAZ6F/SINSAbOpcYh4pMZFPpGUOnUk1pmDUUI3FtTaemWyfCmMz1ib
         Mp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746600314; x=1747205114;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XbSOVpHX9ONGo+6W040E+iDbvkzuPBXxFfDQCihqk0g=;
        b=jJFkiyKb1KMXqenOLbSz1bx0sgTW1yIBePk/E9YYpUIkP/pqhtYDWSMlBY0og823Yn
         G+gvCbDNjQzea9wDjQLTZsfhkMQr8x3RC392oFyKJiOfgfqztJVg12WY06yXbHrf/N7S
         ezESUadBxeaiEu69IPOPYwfoL670OPybWzDvi57zp4tYuTScXHRnOYCG2q9YIULtxEo3
         IgRJNJW+kOucHy+f+ew5qJ6Z/NXh3Y7P7nogBLmxrFJ3TreOKKXjN5fvW4ZFIiig5tQd
         qZl+rhk1CqivYJDfeykggbINQ23OY+sJCNWeavjqG8FiKKk7CfHSgoVoyenz5I3kIHa3
         FhnA==
X-Forwarded-Encrypted: i=1; AJvYcCW/YChNISlgrAdmoOg3chWI4zVD5BhlFcF+pMak15quTInHGnUsx0KsOjNc7gPgPTRuqARPguQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAJPbxnXj+P6SbF7GRSeFA+9fw/whAUqD0mtXcbTKvnHd14yH
	S/UjlBN3IyrOrUWUtkcFg5ArVl2aj4v62iOzBJPfdfmwLObNrjt0tzvHvQ==
X-Gm-Gg: ASbGncuIj5GIivvWFdQqhjv3jBpkPkpEnG4sl8HvBK8EecDDtzjcujEwMMywAs4scF9
	fHLcj1/oafKjn0dUeeqTrMeblapVgG9s6yBCnSN9Sk2tcc6DvM+uMe9VlRu3GT1KSfNp33UIGk8
	PLL7UoBHgHFjHvK/t+KHmFqrDKZqx4SV6nP7kGGWxDz9zg2rRg8uYHK0Z+uPMOkBm59koHuJjJc
	OgdLzd7x1wJWFqWHlvWPWnKrpY4tzKnLZ4BK10KYzYRWCjZEfFlnuEPIBfHeIZVQr/0w6kOheyq
	Szr381nvZ/mcR0k6DeKbc6x+02seivhQcpdzWcDHe7MA7v5HoxKcgoc3+IJ0YH4HFvnYffiwrFm
	EQ9T6W2LTYMJXddkXqg==
X-Google-Smtp-Source: AGHT+IEQdVywCiO7O4awASc3e5UbcHuGWewHoWBTUVx71NaWYTA7DvzTO6PdhbwlLXL4roAqHF7bCg==
X-Received: by 2002:a17:90b:1e08:b0:305:5f25:fd30 with SMTP id 98e67ed59e1d1-30aac184aaamr3669560a91.4.1746600313870;
        Tue, 06 May 2025 23:45:13 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30aae525c3dsm1166850a91.21.2025.05.06.23.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 23:45:13 -0700 (PDT)
Message-ID: <e434a271402602fa7ec5efbcd9d92329ecdd4614.camel@gmail.com>
Subject: Re: [PATCH 07/28] check-parallel: adjust concurrency according to
 CPU count
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 07 May 2025 12:15:09 +0530
In-Reply-To: <20250417031208.1852171-8-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-8-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Concurrency is currently hard coded at 64 worker threads. This is
> too many for small CPU count machines; the idea is to create a
> sustained load of roughly one test per CPU as they are mostly single
> threaded/single process tests. The number "64" was chosen because
> I've been developing this functionality on a 64p VM.
> 
> Rather than hard coding the concurrency, probe the number of CPUs
> available and create that many running contexts as the default
> concurrency to use.
> 
> Further, add a CLI option to specify the number of threads to run so
> that we can over- or under-commit the CPU resources to enable direct
> benchmarking of performance with different levels of concurrency.
> 
> Let's use that capability to show how much check-parallel can
> benefit small systems. Using a single check execution thread for all
> tests inside a 4p control group to limit maximum CPU usage to the
> equivalent of a small 4p machine:
> 
> $ time sudo numactl -C 4-7 ./check-parallel -D /mnt/xfs -t 1 -g quick -s xfs -x dump -X generic/531
> Runner 0 Failures:  generic/504
> Tests run: 921
> Tests _notrun: 272
> Failure count: 2
> .....
> 
> real    61m31.362s
> user    0m0.029s
> sys     0m0.059s
> 
> the quick group on XFS takes *over an hour* to run.
> 
> If we use the same 4p control group setup and run with 8 test
> execution threads to ensure the 4 CPUs are fully utilised for most
> of the test run:
> 
> $ time sudo numactl -C 4-7 ./check-parallel -D /mnt/xfs -t 8 -g quick -s xfs -x dump -X generic/531
> Runner 7 Failures:  generic/504
> Tests run: 921
> Tests _notrun: 145
> Failure count: 1
> .....
> 
> real    17m33.124s
> user    0m0.009s
> sys     0m0.017s
> 
> The same test run takes only 17m33s. The same number of tests were
> run, the same failures occurred. [ Ignore the differences in
> notrun/failure count - the multi-file aggregation currently doesn't
> work correctly for the single log file case. ]
> 
> That's a reduction in test runtime of ~72% for a 4 CPU system. Or,
> if we want to measure it the other way, we get a ~3.5x improvement
> in runtime scalability. i.e. going from 1 -> 4 CPUs being used for
> test execution (4x increase) we get a 3.5x improvement in
> scalability when we go from check to check-parallel.
The functionality looks useful to me and the implementation is also
fine as far as I understand. I have some minor/nit comments below.
Other than that:

Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/check-parallel b/check-parallel
> index cb5d6aedf..0649a417f 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -10,7 +10,7 @@
>  # the loop devices.
>  
>  basedir=""
> -runners=64
> +runners=$(getconf _NPROCESSORS_CONF)
Minor: Not related to this change. Maybe we should have a _get_nproc()
just like 
_get_page_size()
{
	echo $(getconf PAGE_SIZE)
}
_get_nproc()
{
	echo $(getconf _NPROCESSORS_CONF)
}
and replace all the $(getconf _NPROCESSORS_CONF) with $(_get_nproc)
>  runner_list=()
>  runtimes=()
>  show_test_list=
> @@ -30,6 +30,7 @@ usage()
>  
>  check options
>      -D <dir>		Directory to run in
> +    -t <n>		Number of concurrent tests to  run
Minor: Maybe we should mention the valid range of <n> i.e, 0 to 1024?
>      -n			Output test list, do not run tests

Nit: Maybe there is some spacing issue here? "Number of concurrent ..."
and "Output test..." don't begin together.
--NR
>      -r			randomize test order
>      --exact-order	run tests in the exact order specified
> @@ -81,6 +82,7 @@ while [ $# -gt 0 ]; do
>  	-\? | -h | --help) usage ;;
>  
>  	-D)	basedir=$2; shift ;;
> +	-t)	runners=$2; shift ;;
>  	-g)	_tl_setup_group $2 ; shift ;;
>  	-e)	_tl_setup_exclude_tests $2 ; shift ;;
>  	-E)	_tl_setup_exclude_file $2 ; shift ;;
> @@ -111,6 +113,11 @@ if [ ! -d "$basedir" ]; then
>  	echo "Invalid basedir specification"
>  	usage
>  fi
> +if [[ $runners -le 0 || $runners -gt 1024 ]]; then
> +	echo "Invalid thread specificaton: $runners"
Minor: Maybe we should mention the valid range of "runners" in this
error message (0 to 1024)?
> +	usage
> +fi
> +
>  if [ -d "$basedir/runner-0/" ]; then
>  	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
>  fi

