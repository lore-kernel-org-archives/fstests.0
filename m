Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216F126F3B
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774417983; cv=none; b=leARKtpErKvnFV/2boq1nBjGnOzVV/wtkBShEUfc4pc0AN0Ya5tpgOopRG0t4rwFDrjRKItP08KMs0AqDLOzis2WE+p+BDKcRjglX+9GauhaaQoTIZvBLJKna4VjTPYMH/4pNsmg7GKSsiVoDR3IU0irpvzU5M4PF6jQzkCBPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774417983; c=relaxed/simple;
	bh=j+lfb2xERHRKW05h5yrGy3wZBIp5eh8O8pI6t6OZmDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvLj72zVb5MhW9ZkjdJnOMW+zVxYMiTQF/QA1dbTB7LoEnz5d5Ha9cjRwcAHQFg2F56Muy5mOPdPDn2JCY2hAztxZKMk1RcjJBJBewUNPErwMToi4gkapvgCC7yuqtmEzj/E83K0icI3CrwUnXBtcGcOUt41lDQoHc8R8g5LK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4oEgKq+Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4oEgKq+Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SHDXUeS5jnR7y0znBQ+/KFl+xqNiEw10GPaQ+zVa7q0=; b=4oEgKq+Z9wK0/UfLZYwjfIQJae
	QX0Ib6GUJWXRdxWpiZjrnwawzI2WP/kg3FX+sWKJNVm05/u+uHElk0YBR5/GyzYLop8GtNqbdu4VV
	vZ6NxzKIsZWte3mqlLXNnoEvHSisA3lvqQUH3xcH+S2vbLy0GTLDQ4UOqGPyRpdhMBX37Q1WVm2q2
	x+RKePvh+V3C0f+bBuLqK8Orn7IbdoIf3vOr50M6a2XD/Azc6x1fHyCkWp75Ryz3cHXlMyab3TIbK
	+sA+eiytnPpTWT4U4aH0Sd9v6ILU1GN92ML8pPd1OSEFKUK79rGzXowJ/7HA0dprQlfeevZErKiMr
	irUEVJgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5HAr-00000002koM-2gNL;
	Wed, 25 Mar 2026 05:53:01 +0000
Date: Tue, 24 Mar 2026 22:53:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/rc: support f2fs in _require_fanotify_ioerrors()
Message-ID: <acN4PWKHvk_33VB7@infradead.org>
References: <20260324025656.493776-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324025656.493776-1-chao@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 24, 2026 at 10:56:55AM +0800, Chao Yu wrote:
> This patch allows to run generic/791 on f2fs.

When was this introduced?  This doesn't currently exist in mainline,
and it would probably help to run your fserror implementation past
Darrick and fsdevel for review.

