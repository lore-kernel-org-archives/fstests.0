Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F6242D95
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908306; cv=none; b=jGbB+6HOOUz4LG4wT3qY7LJ0ITfi1gvWanDQj4U+UeEOtc8cbg0F6Z0jn9J6mBF5mD5MWk76OehxFJy2KgJLbDmbQ5eQaAafO5HzyYsfxroX0OXO//i9dQP4LFGkcixV8YsTz00GmeFRYXnnYf9sUh3mKXTJ7Lrpu/IJce1ZoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908306; c=relaxed/simple;
	bh=3TbeADHHhW+kReVnv4mpS50MKZpjwPTiW60fCjzafEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH0JOZ1ksiKix+RY3ItXzWJPPI19x/PjGuh87xKfG5gSt7uCWZ0x7ABBEn72DjVY2lodi0PegOQ8MUuIsUYJcvX+XR4THqtibuFk5U3h5gwgH7BBb2y8UxfrZEv12BcLE547jdB544V81W1pxrA35nDefQooBl1fw+/gKXt8yr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfOXH+3t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfOXH+3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758908303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGNoW7FMO9d1BBRikQ6ef0WDOVNu4u7ojdvM/EgHlqs=;
	b=cfOXH+3tsOcNiqjbgsjf8LZ0XtUEQAyJtnqFLkDKL2PPEG4aakTU2BCyM1MMuwdgg3c9Fv
	jfNToTgKq5e73NvJ6pfwwwfYkDUPt4gysc4YEFRVsVlNEKFLOgexO2pmnrsNxO8ZFhFZew
	s82XuTgZciU/tlZW8rdAAES6lVeyw/I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-tnaEku3jPyejQAzKnsoshQ-1; Fri, 26 Sep 2025 13:38:22 -0400
X-MC-Unique: tnaEku3jPyejQAzKnsoshQ-1
X-Mimecast-MFC-AGG-ID: tnaEku3jPyejQAzKnsoshQ_1758908301
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befd39so4376349a91.0
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 10:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758908301; x=1759513101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGNoW7FMO9d1BBRikQ6ef0WDOVNu4u7ojdvM/EgHlqs=;
        b=peqkrBYmz7HH+e3vNiRV1S2BsvVx9ftFq4nBd3zhOvjTB9ubQlcUPAW9GxOD/JqaC+
         qWfXeUhat21bX8eK39teKtO3ycbLNCCFTc++cbtIgPCCqLv/KSjdW7p9HBzdhGqJ51Ei
         KSzF62LuK41FrB4ghHYz1IjPWSxojUO/jsl3fC3scFqAp4/A+sCBWXsF77mfTTWEkbLn
         ddakIXEbdNQO5cyJccfvx671+/rS9b1NAzI/JpunfmDIdM/9tV7MDIYFIFhZmWE13kx6
         qHGDtH7JMtPwChcQj9rL9k5LBd+SDP/lS7Roj2YyAnapLtTn/9hOMZyN8+gL8ClGx8d5
         8GcA==
X-Gm-Message-State: AOJu0YyqQzSyZWigzezQFFEcAsdYzWjbccQtJcXXNareWNalE29L5MTN
	SE/Gb9v8GS3FvRBov7PdTIos2cJ/6iykWQiv8rGNbvw0Uyk3CgWIgGVnKxuaHa+tqxldYKby5p8
	or5DP/4J1cQNgK5r2bMWHGEY7ZK9DJCwByA3Jcux5PCss27ew+cd5fJad0QE=
X-Gm-Gg: ASbGncuEO998xYtMWh79t+jA+KaOD9aTOUnmnkPEZZLfXtjAknAcqUv44GNr793HwDz
	BCPJfbmwqF1dNJO2HgYbAuW6n6sZqM0iLHnuZiGHJakHm6QVzV9xmydnxB44K/E8wipYenv2Y/5
	+LN3534uOUMo1kDZsmA1hHpEpb+3wWKYFIPRplDWMS0+yOPWP9F7C5EjdqL09owHNSwcIQ8wY3w
	dp1LqX/SkbUe/YmSxViQDz4kxobiVTEXDwIWW+DdBAraWRA1t1xfc9NDwHM4SbK76wO580Ffyag
	m2vpHCbFFPPbryEDv0MQ20Z8jx78eMOc6j1vAOnAhW66NSpn0S3IjK6PAUnNicOfedOhkfBkObu
	GhpRV
X-Received: by 2002:a17:90b:2d0d:b0:332:50e7:9d00 with SMTP id 98e67ed59e1d1-3342a269ac5mr8659561a91.11.1758908300853;
        Fri, 26 Sep 2025 10:38:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv0ZE3AQFBhOyhHstmz/f0/TQ2pDP1boHfztCnF9nfVeZiyIddTFdt+71QB6obpu5FyICAnQ==
X-Received: by 2002:a17:90b:2d0d:b0:332:50e7:9d00 with SMTP id 98e67ed59e1d1-3342a269ac5mr8659541a91.11.1758908300353;
        Fri, 26 Sep 2025 10:38:20 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33473f7c960sm6117851a91.18.2025.09.26.10.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:38:20 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:38:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	djwong@kernel.org, fdmanana@kernel.org, quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: Re: [PATCH 3/4] btrfs/200: Make the test compatible with all
 supported block sizes
Message-ID: <20250926173815.wmyvfjxckwhnvu3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <c93a0f1885721e7bc2800094fafb7fd7bd2c607b.1758036285.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c93a0f1885721e7bc2800094fafb7fd7bd2c607b.1758036285.git.nirjhar.roy.lists@gmail.com>

On Tue, Sep 16, 2025 at 03:30:11PM +0000, Nirjhar Roy (IBM) wrote:
> This test fails on 64k block size with the following error:
> 
>      At snapshot incr
>      OK
>      OK
>     +File foo does not have 2 shared extents in the base snapshot
>     +/mnt/scratch/base/foo:
>     +   0: [0..255]: 26624..26879
>     +File foo does not have 2 shared extents in the incr snapshot
> 
> So, basically after btrfs receive, the file /mnt/scratch/base/foo
> doesn't have any shared extents in the base snapshot.
> The reason is that during btrfs send, the extents are not cloned
> and instead they are written.
> The following condition is responsible for the above behavior
> 
> in function clone_range():
> 
> 	/*
> 	 * Prevent cloning from a zero offset with a length matching the sector
> 	 * size because in some scenarios this will make the receiver fail.
> 	 *
> 	 * For example, if in the source filesystem the extent at offset 0
> 	 * has a length of sectorsize and it was written using direct IO, then
> 	 * it can never be an inline extent (even if compression is enabled).
> 	 * Then this extent can be cloned in the original filesystem to a non
> 	 * zero file offset, but it may not be possible to clone in the
> 	 * destination filesystem because it can be inlined due to compression
> 	 * on the destination filesystem (as the receiver's write operations are
> 	 * always done using buffered IO). The same happens when the original
> 	 * filesystem does not have compression enabled but the destination
> 	 * filesystem has.
> 	 */
> 	if (clone_root->offset == 0 &&
> 	    len == sctx->send_root->fs_info->sectorsize)
> 		return send_extent_data(sctx, dst_path, offset, len);
> 
> Since we are cloning from the first half [0 to 64k), clone_root->offset = 0
> and len = 64k which is the sectorsize (sctx->send_root->fs_info->sectorsize).
> Fix this by increasing the file size and offsets to 128k so that
> len == sctx->send_root->fs_info->sectorsize is not true.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/btrfs/200     | 8 ++++----
>  tests/btrfs/200.out | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> index e62937a4..b53955ce 100755
> --- a/tests/btrfs/200
> +++ b/tests/btrfs/200
> @@ -38,14 +38,14 @@ _scratch_mount
>  # Create our first test file, which has an extent that is shared only with
>  # itself and no other files. We want to verify a full send operation will
>  # clone the extent.
> -$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
> +$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 128K 0 128K" $SCRATCH_MNT/foo \

This change and explanation makes sense to me, and I think 128k won't break
the "an extent" requirement (compare with 64k). So,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	| _filter_xfs_io
> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 128K 128K" $SCRATCH_MNT/foo \
>  	| _filter_xfs_io
>  
>  # Create out second test file which initially, for the first send operation,
>  # only has a single extent that is not shared.
> -$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
> +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 128K 0 128K" $SCRATCH_MNT/bar \
>  	| _filter_xfs_io
>  
>  _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
> @@ -56,7 +56,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>  # Now clone the existing extent in file bar to itself at a different offset.
>  # We want to verify the incremental send operation below will issue a clone
>  # operation instead of a write operation.
> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 128K 128K" $SCRATCH_MNT/bar \
>  	| _filter_xfs_io
>  
>  _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> index 306d9b24..a33b3c1e 100644
> --- a/tests/btrfs/200.out
> +++ b/tests/btrfs/200.out
> @@ -1,12 +1,12 @@
>  QA output created by 200
> -wrote 65536/65536 bytes at offset 0
> +wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -linked 65536/65536 bytes at offset 65536
> +linked 131072/131072 bytes at offset 131072
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 0
> +wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  At subvol SCRATCH_MNT/base
> -linked 65536/65536 bytes at offset 65536
> +linked 131072/131072 bytes at offset 131072
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  At subvol SCRATCH_MNT/incr
>  At subvol base
> -- 
> 2.34.1
> 

