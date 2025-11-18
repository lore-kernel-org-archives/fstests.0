Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079A238C16
	for <fstests@vger.kernel.org>; Tue, 18 Nov 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470214; cv=none; b=tPwXlQ0h6kB+vMJlAyj4X/YR4WMCT768HwsfCHA5Aa96lm8nbKuMz/wap9BoNeYRTpw5eqMU5il36J4sDc89ykf8jzB+HzkBoskLpEsUO87ro3mYTnn8F1NKakxMOIkDRRzLudhRGEe8W5Xe7x2N+WTZDmqpINTFZ987chHy++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470214; c=relaxed/simple;
	bh=8BtgZcVczur6eT/NZ5P5NzTh01jSru0pKpvEk214e1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt5Z00PfVSpRAtTh0ilVrlax2edwCiAhKfNCIjyOuzPQXXVFw7P2CCVIBhj0/mOizOOnxWwf0zvIxvNQWqapJ4lRArTv1sEU/w/NY48zdN+3JEBhGXT9rWzEK2qJNRzp5qYVdflhYjIHFi/LXoNEcYAQ5zipMcTFsX6rPNnLfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iZyVTjiJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iZyVTjiJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7tu/4RhZ4PtqkjwvlTEeguYwYDUjCQu0mWV4iDV5l0w=; b=iZyVTjiJYI4+kiBZBFskuLVTXm
	uPNUnQ9/GXbEE+Sj2vGfIhxb99CkJaCMosMYmSgoNPw2TCdXen4mVgTbp/4YqTFD+6EB4d1gfem80
	Id+hCCinxrE0wmBYKHtpe3jbMlEkUrXvUJDYb2Yi7/NEg8Q+RDfbYNtQA/S7KF/+X8r0niIXWdaoV
	eJAzxF/tUsTwk1679Q6S7z0PNJS6+5nJM/9G+EWUkS1H5UAV+6WkjLaen2vIxQZCkya6JvElKTjRx
	3svhBQKm5XO9nyaM3rIODOYj8MJ+IZWwyvAlME3ckbiseZ0jBgH4hYOxR2w8CyyVOj0GL9S57sYpx
	ySL23AVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLL9t-00000000RTb-1gac;
	Tue, 18 Nov 2025 12:50:09 +0000
Date: Tue, 18 Nov 2025 04:50:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Xiao Yang <iceyangxiao@gmail.com>
Cc: zlang@kernel.org, zlang@redhat.com, timday@amazon.com,
	fstests@vger.kernel.org, sihara@ddn.com
Subject: Re: [PATCH] fstests: Add lustre support
Message-ID: <aRxrgesZ948FOWTt@infradead.org>
References: <20251118073011.362595-1-iceyangxiao@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118073011.362595-1-iceyangxiao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 18, 2025 at 07:30:11AM +0000, Xiao Yang wrote:
> Add basic lustre support so that we can continuously
> improve lustre by fstests.

xfstests is only supposed to test upstream file systems and not
perpetual out of tree things like Lustre.  Community is a giving
and taking.

