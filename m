Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CAA3191A4
	for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533556; cv=none; b=P3pfrN4jgTynv6mhZDSFMF9zGooYadXOqD9IUUhHOCFgG8KqlW63qEaCF8lkXKkQw43dcUeZEx5ERd5KjXRUcx0H79uduCSEGEd5a+Z41jrsIFdmr4VToxEhQL6IvxMi3bJLZP0QACj3+vC1FGlx0XX5OJ+tjdyTujuEwPvyagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533556; c=relaxed/simple;
	bh=09pW9jhMdOSu6az+Co9uCk/7wIEh78BdhoSvkd55rgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVB9bPfG0/EzCXe/p7sQddRthlHcNJ+4+RpN+MWw2yGcXwZ4soMJl8VeVgXtU+dnhxq/ElUmuh+/o6Vj/CvCvvL1N1f4KxdzWpfLZGnw2IxDvh/3W9su4x3+niO/jh7zb/CsJVMT3n0Jope+HcgjIeU2oG4cSCWYbZKmqqV3A90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeyOE+qW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r6gHoYAp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeyOE+qW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r6gHoYAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763533552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E2rF5cAI3lm8Pi9Ht/Ve6J+2WxlbMHFIbxOe2vE7yQQ=;
	b=EeyOE+qWHq9K4WF3uj8dWaQ8tcaSENew4IoV79qGX6ZXBoKHbXWERFwbmyXwmxcFGOpYIX
	geLfZyNKAuGnaPe9z8JxtbSF5cu6z538r3Pa3EPWoPKUFG1/ZZQfzuoUBlV3L0k/Q+OaeG
	nJYd8Yh2fglSiM+/d3URuXcjSdimzLQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-AEjnayWyN_uUbpN5oAlERA-1; Wed, 19 Nov 2025 01:25:50 -0500
X-MC-Unique: AEjnayWyN_uUbpN5oAlERA-1
X-Mimecast-MFC-AGG-ID: AEjnayWyN_uUbpN5oAlERA_1763533549
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29806c42760so231615765ad.2
        for <fstests@vger.kernel.org>; Tue, 18 Nov 2025 22:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763533549; x=1764138349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2rF5cAI3lm8Pi9Ht/Ve6J+2WxlbMHFIbxOe2vE7yQQ=;
        b=r6gHoYApWRiW6sGkgL+gqa/aUZbuv0YvzHSInQvRL6qt2itD0a6gvqEn7zjeOHbF+L
         Q/WScrhybKnmdXIHABlzNYzacT3mGuxqgQ1r+pLEKFCPjlNYFdWHFpuqXfnE5JqRbGr5
         mtggOT0Vtt4JvvetNcJgwBALrq5X7PgWmI2PCzKwjTIMGApuT1QVPNSe+aYo+t0pwPGd
         WYuuTZQHY3tfeyu1BDurYRZdjoGl2vM+pY9rNaINUIKCDYB/wOsAvyBwk2XzlTpisaem
         P73N8VfWmc8Cax2fv5pb5ctkbVhKAxPoR+BQdRb606j+8ZmRNXOHd15GLa0VmGPKauoY
         1rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763533549; x=1764138349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2rF5cAI3lm8Pi9Ht/Ve6J+2WxlbMHFIbxOe2vE7yQQ=;
        b=lgolY1hT0G6aF8HR4NG8o/rKer79AV5XMcco+IK7hZCcjFbMbLtY/jp8Mx+nwHlrZG
         XAtC/J8uXwMyod1wLObhBFGjovnGLn2sud6gtU1RXwQwb9HwUl3kWYUvF0aU2UUJDTOd
         vIJ9OG8mQ1Nd2oZ+BQxf6RAMaMfsH8+z2ZGrXo6TTLPW/zfR9qqO+dco07e/Nxo7ZJJi
         Svy1uClACc6ruf1gxEPv56CuM2UU6J3YMZFh6Y0EIgFSuSKPupP6hXgdDXcFqugqo7HW
         tPRe1bNNyWCJp2dcW9OgC1MQ027kS4HaTc4V150X3ueavLA/0t73BZP3eFMPQzp1mcWn
         Q73g==
X-Forwarded-Encrypted: i=1; AJvYcCULHNyi5ZJ3SprfZXKUbQkJKhCKZWKyHAvcJ0KPMLGfFTIYN2QHmXY4tvhlOBKu0FDA2QLdHCnf@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtV6Eavovafle/t74BQwcTUTMQqF4nTy9CCTErLY2QT1RWhri
	ZsCVAUvjmayzsMLYKKV3nYRUk+oHgMNsionOZz6jgMM/u7hxbExZlaFjocEyrlmAiwE0tbEyQ7m
	lKyidm8SNTmd3w0rqeGl4kbfS+7F/ZfrnkjQrXAUSXV1uEWm1NEhKoDfVP7I=
X-Gm-Gg: ASbGncux6YZCp1Y336ZOdGDrYqdk1986I7RGgNZOwabT6SytA4MWjjT/y3R6cFqMW5T
	UUOYSkKUEu32zAWijlLa7/nQKs66aUY5AWT0GjaT4p4gKCT6vcGg5wgzGq1+fAZnkEYNFyZxVYw
	GXqLYUYAnvJheR9PADcDYBkqtP1gVa3kKJ/+HvfV0i/wgupGOlhGV/yjfEyj9msLaBmggfXKWYQ
	noFvwEefb1GBPeDInVZdQa8axgVXkplVOaebyS7+tFyMCDWAp3M9uGzhezjNn5a7uZ4mNSvamWu
	GxGBtVMSgwnktwZ6zzSuunHtPlaD18OasFzDl0MFaqe6WLZ83I2hiwGMjIEKDueSqj+8QPrPJRy
	bqPFB98KL0ShMg6qa0uCeGpWiQKAhbyp0HcwgPTo1WDX2ibmCrw==
X-Received: by 2002:a17:903:2309:b0:298:1156:acd5 with SMTP id d9443c01a7336-2986a73b95fmr267930845ad.39.1763533549196;
        Tue, 18 Nov 2025 22:25:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK/abK9enFXr8hJcTEJjyu+dl2lkjNPM5wxBgfiNyKPG+ueV6y4n2OQD44UVqxyfARt/W8MA==
X-Received: by 2002:a17:903:2309:b0:298:1156:acd5 with SMTP id d9443c01a7336-2986a73b95fmr267930415ad.39.1763533548627;
        Tue, 18 Nov 2025 22:25:48 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245e04sm194064755ad.38.2025.11.18.22.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:25:47 -0800 (PST)
Date: Wed, 19 Nov 2025 14:25:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Xiao Yang <iceyangxiao@gmail.com>
Cc: zlang@kernel.org, timday@amazon.com, fstests@vger.kernel.org,
	sihara@ddn.com
Subject: Re: [PATCH] fstests: Add lustre support
Message-ID: <20251119062543.lhqaqn3h76btxyk3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251118073011.362595-1-iceyangxiao@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118073011.362595-1-iceyangxiao@gmail.com>

On Tue, Nov 18, 2025 at 07:30:11AM +0000, Xiao Yang wrote:
> Add basic lustre support so that we can continuously
> improve lustre by fstests.
> 
> Signed-off-by: Xiao Yang <iceyangxiao@gmail.com>
> ---

Hi Yang,

As you can see, the fstests community doesn't like to spend time on
maintaining fstests for out-of-tree fs, especially downstream-only filesystems.
I'm not a dictator. If we accept to support someone filesystem and its
patches, that means we'd like to spend time to review patches for it, think
about it when update fstests, fix issues on it, and so on. So I'd like to
respect the willing of fstests community.

For bcachefs, it was in-tree, and we know its contributors are still trying to
keep it up to date. So I'd like to keep its supporting.

For glusterfs, it's an upstream open-source filesystem, it's base on FUSE of linux
kernel. It can't be a kernel module, but it's a pure upstream fs at least. Actually
I brought in it for testing FUSE at beginning.

So do you do this for *upstreaming* the lustre filesystem (any active source code link?)
or just for using xfstests downstream? If it's the latter, I'd suggest you to fork
xfstests, and maintain this patch downstream.

I noticed that there was a discussion about Lustre filesystem upstreaming:
https://lore.kernel.org/linux-fsdevel/DA28F0FE-ACB6-486E-BF3D-85AF328FE2AD@amazon.com/T/#med943c38d27ddac1b68e9db37d6b0f2803ee6133

But I haven't found it's online. So if the "lustre upstreaming" project get
an offical version be acked by mainline linux, fstests willing to support
its later developing/testing. At your early developing stage, I think you
can fork and maintain a downstream xfstests temporarily.

Thanks,
Zorro


>  README                 |  2 ++
>  README.config-sections |  7 +++++++
>  check                  |  3 ++-
>  common/config          |  5 +++++
>  common/rc              | 29 ++++++++++++++++++++++++++++-
>  5 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/README b/README
> index 9e9afe3c..9e3ff13f 100644
> --- a/README
> +++ b/README
> @@ -87,6 +87,8 @@ L4: Active support from the fs list, has lots of own cases.
>  +------------+-------+---------------------------------------------------------+
>  | 9p         |  L1   | N/A                                                     |
>  +------------+-------+---------------------------------------------------------+
> +| lustre     |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
>  
>  _______________________
>  BUILDING THE FSQA SUITE
> diff --git a/README.config-sections b/README.config-sections
> index a42d9d7b..18af445f 100644
> --- a/README.config-sections
> +++ b/README.config-sections
> @@ -135,3 +135,10 @@ TEST_DEV=%example.com:xfstest.test
>  TEST_DIR=/mnt/xfstest.test
>  SCRATCH_DEV=%example.com:xfstest.scratch
>  SCRATCH_MNT=/mnt/xfstest.scratch
> +
> +[lustre]
> +FSTYP=lustre
> +TEST_DIR=/mnt/test
> +TEST_DEV=192.168.1.1@tcp:/test
> +SCRATCH_MNT=/mnt/scratch
> +SCRATCH_DEV=192.168.1.1@tcp:/scratch
> diff --git a/check b/check
> index ce7eacb7..a5d43d98 100755
> --- a/check
> +++ b/check
> @@ -70,6 +70,7 @@ check options
>      -pvfs2		test PVFS2
>      -tmpfs		test TMPFS
>      -ubifs		test ubifs
> +    -lustre             test lustre
>      -l			line mode diff
>      -udiff		show unified diff (default)
>      -n			show me, do not run tests
> @@ -277,7 +278,7 @@ while [ $# -gt 0 ]; do
>  	case "$1" in
>  	-\? | -h | --help) usage ;;
>  
> -	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> +	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs|-lustre)
>  		FSTYP="${1:1}"
>  		;;
>  	-overlay)
> diff --git a/common/config b/common/config
> index 1420e35d..9d3c36e8 100644
> --- a/common/config
> +++ b/common/config
> @@ -394,6 +394,9 @@ _common_mount_opts()
>  	ubifs)
>  		echo $UBIFS_MOUNT_OPTIONS
>  		;;
> +	lustre)
> +		echo $LUSTRE_MOUNT_OPTIONS
> +		;;
>  	*)
>  		;;
>  	esac
> @@ -539,6 +542,8 @@ _source_specific_fs()
>  		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
>  		. ./common/ubifs
>  		;;
> +	lustre)
> +		;;
>  	esac
>  }
>  
> diff --git a/common/rc b/common/rc
> index 8fd7876a..7f75963b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -867,6 +867,9 @@ _test_mkfs()
>      pvfs2)
>  	# do nothing for pvfs2
>  	;;
> +    lustre)
> +	# do nothing for lustre
> +	;;
>      udf)
>          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>  	;;
> @@ -981,7 +984,7 @@ _scratch_mkfs()
>  	local mkfs_status
>  
>  	case $FSTYP in
> -	nfs*|afs|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
> +	nfs*|afs|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs|lustre)
>  		# unable to re-create this fstyp, just remove all files in
>  		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>  		# created in previous runs
> @@ -2064,6 +2067,15 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> +	lustre)
> +		echo $SCRATCH_DEV | grep -q "@.*:/" > /dev/null 2>&1
> +		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_DEV"
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;
>  	*)
>  		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
>  		 then
> @@ -2288,6 +2300,15 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	lustre)
> +		echo $TEST_DEV | grep -q "@.*:/" > /dev/null 2>&1
> +		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ]; then
> +			_notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;
>  	*)
>  		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
>  		 then
> @@ -3658,6 +3679,9 @@ _check_test_fs()
>  	;;
>      pvfs2)
>  	;;
> +    lustre)
> +	# no way to check consistency for lustre
> +	;;
>      udf)
>  	# do nothing for now
>  	;;
> @@ -3720,6 +3744,9 @@ _check_scratch_fs()
>  	;;
>      pvfs2)
>  	;;
> +    lustre)
> +	# no way to check consistency for lustre
> +	;;
>      btrfs)
>  	_check_btrfs_filesystem $device
>  	;;
> -- 
> 2.43.7
> 

