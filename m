Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A84BD7AA
	for <fstests@vger.kernel.org>; Fri, 18 Sep 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722114; cv=none; b=nk82+5km642vNKzopmUaxBOVbbmmvNIXAmcbplHqkAYS11hrbevgn7dpw6CXPaDsW19uQ80mgTaLQwvKF7kq7Lhl6O+37q1002oAwJpw60TG3t2KL1wI6x7QEBYGfMy692PS3eC1gTTHr/sEk5pWRZgBdE4R5ks8LFHXkcO8JZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722114; c=relaxed/simple;
	bh=a3IUeLVI6y4tZ7ySB0NG8iiYfS86H0IeG9cmr2dKkfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfoLMtB1qyMH5qWtgHffdFVC7GjpnyIwDaWhEa0uU01IKOTzpkIirJufoxj+WOxVTcQITaLIorWGXP7RdzXCzIghLRYbMOundH8skbjIzsjIZsc838hFxbPE/kZB1i9HgJ+Jg/crmJrOsnXW2PhF6Ij9Gh3XtWVz06GPel/D5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2556068C4E; Fri, 18 Sep 2026 11:01:44 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:01:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Moritz Tanner <moritz.tanner@linbit.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] generic: test bdev freeze count leak on nested thaw
Message-ID: <20260918090143.GA12603@lst.de>
References: <20260917065938.51819-1-moritz.tanner@linbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917065938.51819-1-moritz.tanner@linbit.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks!  It turns out that a few xfs-specific tests actually are
hit bit this bug, but catching it earlier using a dedicated generic
test is much better.

Reviewed-by: Christoph Hellwig <hch@lst.de>
