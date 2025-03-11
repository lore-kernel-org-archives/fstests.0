Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6372222CE
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678648; cv=none; b=nRRshkK5GAGg+cwnSlGhyYLXyhSOcoCAQuRSXbUH1/4GYivD0L/RFtnsuNfThe5+m02QQyJj0CrBFXR6bl4JHIYuDqjFYB8v0g9CrdVCFFkBYsB/B+LRQQEE7INAjdDFQzl5FPL5BkRkyKF5BFaLo+Th2yyC4Y4CPNd6BT0pDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678648; c=relaxed/simple;
	bh=dMXjSt7iNZST+s7oli0nXJJe0rwwSqqxWI63ryMClc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph/SXB+P96Q1OY/aGA5eHQA5nXKkcbNybjaRvd5W5Od+r9UODuc7sRA9kmkPm74YrnrjuNhWq9/XfbsaXukQP52J63WzKxq+/qIdPk0deaFnCElc/cnX9fgC9X41tUT5SflSM/8JGJx2AE/Bkf/ybgQ12ajpw81npcrobGaFO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mNBpNfmy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNBpNfmy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q5aSelpxNp227644N/rAufymvvi4nr0/MX3brCklVR8=; b=mNBpNfmyhZvGABPOfSzSOW+EPF
	6QPPsBFq4XeCm1ZhFI0KFbhTh7VSYQvkHE4jE/XcXcR+OJ/xn1icX8VoFlzxcC1+AzrbBO6ua7PRv
	KdVkCPSTLgwbKNEFWQy6/NUD0Qp0CQJEJGQ237K5LClDw45PAx6BpNI2hyKA71TBRPp97x9+iF0vB
	/VWIU62c5iaMB0Ndvy9ILP09U3eJ1wxi9k5riK5Q600KpqvS3OzkQ7HM5iqy6+CcW0Zoa+NmS+QTp
	E8RY8wMduidU+0Wwv/wzSvBvkr7QmjGmAvQCI5jN9PmkthPKD3Cyhx26muDUtng/Dm2F/WnCMkP8t
	n8pWeZsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1truB3-00000004scR-2Sfr;
	Tue, 11 Mar 2025 07:37:25 +0000
Date: Tue, 11 Mar 2025 00:37:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, hch@infradead.org
Subject: Re: [PATCH 2/7] treewide: check for #ifdef __linux__ not linux
Message-ID: <Z8_oNXzVd_jd-on3@infradead.org>
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-3-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310182954.1396724-3-sandeen@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 10, 2025 at 01:29:04PM -0500, Eric Sandeen wrote:
> There are several #ifdef linux guards in the code, which caused
> a few sparse warnings, because while gcc defines both linux
> and __linux__, sparse defines only __linux__. So, switch our
> guards to check for __linux__ which hch says "is the preferred
> version these days."
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Sorry for nitpicking, bu "he says" is usually not a good way to
write commit logs.  Just state that __linux__ is also pre-defined
by sparse.

The changes themselves look good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

