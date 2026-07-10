Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DA37AA8A
	for <fstests@vger.kernel.org>; Fri, 10 Jul 2026 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661418; cv=none; b=XDw9uGeQFnSWSJ6/xmajPp18h18iPY64VMrsFvvRIywBK97ZBvXy7ty2s1o5sTwJ8H15r44+3ruXFbv9IIqrA1HQ2+P6XXtnlo8cHw7k9pXHetSga3n8uLFgAQRqR3KDHHDnPDqi6nDPwPTv6cGe8biwvKR2dSuUxqewwzMEJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661418; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD8PTQHOPH8u39v1iBTtXYJ7u7CXzw6Yk2dK2tYr2PI17wdC1+nvtl+QcyQEiZJ20qK0upzLRBYSKp7gR43Y6Uvhi6GZIu/36amnpKTOqd4FfRBu668lEEdZRro3f5KJSzN+dYSQmwEZRynRvUC7KaFqELWv9WcWhk+TM0gMTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2/1yM6YM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2/1yM6YM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2/1yM6YM/MlhPKPNzf6J4xX+9K
	HqU8aqtQD8SdOaW0ORLHSWADNVzONfccOvrAmwu+peU0JStahsxEh1EP0bsrAPGa8dsa0aZf9i462
	r5c9V1tlmOyf+oU1r6l5c9qTt1cdSM7LY/cnydLM62aCVOxxQGWi399QUkNUYh7AyjQoNF6K+lGxV
	wINyScW9oCL6YNQeZSGnlaZ1IWOvauDtbdOddTDUg4cs8FwADgZ1PNRkuxEdDdT3tYGuO7/BafWqq
	TODVru7ML8dd2uCj7lfwynKhzDNPJMqiIXqsLsSJ+TqSb/AW6knq+hieM8Yau/YsClMfbJ792WVo0
	MWZW4eUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi3oV-00000004CY0-1nmU;
	Fri, 10 Jul 2026 05:30:15 +0000
Date: Thu, 9 Jul 2026 22:30:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] generic/270: kill fsstress by exact name
Message-ID: <alCDZ0cHBzgDvVv9@infradead.org>
References: <20260709111847.2842394-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709111847.2842394-1-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

