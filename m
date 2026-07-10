Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F11A6831
	for <fstests@vger.kernel.org>; Fri, 10 Jul 2026 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660957; cv=none; b=FLVYB85AS88DMGCcF51xCSUuMyObgsn/DxSowGo7nRGXJ/RurSe0X7+bAn+CLuDM1gg36TeN6KGLD3Pqa+9zJ81Vu7/QbYquLl4bo+KLKWigKbVfyzigbw40IuRjp7BCzwCsVfBXpom6897I2oCs6Qr43oG0i7aEdWBOdDA9//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660957; c=relaxed/simple;
	bh=dN5hbMFOH/GNkUgYEm2pEMs8X9nGa6BohOwwGbClgk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjmANeL76j/QBAYu7h3lylkmvnBPxpEcv13WRWr+A/94rj1k4qwXpJPHgE9B8O4SvLPOIh4KB2lRXmD1yVfhUWuEyVYR7p8r+d+dfccZRsGBSiN3eiRln2GBbyFMQsJEBd0ts/Z32St18WXw7ZLyFNa5CCW7V8kFzn8fAC7HXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g1xwFYzj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g1xwFYzj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Mm0TPfBYh95wt1CPP1R9+QVImoMDsDjMKyxKgqmDyog=; b=g1xwFYzjca6AopB4P/r0zUGVFr
	yB37qDMBjDGe6hLYPvTmth//vzqxFbTCE2Lbfv4nhDl1JKrzWXv0Wm2tYFri+U+TK6ShRsQwY9iCu
	BdaxmyoLkkL5XR1iCElVY0kMTd2nXTdWwc3adV9+Q5KoRFL3UbbNltgphkF6MiTU1drjqDKo8LyzW
	3w86s+Pc5LzQuCQvgnBbPOoh9ZyTM6hGwK7uxKMnUJsmOTbl6PveGj/5SSEjdA1ZUYEVYmSROuNAE
	Ye+v7gLqXsfGVdApS2hld1+mX48XsQfici8/Wj0t1YMK1hr3wvieoo6eP1UTfoWLlNSjshLTRgcEw
	ldeHVgiw==;
Received: from [2001:4bb8:2cc:d72d:4dff:292f:a943:a4b9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi3h4-00000004Bwq-2G7M;
	Fri, 10 Jul 2026 05:22:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v3] common: log mkfs output in _test_streams
Date: Fri, 10 Jul 2026 07:22:08 +0200
Message-ID: <20260710052229.1841342-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Log the mkfs output to allow debugging the mkfs paramters,
especially when mkfs and thus the test fails.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v2:
 - really append to the log

 common/filestreams | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filestreams b/common/filestreams
index 838b5921520a..cce7599817cd 100644
--- a/common/filestreams
+++ b/common/filestreams
@@ -89,7 +89,7 @@ _test_streams() {
 	# Skip these tests on zoned file systems as filestreams don't work
 	# with the zoned allocator, and the operation below would force it into
 	# the tiny data section only used for metadata anyway.
-	_try_scratch_mkfs_xfs >/dev/null 2>&1 || _fail "mkfs failed"
+	_try_scratch_mkfs_xfs >>$seqres.full 2>&1 || _fail "mkfs failed"
 	_scratch_mount
 	_require_xfs_scratch_non_zoned
 	_scratch_unmount 2>/dev/null
-- 
2.53.0

