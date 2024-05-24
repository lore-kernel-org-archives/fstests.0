Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DC17578
	for <fstests@vger.kernel.org>; Fri, 24 May 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538019; cv=none; b=fl3QSlzu+CQcnldwYPWXLF7VqYzjJWdfbKNUgBwP2KJUgZwYBHUW+7ByY0gAqd3Wd7k6itVpcMUqeqvKL7XYPVOnmBywwpwZeyBtiLJZYEbB8ktMWCzO6wfP7vp3c/0V7eJKF8Eorb3NRykNezIGo5BWRrFxDM61pId7Fgsf29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538019; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSBkgYluMAWIjlsD0DNMOthKUGMHaDbKOFVxPCZfio5yM7jry7HD8L1RsniqxRyFSYTWNdTduapS0AleXFm1XlF9FELuuaBxQAFsh5+PDJujvmFbsICZ7UNcnREAiH7Fhd1DsOb0GkCMUt+kQ7ghok7wixrJH1r48V6BYzWtyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=je3g4/Nt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="je3g4/Nt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=je3g4/NtyOecso4EHu6NVi2CoN
	FziwSIcpLrpYGhooYpSYRuVgoboT9MIzVOzFsXaLh1v+Z+vlPcCrSGnPHpPJbSQul3j+61xrD2UAR
	x0s1hgvWRrYVz516WKFTGgVh97Huq1/beHjg2qMcRrkKaPcz6pddm8XMrgcruEfxjRp6bk0tcvUoz
	iOttwJ1iqYhj9IZC7ln1uAn4PEQUYB1Noa/xNUFfnUy8gRTg5nRRM4wcEGTyi9nxdZSTkb66YfgMQ
	5xP8pUOC0wGNDA/ZmbIZ4vYFGg1OgTYSjxCZcSvjG0wNLnOpvEWesC/nGK9BLQtBJqycAP8U3ay1+
	A0gJJixg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPx3-00000008LKX-2mLt;
	Fri, 24 May 2024 08:06:57 +0000
Date: Fri, 24 May 2024 01:06:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] _test_mkfs: Include external log device (if any) when
 creating fs on TEST_DEV
Message-ID: <ZlBKoTRxNPHPtUY2@infradead.org>
References: <20240524073104.615253-1-chandanbabu@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524073104.615253-1-chandanbabu@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

