Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ECC3C07A
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442440; cv=none; b=hGsdCM7Gt+6Ns2JKECPK3xmv5Kx90Sj2Sdhh7fNXdgPZFbqnAMjnRmy+2EHmqgjqvrQfdMD1ZbiJukqGh+uTAls0/12EKx9WuyCa7ZV9GAS4VVx3bNdw8XTXYJxQ2I08+TD6kOAuFN9ZoUVgMo5p59wroCgxcBJhiZ62qGj8XsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442440; c=relaxed/simple;
	bh=m/Uovn5qp3c8kdx/jqNwvUdMDwNVHz1YHVP5nScRcTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B01R2fF0b7YeVCGO6ef0Lv5x3ejOBkwPAcJZA6ZJuRFP13RXH982YOX8SOsyjR35ucLLVIzxiM879T4yrqssytUUJDvk11wa3nbqwNgU0oJGWkdShJZwMnc2l7L1Z5mmLJGQkv9ZxFN+3p0aBNGEvLGvGfPbiHmy983oaKi9PYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCMuOYe5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCMuOYe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E981F00A3A;
	Thu,  3 Sep 2026 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442420;
	bh=sxrFoipfzeKcvepVX3s/E5oLIrJQCwmYzpgItLRjl+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bCMuOYe5wB8uByh2C594xGNynVfY6JPFyRBXpoWl9h4Y3AUfmcLR+pOym0NsQQUww
	 8rK89XRaNn9XAulsSJ0DMYDoOu6/gjAmfcvZ9vppY9KBukLUUFK1CSwkyb+QEUWg0c
	 oqlVYkDMQBYuHqBiConUCGCj/5py8pZpXXjCUICf8YteZguNGaH7mQ8T9YmmKH+ol1
	 HCTXcWDPKre4jg7JbVptEa+Q1vo46nrcvLVsrvdIjCHforvNtQS7H5wbqIga3188jj
	 Wpeozdnq9CIYJxMZ+tdyd5mAEQGG7NQ0BXuMxCSepWSP6oso6OpWPfqG/poOCXDnxX
	 CqWtY8SwXpjFA==
Date: Thu, 3 Sep 2026 21:33:36 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] generic/091: enable sub-block reads
Message-ID: <apl0ygQEwNaL20Za@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, 
	"Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-4-hch@lst.de>
 <20260831171931.GD839663@frogsfrogsfrogs>
 <aphR1JHVpfU9_zTG@zlang-mailbox>
 <20260903053451.GB16469@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903053451.GB16469@lst.de>

On Thu, Sep 03, 2026 at 07:34:51AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 03, 2026 at 12:46:54AM +0800, Zorro Lang wrote:
> > On Mon, Aug 31, 2026 at 10:19:31AM -0700, Darrick J. Wong wrote:
> > > On Mon, Aug 31, 2026 at 09:51:06AM +0300, Christoph Hellwig wrote:
> > > > The description of generic/091 claims that it tries to exercise sub-block
> > > > direct I/O, but the test currently limits reads to PAGE_SIZE alignment.
> > > > 
> > > > Use the new min_dio_alignment -r option to query the minimal read
> > > > alignment and only limit the read alignment to that.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > I've long wondered about why reads are the page size when xfs could
> > > easily do smaller...
> > 
> > Maybe we should rename psize/PSIZE in _run_fsx_on_file helper (and cases
> > call *run_fsx* function) as well? Keeping that name for DIO read alignment
> > doesn't quite match the new semantics introduced by this series.
> 
> Heh.  I found these substituations weird, but also don't really undestand
> the purpose.  Why don't we just pass these as explicit arguments anyway?

This change traces back to commit 3597757462a7 ("fsx: Small improvements
and fixes") from a decade ago. It moved run_fsx directly from a local
test-case function into a common helper without any modifications.

This issue doesn't block your patch series. I'll send a follow-up series to
clean up run_fsx once this is merged, so let's keep the focus on your changes
for now :)


> 
> 
