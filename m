Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CE1F4C96
	for <fstests@vger.kernel.org>; Fri,  1 Aug 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079499; cv=none; b=CMikF3QL6kbNhzvrx8DqtZoRGsgAU9/MR+T5ZU7XkrUS4hsh57TrdoRVEEAk4BTt4LE6mfAC/bJ5Y6hVk6avG5kGwx/ZGYlAT8j7buvWCW9lKhl/vYM1iw3pWIPL0J+jA4X/vwyXxAsi4kzWjzlSvY1fCRJ32/NRfYViylqCDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079499; c=relaxed/simple;
	bh=uMkFiq6AZJwmIkFvE8ChgRTD51SuL7/Yyz2Dw604GGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRBBzKnID5M2WDl+h1r6sN9RWwYKuVRtwnt+9XCPftAT0YPLcE9JvyiRs2mt3T42b3tQAaQq0xMZJsRUGH20G9P0BSP2yEseVXd28Iub74nDP3oRUjOP6l6O2sUr32zZr4oTrIg9SLgJZS+6g0VVPE6cytG2V+3yqxz2ioI/x/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1r2NImH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1r2NImH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754079496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7fmOopcTxDoSThpjeI/4cWAq0iS9rqmpGCXd3gUbIU=;
	b=J1r2NImHLygo+wJtD4FGSm4lTSoVdNUyFOXjt5hhNYG7/HCjkEnmA0w46IruPGDy3F1vvX
	Q6A23JlIDuDXMOvXCHBMEj0H3W+lrgW3yJsaKL737YVTX0eo6P80lfvMcZslFhSyzCTRn7
	Ys4wVUPAvbH2ZmTKlZjKOatL3rLgdGI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-ONkyCawQPiW6KmU_tPoukA-1; Fri, 01 Aug 2025 16:18:13 -0400
X-MC-Unique: ONkyCawQPiW6KmU_tPoukA-1
X-Mimecast-MFC-AGG-ID: ONkyCawQPiW6KmU_tPoukA_1754079491
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so2269686a12.1
        for <fstests@vger.kernel.org>; Fri, 01 Aug 2025 13:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754079491; x=1754684291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7fmOopcTxDoSThpjeI/4cWAq0iS9rqmpGCXd3gUbIU=;
        b=Yrjg1HWrBtHoYHL5H93RnSypmD0wJ7XsaeTptWPlTVYhxeV6XX6mVw5wrp7AHjxa/K
         WRk78yX3Bp771aHx9owhBW4m0wfcCLqIxHvsAI+9EaZrrGTjBw71/GKVPCQOm1yUtmj8
         b6tQnG0qed327GQedloPyJClkcS7QBspk6AP1TO5EQoQ1xZblWnxbDqL8kMtGnMPstKZ
         Aa0euPts5bnhQCc6ixGBY9f9GMx2Mk+e7DWmV2pni1kAv5WSJFYzV4f+RxJp2nW8e9Iv
         RUQVUdaSiTNrnnlrpGy+XCE4g1DQpu//RCx1CDazPz3lEi98Emxg+oV+MCQFyZRvz1Mt
         2Plw==
X-Gm-Message-State: AOJu0YzNKpGvD85wgSfso0+vJ7wxIoak8q8iaWbfsxK+7iFwfum/VQpn
	ohVwpPeAv7xOtbfaYNGMRIBxFzj9ojcx8gkalogR3vAFL2Nn4Nk/ro/pUN1HO1NZ1urrhH/qZR8
	B7oFCt9rMxJvTu+JLuiyleQErxkUiwLVTlDMrstP+EyfGXShjdrAD1w2o3zo=
X-Gm-Gg: ASbGncsEdG3+1FUg8HPSfhzB+KBoGdosyEBh2gxtUQLbHUVrxt0tZuNSFbfLcBev7TH
	uwprHycR6Q+THW093ay+Cn9hGGG4FYgv3B5JLlSndp0k295GBcQcckgLPHgEiRybcZo/jpOpEY7
	ZB8qiX8XnsWmIzQfrY5Zo0LxoFjbUtGJk7ffKVpGkYT6x7DKl1hSoQbybnWNnOsGNz6KChd+rfP
	d/Ien9GO+JGfUJgdJ8FZFM7ExKT1uUp3dOc0AHpqujmMJHEKP1YU2Ze75j4316bVqEqvDYJJub4
	Wdb1gS3+DFS6ivZZLhRzYFPfK1MMzh74jiYrQSorunL/nTVjFe7gUEnQmaGV7+ULDHO8qZBXGUX
	KraqB
X-Received: by 2002:a05:6a20:9194:b0:238:351a:f960 with SMTP id adf61e73a8af0-23df91b34aemr1471838637.23.1754079490794;
        Fri, 01 Aug 2025 13:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnzxdlMr0kIE/UaMgUjepudz7ra/RPe6/qih6kTRpTDvU2Nw2pt+5LvbeotXDB7/B318tkrw==
X-Received: by 2002:a05:6a20:9194:b0:238:351a:f960 with SMTP id adf61e73a8af0-23df91b34aemr1471799637.23.1754079490222;
        Fri, 01 Aug 2025 13:18:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6fe4bsm4837616b3a.9.2025.08.01.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 13:18:09 -0700 (PDT)
Date: Sat, 2 Aug 2025 04:18:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/2] generic: Add integrity tests for O_DSYNC and RWF_DSYNC
 writes
Message-ID: <20250801201805.6h7sa2oyrvhnalph@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
 <9b2427b42e8716c359a36624fd6363f71583941b.1753964363.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b2427b42e8716c359a36624fd6363f71583941b.1753964363.git.ritesh.list@gmail.com>

On Thu, Jul 31, 2025 at 06:05:55PM +0530, Ritesh Harjani (IBM) wrote:
> This test verifies the data & required metadata (e.g. inode i_size for extending
> writes) integrity when using O_DSYNC and RWF_DSYNC during writes operations,
> across buffered-io, aio-dio and dio, in the event of a sudden filesystem
> shutdown after write completion.
> 
> Man page of open says that -
> O_DSYNC provides synchronized I/O data integrity completion, meaning
> write operations will flush data to the underlying hardware, but will
> only flush metadata updates that are required to allow a subsequent read
> operation to complete successfully.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tests/generic/737     | 30 +++++++++++++++++++++++++++++-
>  tests/generic/737.out | 21 +++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/737 b/tests/generic/737
> index 99ca1f39..0f27c82b 100755
> --- a/tests/generic/737
> +++ b/tests/generic/737
> @@ -4,7 +4,8 @@
>  #
>  # FS QA Test No. 737
>  #
> -# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
> +# Integrity test for O_[D]SYNC and/or RWF_DSYNC with buff-io, dio, aio-dio with
> +# sudden shutdown.
>  # Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
>  #
> 
> @@ -21,6 +22,15 @@ _require_aiodio aio-dio-write-verify
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount
> 
> +echo "T-0: Create a 1M file using buff-io & RWF_DSYNC"
> +$XFS_IO_PROG -f -c "pwrite -V 1 -D -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
> +echo "T-0: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-0: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-0: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t1
> +
>  echo "T-1: Create a 1M file using buff-io & O_SYNC"
>  $XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
>  echo "T-1: Shutdown the fs suddenly"
> @@ -48,5 +58,23 @@ _scratch_cycle_mount
>  echo "T-3: File contents after cycle mount"
>  _hexdump $SCRATCH_MNT/testfile.t3
> 
> +echo "T-4: Create a 1M file using DIO & RWF_DSYNC"
> +$XFS_IO_PROG -fdc "pwrite -V 1 -S 0x5a -D 0 1M" $SCRATCH_MNT/testfile.t4 > /dev/null 2>&1
> +echo "T-4: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-4: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-4: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t4
> +
> +echo "T-5: Create a 1M file using AIO-DIO & O_DSYNC"
> +$AIO_TEST -a size=1048576 -D -N $SCRATCH_MNT/testfile.t5 > /dev/null 2>&1
> +echo "T-5: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-5: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-5: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t5

I always hit "No such file or directory" [1], is this an expected test failure
which you hope to uncover?

[1]
# diff -u /root/git/xfstests/tests/generic/737.out /root/git/xfstests/results//generic/737.out.bad
--- /root/git/xfstests/tests/generic/737.out    2025-08-02 04:04:57.334489725 +0800
+++ /root/git/xfstests/results//generic/737.out.bad     2025-08-02 04:12:08.167934723 +0800
@@ -28,16 +28,14 @@
 *
 100000
 T-4: Create a 1M file using DIO & RWF_DSYNC
 T-4: Shutdown the fs suddenly
 T-4: Cycle mount
 T-4: File contents after cycle mount
-000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
-*
-100000
+od: /mnt/scratch/testfile.t4: No such file or directory
 T-5: Create a 1M file using AIO-DIO & O_DSYNC
 T-5: Shutdown the fs suddenly
 T-5: Cycle mount
 T-5: File contents after cycle mount
-000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
-*
-100000
+od: /mnt/scratch/testfile.t5: No such file or directory

> +
>  status=0
>  exit
> diff --git a/tests/generic/737.out b/tests/generic/737.out
> index efe6ff1f..2bafeefa 100644
> --- a/tests/generic/737.out
> +++ b/tests/generic/737.out
> @@ -1,4 +1,11 @@
>  QA output created by 737
> +T-0: Create a 1M file using buff-io & RWF_DSYNC
> +T-0: Shutdown the fs suddenly
> +T-0: Cycle mount
> +T-0: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
>  T-1: Create a 1M file using buff-io & O_SYNC
>  T-1: Shutdown the fs suddenly
>  T-1: Cycle mount
> @@ -20,3 +27,17 @@ T-3: File contents after cycle mount
>  000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>  *
>  100000
> +T-4: Create a 1M file using DIO & RWF_DSYNC
> +T-4: Shutdown the fs suddenly
> +T-4: Cycle mount
> +T-4: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-5: Create a 1M file using AIO-DIO & O_DSYNC
> +T-5: Shutdown the fs suddenly
> +T-5: Cycle mount
> +T-5: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> --
> 2.49.0
> 
> 

