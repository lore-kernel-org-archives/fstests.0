Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4272F2E
	for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759071309; cv=none; b=FAQKeeNiY3FNDQD/dfRQN4ayaOvcN/9ioUYSTUKkl76C+YitrZa1xPTohB3fwhpCKOpkDrVKtZ+FHSG8OkEMHFyEDKAYTxvT5Aj+UAOAnxaQ7TD7+TRDDur86qB/jEqLrjR+8Qddslf7nIc9J6aLAeJVfht0iOvnO4oNxP6LjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759071309; c=relaxed/simple;
	bh=faXbKWkSCqgyuZE7zHv7M+wyMfCgrrphjB4x+XER4bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykz+F1RGnUNJ8XYi0IgvH8OuoIX30dOQ9zsXwXYNVe6GnWck6n2GdeU6VrMdlghleueP/Tls3SckqqfWn2dBkA4Vh0t3QqHl4iBtOS8hr+H1Bh9R2Pj5Ld5xCbJ6T36pFQ9NkjxJ1plOJLeTcSeM/kkQDNn+jE9qA9GQeaCBySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDztpd44; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDztpd44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759071305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VCbcP4jnuJD0yk6auspq17+0DRODrBb74tm3+Qhevr0=;
	b=iDztpd445NAlnSnTq2PqW3HGIM0RFS5NpsKYe/Gjjxdxi+OJON99RPm+tcImmdoHQqpAOf
	e5AIAIeePJsdAq9sDEHWaGe7ZFPiDpX1njQgNw1zqo4A0UFe9UZ3r7H40VU/0HQ+hkdA2S
	zZgumRmYEVRwu6WzTOlctp2xNG9vSlc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-E0y0TZlUN_mZzUyTtuo8VQ-1; Sun, 28 Sep 2025 10:55:04 -0400
X-MC-Unique: E0y0TZlUN_mZzUyTtuo8VQ-1
X-Mimecast-MFC-AGG-ID: E0y0TZlUN_mZzUyTtuo8VQ_1759071303
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269939bfccbso46377665ad.1
        for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 07:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759071303; x=1759676103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCbcP4jnuJD0yk6auspq17+0DRODrBb74tm3+Qhevr0=;
        b=AkrUsVE9537x9Fr0u34bBMF90bA6JmeZz+Mkw0hD/PFi05pQI73hOT9PSlF/G9YwA/
         ORGId0IFSeg7Gtq+Qe5G9RXbsFqbIRWI0/EaHrE1fSOo+i7GUEFumQeHOHmWzAG1o7rT
         jAPJKChidlZWR3yZ44y2o0WeD32WPSz31BqWqe6vFa6SJifpZmeFz9AFPxdZhC0XDa2A
         UD/FyB9v0roSvhqn34CVYqXxlFsg4HfwKYfv/z2pNrUNNmbq8G/+Afr4bvXg+69NfGMO
         Kbs0ggWbYQdKuV7IZqYGRgE5sh97a/4YIgIxMM88rOPhqpv3RTHLvzLX4SyMD+VkvZrA
         /51A==
X-Forwarded-Encrypted: i=1; AJvYcCWYLhN/rif6rD20KZmNpNl0X4X+EeUdomdwD6gzRV7hC/iwtyJGL8wzD7L2S8wUbiWgh76AhSfM@vger.kernel.org
X-Gm-Message-State: AOJu0YwghA2Az1xJsKTyaMC/8dntpzTB7YBvGCyNOEw2BXFU7gKxz93d
	CgergDqxxwTQoNKDWhd0JOVsejo+G2TipJ+HnfDsD3LshyP5dkHl1CxzHLCp4H+F1pcDE/Y7WgA
	ceOyC1xryE4grkE1BgKC+z6qfcnxc812bt0S+P/6YGkohugrNHEaEHjyY4R4=
X-Gm-Gg: ASbGncuhL/qWh35xvyiCg/DPSDs13hKRJbKXQhfObsLOiEhtXhyCpeTUShsOmew1oFm
	8cnDa250M0wJ5P9jtLpcWtxOWgXZIqOF9BNthophiCPIwYJFOu1/qM4a+dQr1REgN32tdvrmV7M
	fT124hYYEiOB7JI4GHZmvPozzMH2cBnZ16tVJDlekjIAl/rkEhmKFPRnNAgXJSwtSbCTMFL9+Rd
	nNFZxEHXmttKIsA1+ZfPwuCQvyoWkyHvS+v70KhoOSytsN9IwycSWKheh2DO8pPhJ5aLKu2OCXy
	gNg20HB/fLmqaH7LhAylsVqpGM3WrSr/Nxswy8HBd4Ced5YU6WOkuMrhd32amSxpm5VenZRfkkI
	nZGbZ
X-Received: by 2002:a17:902:e54d:b0:266:2e6b:f5a7 with SMTP id d9443c01a7336-27ed4a89b48mr157882725ad.58.1759071302574;
        Sun, 28 Sep 2025 07:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnZJHixwIXPjcp9HWUyz95ng9jKF9JaA/afuk6s64CuGQ4XCLUMKYvsb5zwyBW8bI1FO/YTg==
X-Received: by 2002:a17:902:e54d:b0:266:2e6b:f5a7 with SMTP id d9443c01a7336-27ed4a89b48mr157882555ad.58.1759071302079;
        Sun, 28 Sep 2025 07:55:02 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c5575350sm9022500a12.26.2025.09.28.07.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 07:55:01 -0700 (PDT)
Date: Sun, 28 Sep 2025 22:54:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs/012 btrfs/136: skip the test if ext* doesn't
 support the block size
Message-ID: <20250928145453.wyztv2kvfpgmlw3k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-2-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918224327.12979-2-wqu@suse.com>

On Fri, Sep 19, 2025 at 08:13:25AM +0930, Qu Wenruo wrote:
> [FALSE ALERT]
> When testing btrfs bs > ps support, the test cases btrfs/012 and
> btrfs/136 fail like the following:
> 
>  FSTYP         -- btrfs
>  PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #285 SMP PREEMPT_DYNAMIC Mon Sep 15 14:40:01 ACST 2025
>  MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
>  MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
>  btrfs/012       [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/012.out.bad)
>      --- tests/btrfs/012.out	2024-07-17 16:27:18.790000343 +0930
>      +++ /home/adam/xfstests/results//btrfs/012.out.bad	2025-09-15 16:32:55.185922173 +0930
>      @@ -1,7 +1,11 @@
>       QA output created by 012
>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
>      +       dmesg(1) may have more information after failed mount system call.
>      +mkdir: cannot create directory '/mnt/scratch/stressdir': File exists
>      +umount: /mnt/scratch: not mounted.
>       Checking converted btrfs against the original one:
>      -OK
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/012.out /home/adam/xfstests/results//btrfs/012.out.bad'  to see the entire diff)
> 
>  btrfs/136 3s ... - output mismatch (see /home/adam/xfstests/results//btrfs/136.out.bad)
>      --- tests/btrfs/136.out	2022-05-11 11:25:30.743333331 +0930
>      +++ /home/adam/xfstests/results//btrfs/136.out.bad	2025-09-19 07:00:00.395280850 +0930
>      @@ -1,2 +1,10 @@
>       QA output created by 136
>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
>      +       dmesg(1) may have more information after failed mount system call.
>      +umount: /mnt/scratch: not mounted.
>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
>      +       dmesg(1) may have more information after failed mount system call.
>      +umount: /mnt/scratch: not mounted.
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/136.out /home/adam/xfstests/results//btrfs/136.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Currently ext* doesn't support block size larger than page size, thus
> at mkfs time it will output the following warning:
> 
>  Warning: blocksize 8192 not usable on most systems.
>  mke2fs 1.47.3 (8-Jul-2025)
>  Warning: 8192-byte blocks too big for system (max 4096), forced to continue
> 
> Furthermore at ext* mount time it will fail with the following dmesg:
> 
>  EXT4-fs (loop0): bad block size 8192
> 
> [FIX]
> Check if the mount of the newly created ext* succeeded.
> 
> If not, since the only extra parameter for mkfs is the block size, we
> know it's some block size ext* not yet supported, and skip the test
> case.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/012 | 3 +++
>  tests/btrfs/136 | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index f41d7e4e..665831b9 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>  	_notrun "Could not create ext4 filesystem"
>  # Manual mount so we don't use -t btrfs or selinux context
>  mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> +if [ $? -ne 0 ]; then
> +	_notrun "block size $BLOCK_SIZE is not supported by ext4"
> +fi

Hmm... the mount failure maybe not caused by the "$BLOCK_SIZE is not supported",
I'm wondering if this _notrun might ignore real bug. How about check the
"blocksize < pagesize" at least?

>  
>  echo "populating the initial ext fs:" >> $seqres.full
>  mkdir "$SCRATCH_MNT/$BASENAME"
> diff --git a/tests/btrfs/136 b/tests/btrfs/136
> index 65bbcf51..6b4b52e4 100755
> --- a/tests/btrfs/136
> +++ b/tests/btrfs/136
> @@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>  
>  # mount and populate non-extent file
>  mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
> +if [ $? -ne 0 ]; then
> +	_notrun "block size $BLOCK_SIZE is not supported by ext3"
> +fi
>  populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
>  _scratch_unmount
>  
> -- 
> 2.51.0
> 
> 

