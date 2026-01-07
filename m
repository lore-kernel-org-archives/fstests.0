Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453EC275B05
	for <fstests@vger.kernel.org>; Wed,  7 Jan 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775299; cv=none; b=hPoEDpKF+7gC6JAGTeUCGglgb+6ow7qx6tagdjrbHEN+qa1+Y/t8oNwN2ZkBzFAKCR3Q3y9ejLGICdlp6b/2PcxFgiSUB63/u3SQbFS/ZWIQXKfWPoBuw7NvXyqNlvZFd5hDCEn9GP97PNqkdRdN8AdByl4J00GOfzfFjWl0Q2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775299; c=relaxed/simple;
	bh=4/Eu6YrSGR3CDOJTx16VJ9kVbohcCHh3lSw4CDY0Y0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLSvArm9NhhnAaS1ngBNdyIVV7I7m/YOrn9mx117OWS6yRPbzzYwus4mnuN7KsDxopjU2as+dLGtQuB2ehDbomcwcuYPJtIn67bmPCYQ4Mv5nDKYQlbHIn9BSYCc+2CFikqwTCTc5Knndycp6yUN3GmTRW/tIsjRAf2q4mZMMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N+gX4/X6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N+gX4/X6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3m74Rq+MET5+XZI2koXuJJIsWa1kRcXNthG+n3IKnnc=; b=N+gX4/X64Uvqe1e7JRJtYABuUj
	OPckAu97D1N7nroj7ltXgOv0K4DAnK5e/adGptNyE3VbOiYWnWtgMLjIIx+BQ+pWQkbg+3n7ME5r6
	wfHsEHttYUeu9qFBk5J7+wFatxvH3ZjtPLz50wDih4LRpwprtDwxSTWMDe3ayXXtG7jRsgMbegt6O
	f3s3jKpsg39H6ApYvQupj013o7FQQUQoRMmy4XluXRanT/IMgDer0wGx96G4JH5NL7cgYE90x5aeL
	w5D4HecPSVQhRD/8i3te8E+v6te/6qv3NC51rsEMUzX3O3ltAoTrgvLhW0HMcaxYj679r1HENeVBw
	sOCAAE9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdP6n-0000000ERZr-3Bkw;
	Wed, 07 Jan 2026 08:41:37 +0000
Date: Wed, 7 Jan 2026 00:41:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shahar Hochma <shaharhoch@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] t_readdir_3: Allow EOF on ignore_error
Message-ID: <aV4cQU4OGCPd-l7X@infradead.org>
References: <20260104102816.1542861-1-shaharhoch@gmail.com>
 <aV4Ya2OyhzF0BwdY@infradead.org>
 <CAHeNByfyTHSL-UHboz_8OtcdXDDfxA+BJ_awkVw3s_50c61e5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHeNByfyTHSL-UHboz_8OtcdXDDfxA+BJ_awkVw3s_50c61e5g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 07, 2026 at 10:36:30AM +0200, Shahar Hochma wrote:
> I'm working on an NFS server solution and we use XFS tests as part of our
> CI. This test failed sporadically, and we found the issue while investing
> the failure.

Adding that you saw failures on NFS would be really useful.  Especially
as NFS vs setpos is pretty special in general.

