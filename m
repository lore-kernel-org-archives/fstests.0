Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091F1519B4
	for <fstests@vger.kernel.org>; Fri, 21 Nov 2025 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763707643; cv=none; b=V8WqPBkv8bASgL2zLoLiZ8MPVVZNKHPbxV453hdIfFwBwRm/zWN5UfVihwS6f61kVc3c+YU4BaQU479PyFh9FK1DZ25oJs0nk6WtDckUJ/N5OK93NsFhsb2oCbuKCI2lOs1vtRfQsFYVIWQaKx1gF+jzRmr8OvG5K5n30U+442U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763707643; c=relaxed/simple;
	bh=TSpA5vwhUZrnZlE0irDXJqaEMQ8vmwwmQrxLUGK3Xc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV9qk16TzZSowt0A1aJQmhcZDHskOW59P31X55wpKkv1O4v1Nldtzw4OozUZQklSKJRKxU8iJtSxyuuV5/AV70ICN1xfqEcxpHDgod4o1JMFtgCaN8ZcV5HG+fvZQCuEOzPk78Rrfi0kI+4vlINXKjEP4hLIoxsa6x85QA/mjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i0Rhonbe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i0Rhonbe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CLYSj12BpepdNI/OSHNExNOA7BmL1gonXSlwFn2J3/o=; b=i0Rhonbe2BDJDd8YwuI8xvJ/cJ
	xzG+nbviv/HR/ssDjvpPVdotsqTtzvi6PZcpL+4VBe/VdX9Q/PK+KGl+FQ95JR94yPFwbb2VHKedL
	IQuVIBQJQajOE7uko3X5dcOH400WENpIkGPDWDZX2OknLGDSUtasRrvMkw1HlvRQ2BTa80POoJehB
	wNPmFKqJk1C4+hdgFbRWg6o/hEUqas93Mi99VV239o9DkiCgr3XfVpuotMkogtL5nBoecehS1OVUP
	K8ZG+ZYLmakldx6Z5BrMAjRK6Sx4uzgtbi4C26XOTmTv70oe9sPY1/TIbeIuzvf3ZGcg3i3HDyF/t
	BW5FBn4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMKvK-00000007wEI-3Ldk;
	Fri, 21 Nov 2025 06:47:14 +0000
Date: Thu, 20 Nov 2025 22:47:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] common/rc: fix _xfs_is_realtime_file for internal rt
 devices
Message-ID: <aSAK8qG0vFjK79z4@infradead.org>
References: <20251120160901.63810-1-cem@kernel.org>
 <20251120231536.GK196366@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120231536.GK196366@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 20, 2025 at 03:15:36PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that we can have internal realtime devices, it's possible to have a
> realtime filesystem without setting USE_EXTERNAL=yes or SCRATCH_RTDEV.
> Use the existing _xfs_has_feature helper to figure out if the given path
> points to a filesystem with an online realtime volume.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although right now it should not matter - one user of
_xfs_is_realtime_file requires reflinks and the other explicitly
excludes zoned file systems.

