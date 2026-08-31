Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349DD3AE19B
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159087; cv=none; b=iEbDKDPP5ZljzNVYQWmeX8ZnckqxFpsRnskGRqOAUQqCIVI93fQlq3n4iXkHdfyxzUCFFlG8ds5yrfK3FodmcjdvAOBHS0rQGBPkSlXWyMBPxQdhJpHJr3je51JIZpa3a9FO3DCTQ4pnfm2CIUrrNoCZlaSiIIxkkgE3gXeR5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159087; c=relaxed/simple;
	bh=RA+2R8GZoolDWW39EGVTBlfn2z3EcxAUz9l0DWqnFlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXoksMH2hSmyVLl50syT25PrL2XZ2GaoYpMKZtSk5eIoHLJTIUttok0bcQLKP5zjT6nJYdBIrDAKamOTaX4Wk76SQ3WAkvTTyL6xHlfHsk8yzrYEcj5dQSDx4k1r+sBtuVJytAtJAXHijhpsPaP0ZWrLHHz9hbEh2Unn4+D8Nok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gSMxvOku; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSMxvOku"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RA+2R8GZoolDWW39EGVTBlfn2z3EcxAUz9l0DWqnFlo=; b=gSMxvOkulywbrs7iW5QY8x/zFx
	LlmtnGPfRyQEsKvI6YbJpt2i3tnWBKPwJhKVUA5Q0pPbFxdTScDWSKvohJUoEPkEPYsM9oQEK/Dmd
	U3CPmb1FqzFlqdc0TiHsX1n/N1rDlSpHfkLiAd/zvD2iw+i6dVVl5DeBgHPi6im9RPqux3qapADVE
	PO91JLXOU9pY/W3HmiT9Rfs/9Z0nufqwMO0F7q0KPlleKDION4Qb6DSogWAkSgSRzoqcXf5taK52k
	HJBn8lFQD86WBvIQCgqgp8cjcJAzZs/AQrwX+G9K0K9IM4supYPWJSSwhhwf4SbMG7gGzAkY0xRk/
	fi+hksgg==;
Received: from [2001:4bb8:2f9:3a59:1608:d03f:db12:ee92] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vrY-00000008eXV-2OWS;
	Mon, 31 Aug 2026 06:51:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: actually exercise sub-block direct I/O reads
Date: Mon, 31 Aug 2026 09:51:03 +0300
Message-ID: <20260831065120.2578146-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

when looking into testing changes that might require a minimum read size
larger than a page size, I realized that various tests hard code
PAGE_SIZE as a direct I/O read size despite claiming that they exercise
sub-block direct I/O.

This series adds support to query the minimum read size and actually uses
that for testing.
