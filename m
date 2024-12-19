Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E633EA
	for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610964; cv=none; b=KsS5qH2R8VcW3HtE2kwjaB+qEMonaDBqE9RvGnAMubgUd89iJCXgHxpa9mx2H5nEDWTW8quiWDfyPQPvncZiJU8x2+4NY0pTmFeYNs8rLiVwt69fAAOXJVUEUbdislAPtaAMd3GiChkJ5rQcgCoJ6DX8e4x8IaGYKBVGyCSeA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610964; c=relaxed/simple;
	bh=KwgY9IM4IHJTnQ/JPLAfhK77iP3A6nj6cV1vPTPbFbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZTPxLog1UpB/IHMVLGHR18//wK6Ki9reeaOCDssomVh2UvqZYZceJ7hZzhlw3b+2EUMTtKBCXelKSuhbGSI9isIZ634riRFIYNGhbQhT/ncnuBZJoXU9+bBh6NXXjFQlRbB7vA96YpNXt5hfumNKPJ0WS4rNHkf6EW6lv0AIRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKzTrpoG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKzTrpoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734610962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cMCLi4zVEMDj7Al3ElXyo8OOv7M+q2sc/pVW1fsv0s=;
	b=TKzTrpoGHQze+kfuWPxBQWReuSHXVka++8Xvjqk+wC7kxBsqUDmvMf+20gIesFlionQAuo
	ORBmVixOpKruOnpGnt3fZkJxwZWqAdirapgLLtowjH6hnumjUzfUakqddXEdCQ3oWtvd5c
	JRmbXfjvNxe8QC1M5NY+9nbLZ8plVgI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-EpdTuvEHMuqZxH_3fAN8QA-1; Thu, 19 Dec 2024 07:22:41 -0500
X-MC-Unique: EpdTuvEHMuqZxH_3fAN8QA-1
X-Mimecast-MFC-AGG-ID: EpdTuvEHMuqZxH_3fAN8QA
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467905ab1bbso17707571cf.1
        for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 04:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734610960; x=1735215760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cMCLi4zVEMDj7Al3ElXyo8OOv7M+q2sc/pVW1fsv0s=;
        b=j+z5bScJT6QcCZ4BfvpuHo4Xuh5dKOEl4fOoLzFmDGe0289Ahhy6sAyzDo+Jso8Or/
         9vjQJTNx5ydRIVFU6J4tNPEptXYvOmkLv43dTrM7Auq9MY6zGqz4CSnDxJGm0zrcsYvs
         oPnS6pl+sk10KhdUwfyra6ClNxiZvHG9MeEnkEgHEDRWh8zOrfyPOxnc2jBe3bChOMmd
         Rev5jxCyROnxQ/LkEIzZk64bVB4Yuio+lPoj+Z4hOy4fVJ3/zLs4mHmUvVs09gbUvIS4
         ubewH8sX+gF4qaXiE7iwi5UIX4n4PhFPldl2O0w4geLCixU1BoC6ec14IEZwR4rxB/T0
         U7tw==
X-Forwarded-Encrypted: i=1; AJvYcCXZIw1LqwsIPUUXlBumPIId0Ao8UsrvSqnqwq/2Vb08/tOd++HxX+b0272c74DEoxnJWGjeK13+@vger.kernel.org
X-Gm-Message-State: AOJu0YywKyFnWnXNBWk1vlM90LPMhmPcpRTcm3c1G9so2zE45se//V6e
	5nB41RxqLJtRaI5EkFc2hZpwsFurW9DG7EntZzecgu33k9BfMyHjuWTkt1e2WKSgqzW5OcAQzvk
	evqgEvUZB+L90v6VEtheGu+YBYg56RPRMO/qiH8Px9CTPCfmLNkmIVp8=
X-Gm-Gg: ASbGncvx0/efRcseYH2fyO/7vNNSqTW4zTf9CQ7Ovfp55WFOjGqjBfJVITqwcvsTJ3O
	7SKbIBPXVRBp8CIvCHJCR9Hf7reKW3jehrAZoJ4tG0bA4Bl15w1CbyJaeyXETd7LEXLRxnqMKCA
	f3b5PdY2pQRivt3utsJATc+f1tXg8njlyXEVkOF77038OVs1vkuEd2N2AObuCGo5c8qakSeQzAy
	RPPtfZNwsMPmT4x5etwqEXEJI9O5wUjGG3r1u2bu4cL0V8SPPldj/VucbTE9IbOHVwDnp1A4X+i
	Iwv3vOy3Z7bckn3XZpMNEA==
X-Received: by 2002:a17:90b:270d:b0:2ee:cd83:8fc3 with SMTP id 98e67ed59e1d1-2f443d71631mr4572265a91.37.1734610558902;
        Thu, 19 Dec 2024 04:15:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKj8Q9BdoBGW4+XcL83PolilcHLx944IS9YHTz9Zw7rHpSMBE47UXoWK1Dd82IOjYEHShclA==
X-Received: by 2002:a17:90b:270d:b0:2ee:cd83:8fc3 with SMTP id 98e67ed59e1d1-2f443d71631mr4572240a91.37.1734610558578;
        Thu, 19 Dec 2024 04:15:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2db9a661esm3119380a91.2.2024.12.19.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 04:15:58 -0800 (PST)
Date: Thu, 19 Dec 2024 20:15:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: add commit id to _fixed_by_kernel_commit
Message-ID: <20241219121553.s24w6rnws6relylc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241202155727.4221-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202155727.4221-1-chao@kernel.org>

On Mon, Dec 02, 2024 at 11:57:27PM +0800, Chao Yu wrote:
> The bugs related to f2fs/00[5-7] regression testcases have been fixed
> by below commits:
> 
> - d5c367ef8287 ("f2fs: fix f2fs_bug_on when uninstalling filesystem call
> f2fs_evict_inode.")
> 
> - 1acd73edbbfe ("f2fs: fix to account dirty data in __get_secs_required()")
> 
> - 26413ce18e85 ("f2fs: compress: fix inconsistent update of i_blocks in
> release_compress_blocks and reserve_compress_blocks")
> 
> Let's add commit id to _fixed_by_kernel_commit in f2fs/00[5-7].
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/005 | 2 +-
>  tests/f2fs/006 | 2 +-
>  tests/f2fs/007 | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/f2fs/005 b/tests/f2fs/005
> index a817d51a..33d4fdb9 100755
> --- a/tests/f2fs/005
> +++ b/tests/f2fs/005
> @@ -11,7 +11,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit d5c367ef8287 \
>  	"f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode."
>  
>  _require_scratch
> diff --git a/tests/f2fs/006 b/tests/f2fs/006
> index a9c823c1..c1f8d4ff 100755
> --- a/tests/f2fs/006
> +++ b/tests/f2fs/006
> @@ -16,7 +16,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 1acd73edbbfe \
>  	"f2fs: fix to account dirty data in __get_secs_required()"
>  
>  _require_scratch
> diff --git a/tests/f2fs/007 b/tests/f2fs/007
> index 6451d4b4..37388433 100755
> --- a/tests/f2fs/007
> +++ b/tests/f2fs/007
> @@ -11,7 +11,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick rw compress
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 26413ce18e85 \
>          "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
>  
>  _require_scratch
> -- 
> 2.40.1
> 

