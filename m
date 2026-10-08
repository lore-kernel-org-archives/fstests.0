Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8C481A89
	for <fstests@vger.kernel.org>; Thu,  8 Oct 2026 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452241; cv=none; b=r2zjuYYHpIemG3r9LpoT3atIdO7pduaaJKCZa4EComjVoOWHVPcyLUCB4lSAT1iYVu6mMU2exct3VNXoHhvDcWbJGWOGgOtoz1LO/Ud5+s0l5TXFA9JPY8EhkjnljC32TjBIIbFrHuQtfL5+EGI7uhC/nVBith0lbS6Ge44jwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452241; c=relaxed/simple;
	bh=SZqm5z7nFulXmE+PhwW8zekZSVNL/9IFTBCvhhqzhAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw6ofJS6X8CVxVvWR/n3wOOEqiEakfmQKmHDxW7r7Nstp2H76oJ82MyuCIrewvuQ70o36IQGd5IyOg0okzZEcMTC5mwim4td0EXfbbSALcrUZbwTL0Tvfy3cAtlw4iRV7ljwtgKx4FCeesl145kCBSnlpqcJwRw9ftQkxnm0Zzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aOmAULkQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOmAULkQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LMJg22Psx8nLoW1hY1581RbqFqeaOcssi/dsbMbo4uc=; b=aOmAULkQ8BR0cb/Dr8TF5kAQba
	opM0exc8YGP/P3OWCWHoEne0bgO5aTsYv+ZAhQfZNiv4dTAB+PolbVEWUunXupxzs+jiAbahKDUYV
	u3w3+N74ZzT+kZkRVaCYyMFOqc8rTK7Ieb7iyozdYlUJx+buV9PIY7GigFPIT/UEj7R5r0zhsalwh
	g1RhjSCSR271KRQvlODtA5iNKRMVtKmhVyW6Llj4CrtlvwCXa9q53H4RKx9EW0q9ux4f11DdiJujb
	q9Vd2IFY8YC4qwscExkQhLd502raMqrecafknyxJaFKxPH5ShLGGSBTgf7CiOjZZ01mkgSqC5aUrc
	TZhY6cBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkYu-000000040zi-1Zq1;
	Thu, 08 Oct 2026 09:37:16 +0000
Date: Thu, 8 Oct 2026 02:37:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] generic/622: increase sleep time for lazytime expiration
 on compressed f2fs
Message-ID: <asdkTCwh9hW5gkEJ@infradead.org>
References: <20261008093317.2792726-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008093317.2792726-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> Increase the sleep duration in expire_timestamps() from 2 to 4 seconds
> when running on F2FS in compress mode to give sufficient margin for the
> flusher thread to reliably expire the lazytime inode and dirty the inode
> page before shutdown.

Please just increase the timeout unconditionally and add a comment
explaining it.  While there are some historic hacks like this, generic
tests really should not have file system specific conditionals.

> Change-Id: I208bf14c189b54cc209059b0fd2de9e403a073f2

And please don't add useless not-standard patch trailers.

