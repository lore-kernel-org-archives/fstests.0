Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0734DB66
	for <fstests@vger.kernel.org>; Thu, 22 Jan 2026 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066652; cv=none; b=LbpAasDLwm+waUaLmdO4c9qm59C8wdwsr6999B4D8SXnIcCf7E5utzB8hiXA9QwuPaXFl9rYdfP+/TFHYFyOBgqubCimvCyPBmKHFDSgT/h6gGkzocuJzLyOWQEeS0SkUsfkAc1FYFwNXUESqiGXNQS2Hqs5fPzuahGkUfjXMVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066652; c=relaxed/simple;
	bh=172JT68suLbRiaUvm4UHX4l87LETpak8ZQmRO6NP+7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjMtzeK1TiDAtW+z/5s/rhsG0EyvifG10MU97v8L83Mxg11Ty2AykmLjz6KrmIXrb1GDVG4uZT6rbqOV0qMG1taODXxe6vxPBWMVzl5PgZZlvTErQMW+r9yNyGUkF4NMBUJt653OZ3BIuuZ/KEP96JmtpdRAC/Gq3hfo2Rcl4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhTEcClD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKmg1WZP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhTEcClD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKmg1WZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769066647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLO37hiRAITaUWMr8QKw+c+4NjeAKh0G2D9ETj7y60k=;
	b=WhTEcClDlpdLvCqjg8bdoIMIJ8eUL+xyV7gsviqcqxkw98lTEgwjqko1NlDLJhTPiHtvzD
	jPDR4M1lqm0wbHTdHu01P5OiyZdSd/4ptFIJ0R9hSLrHVmQCZbQDdufeVSc4hv1AiGeSa1
	EQ92dpGCoKcZAd0jP4dR8Jxnssd+s+o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-_1KgX75FNjixP9k56Byf6Q-1; Thu, 22 Jan 2026 02:24:05 -0500
X-MC-Unique: _1KgX75FNjixP9k56Byf6Q-1
X-Mimecast-MFC-AGG-ID: _1KgX75FNjixP9k56Byf6Q_1769066644
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d6193daso1337326a91.1
        for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 23:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769066644; x=1769671444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLO37hiRAITaUWMr8QKw+c+4NjeAKh0G2D9ETj7y60k=;
        b=AKmg1WZPWRF7EKFf50u1v+UHW0h0KCXytTLh1ay7yV2rFRUkhi9Un/gmycvD2ay0Ds
         Q4uhTwbub/L+Jwzg/OEo3atNPvdm3PtBX8edHqBKn8Hby1JsT1vKt89rJUUGoCoUdwav
         OmjcJuOMqMYkK6dvYyeJ1txQ6WfntSAnq0Stzhx1EJNHPfF8abdO8o+M157wdlvavgeb
         6kfOXXppKGx0G25X4bzSFQN024hEqUA92wxj8WpPm0RwET9wix7UMhWbyLFfXTg2QjsZ
         IYkWdqkBHHFvamL9SGlwv35pG1P3Yio50kFO5+LLhHolRgnB3csDfHrHirn+b9pq6png
         O/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769066644; x=1769671444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLO37hiRAITaUWMr8QKw+c+4NjeAKh0G2D9ETj7y60k=;
        b=Y4btBWoiJtVTwZ5EVdAm9NbUrSkHVVnxgheTYskHfAMNeiAZ3oKXXgHpMZ+3uM55fd
         WFL/sQl37IaDJfou3r41CZ99lmSRFzcsOqU6rm5QRGS1MFok2utf/R5R8LxYSrNE3JCN
         AYmXKJgRg07vcea2Uj2MdY6jfKnaUNmZd5ww9areAesBfBBkOeORxS8238UtrS8+raTb
         7+Nm4biEs0znAm0ThD26nXPD3piAZYIdYdLsnaqlqwn/YOcEUSJwDR1LyioFIpr83YhX
         +2yB221WQ1cYcIPiv3mqLE7kY4TtQQ/IpJkC0pbhulM+Quwwut6PYEWZMwrxCd/XpcCk
         X4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXTlxHvXNqPJh+dyOXoewAnQmErG9b9R09zKVkGEnCr+VVEpwOQ7jJCvI26U3AELAosDe06P7i+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5h7fJwwiApPCJxaEMSF/ihWLiLwjm2aoRJuCs8kRxvUBpjWfd
	LN6RGGacua4vrYzrVepQtwMaO/sQ+y0xpUOH5Fru+2WQEuL6pa7UDIR/BDxDdfJIIUgZ/IHRiw5
	qksGr051tdxDNCadCB62dShW1eioBLl27DcTsfhegYw1jKo2JeGWrPnhQXa0=
X-Gm-Gg: AZuq6aJJSxA2QBRPh+dfZd1fI8XJWBivOiewBDib4v+BWFiWb8mIBms5RBQWxUmXzmB
	K+0dQ7kkke0TIiJastIdVdMhpMG6syJA9EIAHZFL0CUkOGXNKPJFxpep29bjRLZ1riKX1Tx6QT0
	z8fAZjwcCe+Nfta5H1QFsleVMfFtf/cKdJgxSlZ+Owek+wq6+uurLQCGO7DDN1KdZXKQbZDqxvO
	LxMCLBcqv0SIrv1PD5GMI+O+ThjCQrUMAnmnI/aCeVgeBvfE8770/jAAXJGbvWeEOnH4WCYO0xo
	ZqecWocS2039HY1fx2jbDNuqk+2ZcXUuy1CuIsx9Ug6D/vUxWIWEiT5phpDr8cXCObjuZEbp2vg
	WHQw5B+Z67nABW0wuGf/L+iLhlZVXvvFrvq/srzUIYFyXRJZBeQ==
X-Received: by 2002:a17:90b:2884:b0:352:d168:fc4 with SMTP id 98e67ed59e1d1-352d168127emr5037110a91.32.1769066643842;
        Wed, 21 Jan 2026 23:24:03 -0800 (PST)
X-Received: by 2002:a17:90b:2884:b0:352:d168:fc4 with SMTP id 98e67ed59e1d1-352d168127emr5037095a91.32.1769066643398;
        Wed, 21 Jan 2026 23:24:03 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3533525a1a0sm1529292a91.14.2026.01.21.23.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:24:02 -0800 (PST)
Date: Thu, 22 Jan 2026 15:23:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, ebiggers@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test that truncate(2) on fsverity is blocked
Message-ID: <20260122072358.4sujn2ygbt7zycqb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260119062404.3998871-1-hch@lst.de>
 <20260121150833.shad4rfhqd4deg2s@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20260122055908.GB23964@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122055908.GB23964@lst.de>

On Thu, Jan 22, 2026 at 06:59:08AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 21, 2026 at 11:08:33PM +0800, Zorro Lang wrote:
> > > +	dio-writeback-race unlink-fsync truncate
> > 
> > Need to add this into .gitignore too :)
> 
> True.
> 
> > > +_require_test
> > 
> > Does this case need TEST_DEV and TEST_DIR?
> 
> No, just copied and pasted.
> 
> > > +$here/src/truncate $fsv_file
> > 
> > _require_test_program "truncate"
> 
> Ok.

Thanks Christoph, BTW, as you said "btrfs was missing this check", so is there
a known fix/commit related with this test case, if there's, feel free to mark
that with `_fixed_by_kernel_commit` :)

> 

