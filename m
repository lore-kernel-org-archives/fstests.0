Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998B231CA4
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904199; cv=none; b=PYhRUrhgY1nQ/119u9rIJ9K7359Xqp0IOitSO/mbK/wssbMpHIzyafKB/xTqA/dLOkwh46xkkVO74z/NUGppsbL79bFzaM2Fcd38y9mvq6MN26ruwde1kuB02VOMzUM9tKpxY3QZR3Et/PDUKphvRUuk+HBNeMVBJ2/yOoeVzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904199; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKgCnG1mAgf03LqznB7/bTL4rqbgg35G8viFz6b5xkdZ3M2I2xO7aJqOChDcshpOpUE+jWCIQKSja0DaaE2JaiYSEQyCZqnUEGnUth+L6N8QV6i/V34QgmT7DOXlx1VhP1n8XuDATPqflUDln/Fv/IfsfGQzzWIzUqUlDu4N+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JFCtCSJ+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFCtCSJ+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=JFCtCSJ+tEiE+6FnbM5Otyau+V
	FaM9UhQh+/0u44/t/VVZNXiWaG36Q8rNxLpdsgJHFCsqJaWIR2jFZwU+nI9uGRH0Zy9BR9CuuPHcG
	G4B5J8ngwCFnituS7N07ZiC+7YcKKHtm1L25qmlqHeSSx7sOfPFt134yOtRfi+dirSkDFNx286LgC
	HPvVA6CS7aXBJRHCJ2SRe9ImbiCy+29vljl3vyCNgYzphWgnBow0BccQg4ZRvN9fFczZlfcM4J/Wj
	5i4KGpzUgmesXhvPo1vdioJHhWKdThVWefw5B8H2NoXkKxSWca0zAb+veSsXAJgEUmcLVwToUc9Vp
	sf0bxH9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGPt-00000008KYm-2YPj;
	Fri, 07 Feb 2025 04:56:37 +0000
Date: Thu, 6 Feb 2025 20:56:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/7] fstests: enable sparse checking with make C=[12]
Message-ID: <Z6WShahlU_FZPn0Y@infradead.org>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-2-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-2-sandeen@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

