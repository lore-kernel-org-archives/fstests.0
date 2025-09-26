Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFC2BEC34
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904690; cv=none; b=fDz+o7DrRG3NZ08FNqxB/yu4V9Bzbug1XVwGV6Nv2E/5RZpTWKsTZ6ca+Gz/sw3CkZHRcWrTrQ/NAusidfje6rRxKDYLVgk+gx6IlePnsx3ri2Cruyl/vSKwP+XpvqnfDobYzsXX+mU4b+fTutKnBOVs0o8zrcpeQxcc9rqLawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904690; c=relaxed/simple;
	bh=mZp4YHhmnVHuc93METJhY0aWy6YC5WuSCd6iHBRDkqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAsgFssgScf8pHGJxKTLzuUU0/BubpowPW71gP6YcjvWSfmlIUK9G/Vv3cwQfoqR3iilt+GHPvvrwWdSpYjx5yznRLc9wnisb+waIsAjXdVf7XmpVdUA0NcWzI4y5LMTn9ECfgVOBvFRjES8CLDWs7wuYCr2rDUmC+rBng9jwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANF4EFmb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANF4EFmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758904687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00gkouP2qfPz4h/glH8n5zZrSbrZBkEq3qbRrfiJEcU=;
	b=ANF4EFmbWYDiXXxkWbpVRrbMshzN76Shi7yBOGdmUzIawDqKeV21iW49oQbP51q2Ai5qR5
	e9c9BssRclBx5PZufifqCms/gof3pwVZDOKRaQFXRolbAey6kdRkX5YRF6TmpKggFIgCi7
	KZkiPiUdjd0iv5vg7uvsPhfYhnrEO94=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-HoEyUp-LOjSLxWCABfUrGA-1; Fri, 26 Sep 2025 12:38:06 -0400
X-MC-Unique: HoEyUp-LOjSLxWCABfUrGA-1
X-Mimecast-MFC-AGG-ID: HoEyUp-LOjSLxWCABfUrGA_1758904685
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so2485253b3a.1
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 09:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904685; x=1759509485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00gkouP2qfPz4h/glH8n5zZrSbrZBkEq3qbRrfiJEcU=;
        b=CW+ZEBWLuKi1p9OF5TVy2oQ7nlgRvlIbb9++Kn/m8MXAv2ZPErRitalhnFWn7eWzo3
         2blTEpOsknTzwMUpEyqvBzv0vu54IkCkBOIVEyMC/rryL/o2VDRTlW4YxvxbmihQTBxV
         7FaHtZQsuNuQAg35BaXgyxEN9hdV+EnUAEjxhDJUYmErxEvV6FZ8mLGJwlFOkNErGigj
         cZyvEpS6e3hcKN1ZXkl21Dy5UJ0X4NT3hNu5s7STB9x1DnyaZNbeyXdCHmxIpJylXg7/
         5nT3FBUmrLrvqHAS2f8xRRAYWQXufXddCANfq6xj2wNTwUum722dbD+4EK+wA/3z6/Iu
         JasA==
X-Gm-Message-State: AOJu0Yx9jq6C7VWXfyNt4eEfqP69iYKUW9eKSJfyuMFYoUVvpP8CLqUh
	YKkM0YTQC49iyPcz1/zL9HuiyQU7Ukjhh52xW/2nNp1GORtRJFHyZdEH92Al5j1yTpBwhBPbwMm
	evb50Sh6cQYxNkqhRQTEmb2Rq+8UO+Rvpt3E4cGLq+Wb8Gze4dlfG3Q/vWEE=
X-Gm-Gg: ASbGncsEcC6YWs+koaarliVf5vCuRe2gKrt2ucuza0ww3NWtckHYFxsrI3f9SlMe2Vq
	rhGXE+06hNSOJ1Z1LT5nRuMa+jppgLFdl9N4QPVvSqISF74qTrDR//mTu5lUcngBAQs6cy15ZBd
	MthP0bp1Swqnt9DXUP0+lP+J8Wb9lECcYFTvtNo9S9ftBx3ihhieBfxMu8qLT3ZFZvUoGxViboc
	bC3h8lMxsfPU9kEJpmDVBqVok/t1OrqgtY4GB/UkBSuBS2ANiQp9r+VgSyUl5WIjm6NPekX6SMP
	lh1BhfaH3Zowgn3dwXyxGknZOAHAONBVesUgPknsH9Qk1QVAmN6yIvuBU7p4t8s7X16lN2XUcyh
	VdwCJ
X-Received: by 2002:aa7:9a1a:0:b0:776:138a:ec97 with SMTP id d2e1a72fcca58-780fcee3679mr7023522b3a.28.1758904684947;
        Fri, 26 Sep 2025 09:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtgqkU9uIkXCoNKng3H9SEzU/11+7S2gN2KhPOvZV/Y+VL10wL4yxd+9WP0LHzzrUA1yFIQg==
X-Received: by 2002:aa7:9a1a:0:b0:776:138a:ec97 with SMTP id d2e1a72fcca58-780fcee3679mr7023492b3a.28.1758904684350;
        Fri, 26 Sep 2025 09:38:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238ca1esm4874232b3a.11.2025.09.26.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:38:03 -0700 (PDT)
Date: Sat, 27 Sep 2025 00:37:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	djwong@kernel.org, fdmanana@kernel.org, quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: Re: [PATCH 1/4] generic/371: Fix the test to be compatible block
 sizes upto 64k
Message-ID: <20250926163758.hrg4bbyvk3xipcqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>

On Tue, Sep 16, 2025 at 03:30:09PM +0000, Nirjhar Roy (IBM) wrote:
> When this test was ran with btrfs with 64k sector/block size, it
> failed with
> 
>      QA output created by 371
>      Silence is golden
>     +fallocate: No space left on device
>     +pwrite: No space left on device
>     +fallocate: No space left on device
>     +pwrite: No space left on device
>     +pwrite: No space left on device
>     ...
> 
> This is what is going on:
> 
> Let us see the following set of operations:
> 
> --- With 4k sector size ---
> $ mkfs.btrfs -f -b 256m -s 4k -n 4k /dev/loop0
> $ mount /dev/loop0 /mnt1/scratch/
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
> 
> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
> wrote 83886080/83886080 bytes at offset 0
> 80 MiB, 20480 ops; 0.4378 sec (182.693 MiB/sec and 46769.3095 ops/sec)
> 
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
> 
> $ sync
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      256M   82M   95M  47% /mnt1/scratch
> 
> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
> wrote 83886080/83886080 bytes at offset 0
> 80 MiB, 20480 ops; 0:00:01.25 (63.881 MiB/sec and 16353.4648 ops/sec)
> 
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      256M  137M   40M  78% /mnt1/scratch
> 
> $ sync
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      256M  162M   15M  92% /mnt1/scratch
> 
> Now let us repeat with 64k sector size
> --- With 64k sector size ---
> $ mkfs.btrfs -f -b 256m -s 64k -n 64k /dev/loop0
> $ mount /dev/loop0 /mnt1/scratch/
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
> 
> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
> wrote 83886080/83886080 bytes at offset 0
> 80 MiB, 20480 ops; 0.8460 sec (94.553 MiB/sec and 24205.4914 ops/sec)
> $
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
> 
> $ sync
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      256M  104M   95M  53% /mnt1/scratch
> 
> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
> pwrite: No space left on device
> 
> Now, we can see that with 64k node size, 256M is not sufficient
> to hold 2 files worth 80M. For 64k, we can also see that the initial
> space usage on a fresh filesystem is 24M and for 4k its 1.5M. So
> because of higher node size, more metadata space is getting used.
> This test requires the size of the filesystem to be at least capable
> to hold 2 80M files.
> Fix this by increasing the fs size from 256M to 330M.

Thanks for this detailed explanation. As this's a ENOSPC test, so we
must make sure this case still can uncover the original bug, before
increasing the fs size. Can you make sure that? Or maybe we can replace
that "80M" with a variable (according to "Avail" size).

Thanks,
Zorro

> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/generic/371 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/371 b/tests/generic/371
> index b312c450..95af308e 100755
> --- a/tests/generic/371
> +++ b/tests/generic/371
> @@ -19,7 +19,7 @@ _require_scratch
>  _require_xfs_io_command "falloc"
>  test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
>  
> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mkfs_sized $((330 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount
>  
>  # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
> -- 
> 2.34.1
> 

