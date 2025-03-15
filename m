Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10572E40B
	for <fstests@vger.kernel.org>; Sat, 15 Mar 2025 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742013459; cv=none; b=L6r7ZWe4uU6w7HWH8g1N5QZw0QOgprZbY6JqXz6VxZWqhJxl0a1ruN+XYlVL/fK46kpcU1LOvTiAPT+0u8ofajkRgwpYMxuR2cMtLRBWwQefzigI0tGBvS1a3jW5Hl+JLU+/zJYCjdD5Xx9C5m9HS2rUWOeegtGnOo7jcQ9S0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742013459; c=relaxed/simple;
	bh=+95UAqeqL+Yuo37E2S/u3Sw/6J4Y2JgdHVh9z3loPDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caH2FdzXro4rLWdCRyWM9a17ij9d/m18lHXPTStf/1tI0GJwlu3JKEqPAessuxfG7yL1S5TlSRutgIcZKMeFG2kGMwRnH7ytbtatzyHQEh1FrARKoBjXrHmzkWDce9D+IHrQWGspu2XjHujYNDq9itEFLm8gWsW32it7trrn7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBYOT9cK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBYOT9cK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742013455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20TMkzNcyiTbTNlLGCc3HPCs0CACGNs3oGAVgZG4dh0=;
	b=JBYOT9cKX4XL/+H5+00FY1YYAaXomeAbRt5s6Rfmld43CefnmtlRe8jZxIa8STwXkJu2D8
	6KrdBJDawwRekKMA9+EVBOpY4mTjtcWoNrVd6lslaEtVunLFCnmMLxuJtR0ORJhR4LiZtK
	8ely80OlFU3DT3DQjll8Zo7ffeZYpIA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-pvo1jUgxOFiV_f3fNCLdUQ-1; Sat, 15 Mar 2025 00:37:34 -0400
X-MC-Unique: pvo1jUgxOFiV_f3fNCLdUQ-1
X-Mimecast-MFC-AGG-ID: pvo1jUgxOFiV_f3fNCLdUQ_1742013453
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so563969a91.0
        for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 21:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742013453; x=1742618253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20TMkzNcyiTbTNlLGCc3HPCs0CACGNs3oGAVgZG4dh0=;
        b=mUNpYyvHidGqnaRk9EuUb9H99BKjKn03I5eG2DM3v4dPnleQ8zuNHXpDGusAURGHkL
         ywcfDQoGBXG3xLKVquK2Sys5cW3NxdyKQj5uDBQsoVnf+iNEVpP+5zE47SgJiX7Lcoai
         AKh+MR2BOVi/H6TFcniSi9XyoUpUYnhL3ByOxyFX2b6BXakDcrsILQwSHCXdubCKLhuv
         r7d2tgJPPGIx5s53A2gnoDvZUGL/xa397iklROP8IqaVoOAQ/UQ1AQB/zzZA076lFCVZ
         SgNob+A1wNPKgW8YJOKReekertTvbNd/aermDoTsROfalcdmsc1wYSPjQX1kTR9xpiG4
         0PUw==
X-Gm-Message-State: AOJu0YyaYjNxxc9O9Wto0TyMthZCVz/BPoLPwuPb/ZkVE36f//aaiv9H
	z0CwuCjMwMKmOG1hvlGGKhp5Ahlecftbo6uMcdrX9E78w89mvTDSlOPzV6Bb8ijM5eiXInRE3d6
	QgISfsBGyeLFeaPbkD1RCnTpPvBmNS/TnK5DY2ETzuDh2Vatvy7arAtyJI+JcdJQ7pg==
X-Gm-Gg: ASbGncsBmYCLcA2iNn6bxajvXLPwP3lbtz15HP4LCfDJgB2SREdiBWlicX4OFhHMN+J
	0ai1QEjE5FlkyKZYYxPuGFDXaEpPikLIge0NKjv4o+3nKMUx7cIVmytuQZOuOGw9oBa6oWZHKy0
	x8bVcWc7knERmxeAHwhXDFB81PmBELyvnOfAFf1270k0SvE3fTsEfVPLkJ3dIOBePkwSA+a9XVB
	jXmHv1356eiyZJSJmkGG0Nldyg9K6KMlJfhgoEnmrk37R3zgviQbNnHIGO8IOeh9m8m+Ix8+nlH
	Q7qFsECuwS4tC3n2sAgd7tHrzPn7zIt+W7sLnM6LfTSkLNSevCSY1kkm
X-Received: by 2002:a05:6a00:18a7:b0:736:ab49:d56 with SMTP id d2e1a72fcca58-7372234c6cbmr5703435b3a.1.1742013452588;
        Fri, 14 Mar 2025 21:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVH7a0f3+6IL2n+NebLpaCb3eZJm6WLzOnf/pCnqGQv/GuxLNi3gKwpSoRGRAvNykCRlsI1w==
X-Received: by 2002:a05:6a00:18a7:b0:736:ab49:d56 with SMTP id d2e1a72fcca58-7372234c6cbmr5703414b3a.1.1742013452072;
        Fri, 14 Mar 2025 21:37:32 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115592a1sm3689197b3a.43.2025.03.14.21.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 21:37:31 -0700 (PDT)
Date: Sat, 15 Mar 2025 12:37:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH V3] common/rc: explicitly test for engine availability in
 _require_fio
Message-ID: <20250315043728.l7topnjhoyttemar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <3d35c97d-8c04-4d0b-b7d7-bc689edbc1ed@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d35c97d-8c04-4d0b-b7d7-bc689edbc1ed@sandeen.net>

On Fri, Mar 14, 2025 at 01:37:45PM -0500, Eric Sandeen wrote:
> The current test in _require_fio (--warnings-fatal --showcmd) does not
> fail if an invalid/unavailable io engine is specified.
> 
> Add an explicit test that every requested io engine in the job file
> is actually available.
> 
> Also, remove the "ioe_e4defrag" entries in the [global] stanza of several
> ext4 tests which use fio jobfiles. While ioengines can be set in the
> [global] section, they can also be overridden in individual, subsequent
> stanzas. In each affected test (ext4/301, ext4/302, ext4/303, and
> ext4/304) every individual stanza after [global]re-specifies an ioengine;
> either with ioengine=e4defrag or ioengine=libaio.
> 
> Because of this re-specification, the ioengine in the [global] section
> is ignored. This is a good thing, because ioe_e4defrag is not a valid
> ioengine, and would fail this new hand-rolled check, even though fio
> did not complain.
> 
> So rather than over-complicate this new check, simply remove the unused,
> invalid "ioengine=ioe_e4defrag" lines in these tests.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: Be Better at Bash, thanks Zorro. Also add | sort | uniq to ensure
>     we only test each requested engine once.
> V3: I've got a fever, and the only prescription is more pedantry!
> 
> diff --git a/common/rc b/common/rc
> index ca755055..ac443ec2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3977,12 +3977,19 @@ _require_scratch_dev_pool_equal_size()
>  _require_fio()
>  {
>  	local job=$1
> +	local eng
>  
>  	_require_command "$FIO_PROG" fio
>  	if [ -z "$1" ]; then
>  		return 1;
>  	fi
>  
> +	# Explicitly check for every ioengine listed in the job
> +	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort | uniq`; do
                                                           ^^^^^^^^^^^
                                                           sort -u ?

If you agree, I can help to change that when I merge it.

Thanks,
Zorro

> +		grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) || \
> +			_notrun "fio engine $eng not available"
> +	done
> +
>  	$FIO_PROG --warnings-fatal --showcmd $job >> $seqres.full 2>&1
>  	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
>  }
> diff --git a/tests/ext4/301 b/tests/ext4/301
> index abf47d4b..a05b8e8a 100755
> --- a/tests/ext4/301
> +++ b/tests/ext4/301
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/302 b/tests/ext4/302
> index 87820184..e0f5f2f9 100755
> --- a/tests/ext4/302
> +++ b/tests/ext4/302
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/303 b/tests/ext4/303
> index 2381f047..0a83e86c 100755
> --- a/tests/ext4/303
> +++ b/tests/ext4/303
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (3+1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/304 b/tests/ext4/304
> index 53b522ee..5f2ae4bd 100755
> --- a/tests/ext4/304
> +++ b/tests/ext4/304
> @@ -32,7 +32,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> 
> 
> 

