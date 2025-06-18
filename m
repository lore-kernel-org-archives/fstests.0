Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612AA3085C7
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272476; cv=none; b=TxRQEk6gL8QWMuj28zdFHRk4XWByF9qkR+c3FQYsDt0xb2ffvL4zY7eNMfiaq31cqtf6FCIYel8ONVyI/uIYCdJNRduTHVYfUaP7N8ZkKgfuqoo8wtu2NuvUO8LSzFSb2Y3+Fyx0F5L8B9r+iWGgMuJ1V/DfGAkihnw91vFoFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272476; c=relaxed/simple;
	bh=VhWDzluooaK9chvfFzuC5/GuDOX9eOcbx2CXMwrZuHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5csxFR3xL7bwjG4uJDz4Rdnjp/B7kQ/CfvHxauGDNGj5YwrQZtPy1Nt2hI7JNiQU5thc51IYm1SwfpUTuHVGHHpNDqWupDBRVCypw9L1bxpM1wh3akr+N1KwinXnN56rSVj8CTG/lsPwjD6sn7GGtKU1787fds9sVrwXNY27/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCFF6ygK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCFF6ygK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750272472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Twg21ZwQl4L0qXNqLA2YKXPnhGN3gMO5sL1OB+T98T8=;
	b=HCFF6ygKqVe4Pwxi71GBJNVdfzBi4KJJV6K7hxd7inhXDl4Mw9OHeLZiOeZHLat7dhqspH
	8UuTOFNisjbcdx5c8w16O2DTxy/bXsn+q4wODytUxnLZCuOK7q32a0wXqGNmYJRMayudGA
	5jBu2FMIZMXTrHlYfI6j2eaC4HGo30s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-TirUcqTXPu2Nn8RoLz2QHw-1; Wed, 18 Jun 2025 14:47:51 -0400
X-MC-Unique: TirUcqTXPu2Nn8RoLz2QHw-1
X-Mimecast-MFC-AGG-ID: TirUcqTXPu2Nn8RoLz2QHw_1750272471
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b1442e039eeso19910a12.0
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 11:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750272470; x=1750877270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Twg21ZwQl4L0qXNqLA2YKXPnhGN3gMO5sL1OB+T98T8=;
        b=Rup8dnJZ1C5lYoEQMWTKhsRhly399wrzuYgTZFtCpjsWa8M+bSeyu0IHw4Wisd0su1
         1KCQ3tzy1oBm3WN3mEz0xsVseiytdU8slRkYr+R/nN9QsEa8P3caEuFqyuUCW4je/pqU
         vHkf6GBWC3be4n5uVk08KPMYTcfm2J8qP2/tmRSM9I+Zeq70grFYrebKnsWVR2O/stOb
         NnVMKt/xOZ6Q1vz/DnR36SQI7EDXNmRqGvLoCUHN38D1OzVoj4E1w+5fRk5xdPKvqrh7
         4NqadMchoC9PG2/GYiNyNiSUNkfZf3qmfRWbL4aRbjMjyWnZQbQGDbgDEpeU4ZrvMUHz
         tp7Q==
X-Gm-Message-State: AOJu0YwzvS+f8ba5QbRmbZnu1f5Xnzyp8EbQ2Yd9HmydydPtgtgxLprD
	AVz+fFjgoDNvD3r6O1Y9XGGR0ZNtU9Cb+HGOE1Q69uQCvb9Q8CmJgWHxm4i/engEivkpW63EQso
	e9DzHJQuU2IPvyOUoFnRGTSrD7DnyS5K8Jf90HGzjhOyLSLROWy2vzjhtSW8=
X-Gm-Gg: ASbGncvF6HtV5Afy4SWdFCJHFYCEEqr0W2M177CtOdZ1GRNjy5vtltdilgwpUYuS16K
	Eefum+M2v6WMfpInlxmiOUsnHMnIXHHPg0Rg/fKxTDNJu7n47n4FFpxvziT0kZ3dNu04u+61Jgz
	LEoDEQzYzIhrsvRRShtRrA28IkV5G23ZWdHnulrLg26FM7jfd5oKWME7xc/xcKFnC4pUQgIB7Pr
	xRCTAag0MWpBQHYhUwpSWFG4/BgE7bRphLkOZjukm0DDtOuzEO5mxbShn7/geJ1/jlWf0SuEGrH
	vvRWZT4I/jep6yK1KypQAZU8WuUvqLUspQi7hrkJ1YJHF/rR2neyLh+3bn5HqL0=
X-Received: by 2002:a17:902:70ca:b0:236:7165:6ecf with SMTP id d9443c01a7336-2367165705amr197533175ad.38.1750272470547;
        Wed, 18 Jun 2025 11:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1B+3pjmSuhlGz/ybCVT5TZUivfF0O894H7Bqx3ZivxmY/rrB5ecqq0YkXwIkbonTXh9Px1w==
X-Received: by 2002:a17:902:70ca:b0:236:7165:6ecf with SMTP id d9443c01a7336-2367165705amr197532875ad.38.1750272470159;
        Wed, 18 Jun 2025 11:47:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88f447sm103555365ad.45.2025.06.18.11.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:47:49 -0700 (PDT)
Date: Thu, 19 Jun 2025 02:47:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: fstests@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>, kdevops@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>, gost.dev@samsung.com,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] generic/551: prevent OOM when running on tmpfs with low
 memory
Message-ID: <20250618184744.a7tzgv4dofrqheq6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250618-fix-tmpfs-generic-551-v1-1-271027c36dfc@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618-fix-tmpfs-generic-551-v1-1-271027c36dfc@samsung.com>

On Wed, Jun 18, 2025 at 03:00:12PM +0200, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Running generic/551 on a tmpfs filesystem with less than 10 GB (ish)
> of RAM can lead to the system running out of memory, triggering the
> kernel's OOM killer and terminating the aio-dio-write-v process.
> 
> Fix generic/551 by substracting the amount of available memory allocated
                     ^^^^^^
                     subtracting

> for the tmpfs scratch device to the total available free memory.
> 
> Reported-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
> While integrating tmpfs support for xfstests in kdevops CI [1], we noticed
> that generic/551 could trigger the OOM killer when the scratch device
> is tmpfs, due to not properly accounting for available system memory.
> Fix the test for tmpfs by subtracting the memory allocated to the
> scratch tmpfs mount from the total available memory, ensuring the test
> runs within safe limits.
> 
> [1]
> https://lore.kernel.org/all/20250615-ci-workflow-v1-0-53b267cd2f0a@samsung.com/
> 
> These are the kernel oom-killer logs for generic/551 run on a system
> with less than 10G of RAM:
> 
> run fstests generic/551 at 2025-06-18 11:42:44
> aio-dio-write-v invoked oom-killer:
> gfp_mask=0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0,
> oom_score_adj=250
> CPU: 5 UID: 0 PID: 1717 Comm: aio-dio-write-v Not tainted
> 6.16.0-rc2-00049-g52da431bf03b #10 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2025.02-6
> 04/08/2025
> {...}
> Tasks state (memory values in pages):
> [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem
> pgtables_bytes swapents oom_score_adj name
> {...}
> [   1717]     0  1717   876600   875978   875945       33         0
> 7065600        0           250 aio-dio-write-v
> oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowe
> d=0,global_oom,task_memcg=/system.slice/fstests-generic-551.scope,task=a
> io-dio-write-v,pid=1717,uid=0
> Out of memory: Killed process 1717 (aio-dio-write-v) total-vm:3506400kB,
> anon-rss:3503780kB, file-rss:132kB, shmem-rss:0kB, UID:0 pgtables:6900kB
> oom_score_adj:250
> 
> Results collected with kdevops on the following tmpfs profiles
> (before/after the changes):
> 
> diff --git a/workflows/fstests/results/last-run/
> 6.16.0-rc2-00049-g52da431bf03b/xunit_results.txt
> b/workflows/fstests/results/last-run/
> 6.16.0-rc2-00049-g52da431bf03b/xunit_results.txt
> index 02a1f09..0229294 100644
> --- a/workflows/fstests/results/last-run/
> 6.16.0-rc2-00049-g52da431bf03b/xunit_results.txt
> +++ b/workflows/fstests/results/last-run/
> 6.16.0-rc2-00049-g52da431bf03b/xunit_results.txt
> @@ -1,21 +1,21 @@
>  KERNEL:    6.16.0-rc2-00049-g52da431bf03b
>  CPUS:      8
> 
> -tmpfs_noswap_huge_never: 1 tests, 1 failures, 9 seconds
> -  generic/551  Failed   8s
> -tmpfs_default: 1 tests, 1 failures, 5 seconds
> -  generic/551  Failed   4s
> -tmpfs_noswap_huge_within_size: 1 tests, 1 failures, 8 seconds
> -  generic/551  Failed   8s
> -tmpfs_huge_always: 1 tests, 1 failures, 11 seconds
> -  generic/551  Failed   11s
> -tmpfs_huge_within_size: 1 tests, 1 failures, 8 seconds
> -  generic/551  Failed   8s
> -tmpfs_noswap_huge_always: 1 tests, 1 failures, 6 seconds
> -  generic/551  Failed   6s
> -tmpfs_noswap_huge_advise: 1 tests, 1 failures, 8 seconds
> -  generic/551  Failed   7s
> -tmpfs_huge_advise: 1 tests, 1 failures, 8 seconds
> -  generic/551  Failed   7s
> -Totals: 8 tests, 0 skipped, 8 failures, 0 errors, 59s
> +tmpfs_noswap_huge_advise: 1 tests, 134 seconds
> +  generic/551  Pass     134s
> +tmpfs_noswap_huge_never: 1 tests, 141 seconds
> +  generic/551  Pass     141s
> +tmpfs_huge_advise: 1 tests, 142 seconds
> +  generic/551  Pass     142s
> +tmpfs_default: 1 tests, 139 seconds
> +  generic/551  Pass     139s
> +tmpfs_noswap_huge_always: 1 tests, 109 seconds
> +  generic/551  Pass     108s
> +tmpfs_noswap_huge_within_size: 1 tests, 116 seconds
> +  generic/551  Pass     115s
> +tmpfs_huge_within_size: 1 tests, 112 seconds
> +  generic/551  Pass     111s
> +tmpfs_huge_always: 1 tests, 145 seconds
> +  generic/551  Pass     145s
> +Totals: 8 tests, 0 skipped, 0 failures, 0 errors, 1035s
> ---
>  tests/generic/551 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/551 b/tests/generic/551
> index 4a7f0a638235e272ef55ffeb3b3e548707568379..6a7376d7a8e3580bee0a5c98eacdaf93c60c8d5c 100755
> --- a/tests/generic/551
> +++ b/tests/generic/551
> @@ -38,6 +38,7 @@ do_test()
>  	local truncsize
>  	local total_size=0
>  	local avail_mem=`_available_memory_bytes`
> +	[ "$FSTYP" = "tmpfs" ] && avail_mem=$((avail_mem - free_size_k * 1024))

This makes sense to me. But better to have a comment for this. If you don't
have more suggestions, I'll add below comment when I merge this patch.

# To avoid OOM on tmpfs, subtract the amount of available memory allocated
# for the tmpfs

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  	# the number of AIO write operation
>  	num_oper=$((RANDOM % 64 + 1))
> 
> ---
> base-commit: b7680adf9ff7bdc962fb95b5cbd304abd3137b69
> change-id: 20250618-fix-tmpfs-generic-551-4c74b15d4c25
> 
> Best regards,
> -- 
> Daniel Gomez <da.gomez@samsung.com>
> 
> 

