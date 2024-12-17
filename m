Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370D1DA0ED
	for <fstests@vger.kernel.org>; Tue, 17 Dec 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423112; cv=none; b=Dy8Rw6W2taIRxNqwcNP6OSFpQ47WCx8MA075+Gu+m3O+yC6G3hAGH8U9N1sKxxbucNFtSK4fLvRRmOe1l5G/0qqM3sbwKk4k5gs6jawWiHcDATRWdsmT2nYr9Guv0uw/l1kto94KUH6cXmcMebkP37FKE5RcwCwE8ZD2FTRMk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423112; c=relaxed/simple;
	bh=n1ZpnVzkd5nxoBm4erxNzA4+3SxYZo0XiyZVXmL3fpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9/u6aezBPYb8N78xDHoWbEMcvd4xMieZiMdKO6j2Omhc4OFzindqQJ5PnS+zKTi5oB5gy530A9yTaV+kUuOp5GWcgNj00j/8QMPLVDTSrq9VV6YCG0M5f/lJ27fGBIRcmrKNyPxX39HZmmi6aFjrmDeBmItDevBakg4BURZldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sf854OGK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sf854OGK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pMJ91czILfS2jODbHij+CdHMxLo8D6a/1paPrQinmn8=; b=Sf854OGKJaaib/uBqRadfiRUzI
	R6OMb8ePe73f1NSucwWcrHOv8RiUgag89tjithHb548PIG/bDRPlHZ/5y/hKAH9dZEG2JWarqKIsJ
	0X1jVH/HFxcQDEe90fykKMnLWCO4h7ZauT7lI432fljC1NgmzYAA7n88myAvC5VnNkhq6PNJJwngi
	oEfyD/Hv+CtWJD8aJfwMNN0au4zwna1CNcHv5gC+fi+E60eWK3yVb9Da/NfhEGD3IXYPnqHoAMmhw
	4+upoxp1lWAZz1lT09KvQ4nKIu4rSj4+p3Dad3Vx1iVjQF54n3JJoNQvwoVa635L2/mZYeMuuQtNE
	jT4OzD7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNSgI-0000000Cfg2-0hlp;
	Tue, 17 Dec 2024 08:11:50 +0000
Date: Tue, 17 Dec 2024 00:11:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] generic/135: don't try to rm $SCRATCH_MNT/*
Message-ID: <Z2EyRqCv8D6oMpHA@infradead.org>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-2-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215051242.3340572-2-tytso@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Dec 15, 2024 at 12:12:41AM -0500, Theodore Ts'o wrote:
> This fixes a regression for ext4 introduced by commit 32e14cb90b88
> ("fstests: don't use directory stacks"), which replaced a number of
> files at the top-level of the scratch file system:
> 
>     async_file sync_file direct_file trunc_file
> 
> with "rm $SCRATCH_MNT/*".  This causes a test failure on ext4 file
> systems caused by a failed attempt to unlink the lost+found directory.
> The thing, is these files are all super small (4k or 16k) and the
> scratch file system is going to get reformatted before it gets used
> again.  So just dropping the delete is the simplest way to solve the
> problem.
> 
> Fixes: 32e14cb90b88 ("fstests: don't use directory stacks")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

