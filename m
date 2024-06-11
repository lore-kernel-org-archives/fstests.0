Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2B40849
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123127; cv=none; b=f0nVFOg3mddBRbv4uYUdfbpSqhyxcWATDju/HSt0e9IEmQ+Udz1Pp2EKnmr2kjV/5WYKjXZHgK3X3Qc3xaIYSJey9dGiODp61wQ/NBBgCUlSDhyyo3TK6DpOtjKGGeRh9vB0EcVcT9x+fhBBRF1Bfr4ndGDfU8cOUGzHjH5p8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123127; c=relaxed/simple;
	bh=yJ79jtN2XcURLEoZ+e71pOr3UJxRNep/DVOjb/IL7MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wnv8p9FrFAU9RrUDlIiIusSpuM2iumksb0sOkYff/njT76e2rQL7khpITLAczqPjxQRNQ/nhHEP8XP6xHd0JaL7DHW2wxADFmuM9GPGsMB1YuYuNopl0G3gp1R9wAsWgerdVK+sjR7yKN+UKsTrcyMNWoBPYDGPY42wwZ6qKe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=skMIug7L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="skMIug7L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zMswqgAXcMu+xCKVA8ZqIpunFqLamxAUtGlva44bgRk=; b=skMIug7LbSFC7Ey25YkMRsf9zT
	HMl291jaXvY1iK3QLaBPCOoaslhkLPq6jzldx+LF54G/jDlfpjuxMidV+pUJ7X+9XEknwpNZusx6d
	C3jBlkyuMHEKqgJ3hCOO7AcWMvfo7v+l0DnWIQYTWLvQmi5cFnzR/lcU2KIe6gLE1+Xq38MD9sGgt
	WimDG33OPrybTsRG3EkZGXKt85Y+oMUuaIc/ULKtBEWzXQscEKakMcJ0Xh3PzZV5z6ig6k6G0IUKZ
	TohYI55ET+Ya7Fmj3qdPLcao/Kpcn5Oxj/VdPEgqbdcAs3nr3Tnbate7j9ihgKGp+P32BzKWtdHH8
	PDf43Pgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH4JJ-00000009UvM-3dPo;
	Tue, 11 Jun 2024 16:25:25 +0000
Date: Tue, 11 Jun 2024 09:25:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: Re: can we pull in git as a dependency for xfstests?
Message-ID: <Zmh6dRpmWvOF0p9T@infradead.org>
References: <ZmfjlWGk04r_R5j6@infradead.org>
 <20240611142405.GD52977@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611142405.GD52977@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 11, 2024 at 07:24:05AM -0700, Darrick J. Wong wrote:
> > -	diff -Naur $source_dir $target_dir
> > +	git diff --no-index $source_dir $target_dir
> 
> How about
> 
> 	(cd $source_dir ; find . -type f -print0 | xargs -0 md5sum) | \
> 		(cd $target_dir ; md5sum -c --quiet)
> 
> since 073.out doesn't contain any diff output?

That works fine as well for me.

