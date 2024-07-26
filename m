Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1C1171D
	for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008991; cv=none; b=nVy75XQGrKruPTNdaujB8FQ1a055HOXfAjskTnLrbGO08d7CJL46gf5bObn2e2McTHe13u2Z9/LjN3jzxB0M8HeqlXnkk4MagN83WMLfPz7IhnHcBcpb8pUaUB4dlJiib5U+mM5WKTGK2aK2rn0fG/LGEzBBhQqw4xBhEN2tyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008991; c=relaxed/simple;
	bh=PFYTPFiUt6E8HmKQcwBPbnVwaJ2GjZ5Y35pZFAurX+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSXg4p/F99giGEPy0FjY+do+rExac7j10Uvqf4R7dYUAIEnNbE08QobHV3W8xeKnA7EnuJUjsxdFjpN73skToBSQiPKtR8lK94IG9Zpofp4nimMsjDnhr32y3g8Fd3e7DNT9afu9ePQLpFLrGGcftC5b8ImY4Al+ZGaBUerwGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhhMj95B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhhMj95B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722008988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ONAly56Pin9bv9f9L0IyZ2C5ghF4uan7hL3Edo6ut5o=;
	b=LhhMj95BoJWvc+Wp4jrfb5/kRu0BaALEcQhZvyVFpO7KmPWIkEr1pnCVQBWnF1IA1Y+HqY
	8SgJJUxm60p9KbUn9ZcbUBbPDrgboCN/9ztsi5s5oY7YZ0mMJJdhIs2bu6U2i5iZk8AphM
	zXefLK4kQkx4pPWuI+tAb8Iobbe4TYc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-7CIEh_G1OkiP0Pgyx3ixXQ-1; Fri, 26 Jul 2024 11:49:47 -0400
X-MC-Unique: 7CIEh_G1OkiP0Pgyx3ixXQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fc60ef3076so7276665ad.1
        for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 08:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008986; x=1722613786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONAly56Pin9bv9f9L0IyZ2C5ghF4uan7hL3Edo6ut5o=;
        b=rjeis/cGdPsl1d27iBjlwP9bg8YX4oC6qm4xsY4y0yDSBVw1774aIg7TKRWpVthFU2
         D7BGVZUtRx5LSufJxdouK7FrQMMYKZrg6xRu3xetnsrsmEumn5vrPQD83deRJr/f7Hqr
         ze1TINm8PyPihRLaaOql0WLKuavu/p+E+wDrBgareFXUU1DdRdA4BeGrFqZ2XIwGk0JW
         d9Y7DTJ63MudsH6PicptqKf092/EQElhjPYG0Sgs8sZbh+HfB9mIxzb7r9JlthcU2Fm0
         B1idoBZDG78ABzMMWmOiRVyrK987mWpkfPNzS+0oT8LodTHaktBkXqKMjDkuKqBjp6FM
         U3jg==
X-Gm-Message-State: AOJu0YyxNIbSPUEtsRzbDbPqpcbDvMGR4Kh+Y6Omh4NXjI3oGOoPccnv
	B7SeTLT9lMIr1ZYoVN0pOiRjNg29LfBIW0Q15X4pWZFiZN+HRRh5kNfYMfKix+W9l6ffz588qvE
	N+D5+wGw3wQXPlTE/GH3eJrzFUj3HgbGqEvBEnTPTzYEQ5swMKLIlcAc=
X-Received: by 2002:a17:903:248:b0:1fc:2ee3:d460 with SMTP id d9443c01a7336-1ff04858a84mr369275ad.35.1722008985826;
        Fri, 26 Jul 2024 08:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPPUps4Y/l0dGXPyi0XPbe+JP4pMjXykLBpdxaOUUdPI1aVaCxvKME5pZpY68OLkuhyvgCAA==
X-Received: by 2002:a17:903:248:b0:1fc:2ee3:d460 with SMTP id d9443c01a7336-1ff04858a84mr369065ad.35.1722008985375;
        Fri, 26 Jul 2024 08:49:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1241sm34367185ad.172.2024.07.26.08.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:49:45 -0700 (PDT)
Date: Fri, 26 Jul 2024 23:49:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v2] f2fs: test for race condition in between atomic_write
 and gc
Message-ID: <20240726154941.lzpunsvd53lnieoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240720074316.3302470-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720074316.3302470-1-chao@kernel.org>

On Sat, Jul 20, 2024 at 03:43:16PM +0800, Chao Yu wrote:
> Test that we will simulate sqlite atomic write logic w/ below steps:
> 1. create a regular file, and initialize it w/ 0xff data
> 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> 3. write transaction data
> 4. trigger foreground GC to migrate data block of the file
> 5. commit and end the transaction
> 6. check consistency of transaction
> This is a regression test to check handling of race condition in
> between atomic_write and GC.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add kill&wait in _clean() to avoid umount failure
> - some cleanups
> - use exported helpler
>  tests/f2fs/003     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/003.out | 11 ++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100755 tests/f2fs/003
>  create mode 100644 tests/f2fs/003.out
> 
> diff --git a/tests/f2fs/003 b/tests/f2fs/003
> new file mode 100755
> index 00000000..c30e874a
> --- /dev/null
> +++ b/tests/f2fs/003
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/003
> +#
> +# Test that we will simulate sqlite atomic write logic w/ below steps:
> +# 1. create a regular file, and initialize it w/ 0xff data
> +# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> +# 3. write transaction data
> +# 4. trigger foreground GC to migrate data block of the file
> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> +# 6. check consistency of transaction w/ in-memory and on-disk data
> +# This is a regression test to check handling of race condition in
> +# between atomic_write and GC.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/filter
> +
> +_cleanup()
> +{
> +	kill -9 $atomic_write_pid > /dev/null 2>&1
> +	wait > /dev/null 2>&1

This version looks good to me, just this place, we need to keep the default
_cleanup steps.

        cd /
        rm -r -f $tmp.*

I'll do this change when I merge this patch.

(And please don't forget to update the _fixed_by_xxxxx information later.)

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +}
> +
> +_require_scratch
> +_require_xfs_io_command "fpunch"
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +dbfile=$SCRATCH_MNT/dbfile
> +foo=$SCRATCH_MNT/foo
> +bar=$SCRATCH_MNT/bar
> +
> +$XFS_IO_PROG -c "pwrite 0 512k -S 0xff" -c "fsync" -f $dbfile >> $seqres.full
> +$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $foo >> $seqres.full
> +sync
> +
> +# start atomic_write on dbfile & write data to dbfile
> +$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
> +atomic_write_pid=$!
> +
> +$XFS_IO_PROG -c "fpunch 0 2m" $foo >> $seqres.full
> +$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $bar >> $seqres.full
> +
> +# persist all dirty data
> +sync
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +# trigger foreground GC to migrate data block of atomic_file
> +$F2FS_IO_PROG gc 1 $SCRATCH_MNT > /dev/null 2>&1
> +
> +# wait for atomic_write commit completion
> +sleep 5
> +# print in-memory data
> +_hexdump $dbfile
> +echo 3 > /proc/sys/vm/drop_caches
> +# print on-disk data
> +_hexdump $dbfile
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/003.out b/tests/f2fs/003.out
> new file mode 100644
> index 00000000..64698d84
> --- /dev/null
> +++ b/tests/f2fs/003.out
> @@ -0,0 +1,11 @@
> +QA output created by 003
> +000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
> +*
> +020000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
> +*
> +080000
> +000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
> +*
> +020000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
> +*
> +080000
> -- 
> 2.40.1
> 

