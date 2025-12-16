Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D534A78E
	for <fstests@vger.kernel.org>; Tue, 16 Dec 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872327; cv=none; b=bc0Gp8orNTA8uz/VVSK7PiRR2ZioH29Gjmd/5w+9vemvJrm531+AuubAkAHR1QXu0ocMA7ZnWwo0YoRthgh+Letdxe7hrgLDobpiSLMFLWE1exKBBQjhKKYX93yzTHEOoL5XjGDKdxju6DGM7SIi2Fo9/wc+JNlZ8PEFnTodGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872327; c=relaxed/simple;
	bh=XLX7xUN0STtbaswLUVy039LSW+Xs+KrNDznhT2Gm/LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdKfIRmxylAs3q6LbiTR6SiuOt2mjhHyeFLQvX7zglNW8pVI/BA7LHaSoamsNvC2GjDb7wle1NXCHhn50+mEEV46QED1QbDWYHitDjai67zUQIMzSBvSDTpBQWBBAAI4rxK3s8ebq7wdwy0CvED/P0wVtTuvMi6C4bkuY0B/pd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jocCbJDe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jocCbJDe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XLX7xUN0STtbaswLUVy039LSW+Xs+KrNDznhT2Gm/LE=; b=jocCbJDe5dJP8Fa+JCdrQLevpb
	CjjYuDuHHJNXRoiZOtFOGIaIpnKxYe9JBRgE2DhdnZC9Ah6oPMemCBKfBm1tz+NKCAGhOjr5Y3D8J
	+TRwan9tbUf5pBD2F///ez+9vd2OJpQG/FBazoLiYI1UFy4yfZLzoTO1tuO4yRoRY3l0zDNDau7tV
	Pw3EPDAj7a2U1kWKGlfWJaLrg95yAMQbWcN0rDSFYskI92LBFR+4efDIrQfzWnzmkOOHO4KjK6yP/
	0aE3UA4+qW5+pGUjUzO3wu/Ijje+YLzonq8AAkvM5Fx7FiANm8adIBtK5rH74Vii59/OlorGrLFYW
	OS+MSekA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVQ3h-00000004tY8-0PWV;
	Tue, 16 Dec 2025 08:05:25 +0000
Date: Tue, 16 Dec 2025 00:05:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Luca Di Maio <luca.dimaio1@gmail.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, hch@infradead.org
Subject: Re: [PATCH v4] xfs: test reproducible builds
Message-ID: <aUESxSm0pwHGoASH@infradead.org>
References: <20251216080233.2324849-1-luca.dimaio1@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216080233.2324849-1-luca.dimaio1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Still looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

