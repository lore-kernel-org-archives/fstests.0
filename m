Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F47382
	for <fstests@vger.kernel.org>; Sat, 28 Dec 2024 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735360070; cv=none; b=fGr0SkbDFzM5vW8A6/cjSs0TXLAfzeb7v5I1hLttmkH6rDzg7Dqvwl44qyOkM1mD11N0pZDtZs7gNDKhXawDFOlIS9XnQOLioCY/Lo0iS1SAstlZW+9Km+sV2ORmQlDHMs4Uv9UhUcygqsq3mT4m4LGttdLP0R/nkUUeGIKGZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735360070; c=relaxed/simple;
	bh=mnOofn6URV9UNfFzszdWSBRA0oZMWIzJMhtz+hWaDKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZllXtU3M2nmrKY7jRlDYFLFsbvRVHQNkTnKr5ImH+WKPuk/xcLiV6tY5PcXB++gHUkOZiWQhzFM28nBeGBiK6JuYjD/6kgfOFqdMEy4wmEeDUX6amz5DMqekSbydtaQBqPPQk/yqj9L7B21pcrM5hYUv35pbj3/PPHuwXW4Uac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyGckHdO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyGckHdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735360067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxKP1JYtpYze2lidt7JggvzgICQVYYUkZoaw6OgMCWM=;
	b=OyGckHdOn3x/Je0sZEDABjsHpMn3MRkeoIdat+dIPpvxZaemuwkcoooG94fZMDiw6suZgI
	/Dd82CUvxCIgnEnX9cNKo0IpBjTXO6kP5Gn/enyLFM8ymF3El1OiJJbBfdapvqdF1P1c/L
	OJVMSXBslj+h77gwwd+cbjFgJgXBMCs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-ANauCbLsM3aF8ASfCpxNUQ-1; Fri, 27 Dec 2024 23:27:45 -0500
X-MC-Unique: ANauCbLsM3aF8ASfCpxNUQ-1
X-Mimecast-MFC-AGG-ID: ANauCbLsM3aF8ASfCpxNUQ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216430a88b0so102463145ad.0
        for <fstests@vger.kernel.org>; Fri, 27 Dec 2024 20:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735360064; x=1735964864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxKP1JYtpYze2lidt7JggvzgICQVYYUkZoaw6OgMCWM=;
        b=v+9CpvUj6BMN5MGZZPbJRW7bf7e13Vn2k7D84sU5kn09eGWxJtCUYxcZbb+r3qu8LG
         1IBPx/OVb6xp5whN3SyGF51AGfs91DDZaiRajjyc1/773fCnIOywg001uIHS3V+/HDYQ
         5lGlb2tVTj60ikTT3PeGHrXwlR5AW5ix+vCeCojl3JWqNhD9czi7PrU1awKQ+7oB0WSR
         YHEDlpB9JFTYxylwzUMlq0yjojEU7rXIHFShRqArcf7t5kcXMwujta3AXABqvP5iMC8O
         UItq5m6RSUMXPolrbjPdRYkenJOFK9ThaJTafdE1vBkfHdJov4G/nflwBBw3ddV9UGNI
         rTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbPkld6HhQehrgPq8d0X0y6UJIfdrXSwN+DYCILU5y/KjGiN3pXqtrNpKbTcRiYyModXj0xINg@vger.kernel.org
X-Gm-Message-State: AOJu0YwleO/tW30PKtAc5mRNdi4xBC/IrOAEZot7tTQJSiFrnbM2BjWw
	vjTWcFCqQUhuz2mC+a3MNdcE5jCX0haVImQmiS10nPEVqYpOMWBXXzBtRIr8XLpfp9/6sOnSxuG
	Zff/AFOn1/nUWhDMDHu3OJgF+VZbFdACd7Ih9E6KuAja/EOKkLKjpkCvUPXHD1pCIAA==
X-Gm-Gg: ASbGncuMFBiEH277lhtrghWVbtfMUNhfuZ2gAfAsgU9hWgDT8I/6T8ITyQJGlsZMR5d
	lcTDcuUpIGMe8JN+6+eiGBCON/d9saHHlvz9ZC7dEmdsL+By5dxojyvBRX7i7HLRXZFSA23rSqe
	JwW/iVyLXFCQ4V5fYq3lsiJLZ9aucDhpy1ws2GgycMNvlFAWTEU7scujAkogYP0PcAZs+D3jWii
	23gYnA7ajbYOrXTsxYabzlQdd7mvcH2CVvO8tIPdp7Z5jtKdMVLfrqhhvJ9/Y5vjpqLUrTQxfwZ
	z7k8gyB71DraoiDX8RUhHw==
X-Received: by 2002:a17:903:1248:b0:215:a96d:ec17 with SMTP id d9443c01a7336-219e6e9f972mr388774545ad.14.1735360064115;
        Fri, 27 Dec 2024 20:27:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMN3qkkbg7IkE7tokaFOyB9J+Jlk/b/GquRVWEbzCvww8Aslq47g6LUtZs6GhTqkO4yMpgsQ==
X-Received: by 2002:a17:903:1248:b0:215:a96d:ec17 with SMTP id d9443c01a7336-219e6e9f972mr388774435ad.14.1735360063819;
        Fri, 27 Dec 2024 20:27:43 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e85csm142860585ad.61.2024.12.27.20.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 20:27:43 -0800 (PST)
Date: Sat, 28 Dec 2024 12:27:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 2/2] f2fs/008: test snapshot creation/deletion on lvm
 device
Message-ID: <20241228042738.hk5k4impnvstjmj4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241226133631.9486-1-chao@kernel.org>
 <20241226133631.9486-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226133631.9486-2-chao@kernel.org>

On Thu, Dec 26, 2024 at 09:36:31PM +0800, Chao Yu wrote:
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
> v4:
> - use "lvcreate -y" to force wiping stale data in device.
>  tests/f2fs/008     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/008.out |  2 ++
>  2 files changed, 59 insertions(+)
>  create mode 100755 tests/f2fs/008
>  create mode 100644 tests/f2fs/008.out
> 
> diff --git a/tests/f2fs/008 b/tests/f2fs/008
> new file mode 100755
> index 00000000..47696f2b
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
> +$LVM_PROG lvcreate -y -L 1024m -n $lvname $vgname >>$seqres.full 2>&1

OK, so you choose "-y" option. I think it's fine, due to this option was
brought in by below commit [1] 11 years ago. It's nearly same old with f2fs :)
So,

Reviewed-by: Zorro Lang <zlang@redhat.com>

[1]
  commit b6dab4e0598df7b6a44a32749fdb846c03aa692d
  Author: Peter Rajnoha <prajnoha@redhat.com>
  Date:   Wed Nov 6 16:16:34 2013 +0100

    lv_manip: rename set_lv -> wipe_lv and include signature wiping capability



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

