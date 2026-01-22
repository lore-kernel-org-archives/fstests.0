Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E734A3CC
	for <fstests@vger.kernel.org>; Thu, 22 Jan 2026 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061553; cv=none; b=UKoPGId3cHGiaQTQiDpdlD+0+FSG7tBnNHqR/pGeQnim99z0ApC/vnwvU8lBLez6mm1+ixdxuJ2C2NMhuPYRUWiHIGreQPPBve6OYUUlXEwwVxrFD8Xp7HYuBALdX/oVIKZhWFc6xKAI26a09xvDQ7BdLDm/+1+fX48ftY4+pHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061553; c=relaxed/simple;
	bh=FMhKHZk+yjXOM53UjDGW02T+XLiyfW5v1KSS8V6pCqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJeXO5+Dr4KUCYcOnKLDC+WZGlAfPFzZUgle3iNK35AwQsZGtsIM4RPVQk1JkCmt27Stt+zQ7Zg2xPQkZ6BSnaznm7rjvVyy91jlTTAkV5uh16x2Yo9ygzBZYkvt28ux9GTJHEKpI2SYrmXksTjJATXqB/C32kdzmiwJxXN+XY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC0B2227AB6; Thu, 22 Jan 2026 06:59:08 +0100 (CET)
Date: Thu, 22 Jan 2026 06:59:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org, ebiggers@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test that truncate(2) on fsverity is blocked
Message-ID: <20260122055908.GB23964@lst.de>
References: <20260119062404.3998871-1-hch@lst.de> <20260121150833.shad4rfhqd4deg2s@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121150833.shad4rfhqd4deg2s@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 21, 2026 at 11:08:33PM +0800, Zorro Lang wrote:
> > +	dio-writeback-race unlink-fsync truncate
> 
> Need to add this into .gitignore too :)

True.

> > +_require_test
> 
> Does this case need TEST_DEV and TEST_DIR?

No, just copied and pasted.

> > +$here/src/truncate $fsv_file
> 
> _require_test_program "truncate"

Ok.

