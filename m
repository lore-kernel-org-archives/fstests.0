Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D9209F2E
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624517; cv=none; b=dxtx+StwfF3f0CL4EXxR1T1ASphowIwGvcsbLql5gmS7zhvpYgZavr8vlcG5NAkCn2GVkluCrS/FS0Ewkg/i7yJ8Crg62x76GIgO2aE1XCK81Ct0o4MRuimaJaRPwC7cEPDetoIAyjLgHRxmSB4s+ysDt/i8ks63dpjQHPGZ4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624517; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJaNpBVeG+erAacV4ISSphrobOtSijnI2oLT6ljldmdCQwJ3NwaZeBmIZI/sC51r1/9PAuVVPr5duc9QVAXIgKKE67WBNNGj530H2UdFHtQZlv9XRhveVZvW1H5WPC07nBH3XEh7aw9LlHs6bqUuWAq0HJw4AeWsjUeCRuoZ+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VeedOHU1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VeedOHU1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VeedOHU1ZKg0Y9d+JZjQPjwnq4
	7/2/YIkvRU6gf9uR65YefN1CukmlB6uyM7U/GxOxU85wIgzzP+pkux+iW8+hyXEGKt6utbILqNyao
	7Oq80e+YfFqHDwGye5omKdka4Y6LyeeRGSoJAiNw17SySRtrAOGz8RlHjvf5rvz8HcLO4rd1sYfxA
	sh7Nw6RwyugjLVwjO0jbSAgqhtkcwyvdbB1rscp+5korAnCJLhMg11guxMn/jgSQARZawSgrYqm5T
	hfBHP2aAXPVKzJKD6uFt8g5lFJaSmcJnKeCFXyTsvaVzbNJBHBAyoJ4jnLTar+dvkCzJebmZKL17h
	k3D7ZatA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCep9-0000000FZjI-33t1;
	Wed, 07 May 2025 13:28:35 +0000
Date: Wed, 7 May 2025 06:28:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH REPOST] generic/211: completely remove obsolete test and
 related code
Message-ID: <aBtgA9t1VkBjz_7H@infradead.org>
References: <20250507111811.8624-2-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507111811.8624-2-ailiop@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

