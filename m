Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7A36B076
	for <fstests@vger.kernel.org>; Wed, 24 Jun 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287166; cv=none; b=hqkstUkDY3BTZWAdfh9QKNIv8gxCDtETMoYNU+fZgZ3brk8HW7YtICmEAjLFF/PrlYePmRM5vUJuF8NTt+/oOspmyTexvvCcoQxe2Bvsq0uAWvgJcycsC+1NtRtzdOqWIYUGtLDZTyjPnw+qSV/5kV51EU3p/4O+w30rRrtcnSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287166; c=relaxed/simple;
	bh=iLn+dajUvk3A9JnZPGYe5Xx8LYBhy6OUPYhdFq+7Lq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpikzaRtQtgc+GbncTamqiTfAYDnd0k07WQyt+MjyNzhYk2Cii2X5hnIAt8X4xHMDy4KezpK/4Hz107EbK8nC6y4ogzGWDDYEKReOP+KNMx6AOiyixmf8VnURVa8irDji5bQGLoriC7L7P/qMmgEqCbUQtB48gF9p/Tya1YbDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wsrZS24e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wsrZS24e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5SQ2ceOLmQorTQ/rIGAZVtdIP0obDHikYx9CZqlXZ4w=; b=wsrZS24efcnk+Bk5fbKf9298JM
	Lphj2FrgoMJ5q3B9K2UimUGJPyIJSTULUUMaMpUp6t9EeMdEspHBVVZC+NOv0fj+WYnvNXnDY8Bku
	3CnmLqPpMAibDC9/WId1ReugEhQLevVKe0DRgKsFqD8x76tVO4+ck1kk3ghVw1hAnrqol2KobwRTw
	/4Zg0F5BVJZ6TpWzB8hgVCnvEhL3FhG+CEJDQdnoJtwjogHleJAgnHcc0go0GXTohWBhetUpFuxdU
	lJyf9I/yY5P0wM0WrQG8WOBnyiwXsiWjq1eH5MvYiLrH5B9dJ1Nzq7YEQmHWyvPr29K507+blCJ9A
	VG0l0r5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIJ7-00000007LHS-3i7c;
	Wed, 24 Jun 2026 07:46:01 +0000
Date: Wed, 24 Jun 2026 00:46:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] generic/064: allow 50 extents on F2FS after fcollapse
Message-ID: <ajuLORVplOvEXvnI@infradead.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622070438.1542638-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 22, 2026 at 07:04:38AM +0000, Jan Prusakowski wrote:
> On F2FS, generic/064 fails with "extents mismatched before = 1 after =
> 50" following multiple fcollapse (collapse range) operations.
> 
> To ensure crash consistency and checkpoint integrity, F2FS forbids
> in-place SSR (Summary Standalone Replacement) overwrites on valid
> checkpointed blocks. When collapse range shifts blocks, F2FS allocates
> new data pages in LFS mode (out-of-place log writes). As a result,
> sequential collapse range calls rewrite shifted blocks at new log
> locations, intentionally leaving the file with 50 extents.

This sounds odd.  The test allocates a contigous range and then just does
insert/collapse on it, which should not lead to any new data block
allocations.  Given that the test works fine on zoned XFS and btrfs
with strict out of place write policies we know it does not require
overwriting blocks to work as well.

So I think something is fishy in f2fs if needs to allocate data blocks
here.

