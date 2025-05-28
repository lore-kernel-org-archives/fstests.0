Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0993202C26
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430078; cv=none; b=DzbY2Uu1M9E1vmhqM9V1MN+Yomfeb5JsqFcWTNbpYipnOseX1HZEtLdzRFy8/z8oqNsQIVRRCBINtHVPWdPSWUQp0en7uQXNYhFQWbJn3OZ95FNHEHU1RSMr5kFhbByzRzJzFvBXxPKwmM/e3/y9wJWEBdbLnVTMKsAdrUP36iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430078; c=relaxed/simple;
	bh=Dpd23ZKrI+xwLetMAXiCJTkL40i4gSxmIixaJKzkzc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu5CVw+Ayz5s0KZe9lALrlTFd4f8PeppXSEUV8Km18n9opaqLWOqUD6lfEzykgModBjBLHyYM/kZcIbBXCzAhstg1xpqDChJT220kc1Oza/vdYHBkBY+pDodbeNV1550MqFwhPJWQV8SttdQKTHUb0SAKycVfIr2UYVPiiumOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N7C1ljFN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N7C1ljFN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kv+LYMFHWM511g+dXajbfbshmunwe3kHu9sAc2GX94s=; b=N7C1ljFNDEFCK7Dw/d0t5VJope
	LcJvmqyDkMEWkWGjhH3iMkDFmxTwtknR8O+sju/+v8nGbiKQCQwEVTDH6QUS4vkpIiWOMULLE2ffy
	MLhN10vvQqCzcZpOuBdANq0Q2vDc9XC5AqosRwHeOdo1AI74nrr1sYZGPE8L3dbGY/Hi6ycdwTS53
	nHPJLL3tRjaUK4M7avZ39XvZoGmJieielOF5J+NMq17QDu9C19txWHHS3s894RRJPNtx9KmIfLuE3
	dmsWKGRj3t5COU5II2usCT/ZWVBhrBP/h5+RQM+DsVbWAq2Rr7AuaIQbG3aRxRQqsuf4xvcXfqzsJ
	RDfu70DQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKEX6-0000000Cvsn-1mdN;
	Wed, 28 May 2025 11:01:16 +0000
Date: Wed, 28 May 2025 04:01:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Subject: Re: [PATCH v1 0/7] add test requirements
Message-ID: <aDbs_Fr-8CVCxdxy@infradead.org>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 28, 2025 at 05:15:23PM +0800, Yuezhang Mo wrote:
> These patches add test requirements to the following tests so that
> they do not run on filesystems that do not support these requirements,
> rather than causing the tests to fail.

What file system do you want to support?  How are they going to work
without wiring them up in common/rc?

