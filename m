Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E112F549F
	for <fstests@vger.kernel.org>; Mon, 20 Jul 2026 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534646; cv=none; b=WG9zgmWJtqow41gfLvwKBbqZNKrQ/FKNYNLreXUfg12qlSAYhUmQVGwQ6a1HeWlwrqayR5/xRhE4lFM/vN0EK1bwXXetx+pNt5KPJzCA7bj4qVgrJABa6czo0zKIqTNeJd340Cw7M2aYgtzNqV0karx8y22WPfCgZYEDxkGIJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534646; c=relaxed/simple;
	bh=BQ1gp9p3aYvAui7EH5ROM9JM3ievSj52ezm/pEldpXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Swb7yJ3Y+IrGv4YPDLnjsKpSGqY3TQy+elKirwf1nZH0QxkVY748hPEMtZkihNS+4XJ1Ut/+27P1Pe9Mys8P3ZB8UXWAc3+4r6gidjwlJwG4xtBeMSgAeWsUVdMFsm1lpTvsIs0IxICFYYHfKOaMtlgrDFAq4qPshufg6V7BLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pjBU6g1b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pjBU6g1b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+k/S57ilndGjoJss1cqjmQ22UwAd2c+Gg+Fclh9PZOU=; b=pjBU6g1bY/5CCKbkWnRO68c+lZ
	hN+mOASOwbENw9K3BviGH93pyvJIgn8pjfVKR5gDS2Sw8kVKSAw15MWDzUM1UsYVFOXB8lQOeKMT2
	QeMk9wl83lEG/h3aKcExIlga32UzGiy+8fqX9cWEpht1MfzZokqHdm0ZVpeknqkkpiPSe19/Fg/GY
	GMueV8iBvh8MA8z2N8be60rj5R1yInaoG81s2GIzNDzBZ+R/LcccReOLXP2yKXacrzZmYGTCH5+zM
	GYz00WY02oSpeSDqGHwN5YpBDq7pJunwUxTxDH4muBcZgPtfsWUNv74RNayKJIAKZR4ZeaBGykASu
	AQ3YyU8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wliyp-000000069mR-0zhX;
	Mon, 20 Jul 2026 08:04:03 +0000
Date: Mon, 20 Jul 2026 01:04:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>,
	linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org,
	jaegeuk@kernel.org
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
Message-ID: <al3Wcz5pIujPdTrL@infradead.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org>
 <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 30, 2026 at 08:09:19PM +0800, Chao Yu wrote:
> 
> Let me explain it briefly, this is because f2fs has only one copy of reverse
> mapping table (aka SSA), for any checkpointed data, we can not modify SSA info
> directly during remap, otherwise, after sudden power-cut, we will suffer
> inconsistent issue in between reverse mapping table and mapping table. So, f2fs
> choose to rewrite for any checkpointed data.

So looking at this explanation and the code, f2fs does not actually
support COLLAPSE_RANGE at all, but emulates by doing a full data
copy.  What is the point of this and lying to the user that it supports
and operation that isn't actually supported as the intended metadata
only swizzle?

