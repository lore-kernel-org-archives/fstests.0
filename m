Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB512E405
	for <fstests@vger.kernel.org>; Thu, 29 Feb 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171034; cv=none; b=MPouNQpGMVCGWnfkQu5W1CqGbXa2u3jyzmBZNuTKdWgQZklubMAQgQ7NeKzu0hNnci273OIfjvgbRn7QrLA1TyztbZbicCxoLPqlXx7MMneo+L0pzDAgZzxV7dVnl70Zsw5g52yq9mi+ruO3bo5P+gepz0e6k30YXBK2bRHTOvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171034; c=relaxed/simple;
	bh=h5CJevDeVLAgOM8PlGSAD+6pp7wbEEAill3QMPTNCcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYusxSAwKDuSn+8MXceoGGXVr/LRcPJIQg7N+Ne8fH3C0poPgpFp+2ParhqxPc9zTAQVqoE0fCj8sfFDBUbACahY7bdFQjuUqPSukPgOvQbl+h7eF+VJSPLhDsKmFzalhFVrQvGgmmvX7REAYb6tSLfeUI8Qe4dTAt+f3wx5Dl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8umfnC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8umfnC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709171031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cp2uZ/Q+UnJoC/yZxBWM0l/WE9YN4IlAsRchJZIA5Ls=;
	b=d8umfnC1iYbENaSmkkqAFE6sRHj6Gk5lgiosm6wt83tNONR4agJQAP8DmzsN3QnDWXx44Q
	WZDeBtK+BmOnBoJ769+Nw5YtAalzA6Frvzj8J28OA190lenukV4SOzXoor+oiKVHwndVaB
	9UpaNdiaxaIBLAAH33kTRRHvvNb0i4I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-paRfdSZNPeixAj3uBB57fw-1; Wed, 28 Feb 2024 20:43:49 -0500
X-MC-Unique: paRfdSZNPeixAj3uBB57fw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dc0cf01899so3472995ad.2
        for <fstests@vger.kernel.org>; Wed, 28 Feb 2024 17:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171028; x=1709775828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp2uZ/Q+UnJoC/yZxBWM0l/WE9YN4IlAsRchJZIA5Ls=;
        b=oF5H0cyNo2pCJoeFROhV74Iiv/OS7z6+dUy4iz24+cmmsxU2w/uewzbPd4OT273aOt
         K40T3Zqx5a0Vi7EFdsI8Uc/FatlPbgAHkiU6rBva4iMWQB6En5m4iiVADHjy/r10S6Kd
         D2D5hVh0q6/FyhMmOtNdn9QlXvlVOCWg0cUd8mI458s7q54gbPdpdfKJx/bUgoYj+A2d
         Loyhcqwuqcg3RRx3gEPDyzdapARQGKbXoyF+gcf7if3fhI8X+WUV4EudGSCp3jReDM0t
         ctQM0INyZHKLlCutHXVuuq+ACi4TKHPTC51pWGnsLZz4ojjuHIr0OwppbWVdltW7jVu0
         UDqA==
X-Gm-Message-State: AOJu0Yya+TK6RhEtINy2RjrQP/6NgQdIW0/bpBIj1z363eDkza2ujk5a
	/GRXOXlN05Rk/j/xJwupC+Hs+VhkuTquVjj1k+hAxPyLjXW2Fq0GHCr5nWQTnTJnWS1cQ8H/iV3
	iosTB/1pgAj/yxmZ/XFY0q+4j6DGd0MU7CamVeOYGyrNsFRjl7IeSD7Y=
X-Received: by 2002:a17:902:d2c2:b0:1db:8fd6:915e with SMTP id n2-20020a170902d2c200b001db8fd6915emr983990plc.33.1709171028722;
        Wed, 28 Feb 2024 17:43:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8eSN+jPorPo/AeEJbYjM2MQMeA2ypoIIBoQpNf5SwynBm/qEoEiWpH4kKEDKwWQ3sL0ppXg==
X-Received: by 2002:a17:902:d2c2:b0:1db:8fd6:915e with SMTP id n2-20020a170902d2c200b001db8fd6915emr983960plc.33.1709171028447;
        Wed, 28 Feb 2024 17:43:48 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001dc05535632sm111923pld.170.2024.02.28.17.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:43:48 -0800 (PST)
Date: Thu, 29 Feb 2024 09:43:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] common: dm-error now supports zoned devices
Message-ID: <20240229014344.ftd6v3zrjbvtnhth@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240221063741.3563039-1-hch@lst.de>
 <20240225163828.7a3tntpg5kaywlw7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240226095829.GB26465@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226095829.GB26465@lst.de>

On Mon, Feb 26, 2024 at 10:58:29AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 26, 2024 at 12:38:28AM +0800, Zorro Lang wrote:
> > This patch makes sense to me, but I think this patch might cause
> > failures on old kernel which doesn't has kernel commit a951104333bd, right?
> > 
> > Is there a simple way to check if dm-error supports zoned block device? If
> > there's not, I think we have to let it fails on old kernel, to make it run
> > on newer kernel.
> 
> I don't know any way.  But as this just affects zoned devices on btrfs
> for now I guess the usual parties can just make sure it works by
> backporting the right patches.  The previous don't work wasn't even
> a not supported, but a case of dm-error being buggy for zoned devices.
> 
> In other words the original exclusion in xfstests should have never
> gone in and whoever put it there should have fixed dm-error instead.

OK, let's have this patch, and see the response from others :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 

