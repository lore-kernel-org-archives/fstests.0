Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95A17991
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877352; cv=none; b=s/G9QnwQT/BMHEo1C7jrz7KXN0Q/16LrL8NZbTx/F08ggL3EDQqvzT6ThR4Qb9t70It0KTFVCZwhNOPzU0IJaaiSyWh1IM5KKY2egndH48bFqAaeFk0HKVX9L8QaBO65URBwn0cd9aKr0lyejdodKFiJjbU41JWz72TeqQVHiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877352; c=relaxed/simple;
	bh=bWVyG4ooUn4bG6bWqWfbJrqunJLdeEr0h0UomtvKp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqcEGYPppw8NkfWq8qSl0d/L3WJK7BNGQ/ZPNSRH/RfuwVEfAYwHppoDCZFPhDbF1LmQY/9i3VIyvKAQ4TYaqHW6PUxMNf93684FdAxJTNIPp6InUt7yfeFP18S8JoBGM01SwivBJclz9e+zYEj9SMF0vqpJJADaoBfPOqqPj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdvY2ymJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdvY2ymJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708877349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4M+DNtT1zWFOoFWAPUy1ymTQkIScq55vkJSM4JvyW08=;
	b=RdvY2ymJl5DU36bhHKSBU9FGfuXS2Rrjc8K9gTOuI+7vcAB3+kGjHxEfUEL+0Z/Y+qzGDZ
	lzsFjJtxZ0uq2ZKdkLGE1tLVOwRdT9lyom9cv97cUyNrgEi1r7LkFsMfmT6OjkoAssD/pB
	K8J94/KBTfys8/otKXfakQoFgpyiWOs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-ZMr8zYbbO_60sxWlxk8JIw-1; Sun, 25 Feb 2024 11:09:06 -0500
X-MC-Unique: ZMr8zYbbO_60sxWlxk8JIw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e50831226dso274544b3a.2
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 08:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877345; x=1709482145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4M+DNtT1zWFOoFWAPUy1ymTQkIScq55vkJSM4JvyW08=;
        b=gaeWLhCQKv29NpnfJFwiYUQlp94peQUqLsnSOFbPBVz9Be8kDObgADgFShKEXNsGY8
         PDUctRS9KuGDQN+P2YCnbJFPE+nhCiwb8K8gnXfExnDDddCYp1ZLIqoeti2teCOfSPHE
         uP0buw1QTK/51FONnoo+VtSLaeN0Hb0sYoRO679r/F59g4uOn7sWE37jzusjTWG3LyKI
         bgKK42Rm6HLoJnd2IdBmZGJ58S0ZU5tkGIZu1mMu19zz67kTIiWG4B4SdO61iv5Q2yz1
         PE4zSdpdomQWt2oikomIFj2DPczrSL6ht7IxuJxLXeYEwmx1gbW6xkh4SEy/3LNaWesH
         3PHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9GYgK4oGJV7XO6Ia0l3wCx3vurgGl8JS4zekNcvX+/NGC0GdSlgXwuGfAFrtS62m2GSSBeEXK5J/ufN+zar7fILM6SfGfhA==
X-Gm-Message-State: AOJu0YyHD3U5DZ5DARwCTOYjbefmabnHKZqKZqvaAC+SYfDZ/T6UUp/M
	G3uv3/Xh/Hljw5tZw1IdTVAl3GTWRWb3yX6wjcP4hiAVfAECBP1AqxNfuCch56IlA01jOxxJ2JX
	3YJf4FBs5fJrnOzcItdXnLBnZx+2k4VO9uNGzyCELa5qFDWtws3Tbxt0=
X-Received: by 2002:aa7:8693:0:b0:6e4:59b3:928c with SMTP id d19-20020aa78693000000b006e459b3928cmr3576539pfo.10.1708877345546;
        Sun, 25 Feb 2024 08:09:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELhdpuksSCkCVmptASRnZV0pLXZtX48KEkxUmfLHWYV0Z7mnKZWeD/8mPjgbAgBqUzUgyzRw==
X-Received: by 2002:aa7:8693:0:b0:6e4:59b3:928c with SMTP id d19-20020aa78693000000b006e459b3928cmr3576528pfo.10.1708877345170;
        Sun, 25 Feb 2024 08:09:05 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a00238600b006e0dd50b0d0sm2485386pfc.8.2024.02.25.08.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:09:04 -0800 (PST)
Date: Mon, 26 Feb 2024 00:08:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
	anand.jain@oracle.com, aalbersh@redhat.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, kdevops@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH 2/3] check: add support for --list-group-tests
Message-ID: <20240225160859.tqbs2ltiqcj72ozj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240216181859.788521-1-mcgrof@kernel.org>
 <20240216181859.788521-3-mcgrof@kernel.org>
 <ZdLNJD5pYaK84w3r@dread.disaster.area>
 <ZdYosXHe9ec04kBr@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdYosXHe9ec04kBr@bombadil.infradead.org>

On Wed, Feb 21, 2024 at 08:45:37AM -0800, Luis Chamberlain wrote:
> On Mon, Feb 19, 2024 at 02:38:12PM +1100, Dave Chinner wrote:
> > On Fri, Feb 16, 2024 at 10:18:58AM -0800, Luis Chamberlain wrote:
> > > Since the prior commit adds the ability to list groups but is used
> > > only when we use --start-after, let's add an option which leverages this
> > > to also allow us to easily query which tests are part of the groups
> > > specified.
> > > 
> > > This can be used for dynamic test configuration suites such as kdevops
> > > which may want to take advantage of this information to deterministically
> > > determine if a test falls part of a specific group.
> > > Demo:
> > > 
> > > root@demo-xfs-reflink /var/lib/xfstests # ./check --list-group-tests -g soak
> > > 
> > > generic/019 generic/388 generic/475 generic/476 generic/521 generic/522 generic/616 generic/617 generic/642 generic/648 generic/650 xfs/285 xfs/517 xfs/560 xfs/561 xfs/562 xfs/565 xfs/570 xfs/571 xfs/572 xfs/573 xfs/574 xfs/575 xfs/576 xfs/577 xfs/578 xfs/579 xfs/580 xfs/581 xfs/582 xfs/583 xfs/584 xfs/585 xfs/586 xfs/587 xfs/588 xfs/589 xfs/590 xfs/591 xfs/592 xfs/593 xfs/594 xfs/595 xfs/727 xfs/729 xfs/800
> > 
> > So how is this different to ./check -n -g soak?
> > 
> > '-n' is supposed to show you want tests are going to be run
> > without actually running them, so why can't you use that?
> 
> '-n' will replicate as if you are running all tests but just skip while
> --list-group-tests will just look for the tests for the group and bail right
> away, and it is machine readable.

What do you mean "replicate as if you are running all tests but just skip"?
Sorry I don't understand this explanation 100%, can you show us some examples
to explain what kind of job you hope "--list-group-tests" to do, but the "-n"
is helpless?

Thanks,
Zorro

> 
>   Luis
> 

