Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F111E7C2E
	for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312222; cv=none; b=AY7/jVc8w7HGhJjo5GwJnKNEETaHauHO3arRvPJ7Uhy32/EONSMtBW/DJpFtCWTLphnEsJ5uWxSjyTyOUGocEwnF2QzDB5YBVR09t2da+FUdGndM6pzs7GoINmc4EdVGWvX8kKBlgXmBG4fNyCSjzvF417HBB2gEnt9BxFnF6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312222; c=relaxed/simple;
	bh=0Zk0yuqrCun3oUWa1Pc4OEUnIpFflBAM2fTLk2+5aN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMEdhlIU1hrtG+MYq5fJX4rPiWsohicpJt++bAfAaMw2CPPII8TEJGjVyE2IAnUULVw2ELY/0mapEcHVgFqzaDEUx+m32Mao9zJLXPKZu+hIkkGnUyyYldz4xf3UrHwkJLBcJYXlVuPNmI+v47lAslYpCM+4KuSkpVMZ34WigpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXXvR+GP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXXvR+GP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756312219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2uLZh/ia26W8L/xMW0jGip+WWLHMpDsr0QFny116Vs=;
	b=hXXvR+GP9GAUa0V0Y9/Tke/Rw535hmrbNhEclrjPgXSQsbaeXHVUxJNYDxRkQjfxwlqScr
	cOzFJp2paATonPmuk5BeUMT27Lq56ouORWWxZPCeKMRp4cfNAunO9iHZkt6HOCXlucoTRJ
	1vvKZduObRRj4czjY7zRd0UHwZtv1as=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-3v_UlOz2PomOYVt3ygUOZw-1; Wed, 27 Aug 2025 12:30:16 -0400
X-MC-Unique: 3v_UlOz2PomOYVt3ygUOZw-1
X-Mimecast-MFC-AGG-ID: 3v_UlOz2PomOYVt3ygUOZw_1756312215
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458274406so61565ad.3
        for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 09:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756312215; x=1756917015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2uLZh/ia26W8L/xMW0jGip+WWLHMpDsr0QFny116Vs=;
        b=V/cCV87hnhAWwA5r3ys42eqEAgAswEntjMGY0ivHJ5C92xIFnEnQ+G8YBg6PVTTY3Y
         zr/31bq/L62Gihhw7Ew/D6921lz6t71S1h0npPJ1ZDeEreum/mISEtZDZAQIG4f9rowH
         yfV0PhvBGLuJidOH9KDQlKWau0HROcBYSs/QJDKxZVIEkPVeh8DacYPniG6OxE/ieJSn
         IB/821fy2G1+kQH73F7+SrGFaY0hJ4Y8FKMRYL7ZMfqP419z0vTRXYeKZsh6gMkxYbYZ
         BpWpMsbOpZDcuROVrjK82J+/uMvcTWaXLyFoOBpHMiXZH/7AnziIdyuOlQHxsQWz1zgX
         eWXw==
X-Forwarded-Encrypted: i=1; AJvYcCVQFiUt99dS1bJ2wejzcXGRHCDcVzC6ELHWW+eUfroFKTBPQF06S73TdJ7lUtTf92XAWKBXLBUN@vger.kernel.org
X-Gm-Message-State: AOJu0Yym547YD4IRdXjCARERKImNrzW1CKp4Yuc78vkDvmiBycnee6oi
	YH0pYASNuKfa8ngh5kYWi39k7WpNgvgcY+lYYc0keSwBOrYv1mxZ0V7LsJYO70wDdOteCNYMSgM
	DvMOHvGYK4SPQIoHE+BxfzzTkdT+V+lbjWKziqnXJRzggnn6H6aLQE+joHmVrKAQvyW0=
X-Gm-Gg: ASbGnctvU4/eXOM/+oZNfrk5LWj2jq+G6llOINBXL6hxkobfgKeTaGqNkwn6r5aXjJM
	kCa+qWVlpbqZexX9hQRVmYzqK9UnC1qTJCsSi2bmNhl93q4TGQwc63DXas61oGCCJW9W3duR4YN
	B1NLFeemSVUBJ6jBwM4DLUaXXtzyZoT+UT+YaN8xeMxZ4E8A0pI3q45rVurXPLjIWDqTje5iEUk
	q/XaTO+FjJoux80L9N4Du2LlzFIQh/mYZWKz+t01LWJ68iUmx89TAN5k5AwR3RSS18UVBDRSToR
	MuF1s4i7ttbCoE//0Tdds10RB9X74pfAqbG8Ar96Pe+P36DKtGgHw4iSqfmXQVMCM8X4lLzcsgS
	hZMv2
X-Received: by 2002:a17:902:e888:b0:246:570:2d99 with SMTP id d9443c01a7336-2462efc9965mr247851395ad.58.1756312214981;
        Wed, 27 Aug 2025 09:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE98l1zbOZQyoC7KgKNLGmuhvQt2Rlqysg/Nbr1XV14Cq0l9fQoW9U1/i5zN32gbFQm+HaHzA==
X-Received: by 2002:a17:902:e888:b0:246:570:2d99 with SMTP id d9443c01a7336-2462efc9965mr247851115ad.58.1756312214558;
        Wed, 27 Aug 2025 09:30:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246837c124fsm114913735ad.138.2025.08.27.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:30:14 -0700 (PDT)
Date: Thu, 28 Aug 2025 00:30:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs: add a new test case to verify
 compressed read
Message-ID: <20250827163010.wli3kz2nfmvl3w4a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250827014250.170552-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827014250.170552-1-wqu@suse.com>

On Wed, Aug 27, 2025 at 11:12:50AM +0930, Qu Wenruo wrote:
> The new test case is a regression test related to the block size < page
> size handling of compressed read.
> 
> The test case will only be triggered with 64K page size and 4K btrfs
> block size.
> I'm using aarch64 with 64K page size to trigger the regression.
> 
> The test case will create the following file layout:
> 
>   base:
>   [0, 64K): Single compressed data extent at bytenr X.
> 
>   new:
>   [0, 32K): Reflinked from base [32K, 64K)
>   [32K, 60K): Reflinked from base [0, 28K)
>   [60K, 64K): New 4K write
> 
>   The range [0, 32K) and [32K, 64K) are pointing to the same compressed
>   data.
> 
>   The last 4K write is a special workaround. It is a block aligned
>   write, thus it will create the folio but without reading out the
>   remaing part.
> 
>   This is to avoid readahead path, which has the proper fix.
>   We want single folio read without readahead.
> 
> Then output the file "new" just after the last 4K write, then cycle
> mount and output the content again.
> 
> For patched kernel, or with 4K page sized system, the test will pass,
> the resulted content will not change during mount cycles.
> 
> For unpatched kernel and with 64K page size, the test will fail, the
> content after the write will be incorrect (the range [32K, 60K) will be
> zero), but after a mount cycle the content is correct again.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Fix the golden output which is generated by an unpatched kernel
> 
> v2:
> - Remove the unnecessary sync inherited from the kernel fix
> - Use _hexdump instead of open-coded od dumps
> - Use the correct 'clone' group instead of 'reflink'
> - Minor grammar fixes
>   All thanks to Filipe.
> ---

Hi Qu,

This patch is good to me, just a few picky points below:

>  tests/btrfs/337     | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/337.out | 23 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100755 tests/btrfs/337
>  create mode 100644 tests/btrfs/337.out
> 
> diff --git a/tests/btrfs/337 b/tests/btrfs/337
> new file mode 100755
> index 00000000..9c409e4d
> --- /dev/null
> +++ b/tests/btrfs/337
> @@ -0,0 +1,55 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 337
> +#
> +# Test compressed read with shared extents, especially for bs < ps cases.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress clone
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix corruption reading compressed range when block size is smaller than page size"
> +
> +. ./common/filter

Looks like you didn't use any helpers of common/filter in this case :)

> +. ./common/reflink
> +
> +_require_btrfs_support_sectorsize 4096
> +_require_scratch_reflink
> +
> +# The layout used in the test case is all 4K based, and can only be reproduced
> +# with page size larger than 4K.
> +_scratch_mkfs -s 4k >> $seqres.full

 || _fail "...."

Fail the test if the mkfs fails.

> +_scratch_mount "-o compress"
> +
> +# Create the reflink source, which must be a compressed extent.
> +$XFS_IO_PROG -f -c "pwrite -S 0x0f 0 32K" \
> +		-c "pwrite -S 0xf0 32K 32K" \
> +		$SCRATCH_MNT/base >> $seqres.full
> +echo "Reflink source:"
> +_hexdump $SCRATCH_MNT/base
> +
> +# Create the reflink dest, which reverses the order of the two 32K ranges.
> +#
> +# And do a further aligned write into the last block.
> +# This write is to make sure the folio exists in filemap, so that we won't go
> +# through the readahead path (which has the proper handling) for the folio.
> +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/base 32K 0 32K" \
> +		-c "reflink $SCRATCH_MNT/base 0 32K 32K" \
> +		-c "pwrite 60K 4K" $SCRATCH_MNT/new >> $seqres.full
> +
> +# This will result an incorrect output for unpatched kernel.
> +# The range [32K, 60K) will be zero due to incorrectly merged compressed read.
> +echo "Before mount cycle:"
> +_hexdump $SCRATCH_MNT/new
> +
> +_scratch_cycle_mount
> +
> +# This will go through readahead path, which has the proper handling, thus give
> +# the correct content.
> +echo "After mount cycle:"
> +_hexdump $SCRATCH_MNT/new
> +
> +status=0
   ^^^
"_exit 0" does "status=0", so you can save this line.

Others looks good to me, with above changes:

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +_exit 0
> diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
> new file mode 100644
> index 00000000..cecbbbcf
> --- /dev/null
> +++ b/tests/btrfs/337.out
> @@ -0,0 +1,23 @@
> +QA output created by 337
> +Reflink source:
> +000000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> +*
> +008000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> +*
> +010000
> +Before mount cycle:
> +000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> +*
> +008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> +*
> +00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> +*
> +010000
> +After mount cycle:
> +000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> +*
> +008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> +*
> +00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> +*
> +010000
> -- 
> 2.49.0
> 
> 

