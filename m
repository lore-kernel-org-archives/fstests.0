Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC02773FF
	for <fstests@vger.kernel.org>; Wed, 22 Apr 2026 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837958; cv=none; b=MHTSG5uBzfFzY7ipVzlf4+qpWtbsLMjUyppmSljEMTi3vTXz4u8OmPORRxjBXvy0ZyHFAf4sRBV8Ob6IQPD3s8wD/U6c/W8gF8MR6J2xwz3tmNhsxa3UA1ubg04pB3loHo0CPNZD/c20dZpe9/ljJrzDcaXWqo6nG8sSVprUAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837958; c=relaxed/simple;
	bh=fkfM+TT7t3J8pHAQwNhoMq0yCntlg/6LMwlwoq878Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHAx9E6uIVGiAXGWQOVWFMDmbrZi6Y7ya7i+Ry/VxjlA1QWAnrYRAY1NkFSweKDOXQB3ZMB0ZX99qLZtSHqCNth9hDG5Ytyc5bUarP+7BIVMaL2RLo5sfZk43733XmLTtaUYhsdWiZCiOHeT7MhE2LJKwYYdO/XOPH3NxmudPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC81F68D09; Wed, 22 Apr 2026 08:05:54 +0200 (CEST)
Date: Wed, 22 Apr 2026 08:05:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org, hch@lst.de,
	djwong@kernel.org
Subject: Re: [PATCH] xfs/653: require realtime
Message-ID: <20260422060553.GE5391@lst.de>
References: <20260417162245.690716-2-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417162245.690716-2-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 17, 2026 at 06:22:43PM +0200, Andrey Albershteyn wrote:
> This test fails to mount without CONFIG_XFS_RT.

It would also fail without zone device support, and the || _notrun
should handle that.  I guess it doesn't for you?

