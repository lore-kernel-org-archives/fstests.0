Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37452417D5
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904478; cv=none; b=e22fcs4NB+1uB7hAK7cSXy/4iz9dvPtbAxASmvdlKoRcKHUq5Skmy7cjJjDqZzCGjxrVOLWFuAInYBUFcOaMqzMLOHwWfZEJs83Xq5MHWbKCbyD3I+z3WA0hHJWyuTLDtQIJPq3LlXqFYtz00gnT21IhlXZVUQlxls3y8jMIQec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904478; c=relaxed/simple;
	bh=zzugfHz7wY9xdRlqDtYJV3YzVBlf8947YSAh2VhpIZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI5cGVt1AKSKltwn7LqLz7Tg38bGXNSJNUS2pwa+DI+gg1iDeuZnljQDIhjGWr+pHNIsHfesLCGpPE8FXTT/3mUZYz3sSZCn6DdRKUPIVKaHhZPbc77fwrUWrIWGY1o9RWKkP89A+Rrsv1ynGuzSnKg5YTHBzXxO9Q8ApPkZmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZ0o84Tw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZ0o84Tw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zzugfHz7wY9xdRlqDtYJV3YzVBlf8947YSAh2VhpIZQ=; b=NZ0o84TwXAroCcYvPE6mEvA+DJ
	XoAU5OXxGLCgmKQ1b/56E0FOk9/pn6cjJF0shBvYlef0/doJnRgG6YoZiZNX7ptdb7EguzDXb6pAD
	uStiSmMMgwChL6XJ1U8bYTbhixW/0ddXNpGvt/9bkPI/Yr8obrRzwXH8HncUGl7uWDS3NvsKMWJHx
	2rSv+VKFZAjRWe6nW4xDcSAGUbn20B4gxNx43AKG4sSvebLCbZc2El8HNMLmA8q72Z5qEj5Zy+Kao
	UArMjBNxJQ5ByCzL3NvkxYyRZ8TWNCP3M4FLQFai9479HBz0Do9H4bk58NZy2kr2XNtocNwpBukUB
	N/h2oJJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGUN-00000008KuT-2y0f;
	Fri, 07 Feb 2025 05:01:15 +0000
Date: Thu, 6 Feb 2025 21:01:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 7/7] lib: remove random.c
Message-ID: <Z6WTm0_kWVjMMGOh@infradead.org>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-8-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-8-sandeen@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 06, 2025 at 03:20:02PM -0600, Eric Sandeen wrote:
> sparse points out that lots of things in random.c could be static,
> and upon doing so we realize that nothing in this file is used.
> Which is unsurprising since these are all part of the standard
> C library ... so just remove the file.

Heh.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

