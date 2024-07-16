Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E81CFBE
	for <fstests@vger.kernel.org>; Tue, 16 Jul 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127832; cv=none; b=T8bTN/g/Ss5wsgPgZId9bjt8qgidJOpY6KgLGXIchjZNv8OZSPjPrF3gxiuub8tgkF+wwot87NkcYb8OyOOFC8T10UXlANhfBdeoyEUzwEx4C08DyMgyaUD262Oniezh8352tB5vOOi+CRL/czH8Ac2Zs38KwPVwB5a4XvDaka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127832; c=relaxed/simple;
	bh=CECCkOWXCyUtj1K/3s+ABp6UPQXG6AS2w2MnGU2LD4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYPd38Qf25rJ65mTUjSxIzzkqUE/9GovRQk5ZMQThmcYkEayK5xiVDdIQbN3aKRchtvwN41nb9LArtT8XeoIz58jP2xPcAHViHhB+puz2NqAPiu4q0EuiUtwqTNaZfVqmJB6h4m+HpWKJiEXF+sChd5w+q+x2qnbjPucCdrZZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q81Aujxd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q81Aujxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721127829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G3/AtxtSwR8lUsUE4FZXEG4bGpUSLh82ydkzVdaGpVA=;
	b=Q81Aujxd0MCvluRXo41G6/P3TwKtyPNBTQd8VDQLKNhUCFzfu6p/Q8AkebGP7Ioi8hzamK
	F7E+gU5GIsMab5jrVNol2GH6wsiIYRAT24Yvfky1odmJPO+Lp3H94fijBT2i8IHphihRu7
	9mznogejvAl6v4Uohm1fkBRY2fZiK2k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-SvANp94vM3G6TiPlCSFTeA-1; Tue, 16 Jul 2024 07:03:48 -0400
X-MC-Unique: SvANp94vM3G6TiPlCSFTeA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fc2d78e911so14101455ad.1
        for <fstests@vger.kernel.org>; Tue, 16 Jul 2024 04:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127827; x=1721732627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3/AtxtSwR8lUsUE4FZXEG4bGpUSLh82ydkzVdaGpVA=;
        b=xNlQv1wtjQaB44BVbFUfXXzSLzcKG4SAQX2kwv8DztQHMb0FMJ0OofdIeSY+rzgfxp
         Ne+ajJJcPp0oDH6DJ3TelOMP24r39o6QR2gC4Ecg5U/7uAcq20Gm+PNWIJUD0Z9LOJOf
         KrFT2r2dptbo7sdQ6NslyctdJ3B66PHMI4XfNa8o1Bq1j3+hB+93L1fJI0xjC5pvKqPw
         ikMm5Dp8twdlgF7rMdke9x6mCC482gSU1A4WPW9fJDrqSBm/ZJRNiHYp2z1bVEEObEAl
         B//cYvFa8AY2QPDwk6yC1S5CykNkWcjCeRk+ku+Q3uTrF2VQpS4VvhYQ6CnEPxSOyY6y
         kMRQ==
X-Gm-Message-State: AOJu0YzMmBxY9ozMT01lmgJrcdoAFjeTfM4UBvTXV76F52M1S7JK/aK1
	GFijuhHJenWbbgNdn0mfmc2gURtQa1UZNCGwvfHSKArRUPbW8AxH05RtbwF0ZYkRXD6nxzmaw2n
	1b8bCbtubIItf9jjOEBv3PGb59qoDjTlwF6dODvlEcDTivqV+XiwB81s=
X-Received: by 2002:a17:903:189:b0:1fb:48c6:a2b0 with SMTP id d9443c01a7336-1fc3d914683mr14517535ad.5.1721127826949;
        Tue, 16 Jul 2024 04:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpuozIIg2P4JkySM51kbaebxVPC2AGB8uZWPOqDTc7+W31Ck3hl6zCrnTREBha5R8olzIpVw==
X-Received: by 2002:a17:903:189:b0:1fb:48c6:a2b0 with SMTP id d9443c01a7336-1fc3d914683mr14517305ad.5.1721127826525;
        Tue, 16 Jul 2024 04:03:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc3921bsm55775415ad.227.2024.07.16.04.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:03:46 -0700 (PDT)
Date: Tue, 16 Jul 2024 19:03:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs: test for race condition in between atomic_write
 and dio
Message-ID: <20240716110342.2jhwp3wn65pvhoyd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240625140233.3907012-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625140233.3907012-1-chao@kernel.org>

On Tue, Jun 25, 2024 at 10:02:33PM +0800, Chao Yu wrote:
> In this patch, we simulate race case in between sqlite atomic write
> and direct IO w/ below steps:
> 1. create a regular file, and initialize it w/ 0xff data
> 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> 3. write transaction data
> 4. trigger direct read/write IO on it to check whether it fails or not
> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> This is a regression test to check handling of race condition in
> between atomic_write and direct IO.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/004     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/004.out |  3 +++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/f2fs/004
>  create mode 100644 tests/f2fs/004.out
> 
> diff --git a/tests/f2fs/004 b/tests/f2fs/004
> new file mode 100755
> index 00000000..26862cb5
> --- /dev/null
> +++ b/tests/f2fs/004
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/004
> +#
> +# Test that we will simulate race case in between sqlite atomic write
> +# and direct IO w/ below steps:
> +# 1. create a regular file, and initialize it w/ 0xff data
> +# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> +# 3. write transaction data
> +# 4. trigger direct read/write IO to check whether it fails or not
> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> +# This is a regression test to check handling of race condition in
> +# between atomic_write and direct IO.

Same as last patch, please add _fixed_by_kernel_commit.

> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/filter
> +
> +_supported_fs f2fs
   ^^^^^
It's not needed

> +_require_scratch
> +_require_xfs_io_command "pwrite"
   ^^^^
It can be removed too I think.

> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +dbfile=$SCRATCH_MNT/dbfile
> +
> +# start atomic_write on dbfile & write data to dbfile
> +touch $dbfile
> +$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &

There's a backgroup process too. Better to make sure it's done "kill && wait"
before the end of the test.

> +
> +# simulate concurrent direct read/write IO
> +$XFS_IO_PROG -d -c "pread 0 128k" $dbfile
> +$XFS_IO_PROG -d -c "pwrite 0 128k" $dbfile

Do you need _require_odirect (not sure about that:).

> +
> +# wait for atomic_write commit completion
> +sleep 5
> +
> +_scratch_unmount
   ^^^^
It's not necessary.

Thanks,
Zorro

> +
> +status=0
> +exit
> diff --git a/tests/f2fs/004.out b/tests/f2fs/004.out
> new file mode 100644
> index 00000000..3af79541
> --- /dev/null
> +++ b/tests/f2fs/004.out
> @@ -0,0 +1,3 @@
> +QA output created by 004
> +pread: Operation not supported
> +pwrite: Operation not supported
> -- 
> 2.40.1
> 
> 

