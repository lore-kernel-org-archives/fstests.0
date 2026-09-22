Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C84541453
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080634; cv=none; b=HI22K2H/34YFQzu9XCCRM8/4r0mKz9u3dS1GUpvrjFp0WgqdGyxzWV8tZ2jW8iPTfIEoI0U5EJ8vusNRa1YUrtyiZlzJiTBbXUp3o8eTFgx1xRwMPLOFoypSQo5F6PQ/47D6CwvvQT+IeCHS2EzmPwTHdrENPIR8fRoLEpaLrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080634; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/P6AfIFN/UR0O2JT3zbo3XYebi1jHUB6UB0/ZS/tZUrI0ZIEZrGat/EPDNd6CKgzJDBzDrG30MxpUcIdlbn0rZcABgIEjJvQOW2ZXcZfWTmRRyBz7d8r68aIilT/50uMBGOmWfaXZe7dbYWrMrUVb9maluS62ix18yjpWGFMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z/cSDSmF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/cSDSmF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Z/cSDSmFyWb0L+xDyfIUrp+8hT
	pnc4fPMF+eRnT04am9R8K6QqaGaEbtrL/2B47QtXzMIG4oABwQ0mHIk839vcQmCWNaoZD/6E/fhWv
	ahmtM0MDGiSTNTAS/bH1OjRdHNm8mecBBl6e9/6/8osgk2WGQtu+4lFSShuMFjLhOyFQsmn0Ni4dr
	tHqoIi2ygZBAEWAxJHODFhP27UoYbpdJYqFl7hVm9ij9TodJCZcnp7DPDIwnN33jj6OxynKt2TAo+
	bsT5AG+2W+eMwJnvIO86bYpx+QPupPETonSdWD4n1I3GsTNW27QCEKNh4d08zILebxg7/JepZjmYH
	uCfaQgGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zkG-00000005K64-00AD;
	Tue, 22 Sep 2026 12:37:12 +0000
Date: Tue, 22 Sep 2026 05:37:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 1/4] xfs/071: use _link_out_link instead of opencoding
 file picking
Message-ID: <arJ2dyn7lnBu5vt6@infradead.org>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
 <20260918173218.1254465-2-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918173218.1254465-2-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

