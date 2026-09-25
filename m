Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597AE30E0EE
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 05:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312607; cv=none; b=FuvW7/uApF66QPWRG1Pfo8WiyrQO5T2BDM3/pMQj35oIrMueePWdaJ7Q9QaU8dDgfcK+L8U9lVJT2o5PhkKQHTDhhCjaRvH+S6iHym3nsPPGZbJYfLzy6F1OaErC1EpzK0Jubnv6nBhQLUiENUop2Yrm39nT/bWmofyZv7bBhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312607; c=relaxed/simple;
	bh=5FnxNnFhfz9WD50mdLk/BGWuLceAnUjwUF7ZddIVyIc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=islXIOiCPTSFXVKOa0fd0BsrJwa4/yg0hlBd+gwY48ka013sCU8SXxfDglbuFOMB0zrBQYNeqMAZmIbOJ7MFVgsgKkz6vpTOfwyIXFh+qRe9qANaMj9v/bbEnhelzHZq7hk0WjdzfC+WLRUOGcZpKxcOLonMrQsYKEX81O5MRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8824068BFE; Fri, 25 Sep 2026 07:03:20 +0200 (CEST)
Date: Fri, 25 Sep 2026 07:03:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, moritz.tanner@linbit.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/805: fix for external RT devices
Message-ID: <20260925050319.GA2408@lst.de>
References: <20260924062118.2684441-1-hch@lst.de> <arUqzDhkxgvrhpa6@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arUqzDhkxgvrhpa6@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 24, 2026 at 09:56:53PM +0800, Zorro Lang wrote:
> On Thu, Sep 24, 2026 at 08:21:18AM +0200, Christoph Hellwig wrote:
> > use _mkfs_dev on the dm device instead of _scratch_mkfs_sized, otherwise
> > the file system could be created with an external RT device, and will
> > then fail to mount without it.
> 
> This patch makes sense to me. But I was wondering if we should have a helper
> similar to _ignore_scratch_external_devices to allow a temporary device to
> act as SCRATCH_DEV, so it can use the _scratch_* helpers ?

You can't just ignore external devices, as options might also not apply
any more.  We could add new helpers for just use scratch without
external devices, but IMHO there is no much benefit over just using the
_dev helpers.

