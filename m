Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3904448BB5
	for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808429; cv=none; b=AHW6+1PbqnTnp2PGb4OWba7cNqmIG8loWsgaNsXO5Sq+gyUvVJyWLjc1Zy4Brd82/RI3cd4R0WzD/3kefcd5QtBLODwfFpgQRPFOGEsvw/XUe7eaiz+6NLHxwkUKcnX5t3cF5hhi5GT/iFDe7UxwWNsHGko+HBIRvfzHndoCMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808429; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoeBvEzwhGCZB+K5Z2WzzTfFpWLoCQDxVlhzG2Af0VGc5xKRX9sdOBIuutLS3jz/46cSOlffUnTxcVfEBScs7qs/6/VSTBJCQicOH+rvg3qeDV4uGvP5VH4CNuyYHonzMmzWKLldDKgIsJfabBomL/3QZxsiosBrRhK7i1ReOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aSSwnFEs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aSSwnFEs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aSSwnFEscTp+TeLHHzoiqEeZ5o
	24qRo0EB50XUqg7KHn1Ohbk2ZS1JezjCSGcikB3RVVmycqHhKtDZky5Efap65d9h6ppEtpuIVkumH
	mekhi5BusSEqsm/YmJSXgvEz4lQ5QVmxfWjJZgwEIBPPruH4nRy3Q0fXZp1Kq0clYu4GoscOehIgm
	woew97L0VJ1yI3ZI6m/8rA93pQTwopXVVAwDTBjeFHJiroKKHfNTIAS5ZWT+H2+TOuYtR7cMIG6tS
	SqAxjs//ghhTPfu7TKGlpowcCSNHWrr6zhhxpnKPL0XUuzXhsKen7mx6uMJT6UXn+hh2FpAFZzRdI
	p42LbEiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGFDv-0000000ASpp-0VWX;
	Mon, 12 Oct 2026 12:33:47 +0000
Date: Mon, 12 Oct 2026 05:33:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] generic/622: increase sleep time for lazytime
 expiration
Message-ID: <aszTqzApi84puqT0@infradead.org>
References: <20261009085544.2450966-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009085544.2450966-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

