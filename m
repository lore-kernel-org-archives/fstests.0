Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED085297
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715233261; cv=none; b=KsRV+oHnhIaULdGzN9HA+rhQ8n6cZ/8JddTZqVenSxZ+93mZH8XnGY8PlXFbanglUF4XSMJNUztLvOQz5iHV3qN3f0dM61vrkI9Z4v8WiPKQzsnEc0H2rSOxhxaDelr1asSt9n1r1MtrH33lZpuhrH0nN8FQKnX3EdInvfwXQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715233261; c=relaxed/simple;
	bh=yYzb4pcW/oPt9IuePyZakw6Gw5TFvVgdwsRWE4/tP58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWpeTz1JEaUd2CMYYhMm2Vaxr8JfJb1H55kgutYNypVmqQFFvet6/Zk1VGSQoOOgey2YVTozrzPWUfF54PEBHyb2tarKTuEdtSwZST363OuzMeqc1hU05INRK6ncuyyRWTsM7jNeU4t3YQbSHTJKy4Y75J+BVn/00cbgdQGY0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BN4eKgMK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BN4eKgMK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yYzb4pcW/oPt9IuePyZakw6Gw5TFvVgdwsRWE4/tP58=; b=BN4eKgMKkLk73THs2FpeTi+goa
	eJ+U8UELQlgWnJJoLZZb4ZTK9plekySMIQsE/zlmf60aosj4gdj7+Pvl3Sp/JqEBbEYNRTZPoemRJ
	GXrLGUsY3i2cgiX/31/0vk2cMFs/wFcNTJAGlSdJkCU5SYKxrSz1Sh8FWfRc1Ph90WTiFjSKaDpEu
	MuX7GbvLPX65jm/Z3MOkOP7celAhnpsTNVvooo/ncduJKpFPUPgY/jrUGwyv8o14hKfmkTE5uiTB9
	cBluT5VMI8+PZ7Ib49lAUdycEGd094KToUpLxlUZgUP43PiqnXCSlAjh2MF+wFoy+vZqFz6kqw3Do
	EpedpNeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4wWZ-00000000S0i-3crK;
	Thu, 09 May 2024 05:40:59 +0000
Date: Wed, 8 May 2024 22:40:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] Move shared/002 to generic/745
Message-ID: <Zjxh6wwyUIA8d-Na@infradead.org>
References: <cover.1715108589.git.dsterba@suse.com>
 <ddb9dd4eabcb5c6695c2c0ea7e257d0b615814e9.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb9dd4eabcb5c6695c2c0ea7e257d0b615814e9.1715108589.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Same comment as last time - please add a common helper to check
one. e.g. a max_xattr_values or max_xattr_space helper.

