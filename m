Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F05C2DECC2
	for <fstests@vger.kernel.org>; Wed, 30 Jul 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897690; cv=none; b=VkJkjmEYshpm6LdqHNQ4osTZb5R2e9OJbyw92fil+bNJedBJWF8i8vjZEl26+Ief2rNNlqMwtJ2n0G/zFAqC7Z7Rj/tJmQVD1aRCukH5Bnn5I1ys75Yg4APLu061Ba87kKFLrOMmYTUD5rz1OQ0itL4NY0hNk0o00UQnnKnAOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897690; c=relaxed/simple;
	bh=ulRi0vbyALT1crC0DQZIKv71CsHtoFc6/PVTT8GhxbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qluoRNpqmKl5Zltx47rvyX0F83ssfrixYmgbx7JWVYa9i6+nltJaFhohuyyOPBWSKassyXQzmKg2QswkT56GJDbH78D1eYduTcU67mijoRuO2b8gBJ2iVaYH+TtqzKEfGXNpRclfxKgRtoAo6UhfwPNP4Q6r1dKF1HSihgtBFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kY806Obn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kY806Obn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ulRi0vbyALT1crC0DQZIKv71CsHtoFc6/PVTT8GhxbY=; b=kY806ObnD8t0T9E/mp8F9Mwq9g
	1ScCwGiMhSOC+e1nBLKppWX+QrxxMnzuCVN89Cmedj5H+YdbOnyTOLzWqfnd2ySMwoGX+8A+381FU
	qVYoE/P+bzewsDSr9jmIwI8Zf3g3UleUeMwbylUGeG4QIKUjn8RxtFNVsdYSMLSIqVYSb+Q9SyTKO
	W248EI4v3saYWuQSIe/gvz7D9ur0xdK1ujbcm88P6dCwtfj4OB0FnwUN9fM9UPIJNwnS4ZtfnCL2X
	Bu9cEt1Lq2GngagYBAwcO8+73nQQV62dbqjh2YqB9CuQADnVsRfVBR2Fl6FSbfMH/Jhg9+I5U6RUh
	IxflNcJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhAuO-000000029Cn-3J3y;
	Wed, 30 Jul 2025 17:48:08 +0000
Date: Wed, 30 Jul 2025 10:48:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/189: fix remount barrier test failure
Message-ID: <aIpa2BGrqVq1V4ce@infradead.org>
References: <20250730172826.122130-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730172826.122130-1-ailiop@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 30, 2025 at 07:28:26PM +0200, Anthony Iliopoulos wrote:
> _test_remount_barrier() is skipped on kernels newer than v4.19 where the
> barrier options have been removed, and this is detected by matching the
> mount command output for a "bad option" error.

I'd just drop the test given that it only works on very obsolete
kernels.

