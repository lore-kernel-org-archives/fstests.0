Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBC30F532
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767219848; cv=none; b=qWZbksD9TE2pVqI4aQU2JibcSOgzkh+x/N05+IVCefa6ChGp9tA4KJ4ttDZEybMKrM8NPJSFfXe8wStOL9xStQfMODTLCvIHPPj++DyGmnb/hNYCVdiZNsbEQlZMk0RY2d8qf8AeNHf8KZOZwElbVSVLXYKMEQbP+XMlg5i1ML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767219848; c=relaxed/simple;
	bh=HgcXRUs1WlGpSYLBIN2t9wqZLKEsnBJdnq68x90pWYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1ZDNKG9wz3vHdcw0VEbhMuHvguI+RQIIkVEu+zbylnmJIVhIIBC+yc2Ha4VRaPTPpFBUEA78DIjexgXoOUdRU0cX9fjiRQ48L62zYsjB2YDe2+nSN0RIlQ37UavGLOFrQ2CRbGjj2nGWN1g72XUQbT7gBRAz9tQ1pyNAA91t78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VstdkSVy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDD2BVCV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VstdkSVy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDD2BVCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767219845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pzg1w7XjpPUiDpJKIbrZBUkh26fh2KWEzx7hjMnlg44=;
	b=VstdkSVyZSHybWaKZcy0MRLWXRIXeMq2ux/61fXRxAVl6gmJ3xqEiUGd+q05PMgXwqDgo0
	NEccz/ZGN+hLkx+DuIBFuwqZlqt/cTiGsoB5i/J7SB5f8PYTjo0B5ijDePZgaes3BEGGOd
	RRv+1khkzHgQk9DU+/ONLrfduq5NI7U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-a5k-jucmPiGj_WjI58o_pQ-1; Wed, 31 Dec 2025 17:24:04 -0500
X-MC-Unique: a5k-jucmPiGj_WjI58o_pQ-1
X-Mimecast-MFC-AGG-ID: a5k-jucmPiGj_WjI58o_pQ_1767219843
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34abec8855aso23678783a91.0
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767219843; x=1767824643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzg1w7XjpPUiDpJKIbrZBUkh26fh2KWEzx7hjMnlg44=;
        b=XDD2BVCVMb+Du6dIlULW21WlmeFqq02hdoEdQrUO3cOUxWBUOEqz/nrV2vCJQLIw0L
         f/yDom8ea5UydgktBy3MiYHYhnnv8Zas3ZaraUL2P21waUUeciqJTXbO8+2kzECwzTQQ
         LVTlaVRSxZmKirP5BmJR1ZZNgMneFqHEhYkQVlFmNJWXTqnMpStX6kibmZi8k6DtUUZN
         gNXA0HjhfXiQNL+Z7kNsS8vQspnKE3jUyKUrvu8EYgFdhRYVU3Sl7tobu99Gxgwn42Bp
         pw4f72lwGu0UiDLSETFDDIXyfrjWoNYDfT0BF1IxQegjEn3CvbB4bqp5Htk9Hp/Q+SN8
         1CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767219843; x=1767824643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pzg1w7XjpPUiDpJKIbrZBUkh26fh2KWEzx7hjMnlg44=;
        b=PSd9zbPr4ohIMiT/kvx2HX3k8Crpd/n3VGIksN9LKR+e4sFekhVbv00DwBnEZeFtuA
         xAjwVARQPYUJ8cYsGXDxJmW3OYifq7VBySC9AGY5KO6L5pXLDREzljHE/M6nW1Z72Lx3
         AxpiHS6bznv+a4AnbH84D3AbIVV5AXYbmsxbsliYxWMdFFD9qo6CweuorrZqOasIvyAc
         0kH3bDEJAv6jJy8foT+Ffx+S0QNmRqj7cVhXUeoKGLN116R6Whsh4Z3xWoeeGxQNLQkw
         LU1Hne+mIjaSl4Dv5LG7R9oy+Buu7+ajtKOMCAJs51ALwVyMlyq/P1baZT5IMO245voP
         3/tw==
X-Forwarded-Encrypted: i=1; AJvYcCW4K/OPVEyT0o8J6+FjDwJZq/hNbmO1vDrGjigd0XDTvFo/mPpBJmw8odLaA5AE8qD1xhpoehqJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qD528s1xity6rY1iGzZFsY+jy6smxsHKsu4HGFrnoIsOMoYN
	U5oWcKRL4E/jmQ7hYzfquw0flqZH4lwO89hGoRvSrqef8q2nmFxs1ulJsFnRFfFv3sOjP8caRrc
	wJdkQlbjCNOK+c4eatD47JUJ+M7uBMUs2R7Xta18HiJv4JbT0sHSEA7rk450=
X-Gm-Gg: AY/fxX7GYWCxaJsIcENH/CtoCCqK2AQks66iGUvZjnLcyAqOo6hL0GghtJNNXWK20vc
	kTY7QdySlIOZ/pvON6M4mGNsSsv9T0ZdU1pHHInZN/JhMSeOK5CkH3DH+pPcSY7fLLARtrL1Svu
	ecDKY+SUJBvviJwdqF7cE4zO06z94dt0ziVvQwlf52j8qdTi3U+Q2Rb1ixhWmKT9/FtdYiFg1le
	fNn9GIxXwlZngkLiF13A/YDuczEMsqmkItda5AMo3Re8+tZzrgHrpi3Zg8R5rucYzXJ7RgynEwh
	0Lny3p9RcHCVQeuup120lADWAtKH1OQTmADhLRjiFwWr4OQHOeC5JairtcpItAzxBnSGZZpNYxt
	yeBd50F8gbD+TBzoo9Xt+i2A1e0jJ3BLTKCX4JGqGJKcVNlL5jg==
X-Received: by 2002:a17:90b:4d87:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-34e921371c5mr31304911a91.5.1767219842810;
        Wed, 31 Dec 2025 14:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHnY9luOFdJ6YVtjjRAjxqjcz7p3sXH9xQ/Aj/NVZyWcSIbJda156hcFdgmayha8ejyLIYCA==
X-Received: by 2002:a17:90b:4d87:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-34e921371c5mr31304899a91.5.1767219842435;
        Wed, 31 Dec 2025 14:24:02 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34ef44e0b24sm10258518a91.0.2025.12.31.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:24:01 -0800 (PST)
Date: Thu, 1 Jan 2026 06:23:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/649: fix various problems
Message-ID: <20251231222357.lqtaiigycgdy7v4l@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <176590971706.3745129.3551344923809888340.stgit@frogsfrogsfrogs>
 <176590971773.3745129.6098946861687047333.stgit@frogsfrogsfrogs>
 <aUKFBx09MGp4Z2bu@infradead.org>
 <20251218041232.GW7725@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218041232.GW7725@frogsfrogsfrogs>

On Wed, Dec 17, 2025 at 08:12:32PM -0800, Darrick J. Wong wrote:
> On Wed, Dec 17, 2025 at 02:25:11AM -0800, Christoph Hellwig wrote:
> > On Tue, Dec 16, 2025 at 10:29:56AM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Fix a couple of problems with this new test:
> > 
> > It looks like this patch got dropped again?  While my git repository
> > has the commit ID, I can't find the test in the patches-in-queue or
> > for-next branches.
> > 
> > The changes themselves look sane to me.
> 
> You might've pulled my for-next branch.  IIRC I've never sent this one
> to the list, so Zorro has never seen it.

I just checked my mailbox, I didn't find an email with this subject or even
with xfs/649. But our mail server filter out some patch emails sometimes,
so if I missed your patches, please feel free to ping me :)

Thanks,
Zorro

> 
> --D
> 

