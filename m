Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763F259C
	for <fstests@vger.kernel.org>; Thu, 16 May 2024 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715831410; cv=none; b=Q3Uh4QD2Nrb0d9XyEW4LtsvAkaRKk3qBWlYRP0xOZ06oUiknRq9x4s6yoSI0tFdGVM3/LUqjYTjwpl88sz1E17UkDzZZPu9Je4aelrioos1PZVVZV6ITpDK83w7W5Hdb3vG9HlqrJOikG/CosZYn1wrAwIrgDdM4hw/WON6Gfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715831410; c=relaxed/simple;
	bh=a2/2b6FDEzUw1rOL8SgMqO/AVqOxWxClxPMIAtDtIlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFt3K6Rq66/NZk3mrK5ynZHTQuxVsr2TxzgSNPyUj2I4Skp7acT9xLDg+N2QJ8W7SjjNqthA4fiM75VAiqSs+NkUxk8zo10a7+KZ9oeSp/tt7NfEOD8iOEQpDd/VwlPzz3ny+i2C3NzBn9NgeAkmakVqduWQfTA537mdbGhmrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F14yjKhT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F14yjKhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715831407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gl60mrDio8jc8u8u6k+Vmdn2yDp+jFT5KdnmnjyNd0U=;
	b=F14yjKhTnvNySmrbyCsbUumVht0dauOHGPHDb3P/miBemgEBF6iq+9IUfp7Zi17DokVzO0
	o5ZLpPsjCRenaXanUKaZkat4GnJU4WivKHaYrtJx3Xgg6/ceq2O4ohFkkOGLYWz4yscZnn
	wIYV79HPLUlY6lHF2KfL2uDGUUkY0p0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-RU52jmE1PpqM6X22MOtJnQ-1; Wed, 15 May 2024 23:50:01 -0400
X-MC-Unique: RU52jmE1PpqM6X22MOtJnQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ec401f87d3so84377605ad.1
        for <fstests@vger.kernel.org>; Wed, 15 May 2024 20:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715831399; x=1716436199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl60mrDio8jc8u8u6k+Vmdn2yDp+jFT5KdnmnjyNd0U=;
        b=eJh230tC60UCCM8sInSVJ5F+4MjsG8xUBGH14MtB5d/NSTbpMPOHzfRz/BNR04Tpbd
         5fqnsPDrZkLcl3TDWGlncQECHaf1jWF7XgL6OI3n3u7+wRdcyrkgd0eI4xMC3dc8YGeS
         NPP5I2+MxyYCcKVBXw2zZWtTdopDzLuxlwWUQzPTqSwAnOwZ3TXD4A/wSGgrLer6Ha/C
         khOPmppetT2OsAzYyQRBMP8ATlJGrLPchHmUrQxNhHZ3APum50f9rFGqCg4RgigUZuK2
         879RDhotXdhzqNyZCsYQ5naaMz1tcVCpk/BpMhsW/FpOqBu4H4RR/2/uxYMUflPIziSV
         V1OA==
X-Gm-Message-State: AOJu0YxRGFG12Z1DYoNXIHPrm78FGn1WFuW2U375IlfeUzhE1wW7xIoq
	AKJETCHbEmIwP93a4wvtKivitnVBkl9wJpF54HATGZwQsspLKLgTzf/0jMfWVHn3Z238MDacqtv
	jD1WFMpy6417vVCrvz66XAZOyGNph/Lyd0QcCjUiOEVNcBwZOKsZzc53OHHTGIFI4hA==
X-Received: by 2002:a17:902:e752:b0:1e4:3320:dbed with SMTP id d9443c01a7336-1ef43f51b8bmr226466815ad.52.1715831398490;
        Wed, 15 May 2024 20:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9iw4BDSqSoydaYv4Kek6dvDiorOM6oI3FuTULeGBeSdab4FpOT10JIC7yt7hYHQs66c/+VQ==
X-Received: by 2002:a17:902:e752:b0:1e4:3320:dbed with SMTP id d9443c01a7336-1ef43f51b8bmr226466605ad.52.1715831397691;
        Wed, 15 May 2024 20:49:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f07dec3fb2sm55858005ad.63.2024.05.15.20.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 20:49:57 -0700 (PDT)
Date: Thu, 16 May 2024 11:49:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH fstests] generic/742: don't run it on NFS
Message-ID: <20240516034953.7im5grlfdr2xzs7e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240515092133.1219-1-chenhx.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515092133.1219-1-chenhx.fnst@fujitsu.com>

On Wed, May 15, 2024 at 05:21:33PM +0800, Chen Hanxiao wrote:
> This test requires FIEMAP support.
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  tests/generic/742 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/742 b/tests/generic/742
> index 43ebdbc6..aad57f2d 100755
> --- a/tests/generic/742
> +++ b/tests/generic/742
> @@ -30,6 +30,7 @@ _require_test
>  _require_test_program "fiemap-fault"
>  _require_test_program "punch-alternating"
>  _require_xfs_io_command "fpunch"
> +_require_xfs_io_command "fiemap"

Make sense to me. But according the change, I'd like to change the subject
from "don't run it on NFS" to "require fiemap support", due to it's not
only for NFS.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  dst=$TEST_DIR/$seq/fiemap-fault
>  
> -- 
> 2.43.0
> 
> 

