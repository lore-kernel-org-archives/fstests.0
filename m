Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288787FD
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904397; cv=none; b=k01oElI1l1p0wl97FiNzdmIWN39qThKf7wK5RNn5QmJiqbUs8JONupM3MiqIv4Jn057CDO3m8U6RnCf7JTXgLateddYuE3wTi5DpTBV5LAhqj+tUCBTOV50QuiIwHJGrdgLh3EFautV/GP7zJzvcxCJpQPc8f+GaFDQd6CW1e+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904397; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h14hk/7q+gOPwhLMYqscRpYeuKOuWkpa5+l9k17CabB7bg+y43g76G+xY3fqbdbsBeJtitvundTnY3Nz3Kjv4EHhoojA9BDFgF137bF0OnY4CE3C1gUDP+kM+hX5oviH39HkjhG65UddTBWTzMdC2/TcxM2I5cRv10qtCe8yhHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3ry9ehHB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3ry9ehHB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3ry9ehHBsoPsHBkKvJ7euU1/vX
	ubgfEP5hQl6rUPOPxUjxbD6wGP807/eRhcvbPm7PiiKSKeBrXWUg+hoyuzqA8Cwx0nBXavktcut67
	NHPc37pbEmSWNKpQAopNpfK4U0EG89NOZKChlhH8foMeeAWkT05kDmrtvv5PlaQ7ymlYYkUq4Ovl6
	TnZm2UWkLtM71m2TKYAAZxa1rkbNhJAD5N0qIjkNYm2Ub0L2MdqEQfPwFCZg14V1qlk6/7yM84hFy
	Fe+Mod+IOAvYS5z/vlecznlc2CpATOEfAXxmtNRE4v+cKBdPmu2UgKaDsPqwoT60boKmrEr7gqBbc
	mNVeSr9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGT5-00000008Klg-3oEp;
	Fri, 07 Feb 2025 04:59:55 +0000
Date: Thu, 6 Feb 2025 20:59:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 4/7] lib: fix empty arg function prototypes
Message-ID: <Z6WTS0S-ygdG0DC0@infradead.org>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-5-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-5-sandeen@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

