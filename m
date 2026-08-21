Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC34052D6
	for <fstests@vger.kernel.org>; Fri, 21 Aug 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290573; cv=none; b=sWIkAUjQwGsFl1jzjOrWv7C1nvsBAhXR6QtO1Ppru7xAWtWZqzUIIU+QkPLjRGbIY2vxla75AFJL4pNWTWOlrqkymeRIg3oZGq2zjgcLoAQ/FL0seZvHFPbb48TjIFc+jNt2m0fFcv5regmmL5uhY9s0EkMCgCnwxhjV2Q0LJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290573; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sfr+VEsopsIt5FTINu6FZxIa28pJtlxnATizYeTY7aJCpo5ExuLCAXvSGiL5OAo2CjfYGQSYdf2we4333p/unCbBHClsaQyHVC+ed1iVr/xw1gm+QZEHuXO6bHbVHoT5mwdzXFzeRueytg1zV8BJbGCmktqSK1ttmBcTlj7ICM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A5mSRBAg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5mSRBAg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=A5mSRBAgtEdM5XtOCqnb2FfEri
	rNSEGTb159IjPF1I4JWuMiG791qnobPgiYUXCDR/DOEFnLF6qNbe/cZX7HjU4UbYO7EUNiiXER6wG
	fibpKVJsIY7rFDeQn+/aUtbxas+5LzYpOparhGfe8/1+gzKiTeZEmyWFIe3aS8Q5P7CYsgpd/68NY
	a5dzb61uJ26wGrdJuodGDuj/M4Ylx1Sh0BlBHRMrWbh8H8/ofzFswRHTo6zV+SmV93Cvfiux51441
	zN3aoxrL8IQpR7i+YLoRUrZJADewPYlHGIaYib6/Cpb1Nz8eYbd3mcofY1732pEJAHecKkjcPnJuy
	YFhHSKkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxHvH-0000000CZL0-0s8r;
	Fri, 21 Aug 2026 05:36:11 +0000
Date: Thu, 20 Aug 2026 22:36:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] generic/800: TEST_DIR, not TEST_MNT
Message-ID: <aofjy3mrkdF9BU3s@infradead.org>
References: <20260819152726.GA6060@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819152726.GA6060@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

