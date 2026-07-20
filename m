Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61BF3AE718;
	Mon, 20 Jul 2026 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534864; cv=none; b=Vs16Rav0E73tz/B7auGmfuR0gbhBowuzDx8DAAZNRfspn7XqvUcV/5a6/W84X5GUJZcSBOofXQvUyissnabfPPDQGDvWka8E359ElOcGi7aXsjTb0U3WD3/5f2dCLZXDUHOoWv4aWSMxy3nEZQ/1MdW+u3krl/72IPBEOarofNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534864; c=relaxed/simple;
	bh=oX9m+LskLxwKLhDWP8omE/1987HKE52GUPJqsmlpb5Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI+ECkDZw1t8NCfB6lRgU23TWcOpG061wCGHAPt3C+yzBTKWkmAMFq9oNKXCBoJlPVthHMtNtZZNUWZRGqTL4dV/+F/gqaKV6SCcsgxhWd3SJ+coHK1CYhHQQ277j2IKuuoX1d4eOgyigP3mrRZTMA6STR8aXYcBJfkyNo1b9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=izn5mV/D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="izn5mV/D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f3CSOTh2GOqz5QwuSOIwM7/sExcCmKBDuMS/W2XlGAg=; b=izn5mV/DWeK7FKk75OiMAxuTA1
	WcGLTHdsooMjMR9xpn0PojhaA2xTUq6Q13+ezolk57BEjJDUqHBI4v+s2G7VFS9R7LbYdMYSg+2Kf
	JAVTmydtYUDVDzLv3XCo8GxnQahsLRWmwgvTYwsieUbfG4ABGIVcNT4hiU/vCc2CGF/m3UvhADa2/
	hMdq9KFKzuRHf/ybNCB6Q+LigoDsC0e125fIL375KRTC2lktFpAM6wnmotzcFvLCoVfDfA/wslDp8
	P155dTpFtsOfAuBHkI/CmZs9wofM3Xl3g6rBhb5JpTc4vRkYut3XGamYUV7ovrefazsREgYC7GwPH
	r36N2pFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlj2J-00000006A3S-49hl;
	Mon, 20 Jul 2026 08:07:40 +0000
Date: Mon, 20 Jul 2026 01:07:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@mit.edu>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: Should we consider disable generic/563 for file systems that do
 not support cgroup2?
Message-ID: <al3XS4P7Z9lHSb_j@infradead.org>
References: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>
 <alpUADtQccA2zmWh@zlang-mailbox>
 <alzYSGVz86d7wDXn@mit.edu>
 <alzzQA9SR55FynDu@zlang-mailbox>
 <alz_HixXWhKTIfRV@mit.edu>
 <al0d2btWzQaFmcI5@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al0d2btWzQaFmcI5@zlang-mailbox>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 20, 2026 at 03:15:47AM +0800, Zorro Lang wrote:
> Sure, hardcoding a _notrun based on FSTYP is a last resort, and it would
> definitely be better if we had a more elegant way to trigger the _notrun.
> As a test suite, I cannot enforce or dictate what features a specific
> filesystem must export just for the convenience of testing :)

Yes.  And if we have to do that it should at least be in a common helper
and not sprinkled over the tests.

> /sys/fs/$FSTYP/features/ is indeed incredibly helpful! Just a couple of
> days ago, I was actually discussing expanding _require_fs_sysfs to support
> features/ checks there, since our current checks are limited to the
> /sys/fs/$FSTYP/$device/ directory:
> 
> https://lore.kernel.org/fstests/aloCfjjqesxpzL9z@zlang-mailbox/T/#mc5a0492cc00550467256951042828bef5d7fa38d

features can very much depend on the actual file system instance.
Trying to expose them globally doesn't make much sense.

