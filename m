Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA31E4A2
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262590; cv=none; b=eXJ7V954eVAHccvTJaaYzrPLUiJucRNHka5QspXGCbyZlBORrOigTbWuTRhFWY5Ftx2idbYEKXvqLxAbjtg8fD8tN47CK+8L9qhJStl2musTDjKOINz8SQPuiLjdqJY4oJIGtEhuJJ/ERdY6+mvMgLsO1V/E6Ho9aVBzJ6tFF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262590; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWZkAylMOIfap8Lk8yon5hAeWhBbxO5D4UrVX61/5iU1Gm6sOC9BHOttjOZrM1nvvba/31/dyS5SHu1Y7usz5p5aCirPwpL4z0o6MeS29Cp8X6urvHa4AIGTnkTEIn3+fX0Tx021FuwsP3AMfPLGRYbI4mcjRw6Si8RErNsYX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DdQ68Pig; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DdQ68Pig"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DdQ68PigQaJgUXpSAJIyr2CSXe
	hwC3XIfrbcjyXGoe2fqLfZdZ6u68KgX1i9h5oMBPRCrPPOuW19VGy0tHo8gDdB1aIUpXsezEox9IM
	XuzcbqL4+4rhHKn4tmakkryfxkawhyVMX6zO01vvvQMTYoL0ZrCUEoz5FyW+a0BDVaoc5bnNUEpba
	DBCh/+MJGFrsYpWahGTDKyWwY+V5ufnePO3yoZaUKwZIu3gfL2GGlG2f/+K+JL5i0xU8d9MpOWiZu
	QwKMLlbfE+Hbnolx5YH51G36xSVQzcMO40FUDKG0S6TLcnfcGkoPlwG41PpK4GK1cTmI/ZDp0LrCH
	orH2SBXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRAq-0000000BX0o-2qA5;
	Mon, 29 Jul 2024 14:16:28 +0000
Date: Mon, 29 Jul 2024 07:16:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yang Erkun <yangerkun@huawei.com>
Cc: hch@infradead.org, zlang@kernel.org, fstests@vger.kernel.org,
	linux-mm@kvack.org, hughd@google.com, akpm@linux-foundation.org,
	yoyang@redhat.com
Subject: Re: [PATCH v2 2/2] generic/732: don't run it on tmpfs
Message-ID: <ZqekPERYzP93HacM@infradead.org>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
 <20240729084715.1736839-2-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729084715.1736839-2-yangerkun@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
