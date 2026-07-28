Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564872FF675
	for <fstests@vger.kernel.org>; Tue, 28 Jul 2026 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208991; cv=none; b=HGCOuCi5OQIzKe0U0fItXaL9Nyl6dPT5ImHyDPYQGpf2tQ47Q0cFvJTZeWASQyU7NVN/LKKxaoOnHI2XPtDNr40U6ADB78Mfh8xd2EX6F8Tp25TltjR217cOI0cxeivRx1KR+Q+JSjfv/MvnKgCG5mmwyvzJ1hhmuI6UTdtmagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208991; c=relaxed/simple;
	bh=27YLSXjIp08lCeTQYpSaYmnCMu4rDLw5yX4rN48wi8I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCzjnv2R9zX2WMeyaOToNaJfFsQ4FUPHm9JsjjS5sMLkZmb4UEaUXj1kmK7sfnzlkTw92JOnuP3+cRCkhn5j0X6PtyIe3Ycs1B3JzT20KR3WQtExoafY2SK3tZ7mMGJuRJuSR4yKH+osRFqDO1BJCDZvm8ru18xtVbLLqHqB/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DT1EWt2h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DT1EWt2h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z85sJ5ygrie5cfJxMo83ikI8nOb1d+yavS9Dx6Ikeuw=; b=DT1EWt2hf+sLqh5NapNyJqzKfx
	FTQVGc2b3VPwiODEMV3tatevMQPGsWxWkxbPhm4x9QU79l85qQhdirjtpEWxp1Mo1UtSA8xSsXBmw
	XFhq2t2h3R/mWnVoiVmjz9h5QvD5QJ8hLsStl+R3AWNgesk0QvtAYS5c0iMQSdPXPB2NtfZzLbBv7
	r+Tjog9nQIhHtLh8ac+j0vXQpMsGCMyUzA8vTcQYw9icacM7GwpukjfGFfZoYLZmx3UEwJ/roM+IR
	+cXVBFnMt7a7T2FmnY0OzIvqIazhK0NounG/cN9HKPCs+S0DpRkgrjoq93wu5QMcswWHbwpGmTQ4N
	CipJOUEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woYPN-00000004KB3-3Uxg;
	Tue, 28 Jul 2026 03:23:09 +0000
Date: Mon, 27 Jul 2026 20:23:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2026.07.21
Message-ID: <amggnYzT5ibjCFC1@infradead.org>
References: <3a82ff6642f00830fc588026ee521a42@kernel.org>
 <amCGrQi2sCcgSgHL@infradead.org>
 <amey_roTyYfWM6tt@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amey_roTyYfWM6tt@zlang-mailbox>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 28, 2026 at 03:54:43AM +0800, Zorro Lang wrote:
> On Wed, Jul 22, 2026 at 02:00:29AM -0700, Christoph Hellwig wrote:
> > >       [1cca2bc0d7a9] fstests: vfstest: skip rejected tmpfile creation
> > 
> > We should get the original patch from Christian for this instead.
> 
> Do you mean this patch?
>   [PATCH 2/2] src/vfs: skip whiteout-device fixtures on overlayfs
> 
> It's currently still under review, I thought it's an overlayfs fix.
> 
> CC'd Christian, sorry for the hassle, but if there's a better fix
> coming from VFS, would you mind rebasing it onto the latest for-next
> branch? Thanks!

I think it is more patch 1 from the above series, but we really need
Christian to fill in as the author of both that series and the
kernel change that breaks the tests without it.

