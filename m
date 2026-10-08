Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66047F78B
	for <fstests@vger.kernel.org>; Thu,  8 Oct 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452101; cv=none; b=tlGlSiUiTuHfMOQfbViBACHiEE3gsw1KChnUZve0eschws9xye9yPDRtFtmCzKkgTSWp9XXUPX/UKWTmC8rLXyMUNGePWLOfGohunyyJVmiwsn+urcCDQjt2cGUUR+p2CaIvSZ5dbR0JiR/smidvgXUHPS5hpJr2UoO5BLExO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452101; c=relaxed/simple;
	bh=qNISq31+8L1nGJip4yS2zwck6riwJ2CvrdSz6AVD01o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1Y/jS4wKJqEPUBokwXUWJxajYbQ8NRVHvkiXc+zok5DNmnregKyD3H2fQ3fDP+kyG2BYIRZg8wTlfaZLlsziTd6NE5aEDaA4YfQn7S8QL8knqk4WRCcWCvOFoP/MnLjm8LY0pJ9vLmAQfVhksWvqmQeQGPveIbN4hk3KPimPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ur46IEAI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ur46IEAI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lWs3Xui8tqzOT+Iim/sKgGnj6GLZQ+VEGbwmVkfcQiA=; b=ur46IEAIB+u8Gj/UcYMxntPmwg
	ifzgFw3GqFDQ7WJrSBZZg1z6Wy6cO1wyl7HMIbrIeRO5C0GEeB1kdDa6m3TDt2gv+JyhLqj4aan4Q
	mu/otUdrUvwLGIh61+6aaLJXXJZgDxwbIoYvGZoq7ayQtAkOyiU6liqDcLnqyLZtB1ktMxzhJrwow
	67yiCQyclQNNc3tZEWNDnwW5nd2TSueftNoNGqoYSZ+w8ddQDvmb08Kov59/tPYNlZtcxvHL/8FrJ
	wTOenwsdsi/Byd0GjfOGgu4q9GBs7laM9FYrWsI3rC/ikfHZO8eYnUQHaWo7XN0P6sjLJrI4WJ7f/
	GoQswUTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkWd-000000040mr-2bI0;
	Thu, 08 Oct 2026 09:34:55 +0000
Date: Thu, 8 Oct 2026 02:34:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] generic/794: add fsync_mode=strict mount option for f2fs
Message-ID: <asdjv0byRIgx2DBO@infradead.org>
References: <20261008093102.2791457-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008093102.2791457-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

It looks like this sneaked into the other tests, but this option
is bullshit and we should remove it from the other tests.

The f2fs default is simply broken, and the justification in the
documentation is incorrect.  f2fs should absolutely fail all these
tests in default mode because it actually is broken.

