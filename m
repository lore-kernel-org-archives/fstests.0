Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420628DD1
	for <fstests@vger.kernel.org>; Wed, 12 Jun 2024 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169030; cv=none; b=Vg+n3kT7IsgbBj+fk5VWjvinb0+gC88yjFBSM/LdGjOFqabU7wBMIFr/CEJMv6qjvZXvAmyXThDwt/ODiGVnemXcU1tjYB9XR+pDNG5QXX8oCRWyBh55wmQGLrcRKi3PCbLPswPBLzAgfxRx8MqiJXKP0yGG4ZEfpBgU5BxbZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169030; c=relaxed/simple;
	bh=uG3PRDvxXyt1S+6DCcSBA0cIRQNsjyN2p8uC+jr6c8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPVPsnJ40hHQ+Fvx81AKosbd5bgO8I3zt5cbgC/GCQxT+GTKHIEvNI0xAboZZ5xJafPPScG9uwFnGPMBJ5ATU3sFdEBWkKh8JL7RMbvqQO7pqrwMiKKgWNGOvnKEzWDu8/K1QInUC7r2DwwL0RgMglRC08Ry0q76FUCnvx89T0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0yb1Veqs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0yb1Veqs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uG3PRDvxXyt1S+6DCcSBA0cIRQNsjyN2p8uC+jr6c8k=; b=0yb1VeqskNybfdsN8VZWF0GDgP
	nDAgGGwRNeC2VOyPP9YwziMAE//x6j5QXanCqXrFiw4B7cVTHtNNC6KDTnJHco/LvqotSfJGH8Ptw
	IqRUDw6GzXbtfz7SiviSFZxeurKgKKOq7ebS7w4z+8jB9A9LmDKRqO/AtNC1nL0F6NfD9XKfhkiSG
	q4kztjzUCrLj4EYe3mHU3UDbTBGL8NFutpBDWaEau0F1YrTzasO+5HR71CBnSNTV+KlTJKmgZT5lQ
	fZV6mY5u9w0P+6NTeofhoDSgU/c4vjarHVIsAon0w1MwMlj5ssjyjGRL++dsRwZ9BpPak8mIIUkm2
	s/4pdcIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHGFf-0000000B6ds-2S3k;
	Wed, 12 Jun 2024 05:10:27 +0000
Date: Tue, 11 Jun 2024 22:10:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: Re: can we pull in git as a dependency for xfstests?
Message-ID: <ZmktwwRvXOVOvTeg@infradead.org>
References: <ZmfjlWGk04r_R5j6@infradead.org>
 <20240612045824.6x3itjgnlkebq67d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612045824.6x3itjgnlkebq67d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 12, 2024 at 12:58:24PM +0800, Zorro Lang wrote:
> But there might be some incompatible options betweeen "diff" and "git diff".

Yes, many of the common diff options are not supported.

But I think the md5sum version from Darrick work just as fine, so I'll
wait for him to submit that.

