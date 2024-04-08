Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3741DDD6
	for <fstests@vger.kernel.org>; Mon,  8 Apr 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602853; cv=none; b=h8DdKWLmkaAkVtWq+L68V5sezeQoD72U68oIpuppPrNZ+cPZaYFotbPnjYvWoIUHA5SEpa98MJSvZCivj8FoQUpew2lfBJkR1TOsV0LzIXBaLxw4E1ZtK6fjGv5B195Y9P9CdJj4SPWMZ3JVgc9Oyv7BULPAzRnY9Eb3dUUUwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602853; c=relaxed/simple;
	bh=K+7q1REcORZIGhh0XnxohXvlSCUt1Sm5g7l9UwSiUkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxkbztN6rnwgJ+IItd33VU5D2kTT4Mt+JylBOW+n3wrsMzJS4mfg1O0gRXRakcuFnYa3wiEnF1hCRmgA6aVbDBCloCQNhM6rp3Xz7ckHi6JYM8capDWk7s2zW7tFH01A/sR54+gTiXiWWuKqFOjn0AYVM3oP0tQH/uacfyp7+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7XEcEDj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7XEcEDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712602851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88+D8iz1phlu4lJsOrmc5P0Y3kTg5b4oDnCnIoO1Zvg=;
	b=h7XEcEDj7tW7pkpa60Ly1aD6rlBJFYYmt7/qPOlNEWadwzt6lhFr1qgF+AD+J78RsXsD1a
	o0Wb52lOOuGsC5jmAkgtftfH9+C0W7dOGVqUXq6qIV2LgMoQxreSQPcpAV4jMbHy7w+HoU
	CMqWO26dwuWbfam9/JhkTLNmeR4z/9g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-WB1sjiOhPOG5x6BG0UeMpQ-1; Mon, 08 Apr 2024 15:00:50 -0400
X-MC-Unique: WB1sjiOhPOG5x6BG0UeMpQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cf35636346so2838407a12.3
        for <fstests@vger.kernel.org>; Mon, 08 Apr 2024 12:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602849; x=1713207649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88+D8iz1phlu4lJsOrmc5P0Y3kTg5b4oDnCnIoO1Zvg=;
        b=KRlvapQyKI+sYuPly0aOw7J75DKHN32gBankdnPR5f28j6R7rNA6IWUKLOiRao0Qt/
         CaHaNMFW62ity/Ub5TCaJEqCf3CLfsL2LO0Le1hWWZ4lmJAOThJQjH/lWrRh6GRyEDxc
         Z5Ma9X5s8tqxS0RG9Ldtj7+0ln6kug25M0e/WpFM/MqDqEDF4Xx+V5P3Ty987xm3sm3a
         HTCxLzqyiXcGUUvEiSSx2z66e1Rok56YX0mbiwFvzqX88TuUEHGvyzxnk3A2+n4YdFNw
         Kmre8ckzzVrpjYdzaX4S/xEwDwZmMSRZ/N+Crccdp8jt5C71/BQXYWaQnNgHUdLhdDj+
         uNbA==
X-Forwarded-Encrypted: i=1; AJvYcCXMe9Prv5Wd444V8o9n5d5TgGOCIpMLKVY7bW+4nlXOsG5FzKYIFuKmm3KYGWwUPSsrZIynPNo5SDmXpdgVnj8xC0ApFJi82A==
X-Gm-Message-State: AOJu0YzmpYW/0Zha3KBEceNpNmt1KZucUY95z+ZFoy9tsS7xvy+8we5d
	X/ghcBcdDN1IF3BocqvMpY4IUUEaQpFESuFXt2V81MlNOHHdsXPDKz0UdgtFlRGLlYfLQqb1NsM
	/fUMsvWVOS5tVkBZIvHu5rm69Trdink6rR+hyZiw8ermNPMkmvtXqUJc=
X-Received: by 2002:a05:6a20:9c8b:b0:1a7:760f:feec with SMTP id mj11-20020a056a209c8b00b001a7760ffeecmr2919463pzb.20.1712602848828;
        Mon, 08 Apr 2024 12:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5eZNvcTRkAd6yJWfNbNuUTgxlUrWgvWXCU3PsR47PtVtR8dRe/LqVTa3PsraTaI9ft/qq+A==
X-Received: by 2002:a05:6a20:9c8b:b0:1a7:760f:feec with SMTP id mj11-20020a056a209c8b00b001a7760ffeecmr2919433pzb.20.1712602848323;
        Mon, 08 Apr 2024 12:00:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s42-20020a056a0017aa00b006ed59179b14sm1329322pfg.83.2024.04.08.12.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 12:00:47 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:00:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J . Wong " <djwong@kernel.org>,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: fix kernels without v5 support
Message-ID: <20240408190043.oib4lmiri7ssw3ez@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240408133243.694134-1-hch@lst.de>
 <20240408145554.ezvbgolzjppua4in@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240408145939.GA26949@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408145939.GA26949@lst.de>

On Mon, Apr 08, 2024 at 04:59:39PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 08, 2024 at 10:55:54PM +0800, Zorro Lang wrote:
> > > this series ensures tests pass on kernels without v5 support.  As a side
> > > effect it also removes support for historic kernels and xfsprogs without
> > > any v5 support, and without mkfs input validation.
> > 
> > Thanks for doing this! I'm wondering if fstests should do this "removing"
> > earlier than xfs? Hope to hear more opinions from xfs list and other fstests
> > users (especially from some LTS distro) :)
> 
> What is being removed is support for kernels and xfsprogs that do not
> support v5 file systems at all, not testing on v4 file system for the
> test device and the large majority of tests using the scratch device
> without specifying an explicit version.

Sure, I think most of systems testing doesn't need this, except some old
LTS distros.

> 
> The exception from the above are two sub-cases for v4 that are removed in
> the this series - if we really care about them I could move them into
> separate tests, but I doubt it's worth it.

Let me check and test this patchset more, before acking it. And give some
time to get more review. Thanks for this patchset!

Thanks,
Zorro

> 

