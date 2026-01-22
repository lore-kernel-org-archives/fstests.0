Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2253359F86
	for <fstests@vger.kernel.org>; Thu, 22 Jan 2026 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066731; cv=none; b=iPIDuDYwYJl9b11ZLbpH6W46qdwhU3quNqDup3N6U+LW0cf8YRtkVU88N4yAyoZARoPvkDPQ+BA16VS6l8CVJ8pJaC11GnhbIX66RplO4jC7f/3VVoTcj2bJXKFGHB8Jrnp5uX9VXpM4KrYtj+HN9gQGlFXpIHprkyavJx//YUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066731; c=relaxed/simple;
	bh=qs1rexq9BpUUaCWQ6hMLdsRgxHZqQzq4EZjYucTaU0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Szy1xnvsgfFH50QXciAXSwwL5PSXmizz6DKiCLt5SHaLLpbOc30yr760GuGFTNjxU8yVdJgqLSVsKJzo2inXNUH0fvvTfJtLyerkoNz7XI6mc1iHKaRHAj48Y+ngPkWoEZ6FZVGnEeCbQPBST39NclBKP5X9vQeDlHw7OmGgcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9D2D227AA8; Thu, 22 Jan 2026 08:25:19 +0100 (CET)
Date: Thu, 22 Jan 2026 08:25:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org, ebiggers@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test that truncate(2) on fsverity is blocked
Message-ID: <20260122072519.GA25329@lst.de>
References: <20260119062404.3998871-1-hch@lst.de> <20260121150833.shad4rfhqd4deg2s@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <20260122055908.GB23964@lst.de> <20260122072358.4sujn2ygbt7zycqb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122072358.4sujn2ygbt7zycqb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 22, 2026 at 03:23:58PM +0800, Zorro Lang wrote:
> On Thu, Jan 22, 2026 at 06:59:08AM +0100, Christoph Hellwig wrote:
> > On Wed, Jan 21, 2026 at 11:08:33PM +0800, Zorro Lang wrote:
> > > > +	dio-writeback-race unlink-fsync truncate
> > > 
> > > Need to add this into .gitignore too :)
> > 
> > True.
> > 
> > > > +_require_test
> > > 
> > > Does this case need TEST_DEV and TEST_DIR?
> > 
> > No, just copied and pasted.
> > 
> > > > +$here/src/truncate $fsv_file
> > > 
> > > _require_test_program "truncate"
> > 
> > Ok.
> 
> Thanks Christoph, BTW, as you said "btrfs was missing this check", so is there
> a known fix/commit related with this test case, if there's, feel free to mark
> that with `_fixed_by_kernel_commit` :)

I sent a fix, but it hasn't been applied anywhere yet.

