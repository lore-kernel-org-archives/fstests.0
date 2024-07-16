Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33913D630
	for <fstests@vger.kernel.org>; Tue, 16 Jul 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127440; cv=none; b=rHrg3yR45Ph2OOWtFFeoGGed12qwFiilqWlMoYUQwa4eptdUzPUJNIQg3+DgcpyfozsNCM8U0BgzyY6Y31XTWyLx29wjnrZcUMuNhZCRNTzgN2mdiLPNah+R0TRKa1yDlc/aMfC81kEKM5nxZrvuxY2wUNPfcrd2j3J0WGyxpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127440; c=relaxed/simple;
	bh=ormxAHnNvqA41nhrhg7ymlrZZyonc+2NcGpbtP+aDwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlaNcZkT6e+1qftJH8naPC4K6oieD51BTk6n8s4k6OsZ2dHnLcwxjnC+AQKGcvKagi5GsTme7RsFQVXGoMNul0gH1ycWlF7fQ4JB5KYb9AJ8lI4zlyrJX0fCethzkfIMqu/hVbpY/PMqmqAY316kJhGE8cjPoUMjMwpBH1VHyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=af8x4t6L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af8x4t6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721127437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=raemaiTUCyRxXG1VBkxVqQkGRFYq9XkfN2TA9fNwoNU=;
	b=af8x4t6LP3Pw16ax5pm+jp1+EhS/GO9hkg9dhk+eLx+AVpYWqKpmeLgdwpHIRuJmxQdZtH
	x5x9O8eCKPmGTPVEo5hb7pNRXvZkdmveK68ll6ojXin+poV0KGDZ/TyALhQcQwUk0VP4TB
	5A1j+e8/gPGUuMSmCe5WngogVE0n/WE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-zy1vLsZLPjudbsPPVt-2xg-1; Tue, 16 Jul 2024 06:57:16 -0400
X-MC-Unique: zy1vLsZLPjudbsPPVt-2xg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5c20b05a0ccso4431227eaf.2
        for <fstests@vger.kernel.org>; Tue, 16 Jul 2024 03:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127435; x=1721732235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raemaiTUCyRxXG1VBkxVqQkGRFYq9XkfN2TA9fNwoNU=;
        b=KAzdx0MFUb/xDjOSQAMIbuPMI8PuALVMBXCAUzhJNH50kEE6HE6Lk27XKCFwcNFPPF
         +Ne+sbgF2YwZEtv5FHCHb2uR8nTYFtStGdmiHCi1Fa1fZj23yPS+b9CVICyRegXrq/3k
         eNOGTYYfKbxNXjlL7oWBO6qYvTIlIksoh5TgNyBHOXZXKM1mU8NZ1kE4bHMAAHBXIbiv
         y8YSqJeWo9kNvsHH7gUsh1ykKZjpo/LsnBf+LV3nsnBnzghVhMLKEH3TQa9Tmq0hHPa7
         0XjEXlpHYY+Jq9NemSzBrVMTl7TstnDDB74yQoBaTzX+2HdMLRNIBGbqdb2EApZHDLti
         YR/w==
X-Gm-Message-State: AOJu0Yyd1bnJaS33ChjZJ+frEoblOq+xm1O6ccjxjRYpy2GKZJhyWT80
	LigIubsx463vZ6FHlP2uZGFAV71Cx8FxjzVnq1IckaQUol3nY72eqgpVlhwsO0z2hsZH7pyyger
	Il8am/6RMK397FAZyk3liM94rSDr+aqYZ4OuogM0d4rVgS+lMxzZOl8c=
X-Received: by 2002:a05:6870:c0cd:b0:24f:d3ce:fe92 with SMTP id 586e51a60fabf-260bddd9806mr1316320fac.14.1721127435324;
        Tue, 16 Jul 2024 03:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsJVDjOCdhNRGycZDg7G5srEqPmDKsBFYfbqBLibXZOhN5bzhMBqN1QJ64eUJJxilT1/3pkQ==
X-Received: by 2002:a05:6870:c0cd:b0:24f:d3ce:fe92 with SMTP id 586e51a60fabf-260bddd9806mr1316312fac.14.1721127434939;
        Tue, 16 Jul 2024 03:57:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e3485dcc7sm4699874a12.39.2024.07.16.03.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:57:14 -0700 (PDT)
Date: Tue, 16 Jul 2024 18:57:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs: test for race condition in between atomic_write
 and gc
Message-ID: <20240716105710.v76icnjhqmvjmgsd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240625030416.3553498-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625030416.3553498-1-chao@kernel.org>

On Tue, Jun 25, 2024 at 11:04:16AM +0800, Chao Yu wrote:
> Test that we will simulate sqlite atomic write logic w/ below steps:
> 1. create a regular file, and initialize it w/ 0xff data
> 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> 3. write transaction data
> 4. trigger foreground GC to migrate data block of the file
> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> 6. check consistency of transaction w/ in-memory and on-disk data
> This is a regression test to check handling of race condition in
> between atomic_write and GC.

Hi Chao,

Sorry for the late reviewing. As this's a regression test, so which onne
kernel commit fix this known issue, please specify it by:

_fixed_by_kernel_commit $commit_id $commit_subject

> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/003     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/003.out | 11 +++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100755 tests/f2fs/003
>  create mode 100644 tests/f2fs/003.out
> 
> diff --git a/tests/f2fs/003 b/tests/f2fs/003
> new file mode 100755
> index 00000000..d8311c4c
> --- /dev/null
> +++ b/tests/f2fs/003
> @@ -0,0 +1,61 @@
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
> +_supported_fs f2fs
    ^^^^^
This line is not necessary now.

> +_require_scratch
> +_require_xfs_io_command "pwrite"

pwrite is a basic command of xfs_io, so I think this line is not necessary.

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

As there's a background process, shouldn't we do kill and wait in _cleanup
to make sure unmount won't hit EBUSY?

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
> +od -x $dbfile
> +echo 3 > /proc/sys/vm/drop_caches
> +# print on-disk data
> +od -x $dbfile

There's a common helper named "_hexdump" in common/rc, can that be used?

> +
> +_scratch_unmount

The SCRATCH_DEV will be unmounted at the end of the test, don't need to
do this manually if it's not a necessary test step.

Thanks,
Zorro

> +
> +status=0
> +exit
> diff --git a/tests/f2fs/003.out b/tests/f2fs/003.out
> new file mode 100644
> index 00000000..d6c8a637
> --- /dev/null
> +++ b/tests/f2fs/003.out
> @@ -0,0 +1,11 @@
> +QA output created by 003
> +0000000 0000 0000 0000 0000 0000 0000 0000 0000
> +*
> +0400000 ffff ffff ffff ffff ffff ffff ffff ffff
> +*
> +2000000
> +0000000 0000 0000 0000 0000 0000 0000 0000 0000
> +*
> +0400000 ffff ffff ffff ffff ffff ffff ffff ffff
> +*
> +2000000
> -- 
> 2.40.1
> 

