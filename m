Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C72393DC7
	for <fstests@vger.kernel.org>; Mon, 25 May 2026 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689802; cv=none; b=SXZBEwnje4/NIih+Q9f/kjtwD0QZ+xCKC27JiRXYxJuqyZaYDoYtDttW+R9LjDFJc5EsI6F9+pbjXBL9z3dYfbu0cpqVxgFpPVyruglL3anfEPVc/77jHMWYmg7wYfiKQ6CMouwQPJKutePMhi3tabPNxoV7TY6ybqoL5nQY/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689802; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpytGKq9v3zaG+4aBpjdUoSzuPWmQOun/WOmRWiQWayMU9F/EtM5h+1V/P/pbmwg79EwR9POvcsHEbY0jNZ5G/tQOTu83sD1CILb6f9883KUUwZYsc6rpb5IZZPPaFsWZbKVijpzKYHOKN0C/mAbBbCsuNGVepXIbOtp3/KQnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LQCpkX+q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LQCpkX+q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LQCpkX+qSdfAdt3zKGz/3blD0k
	wMoD0BqJpxxpHoRoDD0EbWhR8nX/URifytkHfOUENyu8n7jd9Ky94qUhPnuOCLnjuQpP2DwSNf78t
	TexQi7SJZobJPA30opctId2Q2vSOhLKlBWgzVUJjVOxlqO0kI+jv19SgSecBYgiUUQhAbMX5FsdoS
	Aly+zaTwNzydTY32M0BA4YJOjU815L0WdnGhdN1oah3qBnaNhIItJAPwGpKk9lPhsUruwP0tG5y9s
	v/3f77KYU+4qhj9vE7HiyGsyTuZMILTpMokh1l30DYWXck1Q46OLVh6zKRp4kGm/qVkaijyNkhUMZ
	aEh3D7kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROcC-0000000GOca-441v;
	Mon, 25 May 2026 06:16:40 +0000
Date: Sun, 24 May 2026 23:16:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: djwong@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/791: don't run if kernel misses FANOTIFY
Message-ID: <ahPpSObsDxlO4TWr@infradead.org>
References: <20260521082648.843312-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521082648.843312-1-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

