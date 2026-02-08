Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E2323411
	for <fstests@vger.kernel.org>; Sun,  8 Feb 2026 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770580254; cv=none; b=Awha0KxJMkuw1xW9TlY14LWgK1HVuKzg7K0VEt7Fxe6Vq4hkGitn/nyP2XBxWVHGDavE+3FAB0Z6yF3MlQ7D6FxAi8J4tgInaqStIFYAYQ6j0Jy81zZibA1wMwvk9IqGpGwiaq2NDoH9bbUBJvLTHbdKYysK4prQMe344UCaXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770580254; c=relaxed/simple;
	bh=bDsPoOJueL8XsE2CPxjd79nZqHqkLGzOO4tCqDgpNu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKPFuohxB90ztBkhdKNWyrO1fKFvD63tSRjF/bsY4XAHIqKf3PS2CHFBRB+HqH0ab86m3PzhPMdvn3yDNkq55V6hz8eCovQU2Je6lMlKNDBoPUauUHk9pRySot1pAf9w4JxV1Xndvj7+IMUoDTbCKnSHB3GViI8ftIGZ0mF9NzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgngRxUp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikIgRF2W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgngRxUp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikIgRF2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770580252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuUQIPzLp/vHpvT0mZgO8hSxVZ3ISHyaHpQZdkLEjf0=;
	b=LgngRxUpfSG7GkoC7QkEwWL2TBYrqB5KtRZIxsuCCxyBcACROgOYdyMgBak6gcBfNFqV5t
	RqvPKjFcuP76z8830HE4x/3CLBuuHTo5XXx8+E/NXzABymSNMVtG9Kexdo6rBoNmbARbGO
	BbZBK0Tmp47ashd1ayGYxxxgKlswe4E=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-vJVYfuljOvGf7wKR2mVZTg-1; Sun, 08 Feb 2026 14:50:51 -0500
X-MC-Unique: vJVYfuljOvGf7wKR2mVZTg-1
X-Mimecast-MFC-AGG-ID: vJVYfuljOvGf7wKR2mVZTg_1770580251
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f42368322so2331841b3a.3
        for <fstests@vger.kernel.org>; Sun, 08 Feb 2026 11:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770580250; x=1771185050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kuUQIPzLp/vHpvT0mZgO8hSxVZ3ISHyaHpQZdkLEjf0=;
        b=ikIgRF2WlJF4fqJ+Q2bLCO+Qfz7xF+bIbQUnncHr8PUW0UG+Tt3xp5YJPv50hSPB39
         +zr7jCbzeOqsu9yyhl/dkKXYc2NUQwc4TUDgEXaUv9YsrPcXzdRP3A8bx93/ZRUdjfJj
         TAupAwQq7nDXcPPhQU6wIF7XgtY653fSFNGegiTA3pT/3ENBtj02X6afQy9NgBHhkw4a
         Epgc12clWyjzYUxqG0GVGx/+xDG55hHv+eGpOGtNbVNmd6pjgScZcFLqKJ96qu4oOoZE
         TbJ+/0XS4Mu9ZO7vF+G8l9wgz0Upj9jiKERmp9I2L6f70QdhJF/WUvqoRePkaa5vdWl2
         pNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770580250; x=1771185050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuUQIPzLp/vHpvT0mZgO8hSxVZ3ISHyaHpQZdkLEjf0=;
        b=Z6Roz3w3PcMSmQho4XivxtRryCrk+Iqac5akktrr3dSB37O9W22HML7ZmjedQlawra
         qNCDI8XKr/bnqURgiULh3GN4mwmvSl+8M83sBsREiW0aPQB2BqdGzZgFbk7g5EHtqc5R
         /mJGy/JIRI25vwdVn0vD4A+7+s2ZH7fpRd6fRyKOK21y+jIjvuxoqbR9J3klJbhMV6cd
         p0ZWqcJgdRRvpf4fYOtCfZzsl5Yd4aE7c8kFuwwI4FFAhFJ7pLOKGWeTXlirw3BrCDcd
         GxVb4xzL/YX9MX40RxT5NBgSmnaYkzcb85MXXPZSzC1GvNOYVTdfutVH++rgGmu/q4L2
         LsZw==
X-Forwarded-Encrypted: i=1; AJvYcCVfBSgOxMPOsr2xmeLWBrYwh/cszUfbdRr9WbPRHvT/M4ZbCDvqTq3JimmPm8Wun/cgu+qh8ph7@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkXSU9zD0Amn4bM1fHptqwcLfy7o0cUktWcKpZaLZphrSeNWn
	sRo2jx97RDGqbblzGVu54Ym2G4X30jf0POvJdd8Pk2yNCl5GOA2Gew21YBSPONFWjuG0Z1nlEhI
	Fp+XuAMWw8sY6ICbPqG4IETFKM5XoEOvNvUZb7EuD/+AqpT4rs/2e20LdcTA=
X-Gm-Gg: AZuq6aJehxuHwQW+vJ938861tEx/ZrOnYB7LGAYEPOOuMw8XtAYqRFa4btgvtp1/o/T
	tkzOUN2DJjanICyypn8uqaQocExU7s8fV96VcgygQc0NXehWpbmjoKxJH+8PNJsuXeR8RX07oBQ
	zBNQLiE7uxezsk+PQLpvMkXTWWrOhs9cTkHwsYkbjuew3iOgyg8adfhgZFQ6vrkK9F7ynbqc0/1
	0S9oElW2mtIEinYRT5rEdz3Mfgbeiq0B0LIZQ7z31vjq8xZFEtbHr+hul0bc4WuvSErRhvbD29+
	oaYKhJYud03QvfG0lVKeOY49/eWHJuqBZ7F2Kp9Ym/cuvGLkAUaVOMLvimuOEnFnyxOoLkXyE89
	6RTOD0Ud7/vuWnTfRXzmqlumDxMy/g7LkXA4jiuAZHM+TUvOi9g==
X-Received: by 2002:a05:6a00:4215:b0:7e8:4471:ae55 with SMTP id d2e1a72fcca58-824416e3e25mr7454920b3a.33.1770580250612;
        Sun, 08 Feb 2026 11:50:50 -0800 (PST)
X-Received: by 2002:a05:6a00:4215:b0:7e8:4471:ae55 with SMTP id d2e1a72fcca58-824416e3e25mr7454897b3a.33.1770580250141;
        Sun, 08 Feb 2026 11:50:50 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dda030abfsm5911093a12.32.2026.02.08.11.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 11:50:48 -0800 (PST)
Date: Mon, 9 Feb 2026 03:50:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Chang <joannechien@google.com>, fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] common/rc: add _require_blocks_in_file helper
Message-ID: <20260208195043.vhvkanq5pysbb74y@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260108022501.754320-1-joannechien@google.com>
 <20260110013802.GB15541@frogsfrogsfrogs>
 <CACQK4XDtrE5P-PjwSqvGtmEmMvEQS4r2KZkDh55LXY2YAoH6vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACQK4XDtrE5P-PjwSqvGtmEmMvEQS4r2KZkDh55LXY2YAoH6vw@mail.gmail.com>

On Mon, Jan 12, 2026 at 11:20:36AM +0800, Joanne Chang wrote:
> On Sat, Jan 10, 2026 at 9:38 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > On Thu, Jan 08, 2026 at 02:25:01AM +0000, Joanne Chang wrote:
> > > generic/735 attempts to create a file with nearly 2^32 blocks. However,
> > > some filesystems have a maximum file block limit below this threshold.
> > > For instance, F2FS is limited to approximately 2^30 blocks due to the
> > > capacity of the inode. So add _require_blocks_in_file helper to skip the
> > > test in such cases.
> > >
> > > The helper uses a hardcoded constant instead of a programmatic method,
> > > so that bugs which affect the maximum file size are not masked.
> >
> > Not to mention trying to create a file with 1,057,053,439 blocks
> > allocated to it would probably take forever.
> >
> > Hang on, we're talking about iblocks (aka the number of blocks allocated
> > to this inode), not the maximum file size in blocks, right?
> >
> > If so, then maybe this function and its comments should
> > s/blocks/iblocks/?  Or am I confused? ;)
> >
> > --D
> 
> If I understand correctly, generic/735 creates a large logical file, but
> the actual physical block allocation is much smaller. Also, the F2FS
> limitation is about how many blocks the inode can address, no matter if
> the blocks are actually allocated.
> 
> So I believe the requirement is about the maximum file size in blocks,
> not the number of blocks actually allocated. Does it make sense to keep
> the name, or do you think another term would be clearer? I appreciate
> your thoughts on this.

Hi Darrick,

I think Joanne's explanation makes sense, if you don't have more review points
on it, I'll merge this patch.

Thanks,
Zorro

> 
> Best regards,
> Joanne
> 

