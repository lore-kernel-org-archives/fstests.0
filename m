Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A4524CA
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941521; cv=none; b=S4Eg7u4Z6e6TEvFqkIHtmlCdlhud77WqHIgUJ0G/eDsv39QoWlpw6suGrE4IBTf8KRnujzAW3hdERtLkwlAMUUgLhdNRo0Nz6eKbsq4RJ7C7aYt8V0lRnv7dWBqi7zZKMl73MCGWTTPm5+2J7T+k7W3vIql0FjeAug3GkhT1vpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941521; c=relaxed/simple;
	bh=Oj72ZDYXvE7wY3UPhwSNYcoZRO7uatVhMexptiLM55I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFvV952Dyg02i0WLDu+XXogT6l7RPSKxKm+utCpgw3Ak1ZKZoWOJw4BWQhM8FIClT9qzwEENP/6uBbhxJCrls8RGW5B0MB76Rib0nEjUeNtwsDOLHyG4ZuioJ9/6vATzbVNTtnKSkm8kRPX9w1uFEWFEbr/pCpfVR8bEM4dBTHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E7AA68CFE; Mon, 26 Feb 2024 10:58:29 +0100 (CET)
Date: Mon, 26 Feb 2024 10:58:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] common: dm-error now supports zoned devices
Message-ID: <20240226095829.GB26465@lst.de>
References: <20240221063741.3563039-1-hch@lst.de> <20240225163828.7a3tntpg5kaywlw7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225163828.7a3tntpg5kaywlw7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 26, 2024 at 12:38:28AM +0800, Zorro Lang wrote:
> This patch makes sense to me, but I think this patch might cause
> failures on old kernel which doesn't has kernel commit a951104333bd, right?
> 
> Is there a simple way to check if dm-error supports zoned block device? If
> there's not, I think we have to let it fails on old kernel, to make it run
> on newer kernel.

I don't know any way.  But as this just affects zoned devices on btrfs
for now I guess the usual parties can just make sure it works by
backporting the right patches.  The previous don't work wasn't even
a not supported, but a case of dm-error being buggy for zoned devices.

In other words the original exclusion in xfstests should have never
gone in and whoever put it there should have fixed dm-error instead.

