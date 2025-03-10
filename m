Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DE84E1C
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594002; cv=none; b=G4nXzFzGo8j9gE0G0sGGFDI8bejtDAtamRMKwZlLdShbCLs/4fQ+YVApovNZ014kQyq+Uz5B9aE2QFbyiZ+2BIPb3xhOoGHRAKYJsCkjjhO1W5dBmyfBUv3JUmqnCNzcN3UGhW/gY05+IopoBpUzc1HlQdmmCPJGoMsosN91mwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594002; c=relaxed/simple;
	bh=93W6ybCwcYA7AqE4AGQacqgIe8KHvftkYc5f4XtCDwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3bT3d9pgdRid84FgYst2pIgCFBOr/lYPo0Z9T6I5sgVo2wBtaGqte7INLkPa41D+jJ8c0a9bNQrRvkalWR+IFMRvVgRbxnHRm4hQxePRTcaRZuGADzjgYNHw3zBbicC55fiK/XHaZK3GTdvZVmoQrBNdxnW1mgcC4UELHhL/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJt47uIL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJt47uIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741593998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCOLOU56jiLb/4wdgy3TIcrzpp/26Wu5xoarM9qeWc0=;
	b=SJt47uILYl6R2MXsYZ1KOD2Bn5YjlR978EL9Jm2iJ2TyY/X9Bsr+KqQn6q76CXZr6IMLcZ
	OfnYBhR0ugsk9rdfDpxs1aStFbTt74nihdYuKb+MepgZSljOlZvqia/Es9pUUwacHR39fx
	mjpOC7PfDQITpK0yMKSFqaLJvRx+/T8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-urUqFqcbOSav_fTNNTme_A-1; Mon, 10 Mar 2025 04:06:37 -0400
X-MC-Unique: urUqFqcbOSav_fTNNTme_A-1
X-Mimecast-MFC-AGG-ID: urUqFqcbOSav_fTNNTme_A_1741593996
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so11950076a91.3
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 01:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593996; x=1742198796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCOLOU56jiLb/4wdgy3TIcrzpp/26Wu5xoarM9qeWc0=;
        b=TAyLgsVXEtA62WNuuIb5rZ8W94qRqlf3jskTF1qnsasX8VBXie2U9UHdoRyq2Q2DZk
         T+TGO/dHwd9MefrqB0gweoh0shSY3PxE+ir443X75P7aDNLwaZyd3ntZ98y4ovCLT3y2
         kaIBpF90sxiES9uQR2I+oEFZn6JQZC0T4BRYhAWeIKnVi6O54UAZMr7o2RBpCu5EL45S
         7cWaLZ8Ix54zRWiKfEH+jgG73o73dBZU8ce3pQFkA1YPaQfaee1JKhb5IpC3KF7qoDYn
         Rm6X3BCZpvDIKNE2/vGtYjoJMjFzzjZ2OqnKLmevDZkhL/fZXMdGLxj7i3EfKsymksgK
         LXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN9XUp6h2yBYTT2MzBn57vwYmZ0qqPQpTNkXsBZPqvCpYWw3GOfKaJaCpkGhB0YcZW6PyFh3LR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xRxRD197E6FMCYhxJCoUinw1omN+Rhd5kgnG6Gy8RHYKPCp+
	Vns+2+YQQfqkYONXMApX5gqN1GFV7TOWeaCfrh2+Y0HuREbGW9zkpB/5rqyI0ggdcoPh8RDYZKZ
	mGtTv1H5iJRSXHDKgCelvmKyyEE0E2D05A9KXZ6ZKRRDy6+no+alxqI4=
X-Gm-Gg: ASbGncs2gygCp4Dk+aa26uVzeF6M/W+guSTCWS2BVwoREKdj6yxUWKIN9tOIsfAAwBT
	q4MiEGA0KgiK6PRMvX6LMG7zIgiXa1ZldT4rkTtH+T8BnriJ3bzqXi1BqfTZdf22inlrb6yOLlA
	QdkVZsZaNeqYSzJFY+R942OID0iLvg8NNlh5mO+6FnzKB+e5kreXYCQ5u+tiYAKuxpWkFFmZ4iB
	HkgWErN1zqz4X6k9Ix4lINYhJdMaGZRTDwyO5VQyM/jMMZ9T+ig5VY35CSJC5QSayypBR/DxGh3
	NxUxjrKf6T1XfyVL7APjMmCNG69/CKU/CCddKBPh7XswhoY63sLSS7Y6
X-Received: by 2002:a05:6a00:3d55:b0:736:52d7:daca with SMTP id d2e1a72fcca58-736aaadf019mr20663424b3a.18.1741593996269;
        Mon, 10 Mar 2025 01:06:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3zepBp9E0MRImticocc6MTl8Bx7wo5uHRMcLdiudFO4r9G/SfjZxODbq9kG76X31x/uUrMQ==
X-Received: by 2002:a05:6a00:3d55:b0:736:52d7:daca with SMTP id d2e1a72fcca58-736aaadf019mr20663391b3a.18.1741593995950;
        Mon, 10 Mar 2025 01:06:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cd220c5fsm2495334b3a.55.2025.03.10.01.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:06:35 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:06:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Message-ID: <20250310080630.4lnscrcbaputlocv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <Z8oT_tBYG-a79CjA@dread.disaster.area>
 <5c38f84d-cc60-49e7-951e-6a7ef488f9df@gmail.com>
 <20250308072034.t7y2d3u4wgxvrhgd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308072034.t7y2d3u4wgxvrhgd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sat, Mar 08, 2025 at 03:20:34PM +0800, Zorro Lang wrote:
> On Fri, Mar 07, 2025 at 01:35:02PM +0530, Nirjhar Roy (IBM) wrote:
> > 
> > On 3/7/25 03:00, Dave Chinner wrote:
> > > On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
> > > > Silently executing scripts during sourcing common/rc doesn't look good
> > > > and also causes unnecessary script execution. Decouple init_rc() call
> > > > and call init_rc() explicitly where required.
> > > > 
> > > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > FWIW, I've just done somethign similar for check-parallel. I need to
> > > decouple common/config from common/rc and not run any code from
> > > either common/config or common/rc.
> > > 
> > > I've included the patch below (it won't apply because there's all
> > > sorts of refactoring for test list and config-section parsing in the
> > > series before it), but it should give you an idea of how I think we
> > > should be separating one-off initialisation environment varaibles,
> > > common code inclusion and the repeated initialisation of section
> > > specific parameters....
> > Thank you so much. I can a look at this.
> > > 
> > > .....
> > > > diff --git a/soak b/soak
> > > > index d5c4229a..5734d854 100755
> > > > --- a/soak
> > > > +++ b/soak
> > > > @@ -5,6 +5,7 @@
> > > >   # get standard environment, filters and checks
> > > >   . ./common/rc
> > > > +# ToDo: Do we need an init_rc() here? How is soak used?
> > > >   . ./common/filter
> > > I've also go a patch series that removes all these old 2000-era SGI
> > > QE scripts that have not been used by anyone for the last 15
> > > years. I did that to get rid of the technical debt that these
> > > scripts have gathered over years of neglect. They aren't used, we
> > > shouldn't even attempt to maintain them anymore.
> > 
> > Okay. What do you mean by SGI QE script (sorry, not familiar with this)? Do
> > you mean some kind of CI/automation-test script?
> 
> SGI is Silicon Graphics International Corp. :
> https://en.wikipedia.org/wiki/Silicon_Graphics_International
> 
> xfstests was created to test xfs on IRIX (https://en.wikipedia.org/wiki/IRIX)
> of SGI. Dave Chinner worked in SGI company long time ago, so he's the expert
> of all these things, and knows lots of past details :)

Hi Nirjhar,

I've merged Dave's "[PATCH 0/5] fstests: remove old SGI QE scripts" into
patches-in-queue branch. You can base on that to write your V2, to avoid
dealing with the "soak" file.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > 
> > --NR
> > 
> > > 
> > > -Dave.
> > > 
> > -- 
> > Nirjhar Roy
> > Linux Kernel Developer
> > IBM, Bangalore
> > 
> > 

