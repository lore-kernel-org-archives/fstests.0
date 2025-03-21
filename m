Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCCA1E5707
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541991; cv=none; b=EUvHehIO0WjzsvU9eb7N8uZwpZBdSxIF1wbFPrDX7a4Q5YYroPjAzlhB+i3wuX73vnkI1MWeLIaSATHCKoiVXi0A15cnmAV2012E2kVyyIRNXS6juFEvOAOMbdPHjaKzDInsQGdezAJVyTuMcI28oxTNDfEoq5/TGpHUv682fzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541991; c=relaxed/simple;
	bh=wKChFUP/vFYfXAIGKPSQ7cH+fckbwVcXs6mgdqp7mDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9NnvT93asIhGM3Jo+0bYhoZVCxQRJCDJgYeSMByzCvx5Cgm3dYiVSnq3E235WcP49E09EqG/HTVVzRfNGvUaVA9Nm6G0hOlHL4JXLZh1hlqtnLUiwg7oLXr4KsTcw9yNljTAGhfZCelMFFVX+LtfWURuZfNNk0KDdHYPig3X/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GfAxnrVH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GfAxnrVH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J6Xoq8U2dK8Y4554d0Ogsdv/1apKTke3JO46400tOh4=; b=GfAxnrVHsEgFdD3Aqk31RxBcfr
	moB1NuFUjTdhtEvE1F4rdbomSzJ32q+6Au4hFNSs5V/vuenNaN3EFamVitXYIOnJmza0isMsCOXtp
	i78swUPANXNTbvpYgPI6SPd2jVOpzTABQv7/RVuLwfAKXDlBm24xdsNy7YSsfOFmGqiX1oE0yvIJs
	cySWH1tmjYPiqyfjXrl9HD3lyaBxeNJNeinkO/wY0aswo22C1FXQJ4yh7XhZRGG6ymfb8w5FYzm5W
	k8euXtpGejFE1pPawL+2/qXkun3UtcnsH0Ibms4s2kM69V/EAeJ1+QUqTQksrNxED/W6z1f+a7OwC
	PcRhmx3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvWlx-0000000E5vK-46en;
	Fri, 21 Mar 2025 07:26:29 +0000
Date: Fri, 21 Mar 2025 00:26:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/2] revert "setsid" and "privatens" test ways from check
Message-ID: <Z90UpeiUmsq8CAKO@infradead.org>
References: <20250320192812.782380-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320192812.782380-1-zlang@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I can't really review this code as I don't understand it, but keeping
the special logic for the parallel run out of the main check script that
everyone uses sounds like a good idea.

Btw, any chance we could rename check-parallel to parallel-check or
similar?  The current name really messes up tab completion and mussle
memory for interactive xfstests run.

