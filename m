Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4817555
	for <fstests@vger.kernel.org>; Wed, 23 Apr 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418566; cv=none; b=ig3WxVAeSdxwtGdZi4DihNSa0f7WX/5TZjVKxfe5HIJk1JXcj2t6RRNt4SgPrgplcpTXkmvj/sO8pFPZa5Z/00hzpPe9StcF2SXciq00Z94RS48GjiqamHnFwNmjDCSrtYZusqTWYuNtLTBaBYCO/dL2xk+MdQfOdH7m0ui9EvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418566; c=relaxed/simple;
	bh=wamB6f7rHvIfraz+xiKUWZd2kPDxqvOuOt60iZUIKjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb3+bnkCBQib5i2tax8CQj/uaMKYPXgfDwnUsGPHL+dwasIbQWuIHIJpxumtgb32n5SXwWkixELn2P1FFOwZ//bgQv0kLw7wWId4Xu9SCi3V+y27ZN0oxcVaWPn8BkS+94YXyTKS1u6b5Qv79nSMhPigU71yno/biB7XxIoNwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAhedvRl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAhedvRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745418563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNqnmucRpbmwE/zuPcrjopQ96l/AJdyQ/b8kAiFjTIo=;
	b=NAhedvRlwjkomqraX3GWdsawMeFD40uBrDaYCSYtad9jjHMTOcOgrrmtQU3G4NS0N5IVee
	Qf8fWRrLS+Quf7RL3jBcnedqzARkq7JBOxlK0uSueUVlMINggTSe3ttIi4Td1Iiy2RgCHj
	3nnPXuCtDCp6cE2etmR5h2PQW81k2gM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-LnHxdfWXN3O_WQwmKoA1Bg-1; Wed, 23 Apr 2025 10:29:21 -0400
X-MC-Unique: LnHxdfWXN3O_WQwmKoA1Bg-1
X-Mimecast-MFC-AGG-ID: LnHxdfWXN3O_WQwmKoA1Bg_1745418561
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso8145343b3a.1
        for <fstests@vger.kernel.org>; Wed, 23 Apr 2025 07:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745418560; x=1746023360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNqnmucRpbmwE/zuPcrjopQ96l/AJdyQ/b8kAiFjTIo=;
        b=HHLho/mme9Epq4lAriN6c1WLiOte7rtB5A31tCxIGalOQWQvn0VGe4dLqNdr4za1Mb
         3/znhf4qxuaXRiGr/6kFZAD4lnNfQWHydlfRv8KH/IrhLSkbCLOXQk2A0ZisYyGmb5Rv
         FJnIGTobd9efWXp9EvCaOUmTsABDiJNNo9y16AhnGv4SQb0FY2icgU3xYi+AKeKiHR3k
         oOkJcVMmv5NchmU+6xnFLJZh6TTguR9sS/knnbPEXwFn8NlMz9fA6XO8QHUwmT3BJh4b
         lawI/KAo8aPgWLMltHkyxaGr8o+LeAb41KvzDXw8zNlz28umQ3vPHxU+YPQseqVeWy8O
         Rbwg==
X-Gm-Message-State: AOJu0YxiGi5YPirBbMY88jACDPV/Fz6g8XveZs9o6EH5gD5i3FwXZkN+
	Z4L/OQO44AC+ZDeszo90tu1x0S143GLiToOaREPQzybbiAnbmiH7Da2UnapVrsKHUFzEwRpPAWJ
	MfjMENzhS+x+rXiTuzZesks4ksuH+n7eczv98fbsDKSK9G1GRZ+16Q9jlEoR1JTiPkw==
X-Gm-Gg: ASbGncuQLs4icGFfNgjPx+bg1gq5+1QmqqD6arQwEO+12NsonWDs/re26YvcQVFR53N
	7qVMgBmcQEfTxhuHyfo3Wp3Y92iMKPbOwv7XOSt2ns9Tl0A9k3uVg0pqW/C7/eYVELozthNlGvI
	zKF0n27UQPqvadmB2tCB8JrqiXCWEqGzPTF/ptN3d/u/3T1OtAlhMYOVDbvsnxwd6fZoLj/O8bS
	EVtF9vOWwzhEiKOYbUhkUHmB6qpwiaOMN5Hxer8Zm1EE78ooJxL6zZg78NXKqfvEsQp88OXBnsC
	ksL7bBufHmt3DG7YjFaekFj4BtBzCasgIj36rSLiJqO5Lxleetx1
X-Received: by 2002:a05:6a20:12cb:b0:1f5:67c2:e3eb with SMTP id adf61e73a8af0-203cbd27a82mr33978455637.41.1745418560503;
        Wed, 23 Apr 2025 07:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEPYYUQ5lFG8PO2fZ/UA7t3UKYgG7O+c1ukYkJIuy74s9vloMUn0SjyLgnQ0ZyXhQO0fyHBg==
X-Received: by 2002:a05:6a20:12cb:b0:1f5:67c2:e3eb with SMTP id adf61e73a8af0-203cbd27a82mr33978420637.41.1745418560109;
        Wed, 23 Apr 2025 07:29:20 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db148591fsm7249092a12.70.2025.04.23.07.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:29:19 -0700 (PDT)
Date: Wed, 23 Apr 2025 22:29:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: common/btrfs: add _ prefix to temp fsid helper
 functions
Message-ID: <20250423142916.p55223lw7qgbz3iq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>

On Thu, Apr 17, 2025 at 08:27:22PM +0800, Anand Jain wrote:
> Just adding a _ prefix to the two temp fsid helper functions and
> a rename in common/btrfs to keep the coding style consistent.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Looks good to me, I'm just wondering if the _mkfs_clone should be
_btrfs_mkfs_clone, due to it looks like a btrfs specific helpers
and this kind of helpers nearly all have a "_btrfs" prefix.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/btrfs    | 6 +++---
>  tests/btrfs/311 | 4 ++--
>  tests/btrfs/313 | 6 +++---
>  tests/btrfs/314 | 2 +-
>  tests/btrfs/315 | 4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 3725632cc420..44c9d6a6777d 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -942,7 +942,7 @@ _has_btrfs_sysfs_feature_attr()
>  # Print the fsid and metadata uuid replaced with constant strings FSID and
>  # METADATA_UUID. Compare temp_fsid with fsid and metadata_uuid, then echo what
>  # it matches to or TEMP_FSID. This helps in comparing with the golden output.
> -check_fsid()
> +_check_temp_fsid()
>  {
>  	local dev1=$1
>  	local fsid
> @@ -979,7 +979,7 @@ check_fsid()
>  	cat /sys/fs/btrfs/$tempfsid/temp_fsid
>  }
>  
> -mkfs_clone()
> +_mkfs_clone()
>  {
>  	local fsid
>  	local uuid
> @@ -990,7 +990,7 @@ mkfs_clone()
>  	_require_btrfs_mkfs_uuid_option
>  
>  	[[ -z $dev1 || -z $dev2 ]] && \
> -		_fail "mkfs_clone requires two devices as arguments"
> +		_fail "_mkfs_clone requires two devices as arguments"
>  
>  	_mkfs_dev -fq $dev1
>  
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> index 51147c59f49b..9ac997dbba61 100755
> --- a/tests/btrfs/311
> +++ b/tests/btrfs/311
> @@ -47,7 +47,7 @@ same_dev_mount()
>  	md5sum $SCRATCH_MNT/foo | _filter_scratch
>  	md5sum $mnt1/bar | _filter_test_dir
>  
> -	check_fsid $SCRATCH_DEV
> +	_check_temp_fsid $SCRATCH_DEV
>  }
>  
>  same_dev_subvol_mount()
> @@ -69,7 +69,7 @@ same_dev_subvol_mount()
>  	md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
>  	md5sum $mnt1/bar | _filter_test_dir
>  
> -	check_fsid $SCRATCH_DEV
> +	_check_temp_fsid $SCRATCH_DEV
>  }
>  
>  same_dev_mount
> diff --git a/tests/btrfs/313 b/tests/btrfs/313
> index 5a9e98dea1bb..d55667f733ee 100755
> --- a/tests/btrfs/313
> +++ b/tests/btrfs/313
> @@ -30,15 +30,15 @@ mnt1=$TEST_DIR/$seq/mnt1
>  mkdir -p $mnt1
>  
>  echo ---- clone_uuids_verify_tempfsid ----
> -mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
> +_mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
>  
>  echo Mounting original device
>  _mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
> -check_fsid ${SCRATCH_DEV_NAME[0]}
> +_check_temp_fsid ${SCRATCH_DEV_NAME[0]}
>  
>  echo Mounting cloned device
>  _mount ${SCRATCH_DEV_NAME[1]} $mnt1
> -check_fsid ${SCRATCH_DEV_NAME[1]}
> +_check_temp_fsid ${SCRATCH_DEV_NAME[1]}
>  
>  $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_io
>  echo cp reflink must fail
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index d931da8f0293..659a85d39886 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -36,7 +36,7 @@ send_receive_tempfsid()
>  	local dst=$2
>  
>  	# Use first 2 devices from the SCRATCH_DEV_POOL
> -	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>  	_scratch_mount
>  	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>  
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index e6589abec08c..90f77413bedb 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -51,7 +51,7 @@ seed_device_must_fail()
>  {
>  	echo ---- $FUNCNAME ----
>  
> -	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>  
>  	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
>  	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
> @@ -64,7 +64,7 @@ device_add_must_fail()
>  {
>  	echo ---- $FUNCNAME ----
>  
> -	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>  	_scratch_mount
>  	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>  
> -- 
> 2.47.0
> 

