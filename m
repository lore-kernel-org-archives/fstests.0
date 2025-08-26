Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3B319867
	for <fstests@vger.kernel.org>; Tue, 26 Aug 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214556; cv=none; b=RG79mAkJW2VyCGQs+G+sNobicXlt+QlQRqOMT+KqVPuMOdeq6gw/nCgdzvcsptttzZGXAox4o1xpahCCnplrH+zXzJUyuXzfvPP3BOq08MTfAKO9xpljBm9W/Vslub9WckrqcQUuoQqspLTUOzvbfn3oVMDOcY65T3D4oVcP1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214556; c=relaxed/simple;
	bh=99W2vbZ7GLWT411mav4XpM59eQdiDDy88cCZlmY1TqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5X/hQ/bhSICr81lI282fA98DGGqW83BnsCas5g6e4W15Q3lBl19+46XVWPYKLfEduZvMHK8dDob/st9WzspdX5ta+jwtUcZR2JZd3KjZd8TvJNnqwIJHdmxICzqZAiXC3tLX3z61KVs54wVOnguWW3rh7Li8+HC43zAqMXpbzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 521E867373; Tue, 26 Aug 2025 15:22:30 +0200 (CEST)
Date: Tue, 26 Aug 2025 15:22:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] dmthin: _notrun when dm-thin setup fails
Message-ID: <20250826132230.GA1870@lst.de>
References: <20250818072724.1559133-1-hch@lst.de> <20250818072724.1559133-2-hch@lst.de> <20250818205131.GD7952@frogsfrogsfrogs> <20250825154410.dt5avycrauhtd2te@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825154410.dt5avycrauhtd2te@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 25, 2025 at 11:44:10PM +0800, Zorro Lang wrote:
> > Anyhow, failure to set up a dm-thinp volume sounds like failing to meet
> > a test precondition, sooo
> 
> I'm wondering, if we choose _notrun when _dmthin_init/dmsetup_create fails,
> but others _dmxxxx_init/dmsetup_create [1]  fails, we still call _fatal. Isn't
> that an inconsistent behavior :)

I think more notrun would be fine.  These are the ones I ran into
with a totally normal setup that has PI enabled on the test and
scratch devices, so they were my priority.

