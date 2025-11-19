Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75D35B156
	for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556581; cv=none; b=Krw+tpUwQv67ALHomKBQ612PWR8+vcIH/2kzDveg3Tw5yvGBDZqkjEjzQhdHI2mVU3FZGyRgLCJqynICFLiI7Y/aOvvvRyQbbWGtcl/nao0FNlQLtNsMuEbOWUrvTEMa3JeGkDFYEXKp6JLhMnIG/3xwvmTfmq03qCcB6X7KP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556581; c=relaxed/simple;
	bh=Aml9mhbo5ieOTq8KwkIuEkeGr1B1i0U6iqTTRe5f7Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3j0pgD78sK2OxNin+hfQ3Wx8u1juh2w76DrFRNt2BjbhFiSvBW6fwJDTSzOMNzrUziprHqnWzVTTqNQHgOkZoBXGBGFWkDx6m6Z91OikuaZln2vtArpVHmrQQ1EJiM3g7IjQlr01X1E5lIWZpwSlbWG6NzdhT7QDS2xNG1AR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CE7bkVhz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ia0W/+1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CE7bkVhz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia0W/+1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763556578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flkABsEx2eMbyuz8BLkDw0Qlh05ntEkhFH7p7w45OwQ=;
	b=CE7bkVhz8ZSuAcMOHIxVomuNxPAWII/gAJbs1AiYeyltnMT+sRDcEe1C7it9OBQAVSD44k
	uTh7BOBDThuT896czIS8/ChOw1ohnDTdQpcpCJQXGdhcUKcd8xVOP0yF1l3fSgrYnm3n/l
	HJDwnY2NQkrY6nBNLG4HdAG9Haxwres=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-iNEQQ0LINsS2Bl4KFU2pKg-1; Wed, 19 Nov 2025 07:49:37 -0500
X-MC-Unique: iNEQQ0LINsS2Bl4KFU2pKg-1
X-Mimecast-MFC-AGG-ID: iNEQQ0LINsS2Bl4KFU2pKg_1763556576
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295592eb5dbso58681175ad.0
        for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763556575; x=1764161375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flkABsEx2eMbyuz8BLkDw0Qlh05ntEkhFH7p7w45OwQ=;
        b=ia0W/+1CXj//F4QwCbEfblaDrxfK5qzB6pLz1YTm2o1ebEnHDyjdCuqiRKY6vGfGV8
         UIn8uJuVMp0W93MKqflQzuM7GA6uJ9jgxuGObEjinFGWvfY/cQzon6w5FWvgWaAjC5El
         traZkpN3kubUAv6rn1ykkP4yy+5LIAg2PAbg1jSLP6SD8BGknjrJTkFTLbyyaxGhakgY
         t0EeZ3AgMyVV6YUeM4fUJ7EESPIXdoySI3P4Vd04xn9tiMKUsy2Xn6F+tIAG6S6E0rdC
         sPoT7vS1fSTT3qvIWHd4yaoz8AOe3TEXbOgkQUusowzdSM8lqTHN9YC7CfoPeUP2ZMYw
         /tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556575; x=1764161375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flkABsEx2eMbyuz8BLkDw0Qlh05ntEkhFH7p7w45OwQ=;
        b=vp+VyYKCWQr2AMUId5ZnChua5ao8yZ5+HswjVxNp/AUDTjI6S5IlQ2NlCIMGL8AM0B
         L/pD5wKv9NpMB1GHgJ97tRNRD3UPSZ9mTSn1LBxjCEPHiknuNWUQ6zyr7cGk+QmLfqpF
         A0JlnXctFR/GzteNeAq3gZ+Lh+N6qnQDEAqBWBcyqL+Ca4seWSQsfZhr3WVZDo5xR4To
         UA0w/IoP/lYSQSnifqJ5RBQAGl18xvIU7FWm9RuuGrnlSkC4N7ExEy1wULZAdHxwhdmT
         y+bSMia2+Cf2XGwoQwv8vRRdX/dXYXHS0JFfJL3xVv/F8ic5c7OAAhniPhEHwUmp21L8
         XJMw==
X-Gm-Message-State: AOJu0YzQUKYUUrl45fcqmKng2R7zN5edTECreH8se3BGdBUomyUTBstZ
	nfk0N8kPOwFB4BLJcbUUQJdLXjs6ejolLLRhuQGxfVABiAqG9N4P2A6BgtEFZZDGGracYWR7DAd
	ezBiULPENl65z0bNwjsmFmGEDwX5oNhZIyXg/XNDNsuq9txyN3ob+UV8Yk2wXlN7GOy8=
X-Gm-Gg: ASbGncvEIb+wnFmAdNDsh5UMGMqFQ80xOcL2Jf2S/oUoM9jqy5V1c4AQPpXUew0xn05
	DAbct4KI9o13syaShqwQnNadf8Y5S7njxa/mv25UJwRBkU5v7L01GKUUwup8tBlZok2DP3sUOBs
	aDZeqZLzFOOiMxD/QrvLKzKkDUdNNyRqjkdC2Q+/gJwQ7rQXRIUQAMgYZT/KOwcPV8GM8hFqBVk
	bTsxZvRmHdx20zxNQNPpyd/2oefohs/DI1At0Ned40uJfIGvXJMNIspjAamD3P0RR/zi3iG13Ye
	H9bmTPyHalLiQoAjUSnpH938iJvLF22FhDynFLLQqmDFYKCA2FKtmpZvHT4VDF/kFuUJrRmIddZ
	hga+l73Ky7ZUWAjgccRlY6x9Ej1Ch/Jgdwx6C4pj4ZsXBF0AJ5g==
X-Received: by 2002:a17:902:e788:b0:295:9cb5:ae07 with SMTP id d9443c01a7336-2986a72bfa8mr210273895ad.38.1763556575372;
        Wed, 19 Nov 2025 04:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbH9UiL2wp1w2nlF+UYaofJ7mKdhhfcN9stx+h2/YWunOFbKhq9ZMAdbKY9c4oxzla47t0Ag==
X-Received: by 2002:a17:902:e788:b0:295:9cb5:ae07 with SMTP id d9443c01a7336-2986a72bfa8mr210273645ad.38.1763556574905;
        Wed, 19 Nov 2025 04:49:34 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d68sm208240305ad.61.2025.11.19.04.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:49:34 -0800 (PST)
Date: Wed, 19 Nov 2025 20:49:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] fstests: add fuse.gocryptfs support
Message-ID: <20251119124930.mefocqn25p3j2fbm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251116184545.3450048-1-jakobunt@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116184545.3450048-1-jakobunt@gmail.com>

On Sun, Nov 16, 2025 at 07:45:38PM +0100, Jakob Unterwurzacher wrote:
> Add instructions for testing gocryptfs, an encrypted overlay filesystem,
> and a few small changes that were needed for gocryptfs compatibility:
> 
> 1) _scratch_unmount and _test_unmount now unmount fuse filesystems
> via mountpoint instead of via device. Unmounting via device fails when
> the "device" is actually a directory on a different filesystem.
> Unmounting via mountpoint always works.
> 
> 2) Add subtype=passthrough_ll to the passthrough_ll mount options.
> This makes passthrough_ll behave more like most other fuse filesystems
> which do set a subtype. Example from my Fedora box:
> 
> 	$ mount | grep -o "type fuse\\..* "
> 	type fuse.gvfsd-fuse
> 	type fuse.portal
> 	type fuse.gocryptfs
> 	type fuse.encfs
> 	type fuse.passthrough_ll
> 
> With this change, _check_mounted_on can match on $FSTYP$FUSE_SUBTYP
> for passthrough_ll, which also works for gocryptfs and likely most
> other fuse filesystems.
> 
> Results for passthrough_ll on top of tmpfs:
> 
> 	Failures: generic/120 generic/125 generic/184 generic/294 generic/306 generic/317 generic/355
> 	generic/363 generic/426 generic/434 generic/452 generic/467 generic/477 generic/633 generic/647
> 	generic/653 generic/675 generic/683 generic/684 generic/729 generic/745 generic/751 generic/756
> 	generic/777
> 	Failed 24 of 769 tests
> 
> Results for gocryptfs on top of tmpfs:
> 
> 	Failures: generic/020 generic/062 generic/093 generic/099 generic/103 generic/120 generic/125
> 	generic/184 generic/285 generic/294 generic/306 generic/317 generic/319 generic/426 generic/434
> 	generic/444 generic/452 generic/467 generic/471 generic/477 generic/633 generic/676 generic/683
> 	generic/688 generic/696 generic/697 generic/707 generic/756 generic/777
> 	Failed 29 of 769 tests
> 
> Signed-off-by: Jakob Unterwurzacher <jakobunt@gmail.com>
> ---
>  README.fuse | 34 ++++++++++++++++++++++++++++++++--
>  common/rc   | 11 ++++++++++-
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/README.fuse b/README.fuse
> index 969dbd5d..df248681 100644
> --- a/README.fuse
> +++ b/README.fuse
> @@ -1,3 +1,6 @@
> +passthrough_ll
> +==============
> +
>  Here are instructions for testing fuse using the passthrough_ll example
>  filesystem provided in the libfuse source tree:
>  
> @@ -22,5 +25,32 @@ export SCRATCH_DEV=non2
>  export SCRATCH_MNT=/mnt/scratch
>  export FSTYP=fuse
>  export FUSE_SUBTYP=.passthrough_ll
> -export MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
> -export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"
> +export MOUNT_OPTIONS="-osource=/home/test/scratch,subtype=passthrough_ll,allow_other,default_permissions"
> +export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,subtype=passthrough_ll,allow_other,default_permissions"

This patch changes the required parameter to test FUSE, cc fuse list to get
more review.

> +
> +
> +gocryptfs
> +=========
> +
> +Here are the instructions for gocryptfs:
> +
> +git clone https://github.com/rfjakob/gocryptfs.git
> +cd gocryptfs
> +./build.bash
> +cat << EOF | sudo tee /sbin/mount.fuse.gocryptfs
> +#!/bin/bash
> +exec $(pwd)/gocryptfs -q -allow_other -acl -extpass "echo test" "\$@"
> +EOF
> +sudo chmod +x /sbin/mount.fuse.gocryptfs
> +mkdir -p /mnt/gocryptfs.test /mnt/gocryptfs.scratch /home/test/gocryptfs.test /home/test/gocryptfs.scratch
> +gocryptfs -init -q -scryptn=10 -extpass "echo test" /home/test/gocryptfs.test
> +gocryptfs -init -q -scryptn=10 -extpass "echo test" /home/test/gocryptfs.scratch
> +
> +Use the following local.config file:
> +
> +export TEST_DEV=/home/test/gocryptfs.test
> +export TEST_DIR=/mnt/gocryptfs.test
> +export SCRATCH_DEV=/home/test/gocryptfs.scratch
> +export SCRATCH_MNT=/mnt/gocryptfs.scratch
> +export FSTYP=fuse
> +export FUSE_SUBTYP=.gocryptfs
> diff --git a/common/rc b/common/rc
> index 8fd7876a..da8be16e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -512,6 +512,11 @@ _scratch_unmount()
>  	tmpfs)
>  		_unmount $SCRATCH_MNT
>  		;;
> +	fuse)
> +		# The "source device" can be an arbitrary string for fuse filesystems
> +		# and may not be unique. Unmount by mountpoint instead.
> +		_unmount $SCRATCH_MNT
> +		;;
>  	*)
>  		_unmount $SCRATCH_DEV
>  		;;
> @@ -703,6 +708,10 @@ _test_unmount()
>  {
>  	if [ "$FSTYP" == "overlay" ]; then
>  		_overlay_test_unmount
> +	elif [ "$FSTYP" == "fuse" ]; then
> +		# The "source device" can be an arbitrary string for fuse filesystems
> +		# and may not be unique. Unmount by mountpoint instead.
> +		_unmount $TEST_DIR
>  	else
>  		_unmount $TEST_DEV
>  	fi
> @@ -5021,7 +5030,7 @@ init_rc()
>  
>  	# Sanity check that TEST partition is not mounted at another mount point
>  	# or as another fs type
> -	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP || _exit 1
> +	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP$FUSE_SUBTYP || exit 1
>  	if [ -n "$SCRATCH_DEV" ]; then
>  		# Sanity check that SCRATCH partition is not mounted at another
>  		# mount point, because it is about to be unmounted and formatted.
> -- 
> 2.51.0
> 
> 

