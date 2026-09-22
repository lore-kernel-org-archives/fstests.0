Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CD542ED1
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080731; cv=none; b=Y/NOy4gOYnnBU9kSudyYI1y4ZCf6sYkDHo4sgZwpQr6NKsQQDdesFp6gwVm8JcfpuVBByKn5ta0oR82vhtQLsVaeNLouXBspxYJKwIXFdMptBOumj+2u63NjNEOCTG5v6sTGwsAWncXu4u42TLM3EM3FrJH/iZnq88L5P5D6LBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080731; c=relaxed/simple;
	bh=sJBJJU5af62U8fEtBT+p3efypyD3HDaX3B30TKyNvPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvEMrLq/NDSQjSbQNNTuxsEiRbxsGdajPMlIHWaipCfDl3EfDLne1mASP/GeSqIMELAkykFLcqH0fQO5vGdohsW6HxouQMWfM7dwa8foBQ36g9V9uewnQpZ/uPuSjrp/3xxe1txW6rkhSn/IPJRh7uEe5t0Fu2PXPdQP+kYXs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iyyQNQC6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iyyQNQC6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C5PkqYt1sffN/rVuzjN2ucunMc/Nq2uxOganBDfX/HQ=; b=iyyQNQC66CWsNeraWqgQGooSIr
	1zdebwK1mKdU1i+ePHQ5YevynZ0mkLymgNY53kqNsgeu0eoemlS1zP64I7a1bMeobeF9UHR0LtL6/
	/fOJhde+5Iflnk0OEO0nA8KhsD8QqBONT2GcDw3LiGcxMgwZ2ckwP3AzYnCP21kDTEZZCqbKqz+z3
	oKkaONAb+BL3vw/pSOWw3JEXNDEocv60E8V27w1ccWA318MlBoy+NOEguXGYIRE4/7mk7QdXySQHy
	AXO2NiCJQTJNKFKzL2PXMmko9eks1/O3Y1ZuhjnodcqgzAeyD+woWZEktD2u1OMp5PVLLEjccdEc5
	imPgUdWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zlp-00000005KUG-2TWS;
	Tue, 22 Sep 2026 12:38:49 +0000
Date: Tue, 22 Sep 2026 05:38:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 2/4] common: link .out file to the output directory
Message-ID: <arJ22fEt_7WtNugv@infradead.org>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
 <20260918173218.1254465-3-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918173218.1254465-3-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 18, 2026 at 07:32:07PM +0200, Andrey Albershteyn wrote:
> On immutable systems with read-only system packages 'ln' will fail to
> link .out files into system xfstests root directory. Fix this by linking
> golden output file to the results output directory as a .out.good.

I have a bit hard to parse this.  You mean if someone actually installed
xfsprogs instead of just running it from the source tree, and that
install directory is immutable when running tests?  A bit odd of a
setup, but if we can easily support it that's great. 

Reviewed-by: Christoph Hellwig <hch@lst.de>
