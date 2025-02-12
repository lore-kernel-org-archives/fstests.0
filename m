Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6031CA9C
	for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325201; cv=none; b=AKNSx7pLg0yBBwxHdXxP/OliczPQH939rXjfg7/2p6KoiWwYxEuHls5VAauhxUY4XR7/lGUvcp4cu7kobV67txeuDyemzg9JMvpASVgMaKB/GvE31Me7YTzPglRePAAy9Gc9HBBOFuChPS91n6fZWjsP9WK7McjRFv0jeVOSLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325201; c=relaxed/simple;
	bh=161lUi+Z6GsZnNfxahI4UKNYb2OjZYVAsEn6pc/1rY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD8o8qS60kHgGqxCpd/1HX97HlUc3b9/puY2ovTmOEX3B3+io6YRoRW24Gw06vuYOZPJkNJ8KYnQ/Bf58AGpz6XIHxI+MGj45tZgSqHzzDga72FNdquBAhZv5WSOWqrfUaV3eQjqKuW+q/0dRQXvAtLgZnXIj8eJnNNjWHsnDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bh82aKYc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bh82aKYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739325198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShwW8uP4vppu9NWjtPcCG12JjQteJ1armH7JB/XdAQs=;
	b=bh82aKYclyh9EKVvKNtQ52hkaqAxy5u0zgHYTGXosPVACl1mYkOH9l4CKQK7x5vi9KLzop
	hZ+mLpdqdaSXru2amLqpzS+afWxT7aXaddH3nm6qyuWhS5ulSwg6XVJZ2hZQ/uAwQAP8sk
	zFrtL7IlBGYNa4U459pqUMnDxmJrgj0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-s2rYzovmPl-dNw_DPTr2fA-1; Tue, 11 Feb 2025 20:53:16 -0500
X-MC-Unique: s2rYzovmPl-dNw_DPTr2fA-1
X-Mimecast-MFC-AGG-ID: s2rYzovmPl-dNw_DPTr2fA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fa34e65bc1so14072872a91.2
        for <fstests@vger.kernel.org>; Tue, 11 Feb 2025 17:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739325195; x=1739929995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShwW8uP4vppu9NWjtPcCG12JjQteJ1armH7JB/XdAQs=;
        b=avXkpGKXAl/JJYyM22qkk/ygpvxWyIGEKjW6/lwKv36gvLYdd1Nz/eO5namxGB4ald
         D5qrGD7N6P0Ezbdv4/jk6Q1W2RIFM1veMrLoqWOEcFaYhA+XW7XdkpZ1DAEmBeonosZr
         +UOdM7yp7NK8HSPRZUsA2CupH09MQAB9ZxUb8jpwF+aLllKi0Iuo5mYEJX0BMdSZ7+Po
         iTC4duy9HuIRLqyCIxM97UIYI/XwMARNJxrEtaHtai4kuHED7l8ryAcgOXsB9RPFnsk2
         r2BSB7IIvpyt0amKAkIBBVAh57UNIQK7XWpBAdSdTfIKQLcGrtiAxlV2gKJKUje/lbL1
         ZPWw==
X-Gm-Message-State: AOJu0Yz75tCXm388wTH/4m5FnwNRIh9gltcvTSg1V1riMs2N7xB6ebGZ
	jD9v0DdS6EIYxrRbbqeDYuJoQfHI7GCHOR8SYd0Vh8SZ3IQ81/bocPXRScKzFGz8HEPSaQ+d9k6
	4coIPBQmD2v9j9k730bK9QUCmu3HefL0IbPSqoS5h7ZT/eM5J/fYXRHI=
X-Gm-Gg: ASbGnctUr+5x4Ih28AY4waC/TC07OqF4NDTXguZ47ulMUdy/7iB03MVFAtMDm1dx7ZD
	eYOfk0zv1TktPaw/uXiLYPkNjoHO2sIqiXEbBQCI5VrqE4VDM9D6a0gSxQ6+tIAEoS8ruhyt7h5
	1qHonaNXEowbU8a8zHW7bx0TDQ07pTR+PrchB8jpz+sKf6p98jNSWHqoZcX9n1pkR0g+dWq8mnz
	r2ni2hXCNS2DsDFFxWbGg6OHN8k1yDYTb/l2oMDbS71aSEe2XMOf46t9FZ9Ht1TC9LEQiUqGFGB
	hOrR237EKAauDj5IsR6vWcW6qey9bv3LJWtoUdvplLsE7Q==
X-Received: by 2002:a17:90b:4a10:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2fbf5ae2d80mr2468517a91.0.1739325195048;
        Tue, 11 Feb 2025 17:53:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy2dSxl087ZCLJp5iAGw45IvvYKiWgq/W94gbXGG3ddPQJw0i7qqXvXwQxCUdLE2K1LOVNUg==
X-Received: by 2002:a17:90b:4a10:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2fbf5ae2d80mr2468497a91.0.1739325194673;
        Tue, 11 Feb 2025 17:53:14 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9ab0233sm227160a91.44.2025.02.11.17.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 17:53:13 -0800 (PST)
Date: Wed, 12 Feb 2025 09:53:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
Message-ID: <20250212015310.ifnjdxj53jbsy2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>

On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's odd when a test fails on a filesystem and a specific fix is suggested
> for another filesystem. Some generic tests are suggesting filesystem
> specific fixes without checking if the running filesystem matches, so
> update them.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/365 | 10 ++++++----
>  tests/generic/366 |  2 +-
>  tests/generic/367 |  2 +-
>  tests/generic/623 |  2 +-
>  tests/generic/631 |  2 +-
>  tests/generic/646 |  2 +-
>  tests/generic/649 |  2 +-
>  tests/generic/695 |  2 +-
>  tests/generic/700 |  4 ++--
>  tests/generic/701 |  2 +-
>  tests/generic/702 |  2 +-
>  tests/generic/704 |  4 +++-
>  tests/generic/707 |  4 ++--
>  13 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/tests/generic/365 b/tests/generic/365
> index 1f6a618a..1bca848a 100755
> --- a/tests/generic/365
> +++ b/tests/generic/365
> @@ -9,10 +9,12 @@
>  . ./common/preamble
>  _begin_fstest auto rmap fsmap
>  
> -_fixed_by_kernel_commit 68415b349f3f \
> -	"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> -_fixed_by_kernel_commit ca6448aed4f1 \
> -	"xfs: Fix missing interval for missing_owner in xfs fsmap"
> +if [ "$FSTYP" = "xfs" ]; then
> +	_fixed_by_kernel_commit 68415b349f3f \
> +		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> +	_fixed_by_kernel_commit ca6448aed4f1 \
> +		"xfs: Fix missing interval for missing_owner in xfs fsmap"
> +fi
>  
>  . ./common/filter
>  
> diff --git a/tests/generic/366 b/tests/generic/366
> index b322bcca..b2c2e607 100755
> --- a/tests/generic/366
> +++ b/tests/generic/366
> @@ -23,7 +23,7 @@ _require_scratch
>  _require_odirect 512	# see fio job1 config below
>  _require_aio
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
>  	"btrfs: avoid deadlock when reading a partial uptodate folio"
>  
>  iterations=$((32 * LOAD_FACTOR))
> diff --git a/tests/generic/367 b/tests/generic/367
> index 7cf90695..ed371a02 100755
> --- a/tests/generic/367
> +++ b/tests/generic/367
> @@ -17,7 +17,7 @@
>  
>  _begin_fstest ioctl quick
>  
> -_fixed_by_kernel_commit 2a492ff66673 \
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2a492ff66673 \
>  	"xfs: Check for delayed allocations before setting extsize"
>  
>  _require_scratch_extsize
> diff --git a/tests/generic/623 b/tests/generic/623
> index 6487ccb8..9f41b5cc 100755
> --- a/tests/generic/623
> +++ b/tests/generic/623
> @@ -11,7 +11,7 @@ _begin_fstest auto quick shutdown
>  
>  . ./common/filter
>  
> -_fixed_by_kernel_commit e4826691cc7e \
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit e4826691cc7e \
>  	"xfs: restore shutdown check in mapped write fault path"
>  
>  _require_scratch_nocheck
> diff --git a/tests/generic/631 b/tests/generic/631
> index 8e2cf9c6..c38ab771 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -41,7 +41,7 @@ _require_attrs trusted
>  _exclude_fs overlay
>  _require_extra_fs overlay
>  
> -_fixed_by_kernel_commit 6da1b4b1ab36 \
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 6da1b4b1ab36 \
>  	"xfs: fix an ABBA deadlock in xfs_rename"
>  
>  _scratch_mkfs >> $seqres.full
> diff --git a/tests/generic/646 b/tests/generic/646
> index dc73aeb3..b3b0ab0a 100755
> --- a/tests/generic/646
> +++ b/tests/generic/646
> @@ -14,7 +14,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick recoveryloop shutdown
>  
> -_fixed_by_kernel_commit 50d25484bebe \
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 50d25484bebe \
>  	"xfs: sync lazy sb accounting on quiesce of read-only mounts"
>  
>  _require_scratch
> diff --git a/tests/generic/649 b/tests/generic/649
> index a33b13ea..58ef96a8 100755
> --- a/tests/generic/649
> +++ b/tests/generic/649
> @@ -31,7 +31,7 @@ _cleanup()
>  
>  
>  # Modify as appropriate.
> -_fixed_by_kernel_commit 72a048c1056a \
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 72a048c1056a \
>  	"xfs: only set IOMAP_F_SHARED when providing a srcmap to a write"
>  
>  _require_cp_reflink
> diff --git a/tests/generic/695 b/tests/generic/695
> index df81fdb7..694f4245 100755
> --- a/tests/generic/695
> +++ b/tests/generic/695
> @@ -25,7 +25,7 @@ _cleanup()
>  . ./common/dmflakey
>  . ./common/punch
>  
> -_fixed_by_kernel_commit e6e3dec6c3c288 \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit e6e3dec6c3c288 \
>          "btrfs: update generation of hole file extent item when merging holes"
>  _require_scratch
>  _require_dm_target flakey
> diff --git a/tests/generic/700 b/tests/generic/700
> index 052cfbd6..7f84df9d 100755
> --- a/tests/generic/700
> +++ b/tests/generic/700
> @@ -19,8 +19,8 @@ _require_scratch
>  _require_attrs
>  _require_renameat2 whiteout
>  
> -_fixed_by_kernel_commit 70b589a37e1a \
> -	xfs: add selinux labels to whiteout inodes
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 70b589a37e1a \
> +	"xfs: add selinux labels to whiteout inodes"
>  
>  get_selinux_label()
>  {
> diff --git a/tests/generic/701 b/tests/generic/701
> index 527bba34..806cc65d 100755
> --- a/tests/generic/701
> +++ b/tests/generic/701
> @@ -22,7 +22,7 @@ _cleanup()
>  	rm -r -f $tmp.* $junk_dir
>  }
>  
> -_fixed_by_kernel_commit 92fba084b79e \
> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit 92fba084b79e \
>  	"exfat: fix i_blocks for files truncated over 4 GiB"
>  
>  _require_test
> diff --git a/tests/generic/702 b/tests/generic/702
> index a506e07d..ae47eb27 100755
> --- a/tests/generic/702
> +++ b/tests/generic/702
> @@ -14,7 +14,7 @@ _begin_fstest auto quick clone fiemap
>  . ./common/filter
>  . ./common/reflink
>  
> -_fixed_by_kernel_commit ac3c0d36a2a2f7 \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit ac3c0d36a2a2f7 \
>  	"btrfs: make fiemap more efficient and accurate reporting extent sharedness"
>  
>  _require_scratch_reflink
> diff --git a/tests/generic/704 b/tests/generic/704
> index f452f9e9..f2360c42 100755
> --- a/tests/generic/704
> +++ b/tests/generic/704
> @@ -21,7 +21,9 @@ _cleanup()
>  # Import common functions.
>  . ./common/scsi_debug
>  
> -_fixed_by_kernel_commit 7c71ee78031c "xfs: allow logical-sector sized O_DIRECT"
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 7c71ee78031c \
> +	"xfs: allow logical-sector sized O_DIRECT"
> +
>  _require_scsi_debug
>  # If TEST_DEV is block device, make sure current fs is a localfs which can be
>  # written on scsi_debug device
> diff --git a/tests/generic/707 b/tests/generic/707
> index 3d8fac4b..23864038 100755
> --- a/tests/generic/707
> +++ b/tests/generic/707
> @@ -13,9 +13,9 @@ _begin_fstest auto
>  
>  _require_scratch
>  
> -_fixed_by_kernel_commit f950fd052913 \
> +[ "$FSTYP" = "udf" ] && _fixed_by_kernel_commit f950fd052913 \
>  	"udf: Protect rename against modification of moved directory"
> -_fixed_by_kernel_commit 0813299c586b \
> +[ "$FSTYP" = "ext4" ] && _fixed_by_kernel_commit 0813299c586b \

I'm wondering if it's a "ext4 only" bug, or it might can be [[ "$FSTYP" =~ ext[0-9]+ ]] ?
Others looks good to me.

Thanks,
Zorro

>  	"ext4: Fix possible corruption when moving a directory"
>  
>  _scratch_mkfs >>$seqres.full 2>&1
> -- 
> 2.45.2
> 
> 

