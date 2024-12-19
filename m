Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA351F76D3
	for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586677; cv=none; b=qOPtGj/2+jHMf2A55eQDJ8OpMW6TTHD0avKQyVniDwaBuKmEraczxXdshx9vu2z+p9uOts5qoJPWJM1ntDf56RUdhmEkMWCNqexABXWo201SyR2XFZFFgiUAag1Gm5v/Vv4WHMzJ04jomCBrZoMV62e1oHngmlk3WYN3T3wD3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586677; c=relaxed/simple;
	bh=2/0Da8nAIMVIKxEeIH8D/lRVn2KyToC25xS7XS2N5VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0jEyWTepmHKeowLPPala2g8+HyKviushTIMMfJrl+VABvT5J4xSgR8+Ro7I+XMdoOJsd/qknl5ZnWNfllxM2lS0rYnEjIO0izlXrcd39LFL+9xu7IQx4SLbV+rWxxS6dyDF0j1veYm/C1QQXo1wWeiTNmm6SZ31gvvoQTKh1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t6lIKTGk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t6lIKTGk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7/MX1bBYCRkX8j6P/sGsPnoKta0/UqdBGPrlzq/LH+c=; b=t6lIKTGkXHDMz4pMp24QSdUebl
	LBnuzFj/ldNACDBQHumVz/tiRGEkmF2w4PrDkDsXPba1rDB+hU9/6GBPUWzw1GcJt09GH5xpJSa23
	6IQi3d7wi99dSQZCvK3MuMIzucW4vtiKPfo4qjTgvgA5CBRdhbjqLAhTro7EJxApjxlHgMztrulqx
	DAV1Kqhtxrv+7o03UF04Mo6cgJFAba4EJ6JSvIY4UYINZoQ4uOxaiwNrkxx6U870VCO5FWKr3kWcx
	yw/XPVI49+DHv6eUOXUXMmWIcOsRPCMSHVFvmHKL6XB0zg9Yv722qBk2wFvEiqPBUBhnGuuKh1/lh
	PA4mDa9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tO9EP-00000000sVx-2DkG;
	Thu, 19 Dec 2024 05:37:53 +0000
Date: Wed, 18 Dec 2024 21:37:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <Z2OxMQACnMgmBR1a@infradead.org>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
 <Z2EyG0vqtyTSyM5a@infradead.org>
 <Z2NL_oc5QSscZdZ_@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2NL_oc5QSscZdZ_@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 19, 2024 at 09:26:06AM +1100, Dave Chinner wrote:
> On Tue, Dec 17, 2024 at 12:11:07AM -0800, Christoph Hellwig wrote:
> > On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> > > +if [ $FSTYP = "xfs" ]; then
> > > +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> > > +else
> > > +    _scratch_mkfs >> $seqres.full 2>&1
> > > +fi
> > 
> > We really need to document why generic tests have file system specific
> > hacks.  And yes, that's a request for Dave who originally added it
> > without any explanation and not Ted.
> 
> Creating and then unlinking 50000 files is journal space bound
> when using default 64MB logs on small test filesystems. Increasing
> the journal size to 256MB halved the runtime of this test.

Please explain this in thet test.  And you probably also want to
ensure that you don't force the log smaller than 256 either, otherwise
people in 10 or 20 years will wonder why this test forces logs to
be so small.
