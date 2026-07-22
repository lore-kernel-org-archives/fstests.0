Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206303E2751
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710785; cv=none; b=MddWLStcIoIz0jHIAXs9IeMC8jiH62rZAE55XPfEtdALcCzjXAFifznf/ZnAUajm/iBEeDJ3lcyb8YLigMc0s0FMQNajydubhWn70zg2dW5Q/0vCQ8Z/ntOlARHvDlh/bU+myWaqV5LmRPP1JIoFZnEPBqJbXAuNrJOTBqNbdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710785; c=relaxed/simple;
	bh=Z8m36YjCHLk2ONxzy6egXmcUv28iyQxHc9Abgnzgq9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMXCgIeXwK67jpWk9Y0OMqqgoDWTpTgrcR+0k7smjlGykEWhvmkxKn16ldzOJtu0w/jvoqlmI3BwZxb5fhCBjFTD2r8fTFf3dL73Y/c7dr6TBk8SON6d2KGZlVf1TVDvcffMwKsHMx3FB2MJOZCTa4RPFICOCNaHWJSwPX/7oIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J4uquJmA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J4uquJmA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bw/ZwJMR2E4oPPf21+xmPO1rb6lPTHcC55Yd5BZPcLU=; b=J4uquJmA2FpCnM98prIs7uSJEn
	ADzYc74f9ZqtPGNeHhf6amMxoXpK3GP0Z8poom+Gw5qbOiIkWupWAQNuZ3fLzIfoQFPW7NjPb5JNa
	KCMg671g2fNfymh/hyeNnYMjqhRKmBxExBMdMktVFXQ32o6wIY4L3jCFR/rHx/FMZn9KFSrmIZofI
	a+A+9FLLmWw5Uz0foDo1jBP/pXkAx8ZDmFOi9FRHf23jaSDMcZkJp8e6fOSQvI8QzPeUsnafmmU/J
	ccub/qwleepEdHAoT1bnYMfUuhmBuYWCrcp3YNBtuYnGxxOUp2qNgxoJdpGnr7dKH/3IDYAf59VxN
	0U/UQ/CQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmSnl-0000000BJgc-2Gyn;
	Wed, 22 Jul 2026 08:59:41 +0000
Date: Wed, 22 Jul 2026 01:59:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>,
	linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org,
	jaegeuk@kernel.org
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
Message-ID: <amCGfUHu6kI4CPND@infradead.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org>
 <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
 <al3Wcz5pIujPdTrL@infradead.org>
 <1a0bb2ad-c175-4cae-9e3f-79fbf69ce735@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a0bb2ad-c175-4cae-9e3f-79fbf69ce735@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 22, 2026 at 09:12:48AM +0800, Chao Yu wrote:
> Hi Christoph,
> 
> On 7/20/26 16:04, Christoph Hellwig wrote:
> > So looking at this explanation and the code, f2fs does not actually
> > support COLLAPSE_RANGE at all, but emulates by doing a full data
> 
> For non-checkpoint data, we can just update metadata w/o any data copying
> to support COLLAPSE_RANGE.

Can you clarify what "non-checkpoint data" data means?  Older data?

