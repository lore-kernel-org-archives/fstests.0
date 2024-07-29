Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E01E4A2
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262578; cv=none; b=hM5kqu1yjkMUeM3BPaqVVG5JSJWS4z5hxasbevoVkY9uEVI4KMdQ8pYeurSo1ZZMFRtjzUBGxDf7+/AGRinDkOMz/6NPz+CWmpvgKm70ObhgQgmKp1pHyKD578zlS0TarfL5lGQswqJJNbHM8vEqHs+9R4+07oiTJyxMykfFg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262578; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5Al9gqyLFX/3Gbtpi4l9sBhsFd2BFHiIwIbIwk24oKhafJ41lVV9NuFLCPHwM4G+bBAlw9KM3gNoORLuEcfzcgTm4oOQFf6cDY5ncHB+I3DvdkXOTUWNjcgD32IFL0q5vaGubXr1njInPI/lqI/P6KN1AJV4sAUz3NSBkvOtuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hOCt4L71; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hOCt4L71"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hOCt4L71Wit08HyrfTgNS2SSHY
	G+uawrUKFyuHon6lWjNyAS2wbT/gs1qLndUVqJyL1PKaFM0HXOzjEN21ZLCFk71+Tp7lVHYHkbNFW
	Cr8qaC0iwCvcniH7UOD+lIEDO2lrLbtiG2NfIQz502kl1L+s6dZKaSDYYDOIpmbauqYsyeLAT6Pca
	ZaHggCyamvfcpZ60ZEqx+/PFs0zp4KoxXMUfdCvpZhexKaiKOUaChZ97IIqdzTO3GOLzph1Pu2ySF
	Tq3fhBbu0Id4DXzxPyP+QAvjnQmBzUfJvw7hFAYld7gjuhr1EEemBc6oaNrWGfQNtoIBzmReDJ1DY
	bdMNrjUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRAd-0000000BWwd-2rSm;
	Mon, 29 Jul 2024 14:16:15 +0000
Date: Mon, 29 Jul 2024 07:16:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yang Erkun <yangerkun@huawei.com>
Cc: hch@infradead.org, zlang@kernel.org, fstests@vger.kernel.org,
	linux-mm@kvack.org, hughd@google.com, akpm@linux-foundation.org,
	yoyang@redhat.com
Subject: Re: [PATCH v2 1/2] generic/732: remove unused code
Message-ID: <ZqekL92fZP9cxe2h@infradead.org>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729084715.1736839-1-yangerkun@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
