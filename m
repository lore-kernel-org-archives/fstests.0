Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5984DFE
	for <fstests@vger.kernel.org>; Fri, 21 Jun 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990444; cv=none; b=FreE/q0D0zhfbXJEud0Vodon1+Ts+VsLuP5hiPebMtDn7M2g1WlSljFlQ+I7HLbMYcTX1MXzuaAx6gAbsfhRgkm7cgnOVpnrS0MTKvR63Xo6eArPgjps9UUMcoMwwx08p+sAXaRpsDed29LXeYyQDgVVRN7SugBMmOeWX8rO/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990444; c=relaxed/simple;
	bh=s76fpLFLMOfLJ1wET/nz6mIX5hz2pLZweUGOogB6bwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9AlZaBuy0imuQhkUDppbBibrmUNsUoKCEvTBe5bGAB5piSFF8WTkw+9UWKHy0rI1JEtRRfCXON847UmtOd54DDvoy4kaw5JGbMegOoYH4VfLkboU1brv20jhqubjNlv+sotyFxfLfT/xBGqzvKyrrVZ/r5N9RYwDrkEucHnh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fb8+n6hw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fb8+n6hw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718990441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc+WxK4RSwvbDVXPwUm+KwbPzHMSQoYdxMjYxRV3o8o=;
	b=Fb8+n6hwjCWi3XxhOJp7XOAeOwzHZ5lCDzfwlP3hC22VZ5ZrlRtt3nxtrjVCMCGS7r5VR6
	JZdPkxKJqnZR5dSIXQvhsKgHt/odit9xISR9CXAP9O3AqtjcY1BZLfWaquxRiinaHnXh0N
	HdWnE50UW8SdQhf65w/U0+Qn06utSrs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-SrjygsdKOmOSsS1BBBdRjg-1; Fri, 21 Jun 2024 13:20:40 -0400
X-MC-Unique: SrjygsdKOmOSsS1BBBdRjg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-702599d5dedso2435689a12.2
        for <fstests@vger.kernel.org>; Fri, 21 Jun 2024 10:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718990439; x=1719595239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc+WxK4RSwvbDVXPwUm+KwbPzHMSQoYdxMjYxRV3o8o=;
        b=Eqp6vwCyNhv+85IDVe1IPxkhLHkPaLntJhNlbxAdu5EWuolXoMakKPCrhw/8aeJiaF
         xWitL45KAhmQlzYyx4w6pDyXx8NiIYGdCZ6luWAhpPoxAxDPLgu85zmkHYjBeXihNxq1
         PIHBbwV/JgLplEiGOPTE8ygT8f9UijGndZo2uEELWGzyHrFrbTbSKBf7jtWPDCxephWr
         5hfF4VY/cJj0y2R6Xj9LRtYxMw62RYGr98DDujiUKIjHG4CYt2a2xi1k+xjGgXmXPKfk
         kplxSR92V8lcm7V/2mJFN6X5idPHA4V8Y9YtE4CYpcgxbT7xL6ukjPXvaff0Wl1dcXp2
         S6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVl3JY6kIH4y2fckq7472GDR+yPqxygIU6u1VRYIUZNxmhV0InpOEqqqNy6ZJD4K+7KP715kAKl7sgAce+bbgzb9wbMbZauZQ==
X-Gm-Message-State: AOJu0YzEVnCTrFeN2HfJOJvkW8h+oPJXWbX2wHPVJ7GhblkC/hL+N/9i
	Q8kcDHXwLb8ta7oua5HFsUni5ZIJRE7gmOowQi3CS6F0qVvwzU+MB4q3fSiOrJU/Jj5hdL5oZYi
	l0xzAvCjKqbQPzGmNiQSwdr/wYWOe0b0nteZb3pXXXboHx2ThoiHYD3c=
X-Received: by 2002:a17:902:e844:b0:1fa:449:1dd6 with SMTP id d9443c01a7336-1fa04492142mr7378525ad.48.1718990438698;
        Fri, 21 Jun 2024 10:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgh6rbfZ+cOajX/3iN6CBi2KP2Z5fU8wSFfRO3yhV/EuTGpEcYYCkAvO3EXLnRz6fldt61nQ==
X-Received: by 2002:a17:902:e844:b0:1fa:449:1dd6 with SMTP id d9443c01a7336-1fa04492142mr7378295ad.48.1718990438166;
        Fri, 21 Jun 2024 10:20:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f0505sm16553745ad.12.2024.06.21.10.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 10:20:37 -0700 (PDT)
Date: Sat, 22 Jun 2024 01:20:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCHBOMB] fstests: catch us up to 6.10
Message-ID: <20240621172034.qemkrzrpxif37tot@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240620205017.GC103020@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620205017.GC103020@frogsfrogsfrogs>

On Thu, Jun 20, 2024 at 01:50:17PM -0700, Darrick J. Wong wrote:
> Hi everyone,
> 
> This patchbomb are all the fixes that xfs needs to bring fstests up to
> date with what's in 6.10-rc.  Except for these two patches:
> 
> [PATCHSET v30.7 2/6] fstests: atomic file updates
> [PATCH 03/11] generic/709,710: rework these for exchangerange vs.
> [PATCH 04/11] generic/711,xfs/537: actually fork these tests for
> 
> everything else in here is fully reviewed and ready for PRs.

Thanks for big updates!

This patchset is big, I've merged and pushed all these patches to
fstests' 'patches-in-queue' branch, feel free to check that.

I need more time to give them more tests, will try to release fstests
at this weekend or middle of next week.

Thanks,
Zorro

> 
> --D
> 

