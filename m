Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2940242D84
	for <fstests@vger.kernel.org>; Wed,  7 Jan 2026 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767766123; cv=none; b=Dzsy0OLt0CmjvBcOPVvkjLB9qqNTpeZennjlqA4NnCLK3oWm44xlGPoVQ2fYstKCe7qaKiQvYWdpdJYyJyxh7GlAIaFtNbj1S/7CjxPprRA5hM4X2PUcXJ8BRQ7sbQlo3w7EfNl8i27xzHjHFBu0/H1aNbw0c43m4EpPf0VE3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767766123; c=relaxed/simple;
	bh=S7UEPsQcnxVpQe34Jo+8Vb5scuKSDOBHWlEx/j66gog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOtdSeeG6vOlAXxDf8NyN58axjfjlfB4pLxpaFd9dBROdbg8ZCSOIGrTOr69ms6MO/fa81muE3JsQxVmuHrtXuJxLnvbm3pBX+2pKQXUecma52hVnOBZ8xFFRoEGn4Xm5zgSUgCb+LZmRjVDjXTOgrnzhyVm06tJBVr3NfhpX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TtfsuCfQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtfsuCfQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uUK7t4Vymu+X40L8L7QXfKgtGhGr5yJBJiCcKwE8g38=; b=TtfsuCfQhT9nJX3ScLTwq572T9
	lJ0uhvcEJp7vtVOKOdqn0urk1TZEOXyThO+TYmrlwCjYMwefdOdJ8GKz3oG/LIAOWGOMWP+2sImOn
	iXSCH9s4FHb7n2SI97O4lAbEEVk7AaHn3MPDQSoB+Xtto1qgTw6om4Fy6vI5fvtsqNglTziU85P3x
	C0/cpBfNicpO8afu8Xs5X7N/InEe6c1Y/wSXidj5Pa3d8+99rN9w+YWDi3vSKeuOEBRakrYW3FCuX
	40OnSHZ11Xo8BaIf6hCpBmpy+i3mr6UTXz4x62IapeHf2bqo1BtlTiyWrcWn8ywRDovNPFLZw2g14
	Zx6ci76Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdMim-0000000ECXs-46ng;
	Wed, 07 Jan 2026 06:08:40 +0000
Date: Tue, 6 Jan 2026 22:08:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Chang <joannechien@google.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] common/rc: add _require_blocks_in_file helper
Message-ID: <aV34aGUeU0pQkwj2@infradead.org>
References: <20251229023145.1806877-1-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229023145.1806877-1-joannechien@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 29, 2025 at 02:31:45AM +0000, Joanne Chang wrote:
> generic/735 attempts to create a file with nearly 2^32 blocks. However,
> some filesystems have a maximum file block limit below this threshold.
> For instance, F2FS is limited to approximately 2^30 blocks due to the
> capacity of the inode. So add _require_blocks_in_file helper to skip the
> test in such cases.

I still don't understand why we can't do this programmatically.  I guess
it would be simply too slow?  In that case that should probably be
documented here in the commit log.  Otherwise this looks good to me.

