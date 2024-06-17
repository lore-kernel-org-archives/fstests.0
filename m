Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5F19BC6
	for <fstests@vger.kernel.org>; Mon, 17 Jun 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607461; cv=none; b=jRv60yK9hTtd7OUAFeS8SAayTaOBfKTlxkG1ZWoHMbGs5ZPUu8+UB7oGcN5rIh2kvQfRzZV43y+bwhbCqPbbhBH2xXZGDur3dX8BE/e4XVM3N3/UpV4xm/7sTowi+cFg00Ck/FvmRZ7BN4+yln3iE4xHnUaRpk3wA0+UQZUnUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607461; c=relaxed/simple;
	bh=66QCBEwGbPTu1DwAnY57XC0jId4K7blwERNX5QCbjRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzJCONwEvKseD++oPi/OcvkNnR9aC1dSBx4arW7vHDJtJ7IKlDA+6XwJyYZrIRU65ex/cEfabo7UAH7Aa6xBztjULLu4dEoO6Ju5oH/HhBfoLNRHyxbgThvOcvhGo5Do/0czeQSTrdIGbM5rcCSindTKsJmxSmkhKJ5uuLUD4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANvvhvlF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANvvhvlF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718607458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkYd4EhqSoI2kOxwbCLVvGjfrUcupn5ukAcK3hkhies=;
	b=ANvvhvlFubHEpZ7NoG5AAZXm0542g6NlbwRvmK+UdzLUGOwGMn2Y7/YpZe1eRxoOnrfkng
	SXrPAHFeXkdkVoqlFmA77kTtXeLMGbPgEqVF0xpZB0i0zp+R1eCLKoWq6YymoaGxfe6mpd
	axxHpzeoFBe2Mgj+V4IPUKtbbeWVfaE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-3hHwKvlCN9m54i9TqVfSHw-1; Mon, 17 Jun 2024 02:57:37 -0400
X-MC-Unique: 3hHwKvlCN9m54i9TqVfSHw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7043008f4beso4020342b3a.2
        for <fstests@vger.kernel.org>; Sun, 16 Jun 2024 23:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718607456; x=1719212256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkYd4EhqSoI2kOxwbCLVvGjfrUcupn5ukAcK3hkhies=;
        b=acWXwowEf6f6Dc5u4Pil98sxRfVf3bS3HgXGqqUsnWoDcpPpnwUpMa6PFK5r3QiXr/
         VMPEQ7roRpGUFctKaI+06WoIL0cA7afR6d12I8BIQYQxtyt/C1yE2xSTRUxbFvxhPP1E
         dqNkqNgxYiPM6XkpOCO2vwZBkqZ5n9THGqMPaSA9mtdQC6bV6jEO6n6anc5RCkKGl7MS
         R60SK7RmWodiJ2YQ3H5yF65JJ3prsUVmxRCYeA7n23K8wxFZVMYEc7Y/dhZW3mDJykmu
         69HMduumPYgrcI7c9nW6WiQsLk10dy3dKY2Ld+5oUBLs7tUA5CpO5bOzV2EDpbOJ6QWm
         /6ow==
X-Gm-Message-State: AOJu0YxDInXTEWMbUUibN7EoTQjbt9fMroZvI/U8uuLhEkHe/mmsTBDc
	XExdmD5G2/LPmzBMkz244khLazApi4DnOy4Vs+SLnBeddEzfTBE81AHY85TTOzhFOsDAHHBpuq2
	7LXh/gEJQKDh16EiAUHEqIsr/rJV2y6XdRQh8snA65dCsvZYnxsp104A=
X-Received: by 2002:aa7:8c0f:0:b0:705:b0aa:a6bf with SMTP id d2e1a72fcca58-705d710501bmr11274896b3a.2.1718607455967;
        Sun, 16 Jun 2024 23:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+hOgKsD7WQjrpKrcW/UIjRI29YgjCP39XapNYxupr2wRI6DvBCJFb+rVj0fqNhJQ030oPIw==
X-Received: by 2002:aa7:8c0f:0:b0:705:b0aa:a6bf with SMTP id d2e1a72fcca58-705d710501bmr11274887b3a.2.1718607455492;
        Sun, 16 Jun 2024 23:57:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee2d36b96sm5198597a12.74.2024.06.16.23.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 23:57:35 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:57:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 2/5] common/config: fix RECREATE_TEST_DEV initialization
Message-ID: <20240617065731.mb3xiefs5svm6nmk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061726eucas1p2da9aac47102bf2a5c590c0d07f04bed7@eucas1p2.samsung.com>
 <20240614061722.1080-3-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614061722.1080-3-da.gomez@samsung.com>

On Fri, Jun 14, 2024 at 06:17:24AM +0000, Daniel Gomez wrote:
> Do not allow the overwriting of the RECREATE_TEST_DEV variable. When
> this variable is enabled, common/rc -> common/config will reset it
> to false after the test device recreation process. This allows for
> differentiation in mount options for SCRATCH and TEST.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  common/config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index a1cd14de6..43b32b93d 100644
> --- a/common/config
> +++ b/common/config
> @@ -94,7 +94,7 @@ export PWD=`pwd`
>  export MALLOCLIB=${MALLOCLIB:=/usr/lib/libefence.a}
>  export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>  
> -export RECREATE_TEST_DEV=false
> +export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}

Oh, that makes sense. Looks like the RECREATE_TEST_DEV doesn't work
long time. I'm wondering why we didn't notice that in 87f90a2dae7a4a
("common/rc: Enable _test_mkfs to force a mkfs on a xfs filesystem")

Anyway,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>  set_mkfs_prog_path_with_opts()
> -- 
> 2.43.0
> 

