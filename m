Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB112CD88
	for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827864; cv=none; b=RfFAFlSU2XOrP0LOQAJWh8QSVqpZ67lVj4ZKLTkrNt76DQTCmRSfYgsnjKPUtQjAVRk29ucmkuxtU+Xlcxv8+maLcbinGrG0kov/S1fpwk7EXCmzuxfyMhrJu9RVAPNExZ7Vk3z0dt35lsJdepon+fYh7MpAw7K4Y4kxGf8wWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827864; c=relaxed/simple;
	bh=3QjdSWwIo/gyB37LWxY1MDvP0o0lFV3WKc0Q30vKdz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPS+OlmeEGztxDpK1ta1nbv3djUZ0YjgG1eEQAf66isS2xjrUB3L30Yr3l2Nb9U8yG5NPVg0BB+T7qjYbUHtE9iy9bkTZy4NI8pPJdwYFdCsNWXsel+7cgiBF1CNx9UMxeggtRt8zpTeXwMwfPbKfG+DBTSeHJOM9ptrQeeO7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoNC2uhz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoNC2uhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729827861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YteKj671hcr8DQ+XdblfAXUrIeB884eD+JKzRyJ4y5s=;
	b=EoNC2uhz0ouY6FZNUamaWbWDH63I1nBi5kmXY/hJEEnU1l2Il6Zi5u2PTR+u9KVrMCMOaV
	+ighu4faAF1fnL5l/b4v/TDS2dEfDfJQMFKomWvC6+A4GS56bcfSpReSSsLLqhGtR9Eczu
	cpPycYCiEsy1C9FsykZhN62szNDAzdY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-tg2kHqSUPQ2hEE8EM6571A-1; Thu, 24 Oct 2024 23:44:19 -0400
X-MC-Unique: tg2kHqSUPQ2hEE8EM6571A-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7ea750b5e87so1220540a12.1
        for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 20:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827858; x=1730432658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YteKj671hcr8DQ+XdblfAXUrIeB884eD+JKzRyJ4y5s=;
        b=BcWT86NGvoEPeMZa/sSHLfadWemPQvci20TJTD28LA5FDG1u0yAnBCCGrcxU6MCx/A
         /tzORQ7Wo3/yJ9/mFf3Hz+M2MuC8Ax99alFTitN+ifW1BNqFp+uF2Cegd1WXkt+8XE79
         suNceJ/GCF1Y/Jy5EZi5uBJ8YgSSpcMgmjgMuPxYUaoe3Vg7e/TOFMS/UJIIJpS0ZyTO
         Djpf28rpFK9aNUmMKDU3oc5TOhXupRu+FOC+p1MyY1566BotWzlxAwefUHZenSV56Oae
         lDmNmo3HrfhfOvi6yeFgkMreqh+izmlVjMH4VWgLw3nfDgbTnTRRFSyO7HT3UxcSUiSr
         ib6w==
X-Gm-Message-State: AOJu0Yx448eggVIAQUi76kEUwHAMEC1Ftwn567kpwgN5kqsG7DD6JlUj
	zsV/vElD77JmDaFe59JdTmeYuZI8KRK5PRz8bp/240j7iIaM1ms2PQbpMRZUqfOXIxE5utCBrP2
	6m+GVpSGeeJ3gX8MoLGGBd/BGrHsxRWBVpDwf/PiaNszeENmrFyx0HdU=
X-Received: by 2002:a05:6a21:710a:b0:1d9:f95:9f97 with SMTP id adf61e73a8af0-1d978af831amr10840719637.16.1729827858465;
        Thu, 24 Oct 2024 20:44:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4QQcO6UMR0AKLdGxEQmICmZ+jzSj53Fer+sedMwzKSexZ13lMbDEZQDiXBdyIk3loj95qsw==
X-Received: by 2002:a05:6a21:710a:b0:1d9:f95:9f97 with SMTP id adf61e73a8af0-1d978af831amr10840702637.16.1729827858064;
        Thu, 24 Oct 2024 20:44:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3bf5fsm177475b3a.183.2024.10.24.20.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:44:17 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:44:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/2] f2fs/006: add testcase to check out-of-space case
Message-ID: <20241025034413.5s6ecilfgqcoeudt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241023081602.3806579-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023081602.3806579-1-chao@kernel.org>

On Wed, Oct 23, 2024 at 04:16:01PM +0800, Chao Yu wrote:
> This is a regression test to check whether f2fs handles dirty
> data correctly when checkpoint is disabled, if lfs mode is on,
> it will trigger OPU for all overwritten data, this will cost
> free segments, so f2fs must account overwritten data as OPU
> data when calculating free space, otherwise, it may run out
> of free segments in f2fs' allocation function, resulting in
> panic.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add _fixed_by_kernel_commit()
> - use _scratch_mkfs_sized() rather than formating size-specified
> loop device
> - code cleanup
>  tests/f2fs/006     | 38 ++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/006.out |  6 ++++++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/f2fs/006
>  create mode 100644 tests/f2fs/006.out
> 
> diff --git a/tests/f2fs/006 b/tests/f2fs/006
> new file mode 100755
> index 00000000..63d00018
> --- /dev/null
> +++ b/tests/f2fs/006
> @@ -0,0 +1,38 @@
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
> +# of free segments in f2fs' allocation function, resulting in
> +# panic.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix to account dirty data in __get_secs_required()"
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +_require_scratch
> +_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
> +
> +# use mode=lfs to let f2fs always triggers OPU
> +_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
> +
> +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
> +
> +# it may run out of free space of f2fs and hang kernel
> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync

What kind of failure should be printed at here if test on unfixed kernel?
I got:

# diff -u /root/git/xfstests/tests/f2fs/006.out /root/git/xfstests/results//default/f2fs/006.out.bad|less
--- /root/git/xfstests/tests/f2fs/006.out       2024-10-25 11:33:54.693883281 +0800
+++ /root/git/xfstests/results//default/f2fs/006.out.bad        2024-10-25 11:34:55.907252401 +0800
@@ -1,6 +1,6 @@
 QA output created by 006
 50+0 records in
 50+0 records out
-dd: error writing '/mnt/scratch_f2fs/testfile': No space left on device
-3+0 records in
-2+0 records out
+dd: fsync failed for '/mnt/scratch/testfile': Input/output error
+50+0 records in
+50+0 records out

Does that mean the bug is reproduced?

> +
> +_scratch_remount checkpoint=enable
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
> new file mode 100644
> index 00000000..0d7b3910
> --- /dev/null
> +++ b/tests/f2fs/006.out
> @@ -0,0 +1,6 @@
> +QA output created by 006
> +50+0 records in
> +50+0 records out
> +dd: error writing '/mnt/scratch_f2fs/testfile': No space left on device

The "/mnt/scratch_f2fs" should be SCRATCH_MNT, please use _filter_scratch()
by importing common/filter.

> +3+0 records in
> +2+0 records out
> -- 
> 2.40.1
> 

