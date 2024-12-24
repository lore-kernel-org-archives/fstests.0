Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BC1AF4E9
	for <fstests@vger.kernel.org>; Tue, 24 Dec 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034311; cv=none; b=isNivo7ce8Oeb20AgizH0hIIfWG4rGhz+w6V5usUypTnk23YwElP2y3pK5P8A+EjiQwK4FfdFTD8XpPIRut6xPaNjNbsxCP4+U6U4OS2oCNYlRVMpTwgmzOoBuuh/vnw9LxYhW6UiL7cfqpO1NUi0mQa+CptLza8Cy6YJ5NZn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034311; c=relaxed/simple;
	bh=0gdADgAsM2ut3tr3VhiI5NnHwzStN2en8AzswFZzTME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVveik4/sZ10X3Ms7ROeuO4quy2ttE7CmHSGWaM860R/ZHkfZu/VHRlEnuZ4rZZu3XYm7Dyluz0jnOoBph7hvw+7xr+Kb03lCwxs8PWZZaabxWE2MgVppELb6tQcDsuZFFBBH6buSV8vZ3MWVraYyGxSszHfy+InTYSIIEWGoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL801acE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL801acE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735034308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Inzfeq1sXuNH2Lm+tHdVFULsYJqwlPXXwNULENmuYDA=;
	b=fL801acEi6rWmw6sY+SsN8UqUjale6fp+wx19mHIZ6PWou3gJCBfHxySg6weggTuPB73Jg
	ruh1tx/R2fAcElUVF2wxZOetcX8AURHgtW9GO/ctcmECXprtm8PacD6wFxVs9L5sPAyc/A
	0XlodoI1YR8fr1gRmkosjKdNlL4ZEzc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-7wBk3kQhM--SDky4InSbuw-1; Tue, 24 Dec 2024 04:58:27 -0500
X-MC-Unique: 7wBk3kQhM--SDky4InSbuw-1
X-Mimecast-MFC-AGG-ID: 7wBk3kQhM--SDky4InSbuw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so5168394a91.0
        for <fstests@vger.kernel.org>; Tue, 24 Dec 2024 01:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735034306; x=1735639106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inzfeq1sXuNH2Lm+tHdVFULsYJqwlPXXwNULENmuYDA=;
        b=Q2j0XQkBrg4Cg02uD6LFb10szNxl1a6+fm2hQKEsQXg202AgPkZXHqEO3qQJIYKhjZ
         8RNrSPAAuz+TwZK8xpw5rvhgdWNlh2IHMjifVXGr2JmDkvXN9HZyFYXEgygCLJ2UGCch
         lhI6Gd6s0hjdoCq3EAm/VGphjwXvYJbAr/+uXJPHgq4Uykhl7zwgmdETPsC5K/U+CaaS
         OPXckSZLMOttDiBQs/m7Y/f031Gj1YbdGxRozwPnZHaWaXOyLzXQ5VGBYQkVBLBglppN
         GKnDPaGfpPYwcKSan99bjBcbda2ckOs9WLF2JUQ2WLei2H2KcFdTHGj71cZcpagL9GoB
         r7+g==
X-Forwarded-Encrypted: i=1; AJvYcCVtQSScWtmQYeuccZUN4R3ezsGdDy+q55KHR52sTTowSNC7qeK7rD60Stm1gmvBv1cBxjHTKxva@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcZP8l5vIM3d84FOLhVgSO+YBQikHW/5GLPWUSN6L5T0QgYod
	6+3dwsJo58ChVyngr5M+5UEAKFTnICVnkVoPLwikLB9ttRU+FC77zVzvnDdxTJ/RQKA/xzLtjMC
	QnouyurnauC0FKh9EruIWqeeaUy7/JgaSZDHrkta1/mCrTlrjcpXSZTFNMGUMNYkxlA==
X-Gm-Gg: ASbGnctfrMYdSipfLiGR1AnY0SuPhqWAeehoTbH9AjIEFw9zFAvmlWhGIKWEGIVXwyx
	6dG2yyg9QJpDcPAOgyECzOWOJ5JRH364ZJNJpW144/U1QalejVPioNv/pwykFP7BQt48ER51YMW
	TgVyjmFOe6MwGjA+tZL2huUvupjhbKSibssWHcVBBG1IZQPQ8O1Dvr3I1vFKEVF085pUB+nAgBV
	oCmodymPKLplHZ+a3VqTQELxOj5Y1/2erppNEot3TPr7SC+hX3sRC20zTOLN/S1l8cbwos7GLBW
	zMcUAdOKv1w9S8HluHo6Xw==
X-Received: by 2002:a05:6a21:670b:b0:1dc:7907:6d67 with SMTP id adf61e73a8af0-1e5e081c8d0mr29646121637.40.1735034306586;
        Tue, 24 Dec 2024 01:58:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQhQWgdN8z/ID1/XkVVG1F+Cp2R6jsZaHrijRdPme/htkaQtlVkt6GvWoU/Eq5c1ViULJR4g==
X-Received: by 2002:a05:6a21:670b:b0:1dc:7907:6d67 with SMTP id adf61e73a8af0-1e5e081c8d0mr29646098637.40.1735034306204;
        Tue, 24 Dec 2024 01:58:26 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad848020sm9377948b3a.81.2024.12.24.01.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 01:58:25 -0800 (PST)
Date: Tue, 24 Dec 2024 17:58:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 2/2] f2fs/008: test snapshot creation/deletion on lvm
 device
Message-ID: <20241224095821.ylfv622fifsk3tsv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241221082345.196029-1-chao@kernel.org>
 <20241221082345.196029-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221082345.196029-2-chao@kernel.org>

On Sat, Dec 21, 2024 at 04:23:45PM +0800, Chao Yu wrote:
> This patch introduce a regression testcase to check whether
> f2fs can handle discard correctly once underlying lvm device
> changes to not support discard after user creates snapshot
> on it.
> 
> Related bug was fixed by commit bc8aeb04fd80 ("f2fs: fix to
> drop all discards after creating snapshot on lvm device")
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - rebase to last for-next branch
> - update according to Zorro's comments.
>  tests/f2fs/008     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/008.out |  2 ++
>  2 files changed, 59 insertions(+)
>  create mode 100755 tests/f2fs/008
>  create mode 100644 tests/f2fs/008.out
> 
> diff --git a/tests/f2fs/008 b/tests/f2fs/008
> new file mode 100755
> index 00000000..b85e321c
> --- /dev/null
> +++ b/tests/f2fs/008
> @@ -0,0 +1,57 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/008
> +#
> +# This is a regression test to check whether f2fs can handle
> +# discard correctly once underlying lvm device changes to not
> +# support discard after user creates snapshot on it.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +_fixed_by_kernel_commit bc8aeb04fd80 \
> +        "f2fs: fix to drop all discards after creating snapshot on lvm device"
> +
> +_require_scratch_nolvm
> +_require_block_device $SCRATCH_DEV
> +_require_command "$LVM_PROG" lvm
> +
> +lvname=lv_$seq
> +vgname=vg_$seq
> +testfile=$SCRATCH_MNT/testfile
> +
> +_cleanup()
> +{
> +	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
> +	$LVM_PROG lvremove -ff /dev/mapper/$lvname-snapshot $vgname >>$seqres.full 2>&1
> +	$LVM_PROG lvremove -ff /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> +	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
> +	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
> +	_udev_wait --removed /dev/mapper/$vgname-$lvname
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> +$LVM_PROG lvcreate -L 1024m -n $lvname $vgname >>$seqres.full 2>&1

The lvcreate might be blocked by:
  "WARNING: f2fs signature detected on /dev/vg_008/lv_008 at offset 1024. Wipe it? [y/n]:"

So better to use "lvcreate -y" or "yes | ...".

Thanks,
Zorro

> +_udev_wait /dev/mapper/$vgname-$lvname
> +
> +_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> +_mount -o discard /dev/mapper/$vgname-$lvname $SCRATCH_MNT >>$seqres.full 2>&1
> +
> +dd if=/dev/zero of=$testfile bs=1M count=20 >>$seqres.full 2>&1
> +sync
> +rm -f $testfile
> +sync
> +
> +# create a snapshot on lvm device
> +$LVM_PROG lvcreate -L 1024m -s -n $lvname-snapshot /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/008.out b/tests/f2fs/008.out
> new file mode 100644
> index 00000000..dd68d5a4
> --- /dev/null
> +++ b/tests/f2fs/008.out
> @@ -0,0 +1,2 @@
> +QA output created by 008
> +Silence is golden
> -- 
> 2.40.1
> 

