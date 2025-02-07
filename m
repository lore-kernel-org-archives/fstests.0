Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A527FD
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904359; cv=none; b=qBwLJzMGn6uGsYwk7anI4L5uvQJeRq+TUiUzV/aZLsOlDkZF32nzZHqUr6gDGNS3CqXxE4zr7kZRuQ5ITBptxW9EOF24bZz9Ky2NqOFFWMdoKTQZ1v33abfEf5LBne3f0pAOpzoOui6qhiCV4j3deFFRciypsBBLcPCRcSR62q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904359; c=relaxed/simple;
	bh=rNG+l6csQD7u/EFhtyz3Acz8IkpxioEs9kcOAjTver8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4tyTYGenhAAdnWgQ1sWbvD4kDYVZ6q4Ln23Sl47qNIw5JeHLNXkHFo+NOEOASMm01gbU6WN+nNKA2aytQzFAb7HKan5Syb917R4+DBMc0zCIQcS0Hw9qmqWQc2kTI2ZIRzzmU4UOolGwH4aPrFEV3i8ac48/Nl5nJy/nsCtQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qj2Z76ZR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qj2Z76ZR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fvR9+PGsSDa/OhFdAKQrGSTUBYGitO11OKR7NG7ehjs=; b=Qj2Z76ZRsAKY5ABr/8wgqlrRRy
	YzTqo5z4eJ2L+hxBttZOc2k0WRZ7WQyWC1e7zq4xNcgMK29WKYaRkfkqnNm2688PoDkMMmSlagEym
	YU21kXYntR0vgYdDfakkwbPLcO5wrXGcr3gGGX5w+mPF4eyYzGhRGXqI+EyK80VCf0QFAjzF4OBM/
	yg9I0yaHaE+BNbkLAo99oPC8Cc/OWoDSxYVkvcdk8lqG/00J4Z3hWFT8BymtV//AISgTaVJRprRAd
	raPk+MvBQpitLNsz5fJsLZdoE2oB2Bk/0rkNWMYCnBJqSDixl2dwR/1sfBUqTh5YvYsgdvxvUbOiP
	CRcwFEpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGST-00000008Kip-0MZW;
	Fri, 07 Feb 2025 04:59:17 +0000
Date: Thu, 6 Feb 2025 20:59:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 3/7] lib: Fix non-ANSI function declarations
Message-ID: <Z6WTJcJ9SFo60Qyc@infradead.org>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-4-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-4-sandeen@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 06, 2025 at 03:19:58PM -0600, Eric Sandeen wrote:
> lib/ was full of non-ANSI function declarations, fix them to make
> sparse happier.

Oh fun.  Great to get this fixed up.

The path also seems to have a few formatting fixups in the area,
but I'm not going to nitpick on this code..

Reviewed-by: Christoph Hellwig <hch@lst.de>

