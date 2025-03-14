Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C238FAD
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962980; cv=none; b=uuZTl98YrKBNvIVjsr9eEsFb0OIjX1ltNVuVh/fTNPOY9i7VWGjlXtFiYW2qaKsfezsjqDlwyZ33edt+fbqszRw2U0OWP9wG1lY3kX+cYrvTrZ1EtNbDJPT5nWMdCX8lAJIeh2zGqY7h0NrNv572oFz/vsBjyiR9p+Lz7Itdo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962980; c=relaxed/simple;
	bh=FXXKXZ12cPhbf0dAyieVF47ua1RG29rGsyzqOjA7rHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwLQD1MJ3h+QfmY1OrHTkA3b+afJ4t42cXygS/FhJQkmZHpfrw8NeH8GLYr+90CYNv8SRNweyh/QJ928XwxLH8DPQIsnvilKqlosJAryl1EwgDe1xmQK27STbZAzxJPbhwy1Kd4xzBB6AR4bTBjvEEQkFpYO8W49lKBB8wWTnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJ7lJgZv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ7lJgZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741962977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b+nT/4o/eXs8XVff6DeAG5bsQQOREHU5LVR58wpdpCw=;
	b=IJ7lJgZvTNOdzaDHlgsZ5Zq7k6pj4EHdxPt8X9caU+Tsy+QkVm3hOqezYJ0Omu7p9qLSef
	A47aF/Bv8TL+M/cD2LYnIrkF1Oi/D5X4YhKXnhBC7Ee5wdtyadtpDgZJT/cKTQ8d9cw6zE
	/L2xwvpGZUyM9564JkAjvw3OygjCNTg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-kKWitTmBNqu7n_GdUHrPvQ-1; Fri, 14 Mar 2025 10:36:14 -0400
X-MC-Unique: kKWitTmBNqu7n_GdUHrPvQ-1
X-Mimecast-MFC-AGG-ID: kKWitTmBNqu7n_GdUHrPvQ_1741962973
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225429696a9so59751045ad.1
        for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 07:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962973; x=1742567773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+nT/4o/eXs8XVff6DeAG5bsQQOREHU5LVR58wpdpCw=;
        b=Nsp65gCT+Y9TwJRM2z/vXpM3kH+6Z1NX6BdSyZQllFHWWc/bADTekuO0Yiv77R5+FT
         iBiBpvD1DlILU48vsjhdtsJ6VDb1/HYh0GjxNT2cRfYnwLRCV/Xnz1wlCPRvJeLBjCf7
         QlJLCw8CGWYWL/veco6Ff1QE17k/7kLBsD58d7mjBnP0FPYYW7GL0xmkrUh8lSdhF5LS
         w2P2TV/oi6AZD5orjer3Lz7cKmPNsRhWVm9VJ2zsigzWgIOf5sxQTHCSazFfdIwz6kpm
         gLKtFz40f4hDg4J6nsAgV0nStda3A/4XRSepzJq8l+rM9C/Jp2Y3T4xl39VRtYEEYc7I
         x02g==
X-Gm-Message-State: AOJu0Yy5/sstkXqKTgM4AsZumOHDxKw/UNAQkJcYsNNauDDMhdPYfuMo
	0iS7UNLTxauGrhOrWkDLpTQJDunMMfPdvPEfZ0FeF/55wvlh6L90Dh47cL7HCLSFUoAPf8sROs+
	EYTKe3U+fJIBs20LH3FNxzbceIr0wuda3/zsv2eBkxk9aik1y/nasAMY=
X-Gm-Gg: ASbGncubk2R6sBqoox/2BA599C80jJgtESCMbx9k+ySrpB+SlUBmbTClCLFgs09CVBr
	9U1K/essQldwX3/Ftby/2l5YTxBUVta9cBMK9fBjf9bhN+NodvmloYol5yxuVYblC2FB0eHrzjG
	QE/4eyAzR7vwNmqsBv2h9WuGqp0ZZI0tpB49wo/mH1jo26HiN2eCmGZgbTG1LZBBUaJjYZX/+AH
	tIafqb/gMMD4h8E6lI5IzGsG3Psk/G04yaAMJaxVY6IXJPTBpStkZoRQDSEsuBUgMUIahbH2P9r
	n3ZO/xKskfTs8d9NEwHST19yCvBsahMIzojjJlavlDPGph+oFC5HBdIV
X-Received: by 2002:a17:902:e5cb:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-225e0a62f94mr41373925ad.4.1741962973532;
        Fri, 14 Mar 2025 07:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnfK1t+QeVWEJ2bqxna9KYQ176Ne8FQXURso/Yy2gaODkHIBLSSKmafzuUC8oU+FsmspfrBQ==
X-Received: by 2002:a17:902:e5cb:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-225e0a62f94mr41373595ad.4.1741962973198;
        Fri, 14 Mar 2025 07:36:13 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688858asm29186955ad.46.2025.03.14.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:36:12 -0700 (PDT)
Date: Fri, 14 Mar 2025 22:36:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] common/rc: explicitly test for engine availability in
 _require_fio
Message-ID: <20250314143609.wk4ceplp5y3tw4mo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <b761e302-8b4e-4a79-b025-d344d7bf5a69@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b761e302-8b4e-4a79-b025-d344d7bf5a69@redhat.com>

On Wed, Mar 12, 2025 at 11:48:11AM -0500, Eric Sandeen wrote:
> The current test in _require_fio (--warnings-fatal --showcmd) does not
> fail if an invalid/unavailable io engine is specified.
> 
> Add an explicit test that every requested io engine in the job file
> is actually available.
> 
> Remove the "ioe_e4defrag" entries in ext4 tests - an engine with this
> name has seemingly never existed, but in each case later stanzas
> overrode the io engine, so it did not cause problems without this
> explicit parsing and checking.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/common/rc b/common/rc
> index ca755055..c155bb46 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3983,6 +3983,12 @@ _require_fio()
>  		return 1;
>  	fi
>  
> +	# Explicitly check for every ioengine availability
> +	for ENGINE in `grep ioengine= $job | awk -F= '{print $2}'; sort`; do
            ^^^^^^

I think a local variable is enough, e.g. "local eng".

And, how about:
  for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job`

> +		fio --enghelp | grep -qw $ENGINE || \
                ^^^
              $FIO_PROG

And to make sure the "||" checks the return value of grep, how about:

  grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) ||


Others look good to me.

Thanks,
Zorro

> +			_notrun "fio engine $ENGINE not available"
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

