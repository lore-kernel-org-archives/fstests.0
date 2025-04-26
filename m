Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA94A1E
	for <fstests@vger.kernel.org>; Sat, 26 Apr 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745671725; cv=none; b=VszJKZxnzYIhi4RD3g1x13IHNMPaVUznfwj8Z2Q87+xPGuoSr6VPVshPKZTWaPwSVZObP7pjerJTbJknLteHYzlvPKcPex2PaXio/EmlbcKXbyxIFsy/ABL/XFgfn0I2QA8O7T8KttIWB82r6j32s91NB9e+qGPzSW+1DwqHdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745671725; c=relaxed/simple;
	bh=VYqtbLRH/K/iE1LXZ2kNAahJLPEgGpqpa/nRjfps2+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzsBThVB7u/UExtvk7kgpmduvJpacUREJVOvZRGQ0tZdvW6j2YDSZqZOFupsBtXuZu1g4qbJJujOExHiXUees+RCewhqzl45w5O0Q+tQgs98YWeVMiYWBsXQrOBIg1I0ZFfHLm1oULlm/ajSR2kfEEpHX4C9nfLzM3+7EHIWYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hI/ZKjTB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI/ZKjTB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745671720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yPzJiUd4vRbO+EoINHayAlTW+OknUYWyhdkX/Y6xRqY=;
	b=hI/ZKjTBmYaAHRCjsUJ78ScTN7oaDV2BCqZ8VNNwv5u42Lhvt3gG0RediWBvcodbsVrsvR
	tVd0GngZhB2l6J5DujrwRGi+RukFuOrA1+U+Mun9oN/iNWfnsCmcxMBvcusD0JuFQqCF5e
	H6N94ALyIq7kYQgl68SwKf0xc9KesHA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-hckkkmIANTWHlMVbwOlB-w-1; Sat, 26 Apr 2025 08:48:38 -0400
X-MC-Unique: hckkkmIANTWHlMVbwOlB-w-1
X-Mimecast-MFC-AGG-ID: hckkkmIANTWHlMVbwOlB-w_1745671718
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af8f28f85a7so1925967a12.2
        for <fstests@vger.kernel.org>; Sat, 26 Apr 2025 05:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745671717; x=1746276517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPzJiUd4vRbO+EoINHayAlTW+OknUYWyhdkX/Y6xRqY=;
        b=WQQGx0kSjmfTejv6LFoGcGE9ofuzL4ijS4HdCEky5jtGF5UhTz2uhmBQBhz9GYLijx
         IwOiyfUJr3w7Sdl0UIWXKLwSDU/IQdGLV60J+a99W89TgAW/mZeoChAJz8gYxuSTQafZ
         KflYEnSQNO+dhco80fC9KGFfhgFqtWefh/kuB/b+iT31XumGwt9KlBWrIlroWXeUkaT5
         ZVPFDIUYE9eXDcbf5QjCqdGEOVUzvIKk0inyEZdeNInkcNc8ZyF0gbEV5y1TyXTcbd2t
         77syCspHoXRrBpGde0t9TVbq3j0ahAwcrhe+UpMLJZDET3smTvKXhNSPL1KASFc7DcxP
         E+RA==
X-Forwarded-Encrypted: i=1; AJvYcCV7bNK7h2QkuLxtEoeh+ucE9JbXN+8IdEHRsR65Y+w847HyLPjIqS1hPgkHgtWx5c33dn/W7lEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVvNFzqvx880POUIORoBxXx9jNOQgSWri5yoaASk1o3UGryd2
	W/zJKvxjShiSULFDC4Js5j3ZaXHe6Fa1i8KcnvNizoPe/+6m/BNgcsV5NDe2jpVIReKL2IdCiZp
	f7J3jtBRWX4ZO0WmgoVnpmTSpXAVz4ry/EhDfCM0iQ4AD1wyYx9WR0VsoTN7kXHY=
X-Gm-Gg: ASbGnctlkpaa4w36TZMRxL56lbHHhXmGLBVcCAg+swBNS1jevPnw0Q1p///Sz4wfgb2
	baCpr6ScoIBIfIR023ezt/cuEHvYgp4RfWAxE+nfUcp7G+a1uGgdo6GPENGb6ydxj8xqwxS95f/
	rZ4Xm6ypfsYTRL29H7d5+FLF9tCPCkZ6AXnrB7nJdzTJT38QzUCSTtlu9xQ0Y1oIHL1GFjXzW7Y
	6AKLDSYbpGkiwuHXKeN+OvU94YkVuXiBciYS7pmT/nuOlL/xm59RUCFnqpUV5RQ4VZfhNPT1Qp0
	b/bprJYisZPZXdHxdVdy3AqeKWt9eWlUf+sV57fHAw6WrsjPwGLF
X-Received: by 2002:a05:6a21:2d0b:b0:1f5:59e5:8adb with SMTP id adf61e73a8af0-2046a1c0d16mr3957602637.0.1745671717355;
        Sat, 26 Apr 2025 05:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+3tXq3X4/E+08Yc+LbbUeVUjZ13YxvblI7A+3qInc+gOPxUUVstiqoWPgm6VZKUvX1Wg+ag==
X-Received: by 2002:a05:6a21:2d0b:b0:1f5:59e5:8adb with SMTP id adf61e73a8af0-2046a1c0d16mr3957586637.0.1745671717016;
        Sat, 26 Apr 2025 05:48:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a58bsm4912934b3a.143.2025.04.26.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 05:48:36 -0700 (PDT)
Date: Sat, 26 Apr 2025 20:48:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/033: Don't call 'fzero' with the KEEP_SIZE
 flag
Message-ID: <20250426124833.jopyhhzdr6zgal6t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250425152452.105188-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425152452.105188-1-anna@kernel.org>

On Fri, Apr 25, 2025 at 11:24:52AM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> None of the fzero calls in this test end up writing past the end of the
> file, so this flag is unnecessary and can cause the test to fail on
> filesystems that don't implement FALLOC_FL_KEEP_SIZE.
> 
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---

This version is good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>


>  tests/generic/033 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/033 b/tests/generic/033
> index a9a9ff5a3431..b7df56b82619 100755
> --- a/tests/generic/033
> +++ b/tests/generic/033
> @@ -37,12 +37,12 @@ $XFS_IO_PROG -f -c "pwrite 0 $bytes" $file >> $seqres.full 2>&1
>  # delalloc blocks and convert the ranges to unwritten.
>  endoff=$((bytes - 4096))
>  for i in $(seq 0 8192 $endoff); do
> -	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
> +	$XFS_IO_PROG -c "fzero $i 4k" $file >> $seqres.full 2>&1
>  done
>  
>  # now zero the opposite set to remove remaining delalloc extents
>  for i in $(seq 4096 8192 $endoff); do
> -	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
> +	$XFS_IO_PROG -c "fzero $i 4k" $file >> $seqres.full 2>&1
>  done
>  
>  _scratch_cycle_mount
> -- 
> 2.49.0
> 
> 

