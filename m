Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56FC3C47C
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882971; cv=none; b=Ob+dOj1BFCfSsRuDdXyQDrwThP2irx1Kf8JnCbPz5dJtkTXA/qtIWBCyzC+1rAkTaYHxR5D76Hs3lwgcg5sLYil0J+OmNxtd/WeJclwCxBBiJqIrOrczeC5tCwcjmDbM+AEoQfnhJvWedA/x1YOXm7sKi5NuTcEHVlHrMu+WDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882971; c=relaxed/simple;
	bh=QLeKrWuxA65FL2TxwwlTBWYgJNgOhnsVDDZoBmQeafw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ+i7vbut8MY8yuaCDuTDU1kRgxtiKXRxCpu/u8/7m1CAOvXJmJEPMZOOr3WmhefKg8EiBHps9oSKRRBkn8r8EUr/ad1Xn7uOEQ6PXsNKw6OVf0jSHcNlD1pY2/2pB1MjaqGAMJUvUD43/Dl4laKGQ8FIW9jD/1iMgovNsGqac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=van+clLf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="van+clLf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7jGKfeaLspQlrVuaXasC/Ct4R22k9ljhc2sGi2xXb8E=; b=van+clLfPb33A3V/3tThhB62+/
	6CSvcXaVY90CAIorgPKOU3OWa96i3Bt1ta2MoADzQA7qvlDeGEIeDkQrmCFpEe0/wSGPXpD3T6TWE
	kWf2zhqv5Wy3vpr4OZRhOS4GzXlhd1zrqWWnyUbno0+gYK9+tjacpEsYmVWw78kyLjLdsteYdpTC2
	kegjkiifyoe8WU8hJg3XUH+SqUaQgMg7A8wG2WmXz89h4a925vZ+dgnYrYmagVIZmPp0QYkAt0hbk
	p/zsXgGSFrgpg4h12JR92zyufvkdWETbgZ4X4rYHfRqijFeQOm3ahP0OmaO0TY8Jy6tRKzveV+gja
	DgfOetEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmgoX-0000000EGGf-0tLk;
	Tue, 19 Mar 2024 21:16:05 +0000
Date: Tue, 19 Mar 2024 14:16:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, David Sterba <dsterba@suse.com>,
	fstests@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <ZfoAlbEAM2nzA3OW@infradead.org>
References: <cover.1710871719.git.dsterba@suse.com>
 <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
 <Zfn9DMR8UQQMiyiL@infradead.org>
 <20240319211050.GL6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319211050.GL6188@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 19, 2024 at 02:10:50PM -0700, Darrick J. Wong wrote:
> I don't think there's a good way to _require-test for holding i_rwsem in
> exclusive or shared mode during an FICLONE operation.  But that ought to
> be a comment somewhere at least.

Throwing random per-fs hacks into generic tests simply does not
scale.  We'll need a way to describe and opt into these behaviors
in common helpers.

