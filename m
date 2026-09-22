Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFCA5437C1
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080804; cv=none; b=Ru4hYhrqaPZc0bW3uIJXNUR/7k4QncfJkAHSuTct5Q6ADThGI4yKNkPVOr3Ka1jVve1iH2l584tp4k2YWOqH36kWP8/iDQUAkTlueZQV4nQD9G9J08m3kOe0cN1OUrtr3sVqjjZNfCMkzSF++TFaVdXnRzKkLxe2GLQ7ITRX+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080804; c=relaxed/simple;
	bh=QqQpSEvaTKwaXCGj4+T9u+s9tT6JK3cLa6O83ik+q00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ32WnjoZrpSYAHiwfQJSUSw0MWekiVzJfuxVz5utpUP/mtU1VNFrO21zX4C7hmfu1jmKAVhNqavFfsPMNbHSyDm9+5ggbsY8PxAXexCbrgo5NpEF2Hq3M3SGDqFd+LrhEaN/wqMT8v3d6HWSJk/Bbb8vLaiNgr22ax/1jYuxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WrAJfff3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrAJfff3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QqQpSEvaTKwaXCGj4+T9u+s9tT6JK3cLa6O83ik+q00=; b=WrAJfff3PnZRnlosoqxDsPpYeM
	hUFJmgwKwswFrzQciKbL+19NfLj6up6q4FvnfVP/fSZpIxM6N8Y9LznjYIityFe1W2Mn4ybuf5CYS
	2WoQLOqSgkKJ5Gh6r+EVIJLHJgFQe3r9eKyw82gIvJZmxd8lgs5iPP9fZfYLA2JqvPr7A0ePF25EL
	oN01MOnI3PijSUXOx95OctxHzW3y44doe7ePQve8kSoUtEMQXtlcmoWIOYIOdkSb9ImSyZ1/pBJej
	igg7DhKOKSN36RyGgVhfnGVLxxnT9VmuAuifiA6jJx+zpYWTCiQMXUcoUjDukbNIjaPy43BhUEx1b
	KNGwCT7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zmy-00000005KhE-1oiw;
	Tue, 22 Sep 2026 12:40:00 +0000
Date: Tue, 22 Sep 2026 05:40:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 3/4] generic/452: make coping work with multi-call binary
Message-ID: <arJ3IF8vv7pXk5FI@infradead.org>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
 <20260918173218.1254465-4-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918173218.1254465-4-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 18, 2026 at 07:32:08PM +0200, Andrey Albershteyn wrote:
> -LS="$(type -P ls)"
> -SCRATCH_LS=$SCRATCH_MNT/ls_on_scratch
> +LS="$(realpath $(type -P ls))"
> +SCRATCH_LS=$SCRATCH_MNT/ls

Can you add a comment why this is done here?

Otherwise looks ok.
