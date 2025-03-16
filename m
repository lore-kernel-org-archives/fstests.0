Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5FEED6
	for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143373; cv=none; b=ZkIqdFiSiqEbz81mmurUnKD6zjghsLxXZ7ybBpflu9tIXWItDwz0unwR/TUg6/w6gc4V5nSBZsWRISYppd2039zs+bEgcGVI5zrQFZLuqz2HWUFjz/hTgOa3MXY0koqEG500R9AMT87/LqGsE6TIqGcRoU58Qk8cPGue8657z3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143373; c=relaxed/simple;
	bh=dzq0y8RcI0YtRwvcPI7irr7d/7mB4nsTCKyWX6/g9tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP+lMYlEIrBy4+Jq3mRDy/b3mcg3Ywkn9QRvo55L0o0udMHcM64Q91ZrVom6zOcly/HDXjLuVTeQ4ERsYRFWCEwJILY9RILuO3MVwrrliAZ8mJQxa9b+zInBFIIPBv9y9KRg8rhBRRg/cE+VkSs0W/Yk9LYTdBv8u9ZWWD1cWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CT8lwC0a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT8lwC0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742143370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2aeyOWc88W5/3VkSR++QFwIKtJq6IRMPEuNTaxQoh8=;
	b=CT8lwC0aKZfU3ojPEPHSr3qDBbW0nzhIE3n0cVh4UA85BkGSiGmpkOHQFkQaQQGEHRL9D1
	KwlW2Tg8uY4AIZQ8TCyKZR0obkTW1cTdNM+n8seigu9zU//7MMPviSu61mN9syIi5yyEeg
	gQfcyzj7PsxGGnY5Q9srCgsIzvpN90w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-INd1oI14Nwqy22vdtbsr0Q-1; Sun, 16 Mar 2025 12:42:48 -0400
X-MC-Unique: INd1oI14Nwqy22vdtbsr0Q-1
X-Mimecast-MFC-AGG-ID: INd1oI14Nwqy22vdtbsr0Q_1742143367
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22403329f9eso54474945ad.3
        for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 09:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742143367; x=1742748167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2aeyOWc88W5/3VkSR++QFwIKtJq6IRMPEuNTaxQoh8=;
        b=DVuZZHXZk7AFLfk1ZD/Tn0zKxnaVSqzPkDgJZxdt85jton9ch6rpkfjKeLf3G5Q9J4
         Dpy0pDJLCYdVA3fvDjcKL2d4EIqyoMmxABmSdE4yWRRItyj+VOu25zIy4+08loL//x0A
         2guKyr7vI0jKBU5KbZjQ4/s3xjV8R1phgTydQg72HUthYBKPy2c9yAn6MgviXK774hP0
         w67g5yv2b87+SJDAZth6H9xEWCOwxSI/RPUl0AI4X82y+MSncDoO737bTKUedxf6Lq1t
         1QhnsWYQLpEV8Rd5Tgk38XeYuK0AvG/GHjWPV8DuQ2pSzoTaN6YTiweLIU0AkfsMno2f
         sjDA==
X-Gm-Message-State: AOJu0YzHiP+gAPOP+tfYI+Qus4A9NasWysb0tMKel7SPKpLZvC5kFOEd
	86v/av8bQhgtp1LwR0p6AC8DVdjpyTtqLQdPnO6mq7jR8fy4IIl5XDHUl3EwPIRTlJwOC66albE
	GGFrnxCu0A+K3x6e3EHXjYtgElqj5yngYqvg7Q1gd6Z8oxCMkbBRZv0g=
X-Gm-Gg: ASbGncs6UOCN8ffC5OjMmkDCsDceoHJSpe2gYSUzyqintKQPWyzjVKNEVq4GaUR+kp1
	+v97Juu8vEn3ktehcFDxmN1WICqtGQFxV01b5l5JL3WQVK294GDmAEotek4DL/q5x8uwpnPFJCk
	dK03HfySunG9wSfypRC2RfAnOAQ8SXrjLxcNpvrFPQQITWJEXWbRgIhIywP5unUV1hOE/KEFCRm
	c0cxdn2JqEVVYYf8qkaC8ZKVVPH/SqQRaW0Q4ZFpivkrsr/Ipzt6KHEHAsPaSD/ARuJH0DjQUus
	Bt/4bH+fN5Wz4wdOyacPKTEnwb8ZgfuEaXt/tWKassiEGvxnetLIQhE9
X-Received: by 2002:a05:6a00:4649:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-7372240beeemr11797394b3a.18.1742143367464;
        Sun, 16 Mar 2025 09:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk6VqUSWDLfti/hQUkWstmkjALewG5sUlOGeosXZZ6e21AQQXCtn4PqzJM9F+HJKXF+UYSnQ==
X-Received: by 2002:a05:6a00:4649:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-7372240beeemr11797383b3a.18.1742143367143;
        Sun, 16 Mar 2025 09:42:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152958csm5976297b3a.26.2025.03.16.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 09:42:46 -0700 (PDT)
Date: Mon, 17 Mar 2025 00:42:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/7] lib: remove random.c
Message-ID: <20250316164243.5ppcm2csb6qq2oxa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-8-sandeen@redhat.com>
 <20250316145423.c2ws6hhrozl33czv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ce0de787-1017-4b5b-8876-bff6adf4952a@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0de787-1017-4b5b-8876-bff6adf4952a@redhat.com>

On Sun, Mar 16, 2025 at 10:48:50AM -0500, Eric Sandeen wrote:
> On 3/16/25 9:54 AM, Zorro Lang wrote:
> > On Mon, Mar 10, 2025 at 01:29:09PM -0500, Eric Sandeen wrote:
> >> sparse points out that lots of things in random.c could be static,
> >> and upon doing so we realize that nothing in this file is used.
> >> Which is unsurprising since these are all part of the standard
> >> C library ... so just remove the file.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> ---
> > 
> > Hi Eric,
> > 
> > When I did the fstests regression test this weekend, I found a regression
> > failure on generic/007 (diff output):
> > 
> >   --- /dev/fd/63	2025-03-15 13:31:35.044534292 -0400
> >   +++ generic/007.out.bad	2025-03-15 13:31:35.002455111 -0400
> >   @@ -14,9 +14,9 @@
> >    .........................................................................
> >    .........................................................................
> >    ....................................................
> >   -creates:  18736 OK,  18802 EEXIST  ( 37538 total, 50% EEXIST)
> >   -removes:  18675 OK,  19927 ENOENT  ( 38602 total, 51% ENOENT)
> >   -lookups:  12000 OK,  11860 ENOENT  ( 23860 total, 49% ENOENT)
> >   -total  :  49411 OK,  50589 w/error (100000 total, 50% w/error)
> >   +creates:  18839 OK,  18890 EEXIST  ( 37729 total, 50% EEXIST)
> >   +removes:  18783 OK,  19951 ENOENT  ( 38734 total, 51% ENOENT)
> >   +lookups:  11858 OK,  11679 ENOENT  ( 23537 total, 49% ENOENT)
> >   +total  :  49480 OK,  50520 w/error (100000 total, 50% w/error)
> >  
> >   -cleanup:     61 removes
> >   +cleanup:     56 removes
> > 
> > By bisecting, the first failed commit is this patch. After removing
> > the fstests internal lib/random.c, the output of src/nametest.c is
> > changed too, that breaks the g/007 (xfs/188 maybe too) test.
> > 
> > It fails on all filesystems (e.g. xfs, ext2/3/4, btrfs, tmpfs, nfs,
> > cifs etc). I'll defer the release of this week (03.16), hope we can
> > fix this regression next week :)
> 
> Oh no, I'm sorry. I thought that if this stuff was never used it'd
> be safe to just yank, but I clearly must have missed something.
> 
> It's probably best to just revert/remove this patch for now, so it
> doesn't delay any release.

Sure, thanks Eric. Not only generic/007, generic/311 fails on this patch
too. I'll revert this patch, then release fstests.

> 
> -Eric
> 

