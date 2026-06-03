Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1439A4A7
	for <fstests@vger.kernel.org>; Wed,  3 Jun 2026 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465576; cv=none; b=sMPYQfQtkSKdrmgY+/7GNDQ+ehSOww0rQg3upr3Dvv3s20/Os1VP++RdILeTj4CDq3qFO6BtZetTu436BxR77rp8ketKRhxNdG3Q7AtUKCC6Fo8koeZg3M7YKyL98ynBB+P1JeGucC2koYs7yaEnnNzlkvJEFyBfU44PgkCcFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465576; c=relaxed/simple;
	bh=2xXOgoR+zST/WmAVCpdrH6nFpX6HadVH9dYgPRFAGNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NchOjgs2/kXG3lAfWCJCClS00BuaXzzipbqQVXOkU9cYtyDWeZhoa7HW+302nm/o4v2qvMHLKbHrxQMtMtCuY3+RKok37bRttmF215vsHN3kGpwrVPGRQhlsRJ25OsqPCFoYfq1KbFS/2lgR4p8kjkFRCEU5ubr02tvawVfcVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTSA3gmJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJDiqBe7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTSA3gmJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJDiqBe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780465572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lxWg8RhWl6a6iZRyRCRqu1nWnEjM3UJXz8UpBY2oD0=;
	b=aTSA3gmJi/jkAH6SHJrFNxN1p4HCItgaboBxPan7X6+8j96dD2JUza7/5Po9xIpRDys/wh
	GsiY+bWRMiUOIYaAA0k7QiCHkXs56Ep9KXpOi+cgR0raS8zKxFgNEzNmhT/T+VPVcQ7ir9
	AqM+eBA4VQ306n906833q3F4puMAkvY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-Vs5na4abPsOcN99HRz7hmA-1; Wed, 03 Jun 2026 01:46:11 -0400
X-MC-Unique: Vs5na4abPsOcN99HRz7hmA-1
X-Mimecast-MFC-AGG-ID: Vs5na4abPsOcN99HRz7hmA_1780465570
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c10cd7df22so29799275ad.2
        for <fstests@vger.kernel.org>; Tue, 02 Jun 2026 22:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780465570; x=1781070370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lxWg8RhWl6a6iZRyRCRqu1nWnEjM3UJXz8UpBY2oD0=;
        b=PJDiqBe7jZm77b4C1Sa3gdWFWVE1KDraCYoHfiQhGzkePXEfyoYG29tmuLLcy7Ggli
         6xdi8jTvz5z4PjZoDtjJWbFTLZXe3eVDJdlngYlEUNgxlbpW70VT9tkH5yTVzBORAVYm
         NuIaVKqkbIsUxsle5lZirRGRdbayxP5LN2/ONEwGBDCkDqYEKWAEClEVCieYdBEY+Jvl
         J3kDbIl7x5zEattzF4JhXfuv21WyUizUc2tdezAuHoKUclmfjPXPuqAv4diM1lto47Yt
         XWTYuzDx3X1b5QrfGe3LOODVM+EGDNK60ICrm42ZCM0ntvAJEz+vTD2EdGn8UUEJ40+K
         QxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780465570; x=1781070370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lxWg8RhWl6a6iZRyRCRqu1nWnEjM3UJXz8UpBY2oD0=;
        b=DgnmlHc8utlr/3gV6SlTfubXL46dTRe3Y+O7dD59UcT1IbrzsGAS+5SJy1gAnEXl7a
         pTYko+MA97O5r0Mu1Cznr+6glGKQZGvjqPywiTj8hkZ/83fTJFA0BH71JmneqAcHh9oY
         CbSUEBPDIkXlgkwm/AdOXrNBJHPvzIc4peiEISrnWP1TIUMXebF4ASKK1XB2/mnB48Iy
         E6hh1yD18stpxeZ1VUng6w6CYDB9gZcfXBO0jxd6eUNglbwGYRy5FCaPLwBtLkszOm07
         XiD9FZppX6pNc+HIqV4U+zSpnDNIGbOBHDDC97hK+uYdbpS1viBTKEiuEJmpEnbnoLLn
         LX0g==
X-Forwarded-Encrypted: i=1; AFNElJ8GgQvbwW1NLe7+FHXa7AVnzRSYfgYc5rCrq2LqlA3fT7PoNNmeZ0fDyS3xm/kairRWb8+ExtSP@vger.kernel.org
X-Gm-Message-State: AOJu0YwxoC+XaEsd5t2SNk9XAkhrS96Cgo4NTyj2xBnqeaMSdj5HdKJm
	G4bCQhovaGRGZqxadYHxNvyt9ejNNUhwH3pf7Ode6usSVQTau6o5xGTgcrj7ZRgbwNvBnDHnk7p
	eMq6v+fiOyU4xieSBIt3PbANke2gofsFhr6h3Tf8TfQ/k1OoRH5TdmMHiXOKPUxSz4Bk=
X-Gm-Gg: Acq92OHawjXTjCU9ITUkVCWBm2G7ySWCVxaHmMO/H5ptAzYlt084zI/z21I+Mfow1zZ
	ZS0yyMACi/+PWFwZkVBcff9/xtQsDoA+FcaM6hwbM91YrweAvliexDviA2RP1y1oU3jtw9ytDzn
	1kCzwZ43EUnQMUrMUZjZYfHA68OcePT+rSOXkASBcvX/+PJqQTldQfKV5eYxMXWbzO0KneeeII8
	VsbvK+RpwgMH3tJ1FUUv20uYp2UTOluNk3v+iudsnJIZ5jPqCrsNvi3kFOK9+CpzeggWfurlU/F
	VNlFmRE8BzbTckZA6sLUi17OOscVtXnO+Gia9RtoQM6Ly4CJyPI8oNHbrPJlQ48Pp1FLQ61TEXX
	tKBOoCvQJUQxWNAdLMfIhJ+gpxRiYWFpDdcpKK5ZYdaHeNjyNMy9duHlqMidFv72Ul0Rr9I7sfH
	5Lv6G5MQ==
X-Received: by 2002:a17:902:c40d:b0:2c1:1a22:7c43 with SMTP id d9443c01a7336-2c163d92becmr21102845ad.24.1780465569993;
        Tue, 02 Jun 2026 22:46:09 -0700 (PDT)
X-Received: by 2002:a17:902:c40d:b0:2c1:1a22:7c43 with SMTP id d9443c01a7336-2c163d92becmr21102605ad.24.1780465569518;
        Tue, 02 Jun 2026 22:46:09 -0700 (PDT)
Received: from ?IPV6:2001:8003:4a36:e700:56b6:ee78:9da2:b58f? ([2001:8003:4a36:e700:56b6:ee78:9da2:b58f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2d4sm11071915ad.77.2026.06.02.22.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 22:46:09 -0700 (PDT)
Message-ID: <b28a5514-8cad-472e-8417-8d882210ecc6@redhat.com>
Date: Wed, 3 Jun 2026 15:46:05 +1000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use -f by default for mkfs as xfs/extN do
To: Eric Sandeen <sandeen@redhat.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <a31e9841-fd0c-435f-b376-86a7e01ddca7@redhat.com>
Content-Language: en-US, en-AU
From: Donald Douwsma <ddouwsma@redhat.com>
In-Reply-To: <a31e9841-fd0c-435f-b376-86a7e01ddca7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 13:47, Eric Sandeen wrote:
> Recently saw a case where testing ext4, xfs, then btrfs failed all
> btrfs tests because mkfs.btrfs refused to overwrite the left-over
> xfs filesystem on $SCRATCH_DEV.
> 
> This seems well-enough fixed by only making the change to _scratch_mkfs,
> but several other helper functions explicitly use -f / -F for xfs
> and extN, so I've updated them for btrfs as well.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> TBH I'm a little baffled, has nobody really run into this before, or
> am I missing something?


I found myself wondering btrfs folk test with  MKFS_OPTS set, i.e.

  MKFS_OPTS="-f" ./check -g quick

> 
>  common/rc | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 9632b211..e77edf97 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -871,7 +871,7 @@ _test_mkfs()

Not part of your change, but it feels like _test_mkfs() could simplify to

_test_mkfs()
{
    try_mkfs_dev $TEST_DEV > /dev/null
}

But simple is good, so

Reviewed-by: Donald Douwsma <ddouwsma@redhat.com>

-- Don

>          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>  	;;
>      btrfs)
> -        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> +        $MKFS_BTRFS_PROG -f $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>  	;;
>      ext2|ext3|ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
> @@ -920,7 +920,7 @@ _try_mkfs_dev()
>          $MKFS_UDF_PROG $MKFS_OPTIONS $*
>  	;;
>      btrfs)
> -        $MKFS_BTRFS_PROG $MKFS_OPTIONS $*
> +        $MKFS_BTRFS_PROG -f $MKFS_OPTIONS $*
>  	;;
>      ext2|ext3|ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
> @@ -1010,7 +1010,7 @@ _scratch_mkfs()
>  		mkfs_filter="cat"
>  		;;
>  	btrfs)
> -		mkfs_cmd="$MKFS_BTRFS_PROG"
> +		mkfs_cmd="$MKFS_BTRFS_PROG -f"
>  		mkfs_filter="cat"
>  		;;
>  	ext3)
> @@ -1176,7 +1176,7 @@ _scratch_pool_mkfs()
>  {
>      case $FSTYP in
>      btrfs)
> -        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
> +        $MKFS_BTRFS_PROG -f $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
>          ;;
>      *)
>          echo "_scratch_pool_mkfs is not implemented for $FSTYP" 1>&2
> @@ -1369,7 +1369,7 @@ _try_scratch_mkfs_sized()
>  		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
>  		(( fssize < $((256 * 1024 * 1024)) )) &&
>  			! _scratch_btrfs_is_zoned && mixed_opt='--mixed'
> -		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize "$@" $SCRATCH_DEV
> +		$MKFS_BTRFS_PROG -f $MKFS_OPTIONS $mixed_opt -b $fssize "$@" $SCRATCH_DEV
>  		;;
>  	jfs)
>  		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS "$@" $SCRATCH_DEV $blocks

