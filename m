Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D71D63C2
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278472; cv=none; b=pGVISlCDPT/P2u0A3iR3pBEWr0/5b2iMmlUtxfTUudqSY7XszId2ffnOyZ2ftWvBVCXWPyLBq2e+CtH+AQCcUptTb8Y1QrY7jBE0zNwuU5kJXgtsMnYSsm8QIfatkWb3qiZKEF0mB6k1u2cVnvugkBujq+BjhgwFX9+eGYNjgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278472; c=relaxed/simple;
	bh=tPvsw6IQ1wdxi7IsP6D5Qv8d2rjiAb75FJ5OwcdSANU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/0yIL0rQYp97826m2Dwk/uHtZ5todoGpCh4rGIzgOp6eRwogpXJIUYTjRmI8KOuHVKN2WFxUWPQmx77RUtX/gTKyaCCFb4zlUeUs+PX9R2smGm0W0cCHyec7h96JHIMkd0vu5ISarCW+X+yUpfC2TwuhS3xmitYv0LN7NZZURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1VTFxx2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1VTFxx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750278469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bv/FEAhuDX73FTKSiqZ3j1+IvMaDUfQ5VJy1iOE15vE=;
	b=d1VTFxx2R2xR8paPI7NeNsns+e4Njrykt5wP7NPNDWzGMxy5w9koFBkmJqDxj1oMif/+Kq
	9m0ffT3fLQa/eHeLAoNhV1Xj63d3sAMJvVQ2PyfzR++RFZb1cIX8D16cscVq10/Cvpnozo
	aUTFpLNjSYBnl9dDsctY4xipwOKLUsA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-tv2R7DENOKW9GQmk33jieQ-1; Wed, 18 Jun 2025 16:27:47 -0400
X-MC-Unique: tv2R7DENOKW9GQmk33jieQ-1
X-Mimecast-MFC-AGG-ID: tv2R7DENOKW9GQmk33jieQ_1750278467
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af59547f55bso63643a12.0
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 13:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750278467; x=1750883267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv/FEAhuDX73FTKSiqZ3j1+IvMaDUfQ5VJy1iOE15vE=;
        b=ElkhMZjH9KAzFH9Y3j7oBF2IkApjYNcMgsjkLK1qPv6rveRceQotbLX7g+MH0NyKvJ
         3YbNU/TSLOVjsDZPPHlEAHTIH6cfdb0guBW0pY2aGcxRI6Sfly2sb3ukfU1J0SP24Y+N
         os6GJumQn6z+ofImZYXUWgLUSSMroi7v96HOH/syCiqjX+EXv4e7U+3IDyqY8a80AXCK
         ZNWmASBouFvnk5gr3OB/lxxltaAa24iLGaQL6A1MAsdcprXHJzRWfaBdksdlyx+BDgT9
         Y6QVZS28j1+HwFPypYmbbViFRJ1f15qfzn5XCix0kVlsrV7D2/t/SpFnmKvleT9GrPmY
         /Upw==
X-Gm-Message-State: AOJu0YwiB0khbGmk3/IHw1IPPJ9Cb7+SjE4wk73gAYUuLWpSjOKwmdTz
	wPyyP53p2z+oineROtEPWYmkkUoNWhIls2uMxizYURic9aMVkgNTOk27mwqY7PnS4dB0udSWPox
	fMiMj7bnWdmUYwpMis3WHNtwM19nwnztxbQtfTTVrI0KAK+8rs3grsvmNPvI=
X-Gm-Gg: ASbGncs8yIizzHKUTL9FrcoLGdRekrLWAXbWe/YKnvuxeoHb8gBQQdtbizcgPqfkeQY
	KqQCn0yYP3zSFT/XD9gDAVm5lTG9TxwNXANROPFCkNu4fh1LcCORmu7EHNei7OH4U9gN3rFSFd5
	x7bOfQcfe9WsqTTh2zo+/IjQ8AGB8rRnK6hu5jN0zknDwKhUMeBFCta96HJJ3i0mXyZhGOtbS2s
	sniQwXESdez0kIh5s1vUVBdKrJk8yTWs0Lbo9PsJcE/rq1fG0dIzBuzINfLQ+9zjHusyoN5kv4a
	x7513+4lhDruVu43i7aEHY5ltKsSG12cO7HY/4GaMCGqwLpyjHaX3Vwb4mL2rbA=
X-Received: by 2002:a05:6a21:648b:b0:21f:53e4:1925 with SMTP id adf61e73a8af0-21fbd523a1dmr24989558637.10.1750278466780;
        Wed, 18 Jun 2025 13:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERURdLUVTZcJ3+mtv1dlXX2O4HbHHWgm60DxE/XZhkakzgG0KtFk+jTT+Ks0SIETls45F4eA==
X-Received: by 2002:a05:6a21:648b:b0:21f:53e4:1925 with SMTP id adf61e73a8af0-21fbd523a1dmr24989540637.10.1750278466444;
        Wed, 18 Jun 2025 13:27:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748e2c21dc5sm2744409b3a.132.2025.06.18.13.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:27:45 -0700 (PDT)
Date: Thu, 19 Jun 2025 04:27:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 07/12] generic/771: Stress fsx with atomic writes enabled
Message-ID: <20250618202741.dziguhshlq2cqj5b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:50PM +0530, Ojaswin Mujoo wrote:
> Stress file with atomic writes to ensure we excercise codepaths
> where we are mixing different FS operations with atomic writes
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/771     | 49 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/771.out |  2 ++
>  2 files changed, 51 insertions(+)
>  create mode 100755 tests/generic/771
>  create mode 100644 tests/generic/771.out
> 
> diff --git a/tests/generic/771 b/tests/generic/771
> new file mode 100755
> index 00000000..690dfa0a
> --- /dev/null
> +++ b/tests/generic/771
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 771
> +#
> +# fuzz fsx with atomic writes
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest rw auto quick atomicwrites
> +
> +# Import common functions.
> +. ./common/filter

I think this's useless for this case.

> +
> +_require_test

Do you use TEST_DEV or TEST_MNT ?

> +_require_odirect
> +_require_scratch_write_atomic
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount  >> $seqres.full 2>&1
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`

Do you need _require_block_device? Or is nfs, cifs or overlay... good for this test?

> +
> +# fsx usage:
> +#
> +# -N numops: total # operations to do
> +# -l flen: the upper bound on file size
> +# -o oplen: the upper bound on operation size (64k default)
> +# -w writebdy: $psize would make writes page aligned (on i386)
> +# -Z: O_DIRECT (use -R, -W, -r and -w too)
> +# -W: mapped write operations DISabled
> +
> +_run_fsx_on_file $testfile -N 10000 -a -o $awu_max  -l 500000 -r $bsize -w $bsize -Z -W $FSX_AVOID >> $seqres.full
> +status=$?

Generally we _exit directly after changing $status.

> +
> +if [[ "$status" != "0" ]]
> +then
> +	echo "Somthing went wrong, check $seqres.full"
> +fi

but you don't _exit ...

> +
> +echo "Silence is golden"
> +status=0

Then the status will be set to 0 again. So above "status=$?" is useless.
You can check "$?" directly, or exit directly if _run_fsx fails.

Thanks,
Zorro

> +exit
> diff --git a/tests/generic/771.out b/tests/generic/771.out
> new file mode 100644
> index 00000000..c2345c7b
> --- /dev/null
> +++ b/tests/generic/771.out
> @@ -0,0 +1,2 @@
> +QA output created by 771
> +Silence is golden
> -- 
> 2.49.0
> 
> 

