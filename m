Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4C1A2C2A
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715233209; cv=none; b=KT90Ur91Dm1fI4LYRRJlAIWHMt0k6Hc/NFFyDqQfJ6gk1Pohk9U2vnefhX/KVrMwX5UUCBV+SHkF9TAvmaz2aUrtRDnIbHVdOInuRlOxs/lPOIi/whjIb1paQiEqHachxj10tK7DTx+MRW9CbG2vXYezbLsnNGuX/5r8qI+SD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715233209; c=relaxed/simple;
	bh=iwTg8RWme4n7+oo0FzBKrE5V6c2q+YSsCoCEW712Fm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJTbXJMzZL+ihfOT+S4afboc4JAguz1NW+OHVpyA+R1U6B2ih1J3Lf/jlffz2qVKQh5d+vuL6OoYxAmVEja3XeQ2JwNFxtE0rQLL5DGF9JiniAF1768fgyLXc4kmgh5SEvm6TBa/j8wcik8TOJedcpYCu5IXQBWgCs/INP31lDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1wDYdeUd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1wDYdeUd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iwTg8RWme4n7+oo0FzBKrE5V6c2q+YSsCoCEW712Fm0=; b=1wDYdeUdfING6+CFRv5lsKAis3
	QaQNueZi21TCT+oBBIcI8nAUF54GoaI4mogZVoc3QT0jy2vbULmi4fuq4iPBHFY3iXIVpFmd65zNY
	nHJ8pwsY+GSTSimUr9O1r1x0M5bV4UAIU9cmKet6eI6TO1sGckB6crmbMui2kvrIm9s+whsoJZxdO
	m8lQOA08UyNLeve9zUhJkr0PXtUwYwh7sskAIGeJbXH8b51KlrUwBhTasHqfHGkn1ar3svIXUFDRi
	TkMFF8EJNP+vmy6DPba1XuumgHIx/TFK7/UhIF6zhy29xEZQCv6ggWIg2YXD4QksWJYlN65rc3YId
	ifa4v+vQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4wVj-00000000RwX-2PXc;
	Thu, 09 May 2024 05:40:07 +0000
Date: Wed, 8 May 2024 22:40:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] Move shared/032 to generic/740
Message-ID: <Zjxht5OKsau5QJYm@infradead.org>
References: <cover.1715108589.git.dsterba@suse.com>
 <8dcb7d564180452eec0c2888740c1b0919e171d3.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dcb7d564180452eec0c2888740c1b0919e171d3.1715108589.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 07, 2024 at 09:07:36PM +0200, David Sterba wrote:
> The shared/ directory was supposed to host tests that apply to a subset
> of all supported filesystems but this is not utilized much and creates a
> split from the generic tests. Move the test to generic.

While we're at it, can we please have a

_have_mkfs_overwrite detetion instead of hardcoding ext4 and btrfs
with another check for that is supported for btrfs?

I'm also pretty sure at least ext4 supports overwrite detection as
well..

