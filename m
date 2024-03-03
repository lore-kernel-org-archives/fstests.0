Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432D67A04
	for <fstests@vger.kernel.org>; Sun,  3 Mar 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709476919; cv=none; b=e2tgrLn5j8VpCuzcg1iAj6qaBbXM+iCFhZG0AT1e3u8DCUriXG/utZsPeA5n1ukv1Nxm7abdjQ9J9tNqZbFXdxS4/QX0p6eA9pySLnjz874/aFF3bCemXRqxAnjkcUJVLS5nUGBJ57YRTyhEYC/TPvkQtxF5mVDw7ePp001oJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709476919; c=relaxed/simple;
	bh=SThudsZwnWnGyI6jp7a10bTtZojDmLcZXDe6STXoIc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8D/Et/KyxiJKzkcbuxFRXzuk0x81dXVgYqnD9ZOLNqlL+kghnLPCfIcWVOldJMJEkcqH94aZvGpEhNqft/IsWguGnUCnTivlFGQJSL1+KBwKF+YlBPkDwQ+/pxVo0hxQH6YKMqhXQ9aeqi0mnpBQxsWn6mGPuNd3Kdryzu/4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tn8xtxh8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tn8xtxh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709476916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl2ByWGTuIoJFZHZspKAH0Wx8/n3SIks5Pk2qLRqUHw=;
	b=Tn8xtxh8YFMSDn91paB8WNTGduLxQtQHTNGttRHNz0b1IxJ6PXqa0cQin8jBID3du+cy3Q
	/M3xX/vxmUjKV5DgVxdGklbqgSgUmvnFxMTdDXIxMulRYgaKYrG0hnNvBrwIAVFUIKT1yo
	XVdrqGjPGzP8OGgUXJR6C8mJDnuiQ7s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-oKsfUMG6PAWpRlT6I4Zhag-1; Sun, 03 Mar 2024 09:41:52 -0500
X-MC-Unique: oKsfUMG6PAWpRlT6I4Zhag-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dc0cf01899so36854295ad.2
        for <fstests@vger.kernel.org>; Sun, 03 Mar 2024 06:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709476911; x=1710081711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl2ByWGTuIoJFZHZspKAH0Wx8/n3SIks5Pk2qLRqUHw=;
        b=rieSZlUF5rtzAUPo26cTG6oIxj+Gc7FVRQg6wqXaDxYpB8DSMnejDVR+BIx1hw1GGN
         5pXVx0Cj1tRrfvyMtPj4f/qTmIXbasDKw+CmOV9JYbd85o9tqlZotlEM6yibx/7KYKl0
         Nf7maIOGbBDW+9oGggF0sSzlcDObFOoROAuvZNi3ywFR9+fbo/CR9gMGlLjgxJUr8jVr
         Qym65bHFhXMKYkDZQM66Xz6QvVIBfQBLCs2q55QLNI3hx34IKyaVoN8xltWIL8vzdOw3
         fTzjQBw/IJvbW+xxqvGn19jQsQiqr/SEAR0ishyfUQNNb+7AEb1OF98m4eL9t7WImdYl
         q3Mg==
X-Gm-Message-State: AOJu0Yyz/ugp+72EOyui0jGyc0qp17V0vdaHUP4WwKsGFbCXreaRFYLa
	O0B56GOukWUokMsi7AcY/BwWFa9r2sR3aqsJITt3Xpxo//7D7+Ekg2B0xdW3avVPPphHSY1aew1
	JZVX1yNG2RT8jbIBjYu/XIOYnW0DcwTT23w1vA0ta6kCUhZh828Ny5Pg=
X-Received: by 2002:a17:903:2a84:b0:1dc:ccd3:29e5 with SMTP id lv4-20020a1709032a8400b001dcccd329e5mr9452885plb.2.1709476911629;
        Sun, 03 Mar 2024 06:41:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQI2RXeoq7rInr+07aWOpZQfLoydz35OH36u6e//8L01dmgE0Wq9V8fvL2bPwlGoO13RUxxA==
X-Received: by 2002:a17:903:2a84:b0:1dc:ccd3:29e5 with SMTP id lv4-20020a1709032a8400b001dcccd329e5mr9452876plb.2.1709476911339;
        Sun, 03 Mar 2024 06:41:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b001dce6c481c1sm5122843plx.301.2024.03.03.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:41:51 -0800 (PST)
Date: Sun, 3 Mar 2024 22:41:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] shared/298: run xfs_db against the loop device instead
 of the image file
Message-ID: <20240303144147.rjdc3sbx7wdtghzj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240301152820.1149483-1-hch@lst.de>
 <20240303131048.kx4a4b2463deud7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240303141526.GA26420@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303141526.GA26420@lst.de>

On Sun, Mar 03, 2024 at 03:15:26PM +0100, Christoph Hellwig wrote:
> On Sun, Mar 03, 2024 at 09:10:48PM +0800, Zorro Lang wrote:
> > >  	# Convert free space (agno, block, length) to (start sector, end sector)
> > >  	_umount $loop_mnt
> >         ^^^^^^^
> > Above line causes a conflict, due to it doesn't match the current shared/298 code. It's
> > "$UMOUNT_PROG $loop_mnt" in current fstests. So you might have another patch to do this
> > change.
> 
> That line actually is from a patch in Darrick's patch queue that I'm
> working ontop of right now for some feture development.  Sorry for not
> remembering to rebase against current for-next first.

Never mind:) As that "_umount $loop_mnt" isn't needed, I'll change the
single line only. This patch and the other patch "[PATCH] common:
dm-error now supports zoned devices" are in fstests' "patches-in-queue"
branch, they'll be in next release.

Thanks,
Zorro

> 
> 

