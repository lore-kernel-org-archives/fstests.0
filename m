Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED5B1B808
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413697; cv=none; b=bsAmjiH68w7jeZJZwNVO1sAdksOt3+rTAIeQXpyzVAYdCI7S2hRs2W+Gm/5kyrOeoG3Atpk57DIyz/FKGXim2NSNz2aXOZZx4MpO6HgRGWB0BxzOpC5n7mYY3JqRD2O4loXHbd90HIjwaKIQymg9wN07TmJbukZuzojOfTJ4tRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413697; c=relaxed/simple;
	bh=f8VFXUTvghtS7Q0XEodDSa6qjyLQ7KyCQiE9tqK3/r8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmrneRuIk6NMJrxrDLM+R+/Ffxub60JnyDC2GAIUr+3xrXMooHkFNjF1WXzPT4cUuiei0XEjmz2x8IvpTbzBkP/WIEGAlHXlJsMLARGiKj1PYEOrkmW6PSIJWxbK8uXqeQRB3sG7WHHZ7G2VktiO0/PNoYjFwTGw2OKVDl0CivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C80268C4E; Thu,  3 Sep 2026 07:34:51 +0200 (CEST)
Date: Thu, 3 Sep 2026 07:34:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] generic/091: enable sub-block reads
Message-ID: <20260903053451.GB16469@lst.de>
References: <20260831065120.2578146-1-hch@lst.de> <20260831065120.2578146-4-hch@lst.de> <20260831171931.GD839663@frogsfrogsfrogs> <aphR1JHVpfU9_zTG@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aphR1JHVpfU9_zTG@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 03, 2026 at 12:46:54AM +0800, Zorro Lang wrote:
> On Mon, Aug 31, 2026 at 10:19:31AM -0700, Darrick J. Wong wrote:
> > On Mon, Aug 31, 2026 at 09:51:06AM +0300, Christoph Hellwig wrote:
> > > The description of generic/091 claims that it tries to exercise sub-block
> > > direct I/O, but the test currently limits reads to PAGE_SIZE alignment.
> > > 
> > > Use the new min_dio_alignment -r option to query the minimal read
> > > alignment and only limit the read alignment to that.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > I've long wondered about why reads are the page size when xfs could
> > easily do smaller...
> 
> Maybe we should rename psize/PSIZE in _run_fsx_on_file helper (and cases
> call *run_fsx* function) as well? Keeping that name for DIO read alignment
> doesn't quite match the new semantics introduced by this series.

Heh.  I found these substituations weird, but also don't really undestand
the purpose.  Why don't we just pass these as explicit arguments anyway?

