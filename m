Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62E1F4FDC
	for <fstests@vger.kernel.org>; Fri, 11 Oct 2024 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625344; cv=none; b=kJpO5RkzdptNzO5eZ9XETfw3KlnEB1X5wyGgaAbjNs9Xv9Jtd+2/1ggOCNZUPZQBdPkHnzWYy514659LfOjtR/mtYWZgSYZbZ1iy8dXYu6Mla4YPTFClv+fVI8rLthmZaM0j9SO1L21ssdQu7t8PT7Gp6HFiM+e05gzNNTG7D44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625344; c=relaxed/simple;
	bh=idxDbcbNYVJWrkCpa8ghOudRiV6TRc1L6aXaGXyHN68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id2cicPsMLTJBsyHNgUenABiH6tIXf2TStRW3nj3y1eQpGlE6AseJ6IN8Ker3oLnrZ8rfSceJsPwvZ/5yk5MX59CoIWXybIirPcjgr4el9z2MiUKrcHp8lAPZTcUbvlXGFkJnWKp8kbuDFYE8izga4uSiWEc9sx+mjCohCtWbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBCvPn+1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBCvPn+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728625341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53B97lUdI/DP8jBTRSZLCTzYlhOxeGNND2Fs2ic+Gwc=;
	b=jBCvPn+1j6LfqG9NSpFJ637q0wbAHB9cXoEhpouCeDn8+bAI8+BYUh09HFZ2vY+bLy4Lby
	MlKnC/zUgIwuRdoID7KYNFcnihSBbR6M0PYq4K/9XmTkS3SvH+Lq79l9PO0P107a4jsGdu
	6H4PmpZ1J3jLFL40915WCXi/K8bsFDw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-RiBiMIL6NSun0rDtiVD49A-1; Fri, 11 Oct 2024 01:42:20 -0400
X-MC-Unique: RiBiMIL6NSun0rDtiVD49A-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20b6144cc2aso16513165ad.0
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 22:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728625339; x=1729230139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53B97lUdI/DP8jBTRSZLCTzYlhOxeGNND2Fs2ic+Gwc=;
        b=Ek236eal4mLXbD9xPd0hpktv8T9wiYJj6sZWcw0Q8FqhSM5Y211XhApZVNLtTdt2u7
         pvhONSkxEYmVrhyy1lkhB0WTIhU9GW+HlfbvPWoXMELt873vOWXHAdVCD3zL1+yka+e/
         c1hNWp1DHOG+tq58edtDDy3jUPqGfxMxCTwVp13+Zeb59VJ8iS+502SHP/yWtVFS4XOv
         r1YBggeEOtKEJ0reKzdns5d+jhM4KQ5AC/Kg0lZN3m//VN0HY6u25VtALcjru+x8zwuU
         EYHDgJ56R6o93oo4uE5XmTC49e5ksHKb5W0yoXbfDnwytVtfqhVZPAHr/fZZWt7l7uX2
         rC1Q==
X-Gm-Message-State: AOJu0YzbpYCMz8e/8OhYCtPDQrWInItj2BwZo9JGxSNwhtZkhPxNjz42
	gloYwOj8YXNltNF65UjxtcCOU5cDVt27TGazPyb8CNh2da5ZYc6Uwdo7TePWFCyx9RtCO/LSFCz
	1OTBssC8xUmn5gNrSlSKtb6BC0Rwry/1gRHKbTG+WkhvI4fiTknYy6Yw=
X-Received: by 2002:a17:902:f54c:b0:207:794c:ef24 with SMTP id d9443c01a7336-20ca017813amr22664605ad.4.1728625339302;
        Thu, 10 Oct 2024 22:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGludFsYvBrB8CYtTLTqINvYVM9TGvZ0bUIQjzfDkPkA1dfAxtuD6O74+4ATekQ/KG03RwSIA==
X-Received: by 2002:a17:902:f54c:b0:207:794c:ef24 with SMTP id d9443c01a7336-20ca017813amr22664455ad.4.1728625338974;
        Thu, 10 Oct 2024 22:42:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc13315sm17658625ad.107.2024.10.10.22.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:42:18 -0700 (PDT)
Date: Fri, 11 Oct 2024 13:42:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/318: add _require_loop
Message-ID: <20241011054214.km2yl75ya5zcfl36@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241010153630.1225162-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010153630.1225162-1-maharmstone@fb.com>

On Thu, Oct 10, 2024 at 04:36:25PM +0100, Mark Harmstone wrote:
> btrfs/318 uses loopback devices, but was missing a call to _require_loop
> to print the correct message if CONFIG_LOOP is not set.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  tests/btrfs/318 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/318 b/tests/btrfs/318
> index 79977276..df5a4a07 100755
> --- a/tests/btrfs/318
> +++ b/tests/btrfs/318
> @@ -18,6 +18,7 @@ _fixed_by_kernel_commit 9f7eb8405dcb \
>  _require_test
>  _require_command "$PARTED_PROG" parted
>  _require_batched_discard "$TEST_DIR"
> +_require_loop

Sure, this case need loop device.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  _cleanup() {
>  	cd /
> -- 
> 2.44.2
> 
> 

