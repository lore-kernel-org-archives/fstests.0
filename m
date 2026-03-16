Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673433F360
	for <fstests@vger.kernel.org>; Mon, 16 Mar 2026 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686455; cv=none; b=UQKa7JNDSOIL4Eo1q+vNJ5gUjwLY2d74GLSI6XtvIFsskt55xd9Z1p9klHaqy80907/SsBKXnMwkHPIN/dMrlGrqBZ0K1eQaXFCttDa5qCKWIeyHe1hR3LiYyzW8XSnR7Iu71ZX8h7rn634FLtrKmiE8K0kBCxyi7Jv/liLxtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686455; c=relaxed/simple;
	bh=QidtBix1KZQxoTs2FPcZqmT6gEHQJGYZjnLMkHeIxbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYhkCCJZUV1si/oPoOPFUbH9zm3cMGvcwSxUdQGBD/Up5t/PCHqTfPnp9FkcV4sHFTr0JEsd4RMy9by2ZbkTHFuKbh+HGmtcH1pAp7a/zzErgWcFdc3WXoI15R0rWVYOwpSkya5IXvyewJg9fKPPMb0XAcL4ziQzSLSaIP6i6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2xpHAyV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ltoKmtNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2xpHAyV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ltoKmtNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773686450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zg8GjY3hLi9qO5yTJ9QjTKSpRjIDRv4OW1ON0/sXxR4=;
	b=d2xpHAyVUsby87Aojz1iZS+fGVWDUcv4XGPM2Dr+igd1d9xUfvYGihdWVBaZq+fbrCBIXC
	syiPj6ZgU2x9BYY7iHNThKN/oiDIy4PRKvVklfBlNnfdHlWZusepIycDIgmdC168BrEet5
	/CeJlk84qxRiiBz5WHUsv+a7s6JcTgY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-srv_zUxqPCmu5foOntmWnQ-1; Mon, 16 Mar 2026 14:40:49 -0400
X-MC-Unique: srv_zUxqPCmu5foOntmWnQ-1
X-Mimecast-MFC-AGG-ID: srv_zUxqPCmu5foOntmWnQ_1773686448
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35b9246248dso2014363a91.0
        for <fstests@vger.kernel.org>; Mon, 16 Mar 2026 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773686448; x=1774291248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zg8GjY3hLi9qO5yTJ9QjTKSpRjIDRv4OW1ON0/sXxR4=;
        b=ltoKmtNxV9EH7Haj1s2C2U37IlsiDPgpRmtZtM8fDAKOLvD+VfkTwtW4cphR6M1I1H
         IMOTNcKP4kesXOcgYi7JiH0IIeYxshktUkfZBetZZSO7s37bUwNBs0Pb/0Z66URUMEZt
         O992Zxxgr6tM/IhEOVZhuayDrhjZk2RhfKWO6zDd88K2Mh85Z/QoxKTzgsWwalv60ecQ
         53Xb5NRZ0HQLwUFRXC2D063+e7GIpOp2PVat5m5dNkjx5oX5pgFoIHduA3GbqS3nGKo6
         uQxbAZ5i93ksb10N+hyTvRIueRk9/em/hkQLmn3hAo27geHRYBB+YjxeRZTP6HMy/8Jm
         6YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773686448; x=1774291248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zg8GjY3hLi9qO5yTJ9QjTKSpRjIDRv4OW1ON0/sXxR4=;
        b=WuOQRoYNCu9jHbdw8jIKfEGjlekEz+5eiIMtfhhnmXduyA6pCSvQT3I6PENvvIDyPm
         sgxnToAiYCzxPiP/XZyKSVOSpL+X1+bY9GMNeI+y74ayOkqqfPYr5AiZM0K4kxXOj150
         P6l7gvfOfPLWBCVkBIXZysduX405xz4VCoryOU6hmHiU+frMc5A/1cnxOGLfmXJi1Q8f
         bdk+1iuZFFcKvfPv0zhYaNNFrAjZk5ERXTf4BXyhdoegA/2jQ1N84uGdygyIF6z1QIIJ
         yFsD6IST3B9APVB+GYm8ZoCQoTzuO1Dw4BlMIdAn63W4n44qk41GvtBcPHTQngxTzVVa
         PezQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPDotSxH4DUe42XNFPw3Sn+M0DpnRddIcYUc4UiZO1F1IAeMIhO8KRbhLwen8Ua/11FuMuBFn0@vger.kernel.org
X-Gm-Message-State: AOJu0YzcunqYuxPndYs/QL3DcMl9qW/sgnaPXZ1fHDgjbcoOf/eGGz3o
	w3HeKXTt2oBBK+8+9VJxiCB1JIqe3xNvBnMBQmk4CmAzjq7bX9WQnWNedepmrnVjWNS/ectZltD
	Duw9/2kbxml4xNCCTR51d0Z0pSg7FBm9knTAdPV/9EobY5BUe19DNGdU/1ER2a296Meg=
X-Gm-Gg: ATEYQzwuDSf2dwESgPM1rH+/8Wz8arNgEY4uJoNWfWVgKeo9dLODmh45dXipplSC51o
	efArT/Pp3LRpTLGkq+1l8Gh/eTFzsz5hKx5CwVRsUNoV968KLuIkmtHtDsxq7UivXoRvBYyPIMt
	Jv05cwDLpH3CftKcd/8+N8wc6OY0jfUHjeoX+oXAbHrImKJoVy7SoHQ5zdNhfxAb0mVHUKotK+e
	H1r+wECYIUMOxrUepwZEaK0qr0SINMnlalNVplN3hG7C0iA+mRLqm/mHgxOjsQUSqAeJsjhGxc3
	ewJSs39sX44WNjdnX6EEAcj5+u8Tnid9hWyuvAhthtdaxA3MJqrma0P8nHe/CLy2k8CLte6Psm7
	eMy3NXOJGzTvKQuCg7w==
X-Received: by 2002:a17:90b:4b05:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-35a21efd272mr11767647a91.1.1773686447979;
        Mon, 16 Mar 2026 11:40:47 -0700 (PDT)
X-Received: by 2002:a17:90b:4b05:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-35a21efd272mr11767629a91.1.1773686447508;
        Mon, 16 Mar 2026 11:40:47 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada2bfdbsm363654a91.3.2026.03.16.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:40:47 -0700 (PDT)
Date: Tue, 17 Mar 2026 02:40:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, jack@suse.cz,
	fstests@vger.kernel.org, amir73il@gmail.com, gabriel@krisman.be,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <20260316184041.ji5slfx4yvtfwwzq@doltdoltdolt>
References: <177311403420.1186306.10503664469609309721.stgit@frogsfrogsfrogs>
 <177311403440.1186306.11707487947646813883.stgit@frogsfrogsfrogs>
 <abfIexgmKjS1Q7bN@infradead.org>
 <20260316162147.GW1770774@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316162147.GW1770774@frogsfrogsfrogs>

On Mon, Mar 16, 2026 at 09:21:47AM -0700, Darrick J. Wong wrote:
> On Mon, Mar 16, 2026 at 02:08:11AM -0700, Christoph Hellwig wrote:
> > On Mon, Mar 09, 2026 at 08:50:08PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Test the fsnotify filesystem error reporting.
> > 
> > Still would be helpful to explain what is being tested and how and
> > the source of the test tool.
> 
> "Use dmerror to inject a media error for a file's storage, then run some
> IO and make sure that fanotify reports the IO errors."
> 
> (I'm not sure what the process is for updating commit messages once
> something's in patches-in-queue...)

patches-in-queue is a scratch branch, I always re-push(-f) to this branch.
So please feel free to tell me what do you want to update in this patch
(I'm going to make the next fstests release soon:).

Thanks,
Zorro

> 
> > > +#ifndef FILEID_INO32_GEN
> > > +#define FILEID_INO32_GEN	1
> > > +#endif
> > > +
> > > +#ifndef FILEID_INVALID
> > > +#define	FILEID_INVALID		0xff
> > > +#endif
> > > +
> > > +static void print_fh(struct file_handle *fh)
> > > +{
> > > +	int i;
> > > +	uint32_t *h = (uint32_t *) fh->f_handle;
> > > +
> > > +	printf("\tfh: ");
> > > +	for (i = 0; i < fh->handle_bytes; i++)
> > > +		printf("%hhx", fh->f_handle[i]);
> > > +	printf("\n");
> > > +
> > > +	printf("\tdecoded fh: ");
> > > +	if (fh->handle_type == FILEID_INO32_GEN)
> > > +		printf("inode=%u gen=%u\n", h[0], h[1]);
> > > +	else if (fh->handle_type == FILEID_INVALID && !fh->handle_bytes)
> > > +		printf("Type %d (Superblock error)\n", fh->handle_type);
> > > +	else
> > > +		printf("Type %d (Unknown)\n", fh->handle_type);
> > 
> > 
> > Isn't this always going to print unknown for normal xfs mounts without
> > inode32?
> 
> Yes, though generic/791 filters out the file handle and (TBH) I don't
> really want people getting ideas about cracking file handles.  Probably
> we should just eliminate this whole part of the function, but that would
> make future forklift upgrades from the kernel harder.
> 
> --D
> 

