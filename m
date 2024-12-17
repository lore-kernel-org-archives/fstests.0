Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7408126BF7
	for <fstests@vger.kernel.org>; Tue, 17 Dec 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423072; cv=none; b=pgLwRh4il8XtAJ02ONTQWBYpKBpc5oouLlQW/Dc6n05CE4/tA6IC9L/PYmdkA0AZSVhfuLAH0voJJmCzZIDr8HtfKP5PKvSpOkWyOAAjv3NBcHBq1Z4ucldzK4HiZgbiZvPYACSdGjW522y4Y81JryjXqx6WveHaYW/Pc10TI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423072; c=relaxed/simple;
	bh=H7/mqawJhk60FJhSU6Kv0un8/JONH133ydgLOlOR/ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPTWHUTsGvJrNYByIjVE7j7dxl3jbyOCETLhUi8lubrklX+dIEO3i5y2cMHUCE7cxp0r7sRFbT7sFmnYpooo8N9wPDCq8hkeA9frUvEPjYz5jGmXavgUfTge5EURs3jsirzlbBSUfyRxNGmU9VoJw/RiwJXdZNl0VYrXcVXd0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hPVOhKlH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPVOhKlH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zINYm0P8+Rdm1SwqKnExVZj1GlL+8XkzlaofHQs8ApA=; b=hPVOhKlHL8PIrrRUcB2bgDj3iy
	HOu67/uINeuVu70P8oPwf43Pk5KTM6iMABpZ+Lf88Wpcoiyl4ptpWHcLCpIEJF8Hqd+Jlq0Cdu/6T
	1QaiScbgf0GyDzmo2EA+eu+LtDGdcEBx1bEUyon26oxRPsGn3zCi9HV1TetzuC0tp8XaA09uJziht
	5mBCjncBc6dxu6ZOluHSOSHfkboYN7P+gdKRQA50uaRF4YyId/+Nq51baSQe+TU3xWBdWs9L/vpVE
	f+jq6n3W/hN9chYrCjLGZLCKxDzUSVY++IE5wqICNTtuJJR1MVaMsm9s6Rl/5peFcsE2WqFsmrVgL
	sD0N8y6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNSfb-0000000CfYT-0Ufw;
	Tue, 17 Dec 2024 08:11:07 +0000
Date: Tue, 17 Dec 2024 00:11:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <Z2EyG0vqtyTSyM5a@infradead.org>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215051242.3340572-3-tytso@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> +if [ $FSTYP = "xfs" ]; then
> +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> +else
> +    _scratch_mkfs >> $seqres.full 2>&1
> +fi

We really need to document why generic tests have file system specific
hacks.  And yes, that's a request for Dave who originally added it
without any explanation and not Ted.

