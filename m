Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD0442B06
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386588; cv=none; b=I2wxSqQzIAaR5q1mKSIarWXXGtFj5rjQ/soFLSEwPTdS6w/Y4kzK/wWaTzgmgChz6xr9/NzCHvNUQaQqYeJGyG9tNkV+qAwMoKR54MT0zzZI/VMy/klzKV43QdlTxHvcyzMq4TA9b9Rf/nWXQiINz6bOqrzz6neGJA7aPzQYMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386588; c=relaxed/simple;
	bh=JPwetO5K7NLk32lHSvgmsI7uZ9bbMTewFuCpPWCz8J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNTZZHdwv6EvkxeIaoqsN2OZlB4iRbDaH9XRtT1eWD95viY84L8Fy2sEKWs0h7maBsAOT1jV5zVzolHHbISV0vPW73cG2sN1Of++z9cUE9HgsZv9yh5yXAemvjdMc5+h+nB66Z9Vy+BaW5SSmDm9V8NDynTM68sqAf1ClEujHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 31FF468BFE; Mon, 14 Sep 2026 13:44:18 +0200 (CEST)
Date: Mon, 14 Sep 2026 13:44:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] min_dio_alignment: add a -r option to query read
 alignment
Message-ID: <20260914114418.GB23111@lst.de>
References: <20260831065120.2578146-1-hch@lst.de> <20260831065120.2578146-3-hch@lst.de> <aphNSwwkbZTSkBRz@zlang-mailbox> <20260903053409.GA16469@lst.de> <apl3SkiDvs7hPD5O@zlang-mailbox> <aqfAZC5O21fYmVNP@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqfAZC5O21fYmVNP@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 14, 2026 at 05:44:07PM +0800, Zorro Lang wrote:
> > I couldn't find any mention in the statx doc that STATX_DIO_READ_ALIGN is
> > added by default, explicitly specifying it seems more aligned with how
> > the mask parameter is intended to work. Would you like me to fold this in
> > when merging? or did you omit it due to other concerns?
> > 
> > This is the only open point left for the patchset, once we reach consensus,
> > I'm good to merge it :)
> 
> Hi Christoph, friendly ping, I'm still waiting on your confirmation before
> merging this patchset. Would you prefer I keep it as is, or should I add
> STATX_DIO_READ_ALIGN?

Hi Zorro,

as I wrote in my last mail, passing STATX_DIO_READ_ALIGN is required
by the interface, but on XFS, the only current implementation, it
actually works without that. So yeah, please add it, or wait for me
to resend the series as I've already added it locally.

