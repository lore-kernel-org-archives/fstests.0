Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F1443C39
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386356; cv=none; b=X1N5XyprycsgY4I/td753VUqYadFUrk3Dyhb/JByHufTy0sqQgpT4RY61ozGUD44T+Mt6VFxzj3l0afka7rrxLJ2Y0L9JqxoIEaH2LEqSuvCs6XNL0So1UCxoeMkP/YdHqKmkYRPt1O5phCkseqbYz010xm6IUDaOYQLC+6MRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386356; c=relaxed/simple;
	bh=hticdBYL5vMsiNrMYSfG3mPbl+2MyDGCS1tr4omow0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLjjWHFM/wc1L1AzansQqfeCh7WdOW2yx916hT+FSkTYwbpezzDLppP+YiQknOF+cDSkKKwyhW2pEcB5B9rV142N65q3WzOpQALWG+OCCwC8kOLRGddDp42TSKyjIB6btaKAB4dXg+NPdqovMel4o4kRuc+PNpifTvNbYAG9kqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y++y4hZ6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y++y4hZ6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=hticdBYL5vMsiNrMYSfG3mPbl+2MyDGCS1tr4omow0A=; b=y++y4hZ6sTua+q71Q/NxHDEFOd
	Rif1GiIoJnQuvKvfCgp6ktO9xGj77A5hiAx4J/d36XljgPcWhCwDnJb+10IkUDg+Ybwaj7w8/qQuA
	Zt7xipIL7R9YeONVUws6oF7oANx584r/0/n/3A0PF8Ai8RI6YuGGxMRolJu6/Hsbe+k+E0dFSSTPS
	+rbPSZazvDCEHAjUgiQidPc/jqAy5QED5JltRGrbJnv8qzKSYioAH40SPBgY35WEv8Ocinj4heUEn
	+cjoAhmo3irsgzBPYb/8Drenh5YgeY+f1hu6SUg81BP7cL6DXQOq52YJwFH4WGHR/Crn0QJXAcz/B
	hTkmvehw==;
Received: from [195.12.231.4] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x658C-00000003Mys-2Ple;
	Mon, 14 Sep 2026 11:45:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: actually exercise sub-block direct I/O reads v2
Date: Mon, 14 Sep 2026 13:45:42 +0200
Message-ID: <20260914114550.2451308-1-hch@lst.de>
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

Changes since v1:
 - explicitly request STATX_DIO_READ_ALIGN
 - spelling fixes
