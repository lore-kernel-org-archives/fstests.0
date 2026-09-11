Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8153444713;
	Fri, 11 Sep 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110567; cv=none; b=Zv2EvH+PYXern7tbkpGIuU3VYpgpFQ70h1JPsSM1rrBB4K897AKOXM+I4r/RaTJ8fgFgbcU5LSjUnc4cHhLOCy2BSTMIDOXXr1JVqLfbtHdw12bKDfFSTibkwK85/ESSuZ6yzcUeD1VeUqr+fNGUldvdiBr4NHVf3FL9KGcY+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110567; c=relaxed/simple;
	bh=5x8C5HgP3mJEavJ3aUILs2A6y85obuPkf713Mg45P3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7vwrCecqTCvTDSg4ZY0Rk2YQLKMCLp44I4MF8LDd6YNl3HGwTe0/Rr8QKR7zrJdCR4avPFs1yc5Qm3iArAFuFK+iegp/6KXVTuWoz67DmwixBAtIRI9dwefw7JARH8GVx4sfL+NcPRGvV97k//XEOyFbQrZ19zP6Izj/lG385k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s9mqUqHB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s9mqUqHB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hTkHs+49b/cKUxFnftbApDZcQW8H8+gZmxbMV+ntYRo=; b=s9mqUqHBdjfdnQb+WVBm+W8Gvr
	Tg+9P9ZgtUsgdITyLkNxIxXzswLXCBw4Ng5A55WNZtQS3n8F7ZKSbf3zCSm+WkhHW2q6yfpsfnIbr
	WfD2IfqQY7kRREF4X3YauJ3U/beNhkJbB6yg2a0yhjc7XXrybaQG9Nbudoos0nxVJhxSIlvDkk7Rn
	M50PZ9ER6D2BTCn1PETzl6D2vklc+06afRhhbdXo6DliWPWazl85Di1hqp9fflYVgdrdiDRnpQcG0
	8IvIYzax2+0PhBS/AY7L+NfKFLrzdNZuVK9fmsYT6pIsLJsXUiWj81e25h6Tn5EKLznh1OJYLVbOG
	rtk3ngpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4vNs-0000000G0Bf-0EpB;
	Fri, 11 Sep 2026 07:09:16 +0000
Date: Fri, 11 Sep 2026 00:09:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@infradead.org>, zlang@kernel.org,
	fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de,
	vdubeyko@coreweave.com, linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Subject: Re: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
Message-ID: <aqOpHAoHDRzHe9UL@infradead.org>
References: <20260910000449.747189-2-slava@dubeyko.com>
 <aqJ--AqubS-CWiV-@infradead.org>
 <730a395bb6eed86bdff7eb21668f4f1fb42f664f.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <730a395bb6eed86bdff7eb21668f4f1fb42f664f.camel@dubeyko.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 10, 2026 at 01:13:12PM -0700, Viacheslav Dubeyko wrote:
> On Thu, 2026-09-10 at 02:57 -0700, Christoph Hellwig wrote:
> > On Wed, Sep 09, 2026 at 05:04:50PM -0700, Viacheslav Dubeyko wrote:
> > > The dirhash_collide generates filenames from arbitrary random
> > > bytes (only '.' and '/' are filtered out), which are not valid
> > > UTF-8 in general. Catalog names on both classic HFS and HFS+ are
> > > Unicode. Feeding random bytes causes fsck to report "Illegal name"
> > > or catalog corruption that has nothing to do with directory
> > > hash-collision handling, which is what this test is actually meant
> > > to exercise.
> > 
> > If user file name creation manage to trigger fsck complaints, you
> > need
> > to righten the input checks in the file systems first to fix this.
> > 
> > We can then find a programmatic way to deal with these rejects in
> > xfstests, as ext4/f2fs in case insensiive mode probably have the same
> > issue.
> 
> I see your point. And I really like your suggestion. But what is your
> vision of the proper way to check the validity of Unicode symbols?

I don't think validity of a unicode symbol matter directly here.  You
need to check what the Apple implementation accepts and/or what
Apple documents and follow that.

