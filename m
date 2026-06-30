Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294842315B
	for <fstests@vger.kernel.org>; Tue, 30 Jun 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829267; cv=none; b=FXVmOQBrMAI4OhPI0quJtMQ0EVf8m0HE0ahSVGSsoXTPAGYDBelDr5K8zXKbtjxdQbN4TtKhcne1n/WiOHagvBuuucKgoFNEfHDv93S9gOY5MzE+NXwivWp2c0M8ntpzra/uClQ2MDdViU5kaGpp6O+/JbiGSOXwpFlGHr27i84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829267; c=relaxed/simple;
	bh=qeuq4M27liFOGZj23Kgl8nSBSJCtCk8WIn2B/o4ZSRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c93soC4u/Soulo9cfQlf7NCHy+oV97R5IKjINkoUbyeAbWwjQzyYrsiOkYKYSbEs0XnTx6nLyiFzoF2/uS79VAZNNa3YgoHhStvRCzrQR90p0SS2GaCeJwzmkYfMREss4cY65cP1w49J/Ej9+Jla8pscuqScp/K38RvroGYWbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mnUdkbBC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mnUdkbBC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rlksD3tO5OLsFuscTV1ol2i+i3IcgeDK0vZp22r8tIE=; b=mnUdkbBCRB3s7cmO0+h6JxhgBx
	mRQ2s0SeayErvyhWqNCn8OViZPvXrZcJGRWnlEVGDh1ssoDj0OiWkL64+SFOlamYjV49MdZseqcrF
	Prf0zFB6MqTtGghxYxND/fD4v0onwxZvWXjNaVNnj6OnLPRwYBtnbSLnokDkwgHpk8yE6+MvDYDKS
	U6uYFVrfEdTswgLGyxv8873qjX3HI/6mtTWX+1x/jK2dDUSOwAaNUqhiyKuhvv7/NLR5FT0JEtnOV
	kEaSOj5Y8E3W9zg9mFmjZCmGHI70mgen6aPV5It0ig+6nMvtbvnjvO7NeqdXDl/BT+ByTOkmwckAb
	1a2aBJ0g==;
Received: from [80.149.170.9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weZKZ-0000000HGfE-48VJ;
	Tue, 30 Jun 2026 14:20:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] common: log mkfs output in _test_streams
Date: Tue, 30 Jun 2026 08:20:47 -0600
Message-ID: <20260630142047.3612436-1-hch@lst.de>
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
 common/filestreams | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filestreams b/common/filestreams
index 459de8c6b6a6..0b11b6644977 100644
--- a/common/filestreams
+++ b/common/filestreams
@@ -89,7 +89,7 @@ _test_streams() {
 	# Skip these tests on zoned file systems as filestreams don't work
 	# with the zoned allocator, and the operation below would force it into
 	# the tiny data section only used for metadata anyway.
-	_try_scratch_mkfs_xfs >/dev/null 2>&1 || _fail "mkfs failed"
+	_try_scratch_mkfs_xfs >$seqres.full 2>&1 || _fail "mkfs failed"
 	_scratch_mount
 	_require_xfs_scratch_non_zoned
 	_scratch_unmount 2>/dev/null
-- 
2.53.0

