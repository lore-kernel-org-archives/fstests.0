Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C261EA91
	for <fstests@vger.kernel.org>; Mon, 30 Jun 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261940; cv=none; b=DZDsvold7ZjeAq1OvBsHDO2crzIriYCUNvh6XHJSMYIteVoRNQPaeADFJUFFIPIJwAn/GUgE5EgLE8A5PtTnovUInhdYcA8P9OIea7Y42Dng+CrNqT4lMC6LeYaN9tpfb4sE4jT4Ze6SbqGo+vAwkuvO7gWm5T/f0c195PSvLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261940; c=relaxed/simple;
	bh=MbctvWDycftbMKHsVh9IwPM8fu79GAGU2JDlThKhBBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1OGMNJCjc8TeXhJ528lh+nL340w1PDSv+wzEUbIi2O6ZR1skxHG6O3Z8IdE8CSWbz2BLFimjxK2mdlHOCP/gh25OgkGnrVou5t3X0VMlOVUX1glNZNeJ+rLL7lBVZd5noE0MXzWkqhdn3zKkwrJI9CQHjT8EVCyUBEmCP0rimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zyqpYWig; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zyqpYWig"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DM+rdK8MtJA5ZieEc3AZiZBCNVGD6EQeP+vSNViquUs=; b=zyqpYWigB15J3uofkRPO+0HDb1
	NcBsWLsohWuAKc4n3jmhfLuSoGRisSSw9a+7AIbyF1AiDYwawwlVCRY49JgK5T4foMA3Ml1+EJCpP
	5v0Yn+DwjKc4F6CNszRz3iD7kiU2aKUxH/M8YBv8n9HWIONKVdoWLhlPq6X2B1cm5cGcyIgRgTrCk
	9uzmZv/sJeyEEMODzoDKfW4hP9mx46+WXad7cghbwMZS5IhfOsVnb+pOXWsuSMqhKL8rZY4QhvLnN
	pY4RsltHoTiosJqLa4lRIfaQGqUzlRQkKSPqrTFpbcWbQ4bY3IzCWDPf5s9Ox10Gn9Udyjmuqsl6c
	IZwmVr1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7EF-00000001GoZ-30Xp;
	Mon, 30 Jun 2025 05:38:55 +0000
Date: Sun, 29 Jun 2025 22:38:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Auke Kok <auke.kok@versity.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common: add scoutfs support.
Message-ID: <aGIi7wHaq7cPMiZU@infradead.org>
References: <20250627184220.114746-1-auke.kok@versity.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627184220.114746-1-auke.kok@versity.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 27, 2025 at 11:42:20AM -0700, Auke Kok wrote:
> Basic scoutfs support: scoutfs uses 2 devices for a filesystem, one for
> metadata, and one for data. This requires that we pass a metadev_path
> argument to every mount call, as well as a quorum_slot option.
> 
> To run any of these tests on scoutfs, you'll need to build and
> install the out-of-tree kernel module `scoutfs.ko`, and the `scoutfs`
> userspace utility, which can `mkfs` a scoutfs filesystem. The tests
> themselves are unmodified - many of them will be skipped due to
> unsupported features.

xfstests is only really intended to test in-tree file systems, or at
least those submitted upstream for inclusion and still in-progress.

