Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2521598EB
	for <fstests@vger.kernel.org>; Wed, 27 Mar 2024 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546662; cv=none; b=IVCBRjG6OdaRqjEc7rv3xcMlYajveq/JxQ00lFaYagYKFAqeFtnPyWWQTaCbBOXEd5tuUpSrZ5YJD7lTa9O1PYJWs03r4roX8kzlYwjwpGW3ci1WESXTc9Qw9+sk1BkxxBKiR/0RTGXgs24wssOLclxO/crxIwqfeDmvDx+ZrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546662; c=relaxed/simple;
	bh=T0OuOfqK+Sh9vITWjtn5UWtHDCh9Sz3rkuhNleAjrj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1ihWpwb55tPPHb6AmPFKySVlCUlxAxiLOkmR/HUqTvp279JJC2ra7PlZTBxOj+xmTd7i/h1ckYIBKH9lCLerm24L4r7xD9vG3T2puwONF78uF6dwu+ctYYxhm0qxfpNdv48YXgTbi/Dl0PvUhYa9frSLKUcSPRHf0CBI0Nkio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPGXOYK9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPGXOYK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711546659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYcpvlQkMRgSYon5/5H4M4hhbmQVd9vDrzANDvntUjw=;
	b=VPGXOYK98PK82eaPcS9x/QO+FD2zorfTkfWmZNcHaKPcxtWbUoeQX36Na9KnGSLIdIinEx
	gv/i+TQ88mgtrsM+Q8ZT7dJ8/uFaacQZA2aT6Bdqu8kK4/fM7BcS36doUjyXHEqM9rRon3
	qTHu35x0MsAKC1J2bGVG2P3bNPeD0v4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-85jx4rIfNymd-HVrKKZaJg-1; Wed, 27 Mar 2024 09:37:38 -0400
X-MC-Unique: 85jx4rIfNymd-HVrKKZaJg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e0f50354d4so7222515ad.1
        for <fstests@vger.kernel.org>; Wed, 27 Mar 2024 06:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711546657; x=1712151457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYcpvlQkMRgSYon5/5H4M4hhbmQVd9vDrzANDvntUjw=;
        b=AKTC0K+oiCtLkmTq0kEUIjCpPP82DiKH5LxaQ+99oc9Tkw9alHGsaturae1a0EyeCY
         4qe4Zn/UBDWqlUYEh0HjUSB0VhCrwv+RvMOrDgTkTFL/RVK7lQqPzcuQqRhS0vMzfhpX
         RCLJ3uvYLhRb88+A23FuEIrEtRoH506CViJovD8iav0tLZK2W+AUhKmd/jwqrHIbos36
         Jzed81t6jIP9yBC4Vml8ignI8K43njnD/uNNMwP9vr0cO1uw6kteQYkasGPP3pkXTuCo
         zarqDw0u73SQqyNOT8WjM9JE+EBlDJ4R772GFA2wpl5C/TFwXeObJHvrhfUPIZK+3aZI
         EwkA==
X-Gm-Message-State: AOJu0YzUsZqVe5GRHBj27wyAmVKWJZwi7RPFb+Xw1XJoaA1Hevkp6a/J
	clSnC7HbR+VRg+iITJQnAjqOt737+tY9dqzr94acVbUNg4bzGYk1f66fB46FLt0yBr4Rkt4C2+6
	xWApQmdNoa2vCKFbHx8+uPyaWBNR2BGhDSiLtsDOCNmAfTmd3JRo0ALo=
X-Received: by 2002:a17:902:cece:b0:1e0:b5ee:e9cb with SMTP id d14-20020a170902cece00b001e0b5eee9cbmr6841885plg.22.1711546657063;
        Wed, 27 Mar 2024 06:37:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGExWZjtADkajIpzPdg6Z1MPdxJkMLWqmfDw/IkZGPcaU19J4/jbBSgqN/aYRfl/OtycFegWQ==
X-Received: by 2002:a17:902:cece:b0:1e0:b5ee:e9cb with SMTP id d14-20020a170902cece00b001e0b5eee9cbmr6841852plg.22.1711546656544;
        Wed, 27 Mar 2024 06:37:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b001e005a58237sm9208789plb.93.2024.03.27.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:37:36 -0700 (PDT)
Date: Wed, 27 Mar 2024 21:37:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: Re: [PATCH] xfs/558: scale blk IO size based on the filesystem blksz
Message-ID: <20240327133731.f36a5wtz7hoe7r5b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <CGME20240313203828eucas1p22e2b127e8597e2e72397f26370c54b42@eucas1p2.samsung.com>
 <20240313203818.2361119-1-kernel@pankajraghav.com>
 <7f1c749d-069d-4a42-8b87-637f2dfa6f5d@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1c749d-069d-4a42-8b87-637f2dfa6f5d@pankajraghav.com>

On Tue, Mar 26, 2024 at 06:20:27PM +0100, Pankaj Raghav wrote:
> On 13/03/2024 21:38, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > This test fails for 64k filesystem block size on a 4k PAGE_SIZE
> > system. Scale the `blksz` based on the filesystem block size instead of
> > fixing it as 64k so that we do get some iomap invalidations while doing
> > concurrent writes.
> > 
> > Cap the blksz to be at least 64k to retain the same behaviour as before
> > for smaller filesystem blocksizes.
> > 
> > This fixes the "Expected to hear about writeback iomap invalidations?"
> > message for 64k filesystems.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Tested-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> 
> Hi Zorro,
>   I checked xfstests/for-next and didn't see this patch queued up. Do I need
> to do something or will it get queued up for the next release?

Oh sorry, due to this patch was in a patchset with:

  [PATCH 2/2] xfs/161: adapt the test case for LBS filesystem

So I don't know if you'd like to have them both together, or merge
this one (with RVB) at first:)

If you hope to have this one at first, I'll merge it in patches-in-queue branch,
then have it in next branch.

Thanks,
Zorro

> 
> >  tests/xfs/558 | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/xfs/558 b/tests/xfs/558
> > index 9e9b3be8..270f458c 100755
> > --- a/tests/xfs/558
> > +++ b/tests/xfs/558
> > @@ -127,7 +127,12 @@ _scratch_mount >> $seqres.full
> >  $XFS_IO_PROG -c 'chattr -x' $SCRATCH_MNT &> $seqres.full
> >  _require_pagecache_access $SCRATCH_MNT
> >  
> > -blksz=65536
> > +min_blksz=65536
> > +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
> > +blksz=$(( 8 * $file_blksz ))
> > +
> > +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))
> > +
> >  _require_congruent_file_oplen $SCRATCH_MNT $blksz
> >  
> >  # Make sure we have sufficient extent size to create speculative CoW
> 

