Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53AB3E1D16
	for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530423; cv=none; b=JODyiOBU3cXNUskEe+eDrlaX+rqp1qSbjHriNPW6ehQ01I4RyHcj/bCR9IPmQSIZTVmExbLiRm279dfHNj7YwK1RPv7CYJDy77qbwtqCx0NynHdMx0aI4POpqn1ki+FxwRTH3sZTkiI0f4EN1yAvIc0hH6+1RmQLeebBs2l7eBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530423; c=relaxed/simple;
	bh=4yeSinF85CDsootD7G+MCLUhYXF1qQK+GX47Mvlvy24=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb22zR7L6NdVoHMZtBKPvejJ8gm1PNrctZvXUQUgKgwG1gj1Nl1QGJMzmCVGi9yo+3a74Z4mA03tYhvZcqZs3gZrmpYrraQI7F0B4/wQKWsmzlpN+vrfIFOWXkYuuPovFeKS9wHJRhe2AsCV43cva2S5v9DV3yQFPiSSV6r8/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E3B668B05; Mon, 15 Jun 2026 15:33:31 +0200 (CEST)
Date: Mon, 15 Jun 2026 15:33:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/366: check minimum dio size correctly
Message-ID: <20260615133331.GA26132@lst.de>
References: <20260608070010.1285677-1-hch@lst.de> <ai75PcdwbK7kYBTU@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai75PcdwbK7kYBTU@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 15, 2026 at 02:58:11AM +0800, Zorro Lang wrote:
> > +	blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> > +	if [[ $blksz -gt 512 ]]; then
> > +		_notrun "512 byte dio alignment required"
> > +	fi
> 
> Do we need to check this in every iteration?

We don't, but we also don't want to do an extra mount just to check
the feature.

