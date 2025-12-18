Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C42D7D41
	for <fstests@vger.kernel.org>; Thu, 18 Dec 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038421; cv=none; b=jPEEiRdW1rFkGwW7QENftsyxUEacMudb54b0F4BD23vPKD1bxD1ZCpmBqzYtsMopFMz+7gPD+h2zZaIAho+HMGYyoIqx7CRxCeKxrPwfWUQFrC4PXjYhg4reBx+wckoMw36SuNSdMhwjt6wd/B8M112xWVI2itYHLoeJBp9jXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038421; c=relaxed/simple;
	bh=Bbzpaxg35c9yoLqqs1RPNH0oxz2kTUpZhgHspb0q8Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpsByX3cIAupqYINzC3yg9gCb9Qi1GqCXZtI/2ZKA54pDR26KAt+tyy9IxJ3ISyaTo3u/e0u75ffv2VDlCe0/90bDNZFhk/nOrxmZhQmXJoPp8mX7JQmoJ01C7RjP9DhVbzr6SjuzQ5V52mGRZWUr6AhNATzxxkz2teZFHc0F+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vMwqMTfp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vMwqMTfp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xPf4m2vV1fkBj+jLNrYWiyCFKNDUezllbYkRDP5/RME=; b=vMwqMTfpF6pBB8y6nv1eqGIx6B
	xwx1snuEmpT80Bzk8smofCSWXKRRSOxk+cPW2/6XXzQLoCBPggKioAXElYdbOusbQqvWN+C56iAa8
	9MfWK68aEzLFB/TtcF47qXibqlwQ/Yvg3z56C3cU5mwtkZXqra6caiSA6uaY9Q9nDNhLa7QHoCG8f
	ZsIHROX82jJqmtW/TlBeOGEpY4RgfIBLrZThvjnpf6kt4KrM2sVn8Vt8y/MLP+HLGIoHlRxDyACWP
	bPNJ3fx9CTz+JRvRUHxhpJZ3tVCGkE96NDgwP/HyIQlE+YWJqUhTIlx4AKcw5i5zx7tphMxHNgNhi
	KBubmFKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW7Gd-00000007seN-2yGa;
	Thu, 18 Dec 2025 06:13:39 +0000
Date: Wed, 17 Dec 2025 22:13:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <anajain.sg@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>,
	zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix flaky device name in _cleanup_flakey
Message-ID: <aUObk3E3BpQggfr5@infradead.org>
References: <6025643af0c6a7d7d377aef22a53f23f24f06db6.1765988375.git.asj@kernel.org>
 <aUORO1y4rkXHAH-f@infradead.org>
 <3a3ce42a-6eee-464b-a8f4-ff7590ff9dea@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a3ce42a-6eee-464b-a8f4-ff7590ff9dea@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 18, 2025 at 02:11:22PM +0800, Anand Jain wrote:
> 
> 
> On 18/12/25 13:29, Christoph Hellwig wrote:
> > On Thu, Dec 18, 2025 at 01:00:22AM +0800, Anand Jain wrote:
> > > There is no device named flakey-test, which _cleanup_flakey() currently
> > > uses. The actual device name is stored in $FLAKEY_NAME and is set to
> > > flakey-test.$seq. Use $FLAKEY_NAME instead.
> > 
> > This looks good, but I vaguely remember fixing this up on the go, and
> > seeing random hangs. While that could have been me fat-fingering
> > something,  please run all the tests using this first to make sure it
> > works just to be safe.
> 
> Yeah, I've already run the tests that fall under the
> _require_dm_target flakey, and they have no regression
> with this. I reran them again just now to be safe.
> 
> Happy to run any specific set/test case if you'd
> like me to try.

Nah, looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
