Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658E33CEB7
	for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702688; cv=none; b=EKgi2Uk66QAMvmT01JXVBhDOVQyhHGMed8ItbAzVfpDjpUskh7V4EV+8YEsjRbP3gn4LRmiYam8Me+LIaz82Bk4OCba1X5Yuur6fZdJJZEM0Yy8soC3FzKM/AW+IPiyKQQBtU4TeiNJ63/uHtVMtjFRx5/DuDxca+lIZjBrw0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702688; c=relaxed/simple;
	bh=4niGVtwxrRp9bQB3NHWEvVlA4ChaoKAJ7EgZpcCkY9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uvw7+OKnLYyKQZDQ6fAbEX/BtPJBVKcfrbFc+ghyLsObYCn/1aHndneTCs5ToooFsUEI0QdWPGTHWl8qj+DZCctTL0mDDRGwT6vQx5Yd7hHHW6ISIllX4KuaPd73uSNucCKh3pPoQt0KfP94tGf3VrzS9F1XnmaQRB7KFJYzelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LN0ehHay; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhT/hx9i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LN0ehHay";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhT/hx9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769702686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mo0YI1VAMZKaWZpvoAA2d7WpeTK/KkTsMqb8ufoP4Q=;
	b=LN0ehHay7+AIFPxGMn5fQRxX4cu6X9/nYj5hXl4dEX2+XfvfojUR3s/xBD7TcWxjReNIIA
	GQ8CeK0/GHW1x6d1B8TiPc86Wnv8lghNJvMCKVyvnGKzBK+3h0TyxRsHX1c+BEBhzhUIkJ
	YqM+uyFEPJwiW3YTIZd58EboYUf0wV4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-D83noQXYMiCWtUA8oixvWg-1; Thu, 29 Jan 2026 11:04:43 -0500
X-MC-Unique: D83noQXYMiCWtUA8oixvWg-1
X-Mimecast-MFC-AGG-ID: D83noQXYMiCWtUA8oixvWg_1769702683
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-353049e6047so837572a91.3
        for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 08:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769702682; x=1770307482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mo0YI1VAMZKaWZpvoAA2d7WpeTK/KkTsMqb8ufoP4Q=;
        b=FhT/hx9iX+rG67cyKFScmhmYpHBF+Ma5UzrM9fyQlfbT1ljHDdbp604CK1i3mVZatx
         /W8VifvOROyuvXjVhVAxx9uR5ESrsBmnf9nNWocnqibEi4vQFS7VNpTlIm3Ww3yPVqoR
         KGRRT4sSJ3TJGBsvl1ivZLNkW9mV4OsrUeJgo/lI5fMNQTK6XTi+mRDAviinm7m3FduQ
         QAmtcsNsNf4N0+tiDhQNs9IRo4e/28CVX45jViMphKxl5RrzvfcsB6IfZrWebWe97MUZ
         7waeyEwGp6c21Y1iiOL+sUC6mNvjT4CtHrN7cQBXsnbJktCbfS7zmEbCqqxeBEc4sH1T
         FAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769702682; x=1770307482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mo0YI1VAMZKaWZpvoAA2d7WpeTK/KkTsMqb8ufoP4Q=;
        b=kSJWSA5gw5rOzeWwzezKKecaCV+OpIG6T+TnSJQGcJU68xw4TPILrZE8rpCc8ExRFl
         vk/KYH6UZqG3F9c9RCQEzYWSmn0fvqfC9L4an6LVRRTrAM4qYvVpujJvS6YVkFjGFWnS
         SyBTa8CNkpUuNDDqLD8yxsPAafxVQ5pYwQssANVS3Jcko+sd8ZtuKBBuKy4KkVzsXOyO
         zvTNW0Xj7Dee4082LVyfIN2gOjKt2r1Yl3oQ/5JdcL4UVw3Z+9W7TgCUunCbcYvSmDdQ
         tVs0zdiIQI7kS/QzPZBEWl1SKFQH8D4HCaQ9KTOC0IM4i6IPRUMXPqdnurvLOOWLbORm
         JBTw==
X-Gm-Message-State: AOJu0YzUkQz+We+A2gwJ7q4thjNAKImu3+niPMMS5PJ7oZ4lDADUY9zz
	LKqr/mJve7VZDme2lK1+iilrCr2MmRjbSn+KV72tfihDFcF/NhNmWT82KSiUuDXXJ6ugsVjUMyE
	1l8zaCyWBiCz8x/frEU/r3gnnQUUiwC4yvgR3J4pTcX5qh6u2q3XQQZiSzWensFc/n4c=
X-Gm-Gg: AZuq6aIv2tEL2mUq+yjrgrcvTXj41qlov2EtxHWkql6Eq9K0RvqUiospQlWbPPAyfGJ
	aiOhXRHlAWbGkgPuau3yfy47k4U5D9Ga9AuJzXpDUSHWPf+Ogh+Ug1sSl6Te7S20mW0CJaDxUS/
	Utq0XG1MMR7HjQTRNM6GpTi6m8TdYa6bSoujw8DjhLhVsghvzji6xrqdyAreSwKcyG55EYujnJV
	oQQ5A1pI/YB+vmI6Kk7asfw+wLCMrnXiHblQZq+yv89AEIcDuHcDYswm13aLwC4yT6CnbVDMNKD
	YZ5y1lMtdQmGgibKIb0iV86iihDOwLWKT06VuBafMRoCWQFpKdvuy0R/rkUGM2VtbDvMX/4mesE
	WZrtvqFRKEU0XLlwSzV3nPGH1Lfd1YaHAOi7g4ectWQZDEZmLiQ==
X-Received: by 2002:a17:90a:fc4f:b0:352:b674:2592 with SMTP id 98e67ed59e1d1-3543b30564bmr11216a91.7.1769702682014;
        Thu, 29 Jan 2026 08:04:42 -0800 (PST)
X-Received: by 2002:a17:90a:fc4f:b0:352:b674:2592 with SMTP id 98e67ed59e1d1-3543b30564bmr11191a91.7.1769702681575;
        Thu, 29 Jan 2026 08:04:41 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3542dbad222sm16202a91.0.2026.01.29.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 08:04:40 -0800 (PST)
Date: Fri, 30 Jan 2026 00:04:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: add missing kernel commit IDs to tests 784 and
 785
Message-ID: <20260129160435.4g6mvwsldqogiybh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ac7a142858d625cb5921568918b1b9615a650f25.1769525657.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7a142858d625cb5921568918b1b9615a650f25.1769525657.git.fdmanana@suse.com>

On Tue, Jan 27, 2026 at 03:01:52PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The respective kernel patches are already in Linus' tree (landed in
> v6.19-rc2), so update the tests to include the commit IDs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks for this update,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/784 | 2 +-
>  tests/generic/785 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/784 b/tests/generic/784
> index 5d972cce..f7fb6272 100755
> --- a/tests/generic/784
> +++ b/tests/generic/784
> @@ -25,7 +25,7 @@ _cleanup()
>  _require_scratch
>  _require_dm_target flakey
>  
> -[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 266273eaf4d9 \
>  	"btrfs: don't log conflicting inode if it's a dir moved in the current transaction"
>  
>  _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> diff --git a/tests/generic/785 b/tests/generic/785
> index d918de4f..6c3a1c36 100755
> --- a/tests/generic/785
> +++ b/tests/generic/785
> @@ -27,7 +27,7 @@ _require_scratch
>  _require_dm_target flakey
>  _require_fssum
>  
> -[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 5630f7557de6 \
>  	"btrfs: do not skip logging new dentries when logging a new name"
>  
>  _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> -- 
> 2.47.2
> 
> 

