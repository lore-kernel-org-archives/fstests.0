Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EE6EF1B
	for <fstests@vger.kernel.org>; Fri,  1 Mar 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302101; cv=none; b=PD8r5gq3Vj9Hla2WANs+jyEwNzJNeoyo4UDrz74Ho8i4blpW7pr9YRKiZyTDNcLK5rhIK2G7EuM+TEHB6RKj8CeGZMKIYAgdZaVVlWStaHro/oWr1KmpL7dd23+e8cQr1Z3RvjN4F8LqvmBI1sqwREP4vZ3UJ7vbtpEaR/KvGZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302101; c=relaxed/simple;
	bh=QRtrVHbGg6UBQF5jFjC+e9A1xTeKiSYlPPerRwyxsXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji91iZ1NDm7OC92BuT2pKDV/yiS1xxglu85quVgxf9XK3+/HMpSwTCojUk7vdefaFBCPjzLqSmtGHNZmE9mh96CECOrhGsAGj6SQHccY9Xtw6ZYZA0WOzek7TFM3clOittI3J/NXaFieuiqAkiuf+u2Othw1IUsy8M+1i//vEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgdaEvcj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgdaEvcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709302094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCEh9C5EA4GsZD/OC1r5YlOqs5g+H8xXFiHuMW4Cy74=;
	b=AgdaEvcjLxjDsNsw0gx2DqyVxRLgYFnsc+81tZJpPjARHKWutLT1veDuLNcxAV0UGqoxg3
	WU1OoycwFL2lromE1fSNTyDCqAzzQc8hrinOVTRSUARqIG+aUFrxycaPLJqp5EKcO4DuVH
	OMt+N82gKG632fddn/6dlW7AaIq6d1w=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-RqqCxpySMci85eAQJoTN6w-1; Fri, 01 Mar 2024 09:08:13 -0500
X-MC-Unique: RqqCxpySMci85eAQJoTN6w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e50831226dso1556301b3a.2
        for <fstests@vger.kernel.org>; Fri, 01 Mar 2024 06:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302092; x=1709906892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCEh9C5EA4GsZD/OC1r5YlOqs5g+H8xXFiHuMW4Cy74=;
        b=RzqY8pGJEOGM3sOk9FOvl/Ts21KzLnCOG1KjfbkEH2oTRsHBjOLPgngzdAsGJ6lR1A
         WB0QAQ8l5Hc9QVpqJQBQIc5LM4VLFhA8dJJubwwhPCCJTHv49GQ9/3t4tUL1vf7J4T1A
         aWGX7ZdfkTeFSZdsOhvMs/4HP1oWBzD6OMcdw3nRYxJQ/YfoFveCk6SKbRVEU5eW2uCi
         TU/KUdVdbfuA5/GCMhpne7DpvzdWityqmyOImSOsBtyyXgyEWIKhpWxh3vV2kF5fYcRM
         J6AeRZgqAPmSUZYOi26iWaxmXpLAxu0XRlChceL8Azd2Xw6FgT/AwzY++ayJsL24e78t
         MiTA==
X-Forwarded-Encrypted: i=1; AJvYcCVGoAp55lk8qufu77lR2PrubOmkhIPhb7NGfthB6ytzAyf6G7Mf3C87cb6kBWC6ql4djRBsf578nIiPzcPwv4VmF0u25KM1Eg==
X-Gm-Message-State: AOJu0YynSRnLg4KA8IDtxTcUP6N70ObW41yb8WxMSEqM6T3jCDtF15ky
	AFFcAWWiSSllW4kNqigpV9qRhYLeMxEdXkC8BO5SXuJPscW7YiFMVT4zDFb7TX1hgMCwwbdObkQ
	iul123tjuIWfQSvdAfqGIFaEULmbfkAQjEyftuiD9X3Y1TfFvkYp1A8E=
X-Received: by 2002:a05:6a00:1707:b0:6e2:d162:6315 with SMTP id h7-20020a056a00170700b006e2d1626315mr1876139pfc.29.1709302091632;
        Fri, 01 Mar 2024 06:08:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4z3UoeV8S6LT9aGh3Xva9wXhKEudLeCku7yeWFpEZLdB70HoWuhrCEBidtC1j8OJMgYdRfg==
X-Received: by 2002:a05:6a00:1707:b0:6e2:d162:6315 with SMTP id h7-20020a056a00170700b006e2d1626315mr1876103pfc.29.1709302091107;
        Fri, 01 Mar 2024 06:08:11 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b006e560192a7dsm2983892pfh.105.2024.03.01.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:08:10 -0800 (PST)
Date: Fri, 1 Mar 2024 22:08:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] fstests: make read-repair tests md5sum the data
Message-ID: <20240301140807.a74ipz344klfk2y5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c5d3e27fd544b2ecb1a4b374f500314c1b7b9c56.1706112305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d3e27fd544b2ecb1a4b374f500314c1b7b9c56.1706112305.git.josef@toxicpanda.com>

On Wed, Jan 24, 2024 at 11:05:10AM -0500, Josef Bacik wrote:
> For validating that read repair works properly we corrupt one mirror and
> then read back the physical location after we do a direct or buffered
> read on the mounted file system and then unmount the file system.  The
> golden output expects all a's, however with encryption this will
> obviously not be the case.
> 
> However I still broke read repair, so these tests are quite valuable.
> Fix them to dump the on disk values to a temporary file and then md5sum
> the files, and then validate the md5sum to make sure the read repair
> worked properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/140     | 15 ++++++++++++++-
>  tests/btrfs/140.out | 34 ----------------------------------
>  tests/btrfs/141     | 16 +++++++++++++++-
>  tests/btrfs/141.out | 34 ----------------------------------
>  4 files changed, 29 insertions(+), 70 deletions(-)
> 
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 247a7356..8e1aafa3 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -77,6 +77,13 @@ devpath=$(get_device_path ${devid})
>  
>  _scratch_unmount
>  
> +# Grab the contents of the the area so we can compare to the final part
> +orig=$(mktemp)

We don't use mktemp for tmpfile. Please use $tmp (it's defined at the
beginning of each test case), then it'll be sure to be removed in _cleanup().

> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
> +	 _filter_xfs_io_offset > $orig
> +origcsum=$(_md5_checksum $orig)
> +rm -f $orig
> +
>  echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
>  	>> $seqres.full
>  $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
> @@ -91,10 +98,16 @@ _btrfs_direct_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
>  _scratch_unmount
>  
>  # check if the repair works
> +final=$(mktemp)
>  $XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
> -	_filter_xfs_io_offset
> +	_filter_xfs_io_offset > $final
> +finalcsum=$(_md5_checksum $final)
> +rm -f $final
>  
>  _scratch_dev_pool_put
> +
> +[ "$origcsum" == "$finalcsum" ] || _fail "repair failed, csums don't match"

Might be worth outputting the $orig and $final into .full file, at least
when the test fails, to help debug.

Same review points below.

If there's not objection from the the original author of these two cases
and btrfs list, I'm good with this change if it helps for more testing.

Thanks,
Zorro

> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
> index fb5aa108..58dfb24e 100644
> --- a/tests/btrfs/140.out
> +++ b/tests/btrfs/140.out
> @@ -1,37 +1,3 @@
>  QA output created by 140
>  wrote 131072/131072 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -read 512/512 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index 90a90d00..41407f90 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -74,6 +74,14 @@ devid=$(get_devid ${logical_in_btrfs} 1)
>  devpath=$(get_device_path ${devid})
>  
>  _scratch_unmount
> +
> +# Grab the contents of the area so we can compare to the final part
> +orig=$(mktemp)
> +$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
> +	_filter_xfs_io_offset > $orig
> +origcsum=$(_md5_checksum $orig)
> +rm -f $orig
> +
>  echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
>  	>> $seqres.full
>  $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
> @@ -88,10 +96,16 @@ _btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
>  _scratch_unmount
>  
>  # check if the repair works
> +final=$(mktemp)
>  $XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
> -	_filter_xfs_io_offset
> +	_filter_xfs_io_offset > $final
> +finalcsum=$(_md5_checksum $final)
> +rm -f $final
>  
>  _scratch_dev_pool_put
> +
> +[ "$origcsum" == "$finalcsum" ] || _fail "repair failed, csums don't match"
> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/btrfs/141.out b/tests/btrfs/141.out
> index 4b8be189..d8c6940f 100644
> --- a/tests/btrfs/141.out
> +++ b/tests/btrfs/141.out
> @@ -1,37 +1,3 @@
>  QA output created by 141
>  wrote 131072/131072 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -read 512/512 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.43.0
> 
> 

