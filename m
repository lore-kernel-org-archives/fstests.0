Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C31EC2
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365532; cv=none; b=aFDz3VdpcFBuTcMeh5Q2OekrLLEX6dCnO7EEkZAOZInhWq7oURwSaMUHb0tfxa28d1M6kuxnwZeRaPI3jFwDSBmbQIMA+dPoV1xLEgMaVMSSB0EpzdUHm0duRNs8PB8YVOOqKFc9b/ITRaZTe/HPUEBN4I4nXGmxTXAu7nHLhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365532; c=relaxed/simple;
	bh=AhYy/KmaHU2bgdiyTTZ4z2plW7Rb2AKQw/99EIBdIvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKfk6dv9D1dhl0PxJXYUlnKZLuchaSOgU8ZWPCPvD1W+2TNsws75toI0H5q4rSNYYLUPU8el+DVnpf2O5RVckwoYcF1nVZED4REru3ZOawgor0cLwAwphab3x22GYnBXLx8JQDYoqC3vaAbizF/oovfxbEHv7sbry3LhX+E87G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21D1D227A87; Mon, 29 Apr 2024 06:38:39 +0200 (CEST)
Date: Mon, 29 Apr 2024 06:38:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: add to the quick group
Message-ID: <20240429043838.GA31611@lst.de>
References: <20240427075530.1236045-1-hch@lst.de> <20240427174953.nlw5gfi36syp5jnw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427174953.nlw5gfi36syp5jnw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Apr 28, 2024 at 01:49:53AM +0800, Zorro Lang wrote:
> On Sat, Apr 27, 2024 at 09:55:30AM +0200, Christoph Hellwig wrote:
> > generic/095 doesn't take more than 4 seconds on any of my test setups,
> 
> Yeah, it generally takes ~5 seconds. But there's a "LOAD_FACTOR", so
> before we add it into quick group, I'd like to ask
> do you think if it's worth increasing the default LOAD_FACTOR a bit to
> give it more stress, or move it to quick group directly?

I'm fine with it as-is.  Despite being in the stress group, this test
actually provides code coverage not provided by other quick tests even in
the most basic version.

