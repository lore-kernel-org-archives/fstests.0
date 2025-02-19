Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8E4C6D
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947280; cv=none; b=mEAVDOpNo6aenzZ85MCAMDp6LbC1ho/s5QRBQq34yKV8pqSC/B3mDaA4236g5Ocz+dkxbtfjJnrjtE5TaN0dZK2hRgFNh5Q66HBsxvWzUq7tF1lJ1sfp15tHtZqLdjnkomkBv4N3oaj1gP44WIKCfB9sLu3hA87Ylj/n98FEYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947280; c=relaxed/simple;
	bh=5Kyoa5YN3oQqn/A46NKlBkHD2hUWT9oyDy3W4nD/0qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbYLJTL8B8Vqni8B/r4a5tvZ60i1zNIAXz9jgaJiKqdSIreXbU/JmOn5jF8Hnd0EKp7j+mR1vHj97bhWXhJHoVxL1nU7/n0YPJZUdPt9xwZM9QbGvfCOwj8iB5ocCGo4x2S9SVS2j5H2y9rvS4qIfGlbZymIMnUFY+tWmP+5V1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4e38XkD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4e38XkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739947276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evSYPpOTPugg+COw4LKkl+7pmDrY9ljC5M8ckK3PohA=;
	b=G4e38XkDHiMmmaYUMvMpNagM690fS2QvVzUihihJ5Y0CdOmFB3cRrz8HvFL4G3jdVDYBXa
	JEHGccplhMrrct7yBrS3AIVOPDUXKp5TfQNLizl0M979wx5DjWcckINrp85kUU8VCw4sNx
	p1MNjbOF0Irakvy2K7gp6tay147QfME=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-HiPuWacwP5yJzm0TcUNqLw-1; Wed, 19 Feb 2025 01:41:14 -0500
X-MC-Unique: HiPuWacwP5yJzm0TcUNqLw-1
X-Mimecast-MFC-AGG-ID: HiPuWacwP5yJzm0TcUNqLw_1739947273
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc3e239675so13650269a91.0
        for <fstests@vger.kernel.org>; Tue, 18 Feb 2025 22:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739947273; x=1740552073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evSYPpOTPugg+COw4LKkl+7pmDrY9ljC5M8ckK3PohA=;
        b=QTprDaSaneFU3SG8vGIKGG8poaA+wEPtVCxYdv3cVHdc/bXjrpDwYAwYANqbGvD+jm
         pWTYC01Q1U5FHPA9avbGJlQ0mDwsaoyuOv5kOp3pxBX356GDtumBumEIYRXLrHDjs4/O
         ufvul8iQGSBDIh9enzKC//4dmD+sr1tcn3gdUh3WtD9wws+Epas+mpSYPLk23YniX2wD
         U1zgcGRMSKDmQB3A0o7cFPzk3RpA+1jw+BlSGjn5Nruz4P74ch+vwnEuIpdO0HCEFmrH
         5kv6+mMAn596kG05JfOy9judJ+wd50fQIoW/aPDXThgz9jL1ZTWJL/KZvQ3PLKyyAhGR
         8rZA==
X-Forwarded-Encrypted: i=1; AJvYcCWm3M3avgZxWboeOzXhA92TGNq/8vHn+3zjVVWIWAqw5qY86Z+EQybDln5QxWmq2L2+GNJnd0QY@vger.kernel.org
X-Gm-Message-State: AOJu0YzlthrCw1nJwkJvQANaxFNsccsZsBYY594g9D/WnH5BvHTbCMNd
	65XnvZ/7+90iQ0BiFv6UmNfXUkM+ewBspSZkqitm+I83NMai1J/hlA8e/0RDpfPDGc7YErlW73h
	Z5fSZ95YGzTKRdwYtN6jzKeeWZxE20dbwtpr2iNr5T9fa/I/fBqltHL4YbJB4lYTg1w==
X-Gm-Gg: ASbGnctStQ7k3CY9aS1o+ISkyclPZIsd9PozDWmZP9JZIexz54KZk0vybRPfkU28YJx
	yfo/NPmNAkWcLLASmwUPd9lAUsjPP0JFxRVjUgpbc4djJdkkhDKs9UWXCcSWlAM13fx7MKxrdnI
	5k04xvpo+kzL92Xkl9kZJhut962bvhYDWDb7uxlvxsKOmMbWAKcwMzSmv9rqMJh0eFN+nFHRjFG
	5kurMVbR5g7wjQl1OkqwLJNx37Gg33MkFxjnsU/NeWnGXYEtYLL8jdkLRP9cF/VqlwQGrLVCkKr
	9j6SfDQZa8zzthEOv2M0CxjFyfgfQ7B02d04usHxz+mPLw==
X-Received: by 2002:a05:6a00:3c91:b0:730:97a6:f04 with SMTP id d2e1a72fcca58-7326179e966mr21515827b3a.7.1739947273180;
        Tue, 18 Feb 2025 22:41:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE52geqXap1WxboLD+mSo1V37VEDlv5/3hziriQDM+m39MsOhQgP1It1KNBXdD39FiH3cBqqw==
X-Received: by 2002:a05:6a00:3c91:b0:730:97a6:f04 with SMTP id d2e1a72fcca58-7326179e966mr21515802b3a.7.1739947272762;
        Tue, 18 Feb 2025 22:41:12 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265098570sm7550095b3a.22.2025.02.18.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 22:41:12 -0800 (PST)
Date: Wed, 19 Feb 2025 14:41:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/370: don't exclude XFS
Message-ID: <20250219064108.de3tdkwus6xq4kz7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250217063135.3728305-1-hch@lst.de>
 <20250218173912.GK21799@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218173912.GK21799@frogsfrogsfrogs>

On Tue, Feb 18, 2025 at 09:39:12AM -0800, Darrick J. Wong wrote:
> On Mon, Feb 17, 2025 at 07:31:35AM +0100, Christoph Hellwig wrote:
> > Skipping tests just because a file system is broken is always a bad idea
> > as it hides bugs.
> > 
> > (Fortunately despite hiding the bug this is now getting fixed in XFS as
> >  well).
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  tests/generic/370 | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/tests/generic/370 b/tests/generic/370
> > index 8adffd2e9650..8101ef42724e 100755
> > --- a/tests/generic/370
> > +++ b/tests/generic/370
> > @@ -22,14 +22,6 @@ _cleanup()
> >  [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
> >      "btrfs: fix swap file activation failure due to extents that used to be shared"
> >  
> > -# Skip XFS for now because this exposes an issue that is hard to fix.
> > -# See the following threads for details about it:
> > -#
> > -# https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> > -# https://lore.kernel.org/fstests/dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com/
> > -#
> > -_exclude_fs xfs
> 
> Needs a _fixed_by_xfs_commit XXXXXXXX "xfs: flush inodegc before swapon"

OK. _fixed_by_xfs_commit is being prepared, not ready:) I'll add:

[ "$FSTYP" = xfs ] && _fixed_by_kernel_commit XXXXXXXX \
	"xfs: flush inodegc before swapon"

Thanks,
Zorro

> 
> --D
> 
> > -
> >  _require_scratch_swapfile
> >  _require_scratch_reflink
> >  _require_cp_reflink
> > -- 
> > 2.45.2
> > 
> > 
> 

