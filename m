Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9EB1DE4C2
	for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311634; cv=none; b=kbQpJDXg7Dx3IMZ96txiu/vouLBbD8WkKWGzmqP9z+ntRoIEOLw5+8pwinYgmCWMq5goAHmQH24cIKL8h+bT+t+h/fyl41bVyPZNxhtRy/SMSHtVnt1C6OpZXdznAehb1gZDL0aihXbSXM2ZQocLipNQ7Y7fjMRcIwu6FVqbG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311634; c=relaxed/simple;
	bh=1g9Vn8vUYkeyfW2ReVxm5rhQgEWHTYAewxXV6l8y3l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1Ii/4ejs0pBVCePhE42RO6YjkWsLa/evstAVie9Fnvcb5gUYzLTPLzbFueYrGhlbesknIZfrcDuOjt0wuicSH2qHUJ1fzjqI38x46Qjj+FpcuvqVCJVwY+4V2FKfWkKsw1x0OSdxMMfIaVDlEut7ztahGYzUaOl7ntC/sEhZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4rl5lid; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4rl5lid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756311631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cwNiRJTjMRRioAduLilkZsCzG+/w58RGIIyEpO+5NyI=;
	b=a4rl5lid1NgNliwRX28ccu7VRpjJembb5/TZYD8Bq84bSVuxHBzyWZjGiboCj9grFZ2pY1
	zg6F445B1wMaordui5c3E/gNGJthY33+phT85aG8RtWARgwLlTAWOZobH38NPYXmIUV/mb
	7oB/GAk53K49YB4KFUIMUj8/a2OCuAI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-388bf5zPPeCAO0gO7SmqAg-1; Wed, 27 Aug 2025 12:20:28 -0400
X-MC-Unique: 388bf5zPPeCAO0gO7SmqAg-1
X-Mimecast-MFC-AGG-ID: 388bf5zPPeCAO0gO7SmqAg_1756311627
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-327706e0642so46135a91.3
        for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 09:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756311626; x=1756916426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwNiRJTjMRRioAduLilkZsCzG+/w58RGIIyEpO+5NyI=;
        b=NtfRuGoPjeDNpRiFnARuw6N/YWhqusQytQMYfUn/1+MDtCxpB7zjr8UEHHiTGsZnQh
         ZJUQiMSfjHMpdWtyyrnxPNAveKHTTQRsTBfJrW7MzFfKV9FswD2I16HOh/XJzzinLZq5
         aFQ8AH2EtU4MT1XBDJJrCVngvu+ILUX5gCshG3fbHyokgkE/LtHCBh9BzSGZlZdSFlu0
         cIUcOQnW4DaK/bkk8FgsWIJ3pPT40fqRGci5PcXJMleT5p+l4Hc5uYqO9qLSIdqdtGcE
         NRwJ2HIWEdU4I9CdBYXhWzAVm9IJA2PoFdESYNGWXplUb1puvG1hxZlAdICBJPh4BSRS
         8BMA==
X-Forwarded-Encrypted: i=1; AJvYcCU1XhJPnVT7xtl9kruv1Rc9vO9Oao2Q9/WPqBCmpuEiWkDI4w7Xl5J8mUZE8XCYR6+HrZIgpNbf@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTRv+yj//Dj+KUtzjvbbSeJ7q1vxNGnlf9pTPQGfCsKTSUFmi
	Flj5C4cvdh6sxTIuvrf2AjGf0CCq28RAPd5XOzHSb8uLZ8JhLgRaHh1lR98oUWi8X1K1bolGj4G
	3DioY7HoW5AadSg90Y8BP7mSO0pH9hSKqP/M+aw11Q4vBmoh0i+tBu68AbHg=
X-Gm-Gg: ASbGncsU/4H24JX9cYk9gtRfHnSTaU7f89+bN9rFGwgD5tCpWU+0jD3li3bsg1S/Auh
	zEzHwA3fqyxcdPfyYObD+6tZAGFxmiLZEEBO7g4spi+RYqvIaBvzq3kOpvW9cgrJchdGPkAtTMA
	NMPYt2kT4lROvd0YCEosJRol1JLaaZvbG4maH5lUCOIugs1N3MMXI66Q3BRRPomCzqML39F9MM1
	eiwqhm+DzrqWHAN9TE3+KXyGTxqmhAqUXaBF/dkSYZpmHOILtC5fjTdA5r47SaO8yeqRUVq7Wxg
	xJd2R+mNIAYKeTrJixgAXVIIlXal+YAH58yAvoV+SfRsnm659nJaXA+XqjoiwOWAuyNnt3JZwoB
	X+xa9
X-Received: by 2002:a17:90b:3901:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-32515ec131emr25432616a91.23.1756311626611;
        Wed, 27 Aug 2025 09:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTUq0fxzh2SXFL1aHXeQW3WZGhYfge5VUtEOKqibStuGQtlIFy0MvEDUBLHVqLUsFXuekpKg==
X-Received: by 2002:a17:90b:3901:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-32515ec131emr25432592a91.23.1756311626226;
        Wed, 27 Aug 2025 09:20:26 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5925adsm2448049a91.10.2025.08.27.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:20:25 -0700 (PDT)
Date: Thu, 28 Aug 2025 00:20:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] dmthin: _notrun when dm-thin setup fails
Message-ID: <20250827162021.emhti27jux4bakvr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250818072724.1559133-1-hch@lst.de>
 <20250818072724.1559133-2-hch@lst.de>
 <20250818205131.GD7952@frogsfrogsfrogs>
 <20250825154410.dt5avycrauhtd2te@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250826132230.GA1870@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826132230.GA1870@lst.de>

On Tue, Aug 26, 2025 at 03:22:30PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 25, 2025 at 11:44:10PM +0800, Zorro Lang wrote:
> > > Anyhow, failure to set up a dm-thinp volume sounds like failing to meet
> > > a test precondition, sooo
> > 
> > I'm wondering, if we choose _notrun when _dmthin_init/dmsetup_create fails,
> > but others _dmxxxx_init/dmsetup_create [1]  fails, we still call _fatal. Isn't
> > that an inconsistent behavior :)
> 
> I think more notrun would be fine.  These are the ones I ran into
> with a totally normal setup that has PI enabled on the test and
> scratch devices, so they were my priority.

OK, the patchset has been merged into patches-in-queue branch, will be pushed
if no regression from it. If PI enabled devices don't support thinp related
tests, you can exclude "thin" group. (But we might need to make sure that
the "thin" group is added into all cases use _dmthin_init.)

Thanks,
Zorro

> 

