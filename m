Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC5534473
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080818; cv=none; b=SJxTcGoawpdkRQl9PYquEBPvMoKeh/YV1ebcQabN868xYKXaMxu5/BS3rti4X1Ikb30Ub4ZdxSw/RbLiSZZBwFnwfc4CHKi8Owl8G93x9tu1O6f/P9UqYJDlmv4geEzOeFWOufI/919srkeodO14fJSczdQoNlDJIytGs8+wyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080818; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqOE+DDvhQmZZo3Fm2NXAolouqKAGmgiETeZMIBtKVWt7z5Ekgcp1A4jwSbOamUbnQyIcxytUuSjnMF4T0VaFxy9cSWRCjFiwVpP6xRmIHim2v7j7YAimlvRikGxxnmZNciGrm8eigTo0Qo8hUvYQcChrqxRRUzcNXU5zS2jQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4SS6s2un; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4SS6s2un"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4SS6s2un0RZiMT4TZ6GaAyVaGD
	ieFWm55U5CR4AF4RYSVf9FfX/AaaAlz7U9g8zcwQghcbb712n+nCqE5hmupwRETDGAclGx4OKmOzF
	SYIOQISWfnBFIADWIV8IN4Hsk3JU+jM3aX2/I3c7bALz5twTCWyvL6ieXtVfvLkoLnm/avy2bTwZ+
	SKzeGQbeSlqy+YMvJ+VphfL0BK6YooMrR3SIjLGjI0NA4eqvL7t465WEyJvc2kHP+k15mwBroX2+O
	Ss0Y+YaogSnTM0MNZHW+b/gWvBFbS7Jd481BlllgEhIwV6XnT+K0lz7G1tNfVNuVXpLS0XWwxpdpg
	YsfkTtrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8znE-00000005Kii-46rM;
	Tue, 22 Sep 2026 12:40:16 +0000
Date: Tue, 22 Sep 2026 05:40:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 4/4] xfstests: fix permissions on system file installed
 by libtoolize
Message-ID: <arJ3MNuF_sEs6JUg@infradead.org>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
 <20260918173218.1254465-5-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918173218.1254465-5-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

