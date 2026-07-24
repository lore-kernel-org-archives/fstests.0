Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3F242D62
	for <fstests@vger.kernel.org>; Fri, 24 Jul 2026 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897476; cv=none; b=aNRy2fDS9CBectCBYweGVi4zG+3LRbkVJaIVUNPPWVafjwFGes3x3A7FOjKXEY2kZ03HEwegCueWFIBJAB33u9utmoZpcn0X9EUY1eWvy7jrqBi27i2AqjnG9c1r0RknRskdZKvtKS3g3JEZge3oTa9iMT31eIQ80GAQTJuOTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897476; c=relaxed/simple;
	bh=PEdZyzxD/oC/F78eYaa9Bx1QBtem+zqH+EWNU7nPouU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuGYlNiuBd6N4lAv12TyiICcfnFGiIonUzJBlwcgRSDPAv0FZrXlBvmGOTtRisc54YOANCdCbY2Yna7WD+4rZNzJlxzk8YSXNyJy5JGhKtQJi8UuOfj41l/DVITralWtZPs6Hyx8npFyDt7UBWXkIZd2Ua54S9cz+wRiUNTsXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VidoB4qz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VidoB4qz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VPqgRjkaMe4SKEjCSHh68nLzmS1ZjOcHBRiV6hQ2aQM=; b=VidoB4qzml9t9FxJDAW7LVX30s
	ljEXPlaHVCmsigtf0qKgJL4H4+lRGYWnPGomQMj5uBG2iiO6WvoHGYb6GWI/34eSN8I6IR6+OGfR4
	J4YokmyodIP4PewZFTWvBUU1lEIG5IrPUtiblplWHiRs5gauZ48UPGjf38OHgaC5FTO1xdklP02Qn
	q7qJSNqWfXOwYaZNIx97fGw+7N50WRi7wRZAVaw5NiYk4bJ5VN27hrfeU4TjqmNSi44EiygA9ullj
	GmOq2N1xaY3gMHVfsDetfqHIueZdoN2nzjLIJlQbzJmrMny1z3iOR6WloTeBD3C46MN9VpmHJXwjh
	rGSE3X7Q==;
Received: from [2001:4bb8:2d1:bd34:bc05:3da8:f7ec:c468] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnFMr-0000000GQPg-2lug;
	Fri, 24 Jul 2026 12:51:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: wqu@suse.com,
	fstests@vger.kernel.org
Subject: [PATCH] generic/761: add to the rw group
Date: Fri, 24 Jul 2026 14:51:06 +0200
Message-ID: <20260724125106.433118-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This tests the read-write path, so add it to the proper group.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/761 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/761 b/tests/generic/761
index e9030f3c6ab3..d9e095f7a4fc 100755
--- a/tests/generic/761
+++ b/tests/generic/761
@@ -13,7 +13,7 @@
 #
 
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick rw
 
 _require_scratch
 _require_odirect
-- 
2.53.0

