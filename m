Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF17261E
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 01:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749172354; cv=none; b=ZmxtUlwHkdh2kOUUzecZVsDS46HzjE6bkuZLvK7I4EE2ra6v4YvFsyaInW15SxHkykIkO9pYGP/RJ0ElgdG8+DV4axgxwMOScCvSGHUfglM5pAQsbjQxELq61QyZMCfhgM0gxsPs0BP6e72fYYPjGM++Q3o3iEZ4IxRw7zRz8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749172354; c=relaxed/simple;
	bh=3ooHI6FPJCMRAm0ovcKFxMkkwTrgKIpsMgehJU/U3vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib5EsUkKC/YFhXlNGa0B6zAuFpBjIGLOaRNj1aWaL1mxtsVtaSJDoGonytyzURZ/lbRfk9m+Cydj52ySCaJ/zuF8dxDAD7eaZOFEXAtev8by6aScZMaPzQoVUeShDQK1tDf0X0ioLxXZz+ZvRtvPj0dG+YaBD0aJRG3KmQf88mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvx8g/yb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvx8g/yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749172351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HX95HB5ptWt/448FfKgC0KXRWGbuJEkBSek2hhmcx6c=;
	b=fvx8g/ybzakescWhbWpYMKz/i812Jm224ejmvd9Cq9+pwxLNvXVqerZw8mvr2b+0yPlEeI
	Uj+6u3nYlV68l1x3zeWOdmJ6Jju7kiaCe+DOSlWLJ5L+v8O6j7i58JLvb/M8oXtI38Bovf
	wYuJlh/Zp2RuFWUBcmxVthlkq3A8EjQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-6sqjTiT1OS2_KtjzVfof3w-1; Thu, 05 Jun 2025 21:12:30 -0400
X-MC-Unique: 6sqjTiT1OS2_KtjzVfof3w-1
X-Mimecast-MFC-AGG-ID: 6sqjTiT1OS2_KtjzVfof3w_1749172349
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2323bd7f873so13451225ad.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 18:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749172349; x=1749777149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX95HB5ptWt/448FfKgC0KXRWGbuJEkBSek2hhmcx6c=;
        b=D+1c7W7NHcWnj/JOJoq5YLMycU8cO8zEOHoQ0dX3gA36NDmgyZG0FvA7E/9G+vwWh9
         +/WCOP7zeVD4Z5jWjHWJB9C20wWZmFQFkr7YFQR2emKOHRkioMoyy66DSvsLVkUXwoSE
         n1D4JtjJCeCuRI/MCFZBfbj/LFoIIx3MP6kDROGXkXZTerbQJHXgZ/sBEC0mEdmQZd4Q
         W1SGEuwkKB9+qftnbwJApWURjMZ05w5wZwYgidJ37tEvjNJ3mPdv6bOBstse0YuK49Qq
         HVYk8LlDJqkO22V88Oyc/6CWMUfl4+uD+i+B8MCqx3kaNMj6MUVKdh3bOqgPWkvVduav
         aw0w==
X-Forwarded-Encrypted: i=1; AJvYcCWff1fyWGL3GhMENA0degHQQj1IaYpO8qMXHeRIXmqZ3Ru6wAheZsi66Yzr5hj+nfFhlNce80Dn@vger.kernel.org
X-Gm-Message-State: AOJu0YxupbIcIjvPDFQ14QkCHq+hpU82VqrUPCqIz+i7k4UfReiU+kJX
	s42KiHieYedLMirg0uxlk5RkcdljY5SaA8s3HQTheS7FswCi2gKiB9q/I54GFwq6Vzy9OwaVczw
	m4Nt1eDDx2tviWfB71/+nsGM2gUbPKTzNs51xCPBlF32gPX2MKB+iicu9sOs=
X-Gm-Gg: ASbGncvcr7q/j584BR5VMWTjpNRpunvvdTLE+ocJsuXdEZcVgtES3c7mMQXG/tQBb6i
	kmTG76zdHJ3BCV2xWuMnTy9Xa+toWOEnHdd9i0nMAahQhZ9sS3S7b8/gHwavPLDIqgT0waUV6kT
	L6PFOsNWjGcsIMaEwvPble3s7O3EZ1PBQdKNnwk4X9YS7Q0a99wWTVTCndNX7455B3vvy0FQlxd
	qSevWa6RmSi/WFWVkxPhUuQ227xTQruxdgsUtuFXpHKWwiRjqVMquiqC8xKshNBNu5sd2FJto+X
	/qBwUYmlJPV87dL/VjOkEuWO2LuTgYdAoPIDjPXjYp05Lap1N8U3VniDyf21hfQ=
X-Received: by 2002:a17:903:244e:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23601cfddb7mr19419115ad.21.1749172348990;
        Thu, 05 Jun 2025 18:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRZTPON9QJBicej79aRZ7HeLcdoBXyrItjBPAYiGaQ/jSTv7WXBpAacXCL7dgvaln1F4t4QA==
X-Received: by 2002:a17:903:244e:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23601cfddb7mr19418915ad.21.1749172348671;
        Thu, 05 Jun 2025 18:12:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134968358bsm361111a91.0.2025.06.05.18.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 18:12:28 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:12:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 1/6] overlay: workaround libmount failure to remount,ro
Message-ID: <20250606011223.gx6xearyoqae5byp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-2-amir73il@gmail.com>
 <20250605175129.oqqzr5qluxv52m6b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxg2D-ED3vy=jedEKbpEJvWBLD=QYtfp=DCU3pQGGCaGog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg2D-ED3vy=jedEKbpEJvWBLD=QYtfp=DCU3pQGGCaGog@mail.gmail.com>

On Thu, Jun 05, 2025 at 08:30:53PM +0200, Amir Goldstein wrote:
> On Thu, Jun 5, 2025 at 7:51 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Tue, Jun 03, 2025 at 12:07:40PM +0200, Amir Goldstein wrote:
> > > libmount >= v1.39 calls several unneeded fsconfig() calls to reconfigure
> > > lowerdir/upperdir when user requests only -o remount,ro.
> > >
> > > Those calls fail because overlayfs does not allow making any config
> > > changes with new mount api, besides MS_RDONLY.
> > >
> > > We workaround this problem with --options-mode ignore.
> > >
> > > Reported-by: André Almeida <andrealmeid@igalia.com>
> > > Suggested-by: Karel Zak <kzak@redhat.com>
> > > Link: https://lore.kernel.org/linux-fsdevel/20250521-ovl_ro-v1-1-2350b1493d94@igalia.com/
> > > Link: https://lore.kernel.org/fstests/CAJfpegtJ3SDKmC80B4AfWiC3JmtWdW2+78fRZVtsuhe-wSRPvg@mail.gmail.com/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Changes since v1 [1]:
> > > - Change workaround from LIBMOUNT_FORCE_MOUNT2 to --options-mode=ignore
> > >
> > > [1] https://lore.kernel.org/fstests/20250526143500.1520660-1-amir73il@gmail.com/
> >
> > I'm not sure if I understand clearly. Does overlay list are fixing this issue
> > on kernel side, then providing a workaround to fstests to avoid the issue be
> > triggered too?
> >
> 
> Noone agreed to fix it on the kernel side.
> At least not yet.

If so, I have two questions:)
1) Will overlay fix it on kernel or mount util side?
2) Do you plan to keep this workaround until the issue be fixed in one day?
   Then revert this workaround?

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

