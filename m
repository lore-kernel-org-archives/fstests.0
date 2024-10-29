Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D9201027
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730182169; cv=none; b=oQfsdLofLClbwGi4+2MAOr9glqRxr6bhFHE9HJLTuZzCxGNV69gLNZB4FHcvLrEyQs/hVmdMD2kbAnn/+WeNZ1G1ZX1F6cqPA0yZwNZY4jsrzotHI/+1KCfXUfxG4uY7O/ngldOHu2nTAesIYGj0jyT3mF151PDYeYNumv1cqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730182169; c=relaxed/simple;
	bh=RMz7U5nHC8tfjihqLNBPzoenKuZBLFndpyxeWjbCz6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgw94IW4SlWnFPllVMxLIdTmvYtelXLMN0nNDohc/WUXGhboRU1dCAGnx1eOymhj8a8w0202JtKwqcwc2tAvX1RBSuQIWgIq19LinIBNZYsboHVO4bFcoc+pWy38dE/Hbg2HIKJDNt5RC0STL+SYiJPi0tmNJbd1TgOumK0veK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnmAkESy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnmAkESy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730182166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wayk9Uaz9R4LPhk6DPxYh53zbwDTJRdC1Q80mX7VWuE=;
	b=MnmAkESy31cHhUEuK2IsIh2uKyT6NG+u806lgkVU3IV2lX8zR58foBtd9Lmampo8nrKNPU
	plHnjYsTTdUfISqa/+U+Wq4tb8mSNDNC/UZD1GFEvHq80vc8QhYjhuNmsZ1QLGAM7A3VbI
	U3UtdgLGIwbU6ggM/WNM0qRd0E4aopw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-18Ooo3BcP0SsgQvclEKl-Q-1; Tue, 29 Oct 2024 02:09:24 -0400
X-MC-Unique: 18Ooo3BcP0SsgQvclEKl-Q-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20c8b23167fso47974395ad.2
        for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 23:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730182163; x=1730786963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wayk9Uaz9R4LPhk6DPxYh53zbwDTJRdC1Q80mX7VWuE=;
        b=aMaajuxqZNU0BBSpSs5IKA8m0FBAAJ828Ohm44GhJ51RHGM98RSg6IdlP36FWOZkiY
         5BNqgoWzKW/5aEQ//as5+t+819Ul8Kt+DwgHvdz/FK517GZYGqiuut1JNJSP8SE93Qea
         52lH25VWi+2Lq22C0/IQPs96moiEJgdf4HeP/Sam0a9k+yVWfL/hOHUQhHjquHsaUZt4
         6l7anVJeoKVCWv7zGygOcZMf6DN9zoTD+CoVUu90JAAIrjm58AcoPT9R/xH+mGge/FDv
         N10Rgn5bK9ouO00xWrBlqLOIfD/IrXWaOY7i+0fdzqntX2iyod9MYVUlH8+hXkLA3SqH
         6Fuw==
X-Gm-Message-State: AOJu0YzdaAj867ztKVtYWdTbJLgn7hTPSzEpcUciJ2klw2MBlRnTx60P
	6IPES4yCUWg1H1VsJfHtO6pAotIMwOwOEh/HQCKnxxP7RBK6cdhsOJnLXzNBBjUVDj9ABzKoqVV
	GGA7E7YM81goyC0kWgixGqJFoq1iQRVUhe8FAgIs/l4yTnQYC7FWOPt4=
X-Received: by 2002:a17:903:2287:b0:20d:284c:8d54 with SMTP id d9443c01a7336-210c6c1f299mr167698925ad.34.1730182163541;
        Mon, 28 Oct 2024 23:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3FutxUB3sGN6kqlmFHFBtNNulPOXFb+Y/zWBfzmZD+BgSgN4ehflCGx7ewzqa4rw4Rrrkhg==
X-Received: by 2002:a17:903:2287:b0:20d:284c:8d54 with SMTP id d9443c01a7336-210c6c1f299mr167698715ad.34.1730182163200;
        Mon, 28 Oct 2024 23:09:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0492f8sm59652885ad.256.2024.10.28.23.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:09:22 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:09:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 1/2] f2fs/006: add testcase to check out-of-space case
Message-ID: <20241029060919.gxyywjp3gykaqnuc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241028141800.1788356-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028141800.1788356-1-chao@kernel.org>

On Mon, Oct 28, 2024 at 10:17:59PM +0800, Chao Yu wrote:
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
> v3:
> - explain more about behavior on kernel w/ different config
> - use _filter_scratch to filter $SCRATCH_MNT
>  tests/f2fs/006     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/006.out |  6 ++++++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/f2fs/006
>  create mode 100644 tests/f2fs/006.out
> 
> diff --git a/tests/f2fs/006 b/tests/f2fs/006
> new file mode 100755
> index 00000000..f9560b2b
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
> +# Import common functions.
> +. ./common/filter
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
> +# it may run out of free space of f2fs and hang kernel
> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync 2>&1 | _filter_scratch
> +
> +_scratch_remount checkpoint=enable
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
> new file mode 100644
> index 00000000..2dc9efda
> --- /dev/null
> +++ b/tests/f2fs/006.out
> @@ -0,0 +1,6 @@
> +QA output created by 006
> +50+0 records in
> +50+0 records out
> +dd: error writing 'SCRATCH_MNT/testfile': No space left on device
> +3+0 records in
> +2+0 records out

Hi Chao,

One more question about this patch.

I'm wondering can this output always be matched? If the test doesn't care the dd output,
you can filter out them, to avoid it break golden image. Especially the second one, can
you be sure it always "3 in and 2 out" before returning ENOSPC?

Thanks,
Zorro

> -- 
> 2.40.1
> 

