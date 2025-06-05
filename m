Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778751F956
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132728; cv=none; b=eVROTJL1afhsbYnCE1W93LyDGuQgeZSp7S5QiywoPa1lVCBq8HvAl4ymm6DMQr5ue1S9VMiDuWPcJWnet7TBV2hPcsq0HzWo76O9F+WahSHuM3s4qmVFk8hWIeCA3HkYEDK+L8KOCvROCuetfwIoON71jLlUslfiET6pD2M4tO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132728; c=relaxed/simple;
	bh=nRW4fbe0LyMGFAWhi1IFudikCCaPGoDLSIa8K2sP0Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnBtYs6sRJ8K4/Y70bxk/uY841RIVmNW+yxuFuGlY4SQQ9uMKnhRm60tO0GlNQHDrofnVid3CspZYrc36VHVbpK4UozH2YS7TzzFmh1/l+9ZsCoXnfsOqypUN+xYUXxMeK9p0Hs++e6jWLxXtRH39eAR543hWpFTT5lkd44Y6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35A0A68C7B; Thu,  5 Jun 2025 16:12:01 +0200 (CEST)
Date: Thu, 5 Jun 2025 16:12:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/740: add _require_scratch
Message-ID: <20250605141201.GA3986@lst.de>
References: <20250604131922.848228-1-hch@lst.de> <20250605135210.zrezswl6qgc62mmq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <20250605135443.GA2669@lst.de> <20250605140646.xzjyzkp3vkcbos4m@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605140646.xzjyzkp3vkcbos4m@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 05, 2025 at 10:06:46PM +0800, Zorro Lang wrote:
> On Thu, Jun 05, 2025 at 03:54:43PM +0200, Christoph Hellwig wrote:
> > On Thu, Jun 05, 2025 at 09:52:10PM +0800, Zorro Lang wrote:
> > > > +_require_scratch
> > > 
> > > There's a "_require_scratch_nocheck" in this test case, but it's called
> > > after the "_require_block_device".
> > 
> > Yes.  But I looked at _require_scratch_nocheck and despite the name
> > it doesn't seem to imply _require_scratch.
> 
> Due to _require_scratch calls _require_scratch_nocheck, not converse :)

Oh, I guess I should have looked deeper..

