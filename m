Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB34C6D
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024400; cv=none; b=I0wnGRq75Qyd0oORWWQbwCj+hkbzArHVlPqA2nk5jokanZJbHv0dnbxlQrmd0zegrC7mFTyiMpcqZBK9c30H3bzFOdDFpN9DUgNwpVPDYYuADT1FfcSaPOXsarDHyCPdcoxgPpwVa6sqbCboyxrNIy8/YNc0eHYtz+9mn4bU3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024400; c=relaxed/simple;
	bh=IEbGdqiPCaZlzzFVUEsw8gGTr8jGJAtX1ELHqTc5N6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A10rEAw9UNetzvyfbbSTMeVsur6TSzeOhBhuZLO6NL+N+nQ8+EzwNxaK4K05zRSgw+k9F1hW36oNskbWNbHW/20ziG0ImTpUN98WUOjtYyXSJLK2AIVAto63CY7GBsk60wR9igE/VpvE35B5lQhugyIYcHmLjnFNqEhGcVmcESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=livugy9C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="livugy9C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VIuJiRmgRUKwoy4fZIyvENNhSRANuGUnd7EenkJHAIg=; b=livugy9Ca1D/o0BR8zTZKaF20x
	v/BiGYOJmKmznWvsZ/LeezVXLNWGPNxdqr8t0gLl3cesDGvdD3tCZvxtSFlnZFVovNxj/mK298iek
	0PzkjaM1Myc0XbuOtxlK8KE6cpYEK9Z4KJNs5N8h9v4SkVFpGGTWi6RrkOJAEPIwrs5p5VV73ExvI
	N3Cu+pM0zDcHUXqhPn2Gchy2NOqfhwF6+RrNFsdiLTrk41NPigYn2AXNxj4EcuYzzeMF27Q+VEO3d
	NLGM5qKFZonzdcJkDlwjTR2/k5EvedYGIdcpzo5Z4XPzjkp07Dv97Hkm5PkexMyFxFW6/c7neboNe
	qNkT+y8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ovk-0000000E6NX-1IDw;
	Wed, 01 Apr 2026 06:19:56 +0000
Date: Tue, 31 Mar 2026 23:19:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/rc: support f2fs in _require_fanotify_ioerrors()
Message-ID: <acy5DBohMXkFXd-_@infradead.org>
References: <20260324025656.493776-1-chao@kernel.org>
 <acN4PWKHvk_33VB7@infradead.org>
 <20260331201105.xxjmqfne4rckc26b@doltdoltdolt>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331201105.xxjmqfne4rckc26b@doltdoltdolt>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 01, 2026 at 04:11:05AM +0800, Zorro Lang wrote:
> On Tue, Mar 24, 2026 at 10:53:01PM -0700, Christoph Hellwig wrote:
> > On Tue, Mar 24, 2026 at 10:56:55AM +0800, Chao Yu wrote:
> > > This patch allows to run generic/791 on f2fs.
> > 
> > When was this introduced?  This doesn't currently exist in mainline,
> 
> Hi Christoph,
> 
> g/791 and _require_fanotify_ioerrors was introduced in v2026.03.20.

I mean the f2fs kernel support, sorry.

