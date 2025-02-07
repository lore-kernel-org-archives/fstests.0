Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8653A7
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904416; cv=none; b=IXI0Pdfqn5QtIpKEx2ExrU44yXE0gBBmhUVA8k9UmJb9rT6ifUZwb1muVloUK6h1CzlAPS1tGBMleDRjsrraY7R4uZTz4+VZjWe91vOu7a6IbUmB6F13PlTXawpo8X8TJ20oLk8FOlS0H/jLq6q/Pu4S6g0aOPSXSGDEZuiVfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904416; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSHjn4FjTDoH6SHErB0KflApBXAJynePS8UytJY1lJP/MtUH70+639d7LrkLv7HdtMwwYrx4Px2whbKXdb5jmyH/K04LN6F9SnhWjCwDDnboLyP+aPYqHqOzAqprjVTjvlqN6UNgvwZoXxVZyWrBMMQhD8WMHinc279Cy95cxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zs6mVnL/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zs6mVnL/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zs6mVnL/V8EuwK7IuMGHsVOOGy
	dCLhGh6h77+FY26c9/oqkQubJtUr3fxthmACpfQTjCDvAnyLgHQWje3bXzAGdBZrOm+/V4T3IbJjP
	CUfYHHW4aIqb+T+B5kxEdFma9aQRBeVD+R5D3ipjDZAd8BPnKKdHKRlPcuMBeNejaiFQF9uybs2jE
	Z5O2+seocxZbsc2rNoIPzS0CyYqlKKb/GKe4yRrKvx1/WVL3v2zDFdI792RD9kmbXkPpCFp5W8102
	zQ9v++95HRslHFvPrFaIkIJvzKUDrWh95r6uxfruYjCo9YI3txnBSH2O68sqzmwjnurf6/xvYLueg
	FqAat+1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGTP-00000008Knq-10SX;
	Fri, 07 Feb 2025 05:00:15 +0000
Date: Thu, 6 Feb 2025 21:00:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 5/7] lib: replace aiocb_t with struct aiocb
Message-ID: <Z6WTX3mdg9aaDkfx@infradead.org>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-6-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-6-sandeen@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

