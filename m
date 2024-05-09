Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4EC13C
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715233316; cv=none; b=TIxhg6oV/CrrYGLtRyVHYsZ0AqVSl7hIsYiIALfqZqU/gNY7BEwbAlbGHZfdxbXTw7CLpE/9evx6C8XY2h4UpN/fSt26KDv3DC75wxWq0Yos2Em4ejb5KaiEbtElNS/X/xK4m5ThKJgi8imCiBafLb/pR302HT6pR8tgVeBCNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715233316; c=relaxed/simple;
	bh=YXPc7/RZKzRl4pW26qmGs1Xv0PHZ1zPGtpa9ioY/RGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDgV65Sxu+wuQPN06x4Tv5WsXjliHzWbkDLxzSNCZ2+amnjszz3JFA/znp2GqjOzOXEg4eCmjFMhz2WtUHiK8olyJx8Uar24rnlN6wPHVkD049Wesd3ZfharH+NUEIJ0xwZkVfxUuv5dwDfkeaLMsqVUsDHNWa8U3hX2AjLBra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rfl9u6PA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rfl9u6PA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w++L0KSuts0nG1+mIsVI4gVaa7EmNqUoQHjCaDeSHCE=; b=Rfl9u6PAGqJUUSiahe5rZm1w4Z
	q1xRvR0M31ysoSCkw6di5W4c6Ltc9tNN933L/1KWP7YzAcszJ5d39k5AjBmT+VlzPNMmioLfrmm9b
	gxLPTjsQGUBA+xxJbDhjrtUD6l/3xCf59vr3MrD2iLczjCFuvXJBqqKLFof6YuYaws0K005S6HTo8
	z7aH2tNWw04LcBmdYqv1i5KOP+UMdSe8ffe0BeSTmizSjgieBZ6mVUDkeqd1kuT5Tp80srjWI2GQ2
	ezhTM/4fb4NH8Pordje23Oc1f0k6BdhZqBZDHLCWX/L66/I8O1Bq38PN8Ho1zssNd143fROOtj81R
	O6eUFYyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4wXS-00000000S4f-3J6h;
	Thu, 09 May 2024 05:41:54 +0000
Date: Wed, 8 May 2024 22:41:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] Move shared/298 to generic/746
Message-ID: <ZjxiIi4V_E76mFjt@infradead.org>
References: <cover.1715108589.git.dsterba@suse.com>
 <e3ba2cb3b29bd8282852dded32b1a784ce315ba5.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ba2cb3b29bd8282852dded32b1a784ce315ba5.1715108589.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 07, 2024 at 09:07:45PM +0200, David Sterba wrote:
> The shared/ directory was supposed to host tests that apply to a subset
> of all supported filesystems but this is not utilized much and creates a
> split from the generic tests. Move the test to generic.

Similar thing here.  This should probably move get_free_sectors to
common code and then just do a dummy run of it to see if things
are supported.

