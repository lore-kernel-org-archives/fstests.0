Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491C366816
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710832; cv=none; b=dZIlUy4yf2jwmjNhpm4Mj6s4ZC4xkMP3BHJGjAolRSOsJFIOpn8iHX5Lt0NTaSziY9wyyIAd0NeFsAhRZ025+bo11GNsJocVYBduoOjIWXKulunXuoz2wJ1BFP7FlTZ0mTH/vskWzuK4q3Na+QwxmD7N3L/iW9lIkjrLWkeXSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710832; c=relaxed/simple;
	bh=GlN/x7tr6jshJ7EOyFNusUI/gjsmuUI705uP1FrTA7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSkBs4kZKXBA3V4EJgbsKspudNvfH5uIjv97qrOo5UwtzcLTKzqxB98RBjHOBaD2rPUJy6V/PHmRHHIIIJ42LzR/7hc2ZJwc8VbwulL3h3dRbIcy9yMisPAAuYjsjG4vSii3SSiMrvSm45qBCRAJ4QpeG6+UJISKnjlMF3qehJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vHhYklW2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vHhYklW2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A84alNi2/lwR07Uz/90yrVi6ivotcaqzSBbLLoQeRdA=; b=vHhYklW2hoPbUV1Kr8WBkJgYdr
	7q68fU+GoCID6xkqahgmWnNqG/Af4XgvaxaGpFmQeMxEkUbNgOro4ZbNSOHoSiBpqcquPZrDJGhLX
	nyJbdJFo9E114lP9jKgnyrKO559YO0f04R7tGGr7V/qzsz5ZgfWHB1HA+5ahwiY2Yr7rypycPBG4G
	aTEx54ulVb9kQOHlX+4zPICi+iSe7Cw3VTChD8nogwThfZx28tkXPKuJk89s0aoi0EeSni4D6tnno
	IqUi4fUoI3/YSu29w2yQTIsIHUt1XbrhsEHtaB+QWy2X4c7RqiWmNrHnpWNRh4a3xGZ6C1ObG8VI8
	4KyfuVZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmSoX-0000000BJou-33fK;
	Wed, 22 Jul 2026 09:00:29 +0000
Date: Wed, 22 Jul 2026 02:00:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2026.07.21
Message-ID: <amCGrQi2sCcgSgHL@infradead.org>
References: <3a82ff6642f00830fc588026ee521a42@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a82ff6642f00830fc588026ee521a42@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>       [1cca2bc0d7a9] fstests: vfstest: skip rejected tmpfile creation

We should get the original patch from Christian for this instead.

