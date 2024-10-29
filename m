Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347320262A
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208442; cv=none; b=Vfv/AzCUKDXiCrPQBDsnoN8aud24MBh+dBK1+jI3siSer1pzwHhHMM/S/OEN1ODLtT+pKUtM9Z/mFOAHdsng3jJaak6jjTVdg9vPPejLH45jMhMg5nqRD5YcuutSPshnVHIbUNdp4xTnodaAJXaVSUJr4fJidKF9lCWDsVZfmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208442; c=relaxed/simple;
	bh=YkSTKDAMs8Kme3xJp0Xe1T+7GgWRdnBla34STBKIyDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpXwoyKp/ITGk94dUDpGeT3NT4f70Zynmfw7zcTVLkcZVIvbkzUtd9i6S78fxNFZvdLr4ndZSX693uc/E90TnSK6FvfuZZ0msVBlvlUoj2S1DAQ0LbmMmlxVSsPClCv1bBTR64HsmG3F+G0Ew1sVByKnZ32HA8Cdom/0pfHOHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFm835g8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFm835g8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730208439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw7ZnwN/MMT0OxVyJJnC8LudHJvtO616079N5Etu0cw=;
	b=CFm835g8ybCG5OG5bEHfZukUPpViFzCYPOmQnOpSN6tCY6ZnJfHSBQSM6l070ikrkYdGPi
	ZwJPJBSnFGSNRrY7j2T+QhZ2c/Q4g0I6UWR0pGzcd4j8JjPSvt7I/hknFFgC7fqB8iCZSo
	EUub3rd499dgRZvZrHdTCm3t7Vpljl0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-4sPuvOfZO-Kk_MEb04hGBg-1; Tue, 29 Oct 2024 09:27:17 -0400
X-MC-Unique: 4sPuvOfZO-Kk_MEb04hGBg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e3912db200so6775302a91.2
        for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 06:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730208436; x=1730813236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw7ZnwN/MMT0OxVyJJnC8LudHJvtO616079N5Etu0cw=;
        b=i3K6AyiiuKwhxA0mvexQ7mDPbdIAXaOSnJGn0IkTJZ3AP+ej3AXLg3RE+EcZ7KGqwJ
         Ci6b97ftuVCno6ThMxERRwHmVahYEt4Gy/mb3s5UQO3cnlwjxeoAAoUL09PJOzXMr1XM
         BpqHftLtnLCf7DA0mtL8QXzStGBPDxAwNPawyyyf1AuGuRpNtVCQTZsnl+x/PiAm++e1
         qeyScOC6hbgPyjNBZGu6VFMsbog/Hx+GFMtx3IL8wBwSmW8gg9ICMMLBNfvBnrNQApoG
         q//fDW3WR3PNGL+9J6zn4VULUhd0d3HBv2ccIOgtq9efPeKUhaXwvNpyY9FgEl2jUPSX
         PX4A==
X-Gm-Message-State: AOJu0Ywc8rzn3cYQtnx0bKws5URyIEpndBXYePJgYB9qD5w0vnMilQ0l
	Zmp2FqSxoHLfe7pd9Yl71/yd6zjS8LDzzQIGGdnCFkk5YyluQOiSG3PhW8lc6hO4rT9WkG4/rtK
	mTPwzQLGL131dshFr1VjSX9wM4j8wo214t8vZ+EfGnYJcT4c8WnnKg8c=
X-Received: by 2002:a17:90b:4388:b0:2e2:b281:536e with SMTP id 98e67ed59e1d1-2e8f1070ed3mr13210269a91.15.1730208436619;
        Tue, 29 Oct 2024 06:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg2CJLFqwmOmUMIpzaQ5Tb2n2VjcwffUlLAFBdGFahpFV+qdUdM/WSu+/t38NyF2egntO6Kg==
X-Received: by 2002:a17:90b:4388:b0:2e2:b281:536e with SMTP id 98e67ed59e1d1-2e8f1070ed3mr13210243a91.15.1730208436018;
        Tue, 29 Oct 2024 06:27:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555ad3sm9445914a91.1.2024.10.29.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:27:15 -0700 (PDT)
Date: Tue, 29 Oct 2024 21:27:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v4 1/2] f2fs/006: add testcase to check out-of-space case
Message-ID: <20241029132711.veu5kgqkgmjatneq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241029102644.4027606-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029102644.4027606-1-chao@kernel.org>

On Tue, Oct 29, 2024 at 06:26:43PM +0800, Chao Yu wrote:
> This is a regression test to check whether f2fs handles dirty
> data correctly when checkpoint is disabled, if lfs mode is on,
> it will trigger OPU for all overwritten data, this will cost
> free segments, so f2fs must account overwritten data as OPU
> data when calculating free space, otherwise, it may run out
> of free segments in f2fs' allocation function. If kernel config
> CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
> dd may encounter I/O error.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - check dmesg instead of unstable output from dd

This version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/006     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/006.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/f2fs/006
>  create mode 100644 tests/f2fs/006.out
> 
> diff --git a/tests/f2fs/006 b/tests/f2fs/006
> new file mode 100755
> index 00000000..a9c823c1
> --- /dev/null
> +++ b/tests/f2fs/006
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/006
> +#
> +# This is a regression test to check whether f2fs handles dirty
> +# data correctly when checkpoint is disabled, if lfs mode is on,
> +# it will trigger OPU for all overwritten data, this will cost
> +# free segments, so f2fs must account overwritten data as OPU
> +# data when calculating free space, otherwise, it may run out
> +# of free segments in f2fs' allocation function. If kernel config
> +# CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
> +# dd may encounter I/O error.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix to account dirty data in __get_secs_required()"
> +
> +_require_scratch
> +_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
> +
> +# use mode=lfs to let f2fs always triggers OPU
> +_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
> +
> +# The 2nd dd might run out of space, and trigger a kernel warning or
> +# hang on unfixed kernel
> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full 2>&1
> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full 2>&1
> +
> +_scratch_remount checkpoint=enable
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
> new file mode 100644
> index 00000000..675c1b7c
> --- /dev/null
> +++ b/tests/f2fs/006.out
> @@ -0,0 +1,2 @@
> +QA output created by 006
> +Silence is golden
> -- 
> 2.40.1
> 

