Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3F4B1E56
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607777; cv=none; b=RYDcw8IdNfC4TN//tP/pbuh7G7eSotJM5Rl5EGBnBdPSEW3zvMLkziTv2J0GxAnZkM7T5oOfYX/cJTa/L2IaB3sVyIvmJQYbxvcK4k25XpZkdk9feKkZIjDKEJjau45oNbuDcvvM/GooWMPxfGSuVSwpolWP5NXSQrsNQiEMao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607777; c=relaxed/simple;
	bh=itbuovPXsy3flfioDD77Rb1n1ytME897rAyO0GtgVE4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=K2IgoQEvWvu4lWc2hl4lIxs6UMnwZdzjGgY8hwV0uU0LOHlQUgbkvhg6NJjV+30ptmfjSwwB49GAEaaIjsrPnYLV6v4iNSzjZQhUC8UGxRghFwg0I/eQ/M+EMNOQwyCe6h9oY7hlQ2QjQQDf/EInIG+z1A1PIKfS9v5BVvZ6XCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXWi4Lbe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXWi4Lbe"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso7158706b3a.2
        for <fstests@vger.kernel.org>; Wed, 07 May 2025 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746607775; x=1747212575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtZ7VXYacrvALZ06OqAitdCbc1HVncGSImvUzI0OZhU=;
        b=NXWi4Lbe8RGwgL3DOzxAoPTbzDiUWTLlFPj/RhjERcbiEhjxN0x2I3lG8zUClC4Xfe
         +DgixgcPyWoOm6zQbRSrsXC1ZHgkNaF84x+5bTxQIGAibUmpjp7LKbuLoh0Ty0jiVcWQ
         70jUsceqcIyN81Tc8BjZrmElSaodRnv+zOBIGmK+zqSa5q6dLT2Q2bLKcwHQwJuOt1h0
         ZeReLF2CZMkJFBISD6xs0pCfw6+xkT4eRZ51hZSWUCX0u1YeuhIQgDpyb1CRTQkTXi0f
         inVgLJh6OBdKKtLnT6gXXA77YU/TniXXi4KRucc5kq1e+hCKlRFcBV5llr3zyzBQeOyb
         Mx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746607775; x=1747212575;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtZ7VXYacrvALZ06OqAitdCbc1HVncGSImvUzI0OZhU=;
        b=aiaCz5Ykewa/CEXCFYoAKCmziAh1fUeqZZj44Ey4kOaQ1LZLDJvepVeYIS9parqKVz
         O/XQEClT9ExjDYLAQgjIWNHs6KlvHIB5tjqItwR+GOxMYukUMA7vJaIS8n2p+qIgCosf
         C2JPRageD/DTJ3zJSZM11E5JYd4xnt5KkCtkQgEL4IeDqVHNScF5cMDbwrfrE+9KMU9X
         GMXTQio8PJ5dR32rCsTITL2Hy7HO6G0dLC2W0UTcHpR8cYbEnyno5jASHyaVkto+S2D+
         nQYLH1EomDve8Xmx9DT0jDguKg76IMYwHUcTgqPSQIOAjl893s0WxUfIUCpCy9s5x9sV
         Bs8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDRDbwfr1A8XfqmsvOgW73fDvCaJZaQBM4jKEyTp3xhF10pPFSR4t7TIx8GdRSzj1TsvQ6By3n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/s+6/lVK+MYP88iO6kDzqQ/GAbsgqhP7wj/w7mBG0bIUcql+m
	wfS3CyrBNDGbOQsqG6gsI1g+FO+glodl5rmkDXFEa0VvpzvF3ocx
X-Gm-Gg: ASbGnctCNXBlog8ogCjvhG9xMmgpnqD191QVMADQkgcUcGriiJd6iVFqOkG17znO5pV
	SuOoLs+QJAz+EzPCmtxXeFpBWM7+4KN9StnyHeBKn7pVoOXfDjoxB9nD3tdPZZ8Ipe3KwnCIzBl
	BY87I3jJaf+2jCfnv+W2HKItl36n3TOql6ST3nW3ig2vkScl7zShLLjWwpQaGoK8dKksShT7Iou
	btlr47SWRRVtVQyO2HNmrB51SChQ29IrcNT6HYwe1bOpYs4v4hiXUxy6vAk27CkLw8NYKAgO6AH
	ujLz+5cjI8FW7+yWI9DvtlMDb5PRFOKy+E3tVRHp4AVW+SyvbnyCSJJ8/8T+cplz/+EuzeE9u9N
	tikQ+AlvWyQ6T0JYYcg==
X-Google-Smtp-Source: AGHT+IFByzKPeg2NuLo9wRBWyRvItgQicHm8IJnellRKJpnxZHGQw+ZCI2vvobuBqc4GgWmdcxiFQg==
X-Received: by 2002:a05:6a20:2d1f:b0:1f5:7d57:8309 with SMTP id adf61e73a8af0-2148c0fa8cbmr3669210637.21.1746607775448;
        Wed, 07 May 2025 01:49:35 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059021067sm10884626b3a.107.2025.05.07.01.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:49:35 -0700 (PDT)
Message-ID: <ed42bdd1d43dd856978e8dea5b6bbc736e182d8a.camel@gmail.com>
Subject: Re: [PATCH 09/28] check-parallel: allow FSTYP selection from the CLI
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 07 May 2025 14:19:31 +0530
In-Reply-To: <20250417031208.1852171-10-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-10-david@fromorbit.com>
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
> Add a CLI option to specify the initial FSTYP to test. If this is
> not specified the the default of "xfs" will be used. This option is
> different to the way check has FSTYP specified as check-parallel
> has no infrastructure to support non block device based filesystems
> and hence we have to reject virtual or network based filesysetms
> are this point in time.
> 
> Note: This patch only implements default mkfs parameter support for
> the test device. Config sections can be used to override this as
> check will then format the test device when the section that defines
> non-default test device mkfs options is selected.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel | 44 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/check-parallel b/check-parallel
> index 5fee62f37..19f2d2b0c 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -18,7 +18,7 @@ run_section=""
>  
>  tmp=/tmp/check-parallel.$$
>  
> -export FSTYP=xfs
> +FSTYP=
>  
>  . ./common/exit
>  . ./common/test_names
> @@ -35,6 +35,7 @@ check options
>      -r			randomize test order
>      --exact-order	run tests in the exact order specified
>      -s section		run only specified section from config file
> +    -f <FSTYPE>		specify the filesystem type to test
>  
>  testlist options
>      -g group[,group...]	include tests from these groups
> @@ -66,16 +67,39 @@ external_file argument is a path to a single file containing a list of tests
>  to exclude in the form of <test dir>/<test name>.
>  
>  examples:
> - check-parallel -D /mnt xfs/001
> - check-parallel -D /mnt -g quick
> + check-parallel -f xfs -D /mnt xfs/001
> + check-parallel -f ext4 -D /mnt -g quick
>   check-parallel -D /mnt -g xfs/quick
>   check-parallel -D /mnt -x stress xfs/*
> - check-parallel -D /mnt -X .exclude -g auto
> - check-parallel -D /mnt -E ~/.xfstests.exclude
> + check-parallel -f btrfs -D /mnt -X .exclude -g auto
> + check-parallel -f udf -D /mnt -E ~/.xfstests.exclude
>  '
>  	    exit 1
>  }
>  
> +# Only support block device based filesystems with generic mkfs support
> +# at the moment.
> +is_supported_fstype()
> +{
> +	local fstype=$1
> +
> +	case $fstype in
> +	xfs)		;;
> +	ext2|ext3|ext4)	;;
> +	udf)		;;
> +	jfs)		;;
> +	f2fs)		;;
> +	btrfs)		;;
> +	bcachefs)	;;
> +	gfs2)		;;
> +	ocfs2)		;;
Extremely minor: Maybe list the test in alphabetical order?
The rest looks fine to me. 

Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> +	*)
> +		echo "unsupported FSTYPE: $fstype"
> +		usage
> +		;;
> +	esac
> +}
> +
>  # Process command arguments first.
>  while [ $# -gt 0 ]; do
>  	case "$1" in
> @@ -92,6 +116,8 @@ while [ $# -gt 0 ]; do
>  	--exact-order) _tl_setup_ordered ;;
>  	-n)	show_test_list="yes" ;;
>  
> +	-f)	is_supported_fstype $2 ; FSTYP=$2; shift ;;
> +
>  	-s)	run_section="$run_section -s $2"; shift ;;
>  
>  	-*)	usage ;;
> @@ -109,6 +135,8 @@ while [ $# -gt 0 ]; do
>  	shift
>  done
>  
> +export FSTYP=${FSTYP:=xfs}
> +
>  if [ ! -d "$basedir" ]; then
>  	echo "Invalid basedir specification"
>  	usage
> @@ -225,8 +253,6 @@ runner_go()
>  	xfs_io -f -c 'truncate 8g' $_scratch
>  	xfs_io -f -c 'truncate 1g' $_logwrites
>  
> -	mkfs.xfs -f $_test > /dev/null 2>&1
> -
>  	export TEST_DEV=$(_create_loop_device $_test)
>  	export TEST_DIR=$me/test
>  	export SCRATCH_DEV=$(_create_loop_device $_scratch)
> @@ -240,6 +266,10 @@ runner_go()
>  	mkdir -p $RESULT_BASE
>  	rm -f $RESULT_BASE/check.*
>  
> +	# Only supports default mkfs parameters right now
> +	wipefs -a $TEST_DEV > /dev/null 2>&1
> +	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV > /dev/null 2>&1
> +
>  #	export DUMP_CORRUPT_FS=1
>  
>  	# Run the tests in it's own mount namespace, as per the comment below

