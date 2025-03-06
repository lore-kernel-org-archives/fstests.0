Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E720D510
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267478; cv=none; b=ChtiwSvae/QD03d/hSuYYSpHE2TXpgytqGz7dVzQFr/ZSI0fplli0utX3Iw4GpYrHSredUYQsz7maura4e0SB8YFW1+6Xuim54Pi/ZD/prZNqVZN28l2RLqkJH2w7W4y6dVkp4YNVshA8VB7RA0Lc4snX2Yxz/+hyJgtXn0G0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267478; c=relaxed/simple;
	bh=M6kq4gC+/WeG97ua0Fjmeo3ncgKSiNJEB5Xz3BStp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi7FObKLIxMjwyIudWo6LmC9DSe+f2wzp7l1/e7wQNibSXWeS37l7bliBn4wJNt/EzfzUEGauMUlGWDVa1ygcIuo9Yd5M2b/TMlxwvIOcg59gNSgX490mSBf58Wh1rGtD5ALcUOutwvIg5kQ6VUX4/fpELNyv6I7kBAxt6WxsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWfSQOeX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWfSQOeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741267475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVryRIoP7Fmgk9OzPI4cGzgx7a6+rL8H/iTP/uYMo3E=;
	b=aWfSQOeXTvjFcG+iVHLHNjs12nVlX2+3Q4EgTVAeAnmI0gbjrn1LmcyVP4swzhkzaJpeOe
	QZM3fyCvyz0psno9hpzRcGCsMxIFtTVDP63h1Oc4OFVALrdZjJfqavcVVGsixRDTVKrsm2
	ZHTZdwEjhPZnssqg95Zi6VUPSlNghMM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-v8d6qVu4NBOZuZMWqq2nQg-1; Thu, 06 Mar 2025 08:24:29 -0500
X-MC-Unique: v8d6qVu4NBOZuZMWqq2nQg-1
X-Mimecast-MFC-AGG-ID: v8d6qVu4NBOZuZMWqq2nQg_1741267468
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso2071046a91.1
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 05:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267468; x=1741872268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVryRIoP7Fmgk9OzPI4cGzgx7a6+rL8H/iTP/uYMo3E=;
        b=UxtEtGz/Cc1pMlL6GPVcexhUMt/f2K+knx+7tebBJ8JE91W8+g13476RYR11YfuoN0
         +OOWTDpgH161nF9f8IfPzQr6aYRL/fdgvgxkeJt0fiAjP8VAL6BGGcKYWDrF2n2mXNAD
         YKCsA2v5tgPwQTeHCU4Mfs9ajcUpvIJfRr4YYEJP8g9sabsR3Vc1w3L+3/1+cZoFPFAm
         8Cbrbb9HRSCSvQeJV1emgZXZJ7QzugxHI+TBOYn9ihwsczExExXF496s4N3Fg/Xp5x2Y
         5O/3g0uLgkaB812LwP7C+uRMUDUmRpLSNi0JKg9bFbaTa3iP7bjMT6gpnk9e5Km58zKy
         QfhQ==
X-Gm-Message-State: AOJu0YxSwM1qb1+ykqxRG+JbrS6A/1UDYZ/1e9e2JKYLS597IosrU4iZ
	/u4n0D+3UgRjjMjWn/GGgv/5m2GkAoLaUQjsnXwAOu/9DHwWQV89TKTohoJh86qfRvQHwherQYN
	Y+kZRZYtiNUoyzWs4ikAezshQ+EjHl6QEL52dVfn8U/OC+Fl5cCNMwzg=
X-Gm-Gg: ASbGncsRi9nYybtgd8ccbGceu/jC/QeU4GlFXfecCXOhPn8v7fWuF1YzvI6kDeS1MZY
	d8ku1VjFUsoxn6HGlf1gM5WaLVbjEwlrtgdgSxXSzHoHy7EkxAqk3h5bU9FS5yxDpggA5s/bQvT
	ZK541Rao96+0ccelxLYmQicE+7Qw/575ImIXog+YouLtDWJqvbh/ACSPnWyac1FLrLquLLqhvgW
	7prgR0xbHd4la8Gl+KM65bWtLzZkcG/aF5kTyHiGPG3vC3n9AzJjNQBzELjxXr5wP47WFK9BD3T
	quWugy6NeLeZgtfxQB7P3ffowGDP94xTmK1/+ODutrIu32x77yVW6zjb
X-Received: by 2002:a05:6a21:9988:b0:1f3:20aa:4224 with SMTP id adf61e73a8af0-1f3494784d3mr12855205637.15.1741267468208;
        Thu, 06 Mar 2025 05:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoC/Egylhs0uLJZFPsbhfjNLGfUXu4ZZ38wmN6fH0nQSl/62/dUZsK6rwFCfONf3+zket1Zw==
X-Received: by 2002:a05:6a21:9988:b0:1f3:20aa:4224 with SMTP id adf61e73a8af0-1f3494784d3mr12855178637.15.1741267467935;
        Thu, 06 Mar 2025 05:24:27 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28109a4b4sm1174133a12.32.2025.03.06.05.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:24:27 -0800 (PST)
Date: Thu, 6 Mar 2025 21:24:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/363: add annotation for btrfs kernel commit
Message-ID: <20250306132424.aufbif5u2svaoohr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c0d7592ed3a4f8d39245359b55948c1cd60b87bf.1741171979.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d7592ed3a4f8d39245359b55948c1cd60b87bf.1741171979.git.fdmanana@suse.com>

On Wed, Mar 05, 2025 at 10:53:12AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This test exposed a bug in btrfs for which a fix landed in the 6.14-rc3
> kernel, so add a _fixed_by_kernel_commit annotation.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/363 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/363 b/tests/generic/363
> index 74226a45..79b1ff89 100755
> --- a/tests/generic/363
> +++ b/tests/generic/363
> @@ -13,6 +13,9 @@ _begin_fstest rw auto
>  
>  _require_test
>  
> +[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit da2dccd7451d \
> +	"btrfs: fix hole expansion when writing at an offset beyond EOF"
> +
>  # on failure, replace -q with -d to see post-eof writes in the dump output
>  run_fsx "-q -S 0 -e 1 -N 100000"
>  
> -- 
> 2.45.2
> 
> 

