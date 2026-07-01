Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835242DFEB
	for <fstests@vger.kernel.org>; Wed,  1 Jul 2026 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903050; cv=none; b=NqnqsaPpVTkNAvRQCcR72OYOuTp3drFiQ4Qq4+asCsobqSaCQv+FKWLmmv0QZUT5n88kUCviah/QMe4ljBZZmU09H//9suUoQjxrA+nzKFv4QdgfRIdntDHMPqwd8hRQCV9SkMGo9zoBgclsDh6YJxz6PvtUJMzg+qVDfC8kCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903050; c=relaxed/simple;
	bh=LtnwQZlBjRDX9PcZweRBmYbIILGlMl2jqXivXLd6R6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A08+81/8+Btd8H9I/CN6A/Lz7EsWOpCCIG3e/+gGGuK3yX9fW75FdB4S+aK2chvifMBm1NPSeVTYh9QRVWzsH9XhA59KcRpSnfh64guPagakmn0AtSCQ/ZzAEoNYC8HAiW6RXQqp0wH1Q78ZmOM7WNqjvUubcGJwfMIHwWlUid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFF5B68C7B; Wed,  1 Jul 2026 12:50:46 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:50:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] common: log mkfs output in _test_streams
Message-ID: <20260701105046.GA14128@lst.de>
References: <20260630142047.3612436-1-hch@lst.de> <20260630191303.GA6517@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630191303.GA6517@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 30, 2026 at 12:13:03PM -0700, Darrick J. Wong wrote:
> On Tue, Jun 30, 2026 at 08:20:47AM -0600, Christoph Hellwig wrote:
> > Log the mkfs output to allow debugging the mkfs paramters,
> > especially when mkfs and thus the test fails.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  common/filestreams | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/filestreams b/common/filestreams
> > index 459de8c6b6a6..0b11b6644977 100644
> > --- a/common/filestreams
> > +++ b/common/filestreams
> > @@ -89,7 +89,7 @@ _test_streams() {
> >  	# Skip these tests on zoned file systems as filestreams don't work
> >  	# with the zoned allocator, and the operation below would force it into
> >  	# the tiny data section only used for metadata anyway.
> > -	_try_scratch_mkfs_xfs >/dev/null 2>&1 || _fail "mkfs failed"
> > +	_try_scratch_mkfs_xfs >$seqres.full 2>&1 || _fail "mkfs failed"
> 
> This should >>$seqres.full so that you don't obliterate whatever might
> already be in that file.  Otherwise this sounds like a good idea to me.

Oh, right..

