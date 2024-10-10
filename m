Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366A1AF4E9
	for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543598; cv=none; b=s9Z/80a/WsZyuD19GaEfw+Qd8zlg7xe5TfjN2Yvxv8NUYEQZvoFnOGpDftGjDnwFI6f5tC5jn3ktfK+D8rjuvOpq9Jurmv4WkI3PB1KlAms5FvjjcmsVkapHN3oE244et6RsBlnCqmR3KZobseuZRM+tZkdbp6cGnTIjyub0Xfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543598; c=relaxed/simple;
	bh=lbgSa4YSNsiLBhEdXT7mWa+Dce1CMoIXLnX79zRj7/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTdnDQtOwZeuM4qHrE/IMQCXtlCLOvBmYUXXdMp4V79wyTvY3dpIaoUT0yDQlGzZAFGeNeNEBns9YGl7i6+3JciunSN0UJQc0orkIYj8pFAN+Txca5iCEaPY2uA6mmHln28gi/SDr97ZUZSf8B0No2ZYc93uIlb9cJz/npPVjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42E9C227A8E; Thu, 10 Oct 2024 08:59:53 +0200 (CEST)
Date: Thu, 10 Oct 2024 08:59:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/694: sync before sampling i_blocks
Message-ID: <20241010065952.GA6674@lst.de>
References: <20241008071209.160188-1-hch@lst.de> <20241009144817.GL21840@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009144817.GL21840@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 09, 2024 at 07:48:17AM -0700, Darrick J. Wong wrote:
> > +# make sure indirect block reservations and other temporary block reservations
> > +# are release before sampling i_blocks
> 
> Nit: '...are released before...'
> 
> > +sync
> 
> Should this be more targeted since we only care about junk_file's
> i_blocks, not flushing everything in the system. e.g.
> 
> sync $junk_file

I didn't even know sync took an optional file argument.  But yes,
that should be fine.
