Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF22417D5
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904431; cv=none; b=TKOzYp1+gQF/67OlpnQm+uMbTTKQT0wfYZ25DD6KubfTCoRgX94sYo7fXUC59o/OD1Md4sO2ft7Yt7xr4ycNemtEDu/hjBidta80kf08SHMZEMD2cKz6aK0A5aMzzFv4PGdCpUSAdUF1Gfu1t32FQ3hSmpUPE1Zr6QfcwepiEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904431; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU4L+136Y4sm8MLs2SxYrlm2iMXorj8paW+s/tfdePsdpnuznRxbsDdIwLDq4QG7sT459vUfyMYFJC4WCEGn2WDBdwTZtnb81Z6v07V5Sc7qdjgs6eK3pUahTR5yW1fvhHSOLuoO/KO/tmfrUl3JhMt1RV5OPtfiVjb03DJSUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=exby+tmw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="exby+tmw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=exby+tmwvkSrj6AzSYECd0msyN
	Tl5o2Vov9nkM1eEPG2RlvmUBGno6FPNFaZpogMmrPPgHadvOort4bJl5wnVk9NqcDWIc8MDJFSWus
	OtNBMg7dGuDSuBE+z/VDBc1GcT1JsNwxxE0uoYNqvnJc+CLu/rMzhKsq0gt3qQ50YcZ1eTYidUsbC
	sJWkHdC6SzI2Xarbf73bwYcctHKNaeZL0XUreLOs9qgcLfIodAmMwaBCczSmXpW8Ey40OITDl9YX0
	GXkNCIQRes6rbYW+C4fQsm7oP+UrIBoC128eC+ZigklSabvpAzN0vsTcHgeE26/f+/+CAVxCWvNTZ
	h93hsxOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGTd-00000008Kpy-2xvW;
	Fri, 07 Feb 2025 05:00:29 +0000
Date: Thu, 6 Feb 2025 21:00:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 6/7] lib: make a few symbols static
Message-ID: <Z6WTbQIJp0gCxfuS@infradead.org>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-7-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-7-sandeen@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

