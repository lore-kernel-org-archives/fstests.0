Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408B45941
	for <fstests@vger.kernel.org>; Sat, 13 Apr 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713037239; cv=none; b=hqy74GxdemHGnDjGZmEoP48Ulb3L2i2r8ZuY53/o/hujNXZx0A2B449Jxh7ae4rU/GveA3k1TlZw5k/TUzNiZuWm96LvUhFdEyesxlMLBmK0+3pSddsv/MA2IrPUvy3mCa7qX2xD6jFkoXVtmSIEO1GyQq4uw21Fu2qzSDGiQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713037239; c=relaxed/simple;
	bh=GXpxrynSThDC2k/DG8BheDTapWNKA+FsaYFkfpfdzjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL+F29NNyE3wAv9Naj/3dOx513vbUjR0YIJMHLxNDKoAjOlzB8+txgd9+NN+fFOxG8jl+MkqQRAVbnBnnir5ANuo1sdEJqA6wDCVVJA4BtlTww0073f0+brICHC9LO2l3FKw6ds5kPwjsI/fgHsiCjf472FHUD5cFcKiMCnXUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDasbnT2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDasbnT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713037236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNoe5ASoQh7cUmPNmyPTbhdyQmlTunknwP5bJVZdJCw=;
	b=eDasbnT2fQuYdR3/Yf5TQHwUGn/hSMH5ByNRDM+3tiYc2lm2CoGZg6VW2MVtddxWO8UJBh
	dfbyMNirh6spoGUGVoZQcuZWZyKB+T3Nj07Wt+Jh5Klrw8kV4JT8D8ubPqU3eYMxvFHfLw
	gtfXIQH9S68uiakXewwAttbbli3hjKk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-udnWe9CHPIaYP01wS9R_SQ-1; Sat, 13 Apr 2024 15:40:34 -0400
X-MC-Unique: udnWe9CHPIaYP01wS9R_SQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc78077032so273888639f.0
        for <fstests@vger.kernel.org>; Sat, 13 Apr 2024 12:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713037234; x=1713642034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNoe5ASoQh7cUmPNmyPTbhdyQmlTunknwP5bJVZdJCw=;
        b=bd3hpFOurG6fzAIxwwApcj8AxYG/AJddPY/bZf3GWcweTS5T/ORylNNwKb1qCUEo0u
         8UFAwv/welc3yyoFGHkD+sHmaF+9j7U/EHJAxZjFrOCqGTsf/YSDw5MAGA19fU4KPO/d
         Kl1VpcfZd/fRSaU+vm4SC1yDJF8REHJi5iC+TPRE4j2dUrDHQsecrQCDdCXha3HnU1FC
         h9Tmhgrbz9uXAmmULW6VKSlucx3Ew1lVqBSztMdRwSJnSgY3APBTU4AwW2/5Ly8gX71e
         Y+/gjnSglA8F0aO54/Xt88adCG/uIh5Ku0SghBXfC7C2hQG0gWS0BLqG4U9OO57xPojT
         iVgA==
X-Gm-Message-State: AOJu0YzeaszuNedjR3mtdLnKkrsbW8EzI848Y0vBDCjd54gzdJcyEHnN
	c6HHwFCKbF+ynf7HG3spznZ0CUmeXLkZh2CkKHBeNSzW/JOPTK0Di6OwYYzz7wJ0VmloV19B/35
	097JzFjf1OqlfszzGGc7D6KiYboCJGgXyBjFY7ZWTerxBrPvLgk7+Jsc=
X-Received: by 2002:a05:6e02:1c0d:b0:36a:3ee8:b9f6 with SMTP id l13-20020a056e021c0d00b0036a3ee8b9f6mr7346121ilh.12.1713037233698;
        Sat, 13 Apr 2024 12:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp2xLoExfGhTh58FuNbD/VSBNNWxJLy52+GVjxhFe6n3QtEJ/v3tw+kQsQyZ0FCuUx6lYGQA==
X-Received: by 2002:a05:6e02:1c0d:b0:36a:3ee8:b9f6 with SMTP id l13-20020a056e021c0d00b0036a3ee8b9f6mr7346102ilh.12.1713037233292;
        Sat, 13 Apr 2024 12:40:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q10-20020a63504a000000b005e438fe702dsm4462054pgl.65.2024.04.13.12.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 12:40:32 -0700 (PDT)
Date: Sun, 14 Apr 2024 03:40:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
Message-ID: <20240413194029.cqanjm6i4bdhaqdh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <703aa9f2e34bf4dcc1fc5eec7ef4f65a6705ff14.1712634550.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703aa9f2e34bf4dcc1fc5eec7ef4f65a6705ff14.1712634550.git.anand.jain@oracle.com>

On Tue, Apr 09, 2024 at 11:51:11AM +0800, Anand Jain wrote:
> Use SCRATCH_DEV_NAME[n] to provide the device path for each device from
> the scratch device pool. Also, in btrfs/197, remove common/filter since
> it calls common/filter.btrfs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> There are other test cases that potentially could use SCRATCH_DEV_NAME,
> but for now, only 3 of those are being fixed.

Hi Anand,

This patch can't be merged, failed as:
  Applying: btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
  error: patch failed: tests/btrfs/197:55
  error: tests/btrfs/197: patch does not apply
  error: patch failed: tests/btrfs/198:40
  error: tests/btrfs/198: patch does not apply
  Patch failed at 0001 btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME

I'll leave this patch to your next PR, please check and rebase it properly.

Thanks,
Zorro

> 
>  tests/btrfs/125 |  6 +++---
>  tests/btrfs/197 | 13 +++++--------
>  tests/btrfs/198 | 12 +++++-------
>  3 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index d957c13911b4..f742d14f858c 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -45,9 +45,9 @@ _require_btrfs_raid_type raid5
>  
>  _scratch_dev_pool_get 3
>  
> -dev1=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
> -dev2=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
> -dev3=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}'`
> +dev1=${SCRATCH_DEV_NAME[0]}
> +dev2=${SCRATCH_DEV_NAME[1]}
> +dev3=${SCRATCH_DEV_NAME[2]}
>  
>  echo dev1=$dev1 >> $seqres.full
>  echo dev2=$dev2 >> $seqres.full
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> index 9ec4e9f052ba..196110cbdad2 100755
> --- a/tests/btrfs/197
> +++ b/tests/btrfs/197
> @@ -22,7 +22,6 @@ _cleanup()
>  }
>  
>  # Import common functions.
> -. ./common/filter
>  . ./common/filter.btrfs
>  
>  # real QA test starts here
> @@ -55,24 +54,22 @@ workout()
>  	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
>  							_fail "mkfs failed"
>  
> -	# Make device_1 an alien btrfs device for the raid created above by
> +	# Make device # 2 an alien btrfs device for the raid created above by
>  	# adding it to the $TEST_DIR/$seq.mnt
>  
>  	# don't test with the first device as auto fs check (_check_scratch_fs)
>  	# picks the first device
> -	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> -	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt" >> \
> +	$BTRFS_UTIL_PROG device add -f "${SCRATCH_DEV_NAME[1]}" "$TEST_DIR/$seq.mnt" >> \
>  		$seqres.full
>  
> -	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> -	_mount -o degraded $device_2 $SCRATCH_MNT
> +	_mount -o degraded ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>  	# Check if missing device is reported as in the .out
>  	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>  		_filter_btrfs_filesystem_show > $tmp.output 2>&1
>  	cat $tmp.output >> $seqres.full
> -	grep -q "$device_1" $tmp.output && _fail "found stale device"
> +	grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stale device"
>  
> -	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR/$seq.mnt"
> +	$BTRFS_UTIL_PROG device remove "${SCRATCH_DEV_NAME[1]}" "$TEST_DIR/$seq.mnt"
>  	$UMOUNT_PROG $TEST_DIR/$seq.mnt
>  	_scratch_unmount
>  	_spare_dev_put
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> index c5a8f39217d3..ad43b4d1b59b 100755
> --- a/tests/btrfs/198
> +++ b/tests/btrfs/198
> @@ -40,21 +40,19 @@ workout()
>  	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
>  							_fail "mkfs failed"
>  
> -	# Make device_1 a free btrfs device for the raid created above by
> -	# clearing its superblock
> +	# Make ${SCRATCH_DEV_NAME[1]} a free btrfs device for the raid created
> +	# above by clearing its superblock
>  
>  	# don't test with the first device as auto fs check (_check_scratch_fs)
>  	# picks the first device
> -	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> -	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
> +	$WIPEFS_PROG -a ${SCRATCH_DEV_NAME[1]} >> $seqres.full 2>&1
>  
> -	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> -	_mount -o degraded $device_2 $SCRATCH_MNT
> +	_mount -o degraded ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>  	# Check if missing device is reported as in the 196.out
>  	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>  		_filter_btrfs_filesystem_show > $tmp.output 2>&1
>  	cat $tmp.output >> $seqres.full
> -	grep -q "$device_1" $tmp.output && _fail "found stale device"
> +	grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stale device"
>  
>  	_scratch_unmount
>  	_scratch_dev_pool_put
> -- 
> 2.39.3
> 
> 

