Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886140315B
	for <fstests@vger.kernel.org>; Mon, 29 Jun 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751056; cv=none; b=RNpYOkBijqlmIX+Lp9Af0GUCmyIqZ8dwBOLC0byxnIJE3TmkVwfdPLHCtF6Qk5hZeFycKgbHWXB132CEK0A3gWSbeB5kYpCWgDetAYFDeCcQc46Az1ajwUO2AzF2MmqIrKnlIkTTx3BAWpv4XtxLYSU4vOS0h4rwpWoJuz9wA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751056; c=relaxed/simple;
	bh=Ly2eM5usbijVbR3s3cQl200vfsIvIuCXQcLe7fOGQnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmPmySAFtvpTlsIJgiJ4po8yKZMr5nGNzGxE3leDJ26CHkRlZ5o9QUjtdZHWvm7KfVnLU4oWYitzmSfJlLz8wo4B1pWnqWhuOV9zvIgsB4zVasvknmDgHDAi2Wveor5BH1cJoPaCgvsM5iEtqFPGAXQCojXwK4TdFuD05FwEQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a69pGlB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a69pGlB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAED1F000E9;
	Mon, 29 Jun 2026 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782751055;
	bh=7JHewKYa5/FTTPDRStSCJXtjBGuHptHfKbTCR8wXYao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a69pGlB4jKPrTsc+I/siJAuw8v/xiP50xITuIxUZv7uXRzugRpCea1B0Ft9FLa01J
	 3aSWZqW7Ix0lmLmF3NF9XVKH/1McKzT2BoQQAQiVeyMUYdKl0rMIaY9LVunZjUPSxZ
	 vIO3uTlKlAPO84EPoNMo0wWq4aRtDwV4G4evF3ij79hy3HQSLbwMghZRdKc0LRNDcX
	 56WWWmKBqEMjtzuSrAQnAv+2IIrm5JiUtd+fNzROy3jU6ie1bTwl2kvgfAmxFK2V6A
	 HJiVmvcdfYS6T/oH/9gABsW75rT/07LcWgNF2fIdmju9ZtavTELMm7wgcfr7rQ1Lds
	 PDY7gq6Ns8hYQ==
Date: Tue, 30 Jun 2026 00:37:29 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] generic/064: allow 50 extents on F2FS after fcollapse
Message-ID: <akKd2IImO7bRjVV2@zlang-mailbox>
Mail-Followup-To: Jan Prusakowski <jprusakowski@google.com>, 
	Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajuLORVplOvEXvnI@infradead.org>

On Wed, Jun 24, 2026 at 12:46:01AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 22, 2026 at 07:04:38AM +0000, Jan Prusakowski wrote:
> > On F2FS, generic/064 fails with "extents mismatched before = 1 after =
> > 50" following multiple fcollapse (collapse range) operations.
> > 
> > To ensure crash consistency and checkpoint integrity, F2FS forbids
> > in-place SSR (Summary Standalone Replacement) overwrites on valid
> > checkpointed blocks. When collapse range shifts blocks, F2FS allocates
> > new data pages in LFS mode (out-of-place log writes). As a result,
> > sequential collapse range calls rewrite shifted blocks at new log
> > locations, intentionally leaving the file with 50 extents.
> 
> This sounds odd.  The test allocates a contigous range and then just does
> insert/collapse on it, which should not lead to any new data block
> allocations.  Given that the test works fine on zoned XFS and btrfs
> with strict out of place write policies we know it does not require
> overwriting blocks to work as well.
> 
> So I think something is fishy in f2fs if needs to allocate data blocks
> here.

I have the same question with Christoph. Shouldn't fcollapse in F2FS just
remap the metadata instead of allocating new data blocks?

> 
