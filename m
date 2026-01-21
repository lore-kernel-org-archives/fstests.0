Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E927A123
	for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003485; cv=none; b=ZUV0bEkyoS4wDibDRpuMjgC+JYN0xYuXVuoKvW0XGQA2sbnHTkxSKY0JFREB8TpcgK6ureOVjsNP76Ui4syNsLV+xLAZoq5l3XjDMll3AvP5XTnB2qLT0uEI0BFk53tcVzQrWJwNNR4RyyD5Kq4roOUij3yn/YyTRJnYFz7Rzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003485; c=relaxed/simple;
	bh=iO7E8zWhjoHroNGr61CgaNdoxjgpnsVYjZroJea4PO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nglh1fLqRq24bNXTMXTt/MbLxbymrgooA2uz45rx5Rz2QBdSqGxBeOgttiz4ZwCJGF1DbrpRwkuqzC8eazUphgq6AY3+R32ZSy6Q/AuTSHWfTTpazPQ5PVetsGqeqG6tbzjP5A3zi7tzkr2KY7dXIFYC0Hxt1Wvr/G5Op5RB46I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9QgYB2g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJgsg1PZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9QgYB2g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJgsg1PZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769003481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pyOAe8U3dwnToaq8Wod8FWTkEuAMiKN15hDqRNZsMo=;
	b=I9QgYB2gIGGOtd5/VUX0jE9ykcq5eiNB5SfTlNf9lbCoB8P/X8cZi7UfZ34GrWFb/dkQVV
	CyZ8PdtPqgdap2gFOCBHgF0ncZuPKKAREqepx+FY8+2gQ7O6mCAJFBfMEVDVpxskzlsCna
	NIWYYAMenvD5iEXaybYWJOPvFk3x/oE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-2_c5oOJSOuWsrQdhzQZhdw-1; Wed, 21 Jan 2026 08:51:20 -0500
X-MC-Unique: 2_c5oOJSOuWsrQdhzQZhdw-1
X-Mimecast-MFC-AGG-ID: 2_c5oOJSOuWsrQdhzQZhdw_1769003479
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c6e05af6fso6335824a91.1
        for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769003478; x=1769608278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pyOAe8U3dwnToaq8Wod8FWTkEuAMiKN15hDqRNZsMo=;
        b=XJgsg1PZpba5XUlQqFxWqLL4e9s41WMob9EHryYKJSEzMk7fEGEprPq1tRjwfIJx19
         jyYDwqLCFW7X4UkjHfNQjrxEqPYqR8NXjEVjp+rRyBHRH0wI0196/sE4Ogu++UrHJV6w
         z0WGXnYFPcvLyidAY9C9FARlDJoUdb+xvytehCEDSXPIz7up5Yx3dnnDtijVtk+uR699
         gtjsY35xEdNLIGBW2EC1uXfPqtbPdn8WQ7lN5e+YeP8tjaH2dw2IBtGHxJ4JvvlWA4h0
         fTTfsj+bobFfIc2j1YInkW9AmacJ9NV4w4e6b3t5cB7LW5w0rRriSRcKKWHYmW+lDhWr
         gV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003478; x=1769608278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pyOAe8U3dwnToaq8Wod8FWTkEuAMiKN15hDqRNZsMo=;
        b=SmPlQ9Xk85hOV6oN5eEAdcJnhiEj5T/7RmMAa7/PV7P81MiuuxKGJBSiI+jvAxalno
         EnaRNXwH/Oq4aBoDm7YO8aqko5NiMRgaBUzf/8Cbmp5iqZZryInhfUqnagVOfj25MR+o
         rAFBrH99cIlTpgI1K1lbX4HIFrSs8PCmxVq/eouw81tp1ZYLznkCToqjT3/PG5Fr5+2x
         8vW8vZIvbiX8a5/m0hmzKiaBU2ufnfbyhBgvx3IbUUQagB+WRYKf/Ad2y3VQzvug41If
         SMpGSx9vSmeSBEVV9+c/35IVyONoLoWlZ+zsLu2H+F6pr8vY6cv3BTuVWT10EJTZp7jW
         Ic8A==
X-Gm-Message-State: AOJu0YyA/OVaj5fKJcQnVdAiiPCN2n1wvEE1BGetVRcJtSIW9NM7Nd9E
	rSaNxAvbGpJtpE/Nj+iPTLWgvR6gjC+XFbO9SO1YnZDHaZgEfAXuZauqitcHIKNZYoBjSLCLD0r
	f/QCBrYoofgf1ghzUvKy4LOakGFzEikf6LEGJVqQb0v2Pvr3a/kKoU+RaNvbQIgRwQpY3JQ==
X-Gm-Gg: AZuq6aL4vjhB8JkEypmaq+WCW5tffPYPH7trlEVgL10hwkceITKSiuHWj6Udc4CAeMR
	e6YwBeSJsmXFczzTHPYd8aNSVN5j+WZJ0h8HAw54I7cDbyY7DkZq7KKhZVFrnFqb5RY1dwdk44L
	o/p7xJ7AWdEC5xULfeoUDJdBeTb5kFUkHlB3ERHHOEBTX4yCaXgEmjlMCZrcD/2r1DPi4p7DM2T
	nY8JauuIVIqpxGhrd4d78A7Ylmn34tKXPvyxuQxKo+uQq6vPcYBU1WLgR73qeECSv8uXwD7uueQ
	MZENvcw4B2rLxn1xmabKuclX34M6Zk5GLYu35yP6MWwtA1xUOVLp/dxwt43kOO7dXiUhrjZrHcY
	BpUyNtWRXRogA9Z7eOFHdtQyUQHXipvLhOLCD95PJjex29tJ9Lw==
X-Received: by 2002:a17:90b:4f48:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-35273179667mr15795516a91.12.1769003478089;
        Wed, 21 Jan 2026 05:51:18 -0800 (PST)
X-Received: by 2002:a17:90b:4f48:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-35273179667mr15795472a91.12.1769003477558;
        Wed, 21 Jan 2026 05:51:17 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce415sm158900115ad.35.2026.01.21.05.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:51:16 -0800 (PST)
Date: Wed, 21 Jan 2026 21:51:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	djwong@kernel.org, fdmanana@kernel.org, quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: Re: [PATCH 1/4] generic/371: Fix the test to be compatible block
 sizes upto 64k
Message-ID: <20260121135111.7owayhl5sdva4gqq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

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

