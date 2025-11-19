Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3225315D39
	for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763532907; cv=none; b=jmwnLhcS+RdzUuhonDvSLlJNBdc3xQtPYxnkaTyBmBpLLdljlgR0hYJyVmbZikuwa3ihDCilCLkmogMgQdoV3W4SVBCYRIJ3A8xuoon1XbRvqOU/h8fi1V31W2RJkSNITGp7Lu6v8GynqxsF88h5PHHC5/bt6H6xvond4Ld01+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763532907; c=relaxed/simple;
	bh=QYhxgXL3uLXykCG8G6DzE8xUz4YXAUWhBdHSIEbeQNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezCPjvNedPQazXqvEMF9dS1papLHKlXPpaCpzA0Qw/d/2039Xs/DXhiVCN4k0ld08oNAOw4YpXxFVk+dsmNKe0y8nQxaBSzvsRiR6DOi6iyh1sfnlhz3pYhMl9AgJBkmDWUflU9JHPzs8yY1LnL+5qAcIKlb8ViT4b3qSCPS0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pnme0SNP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pnme0SNP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=unYoSc2Pvkiqb0TlkMV3dqCnbg/y9Rm23yetvFx3xOc=; b=Pnme0SNP1NvHbJQsi+a2V/jykr
	hjPnUGkPSblfnC/xAp4/iaGD6ipvlvME2OcAEJCaveehGjHIB4DwaqNAO8FU0XCQyq+r38c84S20T
	VT09hoQ+8f+tK5RqsN2LWvvRucCRqKUK9QKI5Neabv0WZewzTSgqmMc0hYUK2D4Q57fW/r9gtIUrZ
	KpNXrjtz/4ph6MSDWeOnCVb+hDr1rSPwofJZdltVGPiVLgicoc4PN/KDYSxFIPbWyRhGjVOWr/VzN
	l8sKFgfQLj7EMPw6vCF8VbiRb+TJfvyNs6zzM8h9GkZe0+06b0EZlOSaRuIGmqbk34dpMPO5Y77rG
	v0CNLWaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLbT5-00000002co4-2hRu;
	Wed, 19 Nov 2025 06:15:03 +0000
Date: Tue, 18 Nov 2025 22:15:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Day, Timothy" <timday@amazon.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Xiao Yang <iceyangxiao@gmail.com>,
	"zlang@kernel.org" <zlang@kernel.org>,
	"zlang@redhat.com" <zlang@redhat.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"sihara@ddn.com" <sihara@ddn.com>
Subject: Re: [PATCH] fstests: Add lustre support
Message-ID: <aR1gZ5npe7n-nS4E@infradead.org>
References: <20251118073011.362595-1-iceyangxiao@gmail.com>
 <aRxrgesZ948FOWTt@infradead.org>
 <E35FD5CE-23C0-4A3D-B563-93E19F929291@amazon.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E35FD5CE-23C0-4A3D-B563-93E19F929291@amazon.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 18, 2025 at 03:23:33PM +0000, Day, Timothy wrote:
> >> Add basic lustre support so that we can continuously
> >> improve lustre by fstests.
> >
> > xfstests is only supposed to test upstream file systems and not
> > perpetual out of tree things like Lustre. Community is a giving
> > and taking.
> 
> For better or worse, xfstests does support some out-of-tree
> filesystems like gluster

gluster is a userspace file system using fuse.

> and bcachefs (both listed in the support

bcachefs was upstream, but yes this should be cleaned up.

