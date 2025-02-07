Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95C7FD
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904276; cv=none; b=RwjvSWm2hurqbvWCLyvKQZrFK6b1Wkh3FENwjCi9FqZR2668ekzrPxO2AQ9k4uq+pmqpE2hl0nPvsL3zlGJu1CCWigKghvtwCrHDg+iK/3eCQiNKjC+Uhwoq8uGJgktDel3KDh6AqRsWtywF36FPrHXBS0t7kJw7jf/B0Ujf7tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904276; c=relaxed/simple;
	bh=CaQLc+JU5xV+gIHXIJGyldaJEE0L24Yrxts7r+2iCV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oag81dGIqyFQP4ULDrpQ3lv4Sw8/pvY5TN1hZ9XB/4rFonPOSFkyCBljMk8CtIyMHJGLpZu89ka56/S9HctlEjphidQoWvpOrQbychX5BbL+n5LWNJpseDWYBYOZcwlPzH7Bc3LNl8Jf23C5ICK1/MSzu9wCbuF1399djv4Sb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aly/dNr8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aly/dNr8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bFBv7iDdvmN/rDMFmb1pmRvQQxOBf+8qeoRzVsdNZTc=; b=aly/dNr8mWRO4CZCc0wlOaSv5A
	HLt8Fx3fVjD2ESye8HhVuW8RDNw6affMeE6E9A1ogQ4l5Ei2QYO+PBKIkzs3esj08Nbo7lI4l7xv+
	hIOtJtofhT6E82+8IYm7TP0HEOYEKG+13uGh97Gnt+gCQFGHJu0BimfS2EpJTreL0byF/iTLzcz3/
	/KJPs0/s5ntE5MyO9t7BPy08MzlDlKYhYRR1W05OxbX84jDiQDmZaCqWYUc3AidUTS+DfCbO5GOjr
	HIJh1/5+HNsj75ejy/XZYvuz7PvpyU2w0QlupJf0+xjGO580XOPhZ0FNalVFm+HI0fvUIfIecIPPI
	a5l9NYIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGR9-00000008Kcw-02L5;
	Fri, 07 Feb 2025 04:57:55 +0000
Date: Thu, 6 Feb 2025 20:57:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 2/7] builddefs: define linux
Message-ID: <Z6WS0iAd4t8paMVd@infradead.org>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-3-sandeen@redhat.com>
 <20250206223905.GO21799@frogsfrogsfrogs>
 <006e3012-c4e9-4672-a9bb-ccb726017b21@sandeen.net>
 <20250207020136.GK21828@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207020136.GK21828@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 06, 2025 at 06:01:36PM -0800, Darrick J. Wong wrote:
> sparse doesn't define linux by default:

Does it define __linux__?  That's really the preferred version these
days and we should probably switch over to that.

