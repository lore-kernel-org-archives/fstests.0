Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47134198842
	for <fstests@vger.kernel.org>; Tue, 28 Jan 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048457; cv=none; b=PZACo8aaHM4e1NxTxBix/V71yt4BPRQMFwg3CzbVpoByLqSL9IW7FrbIkONRRtTjt2eSKqr199pEMz4AowPv4wIMZmZTF72pyFpZfwSOj2ciagNCKYdcIWN3dWLtdniO4Yfy/gwmWViaI33SMcl7uLeDuAGH2dx7r0rXKzcn0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048457; c=relaxed/simple;
	bh=qJxR5pV8ccsklg8ZAdldf78fAmzKM5W6mea776l6JY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMywbg1bcyeWszIyYhIoYyOOMVuHSMlxUYC5YgArd0wq5g1+C1D3OQBr/p77QWU75qiUWuTrZxhRSlCn9kY1eqMTCDVqC7T14QnWDcekAnqtHr2q95Y/Mo6EHAJ3qQCvctnnH7sCR8Q5Yd/RSunzecFexM04OP0pSk0wnowayJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pWxWLjTl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pWxWLjTl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tWiKrJ8o0aevZc95PG+GC+Co4Fr0w1T7HooSIQxUGrI=; b=pWxWLjTlgLh+fJzlbHm70Pjrzc
	CD3/Sy55R0CEtvogaJFCnT9w+YB76Mt0WQcnDqQ/wSE3VTYi+QGhacj6imKAIhtKWfDqFQa7VWPYa
	tsx5TFlQF2KuAwi87YXvNdXBD0sC7lmmDLJ/NaZL0jmqi8wHt0PT9lIkhVQ6yk3FB09v6I/t16OKN
	qmx2iK300hUIUg9hkCwDGx1F3sriOyvnMsW5cGbBOf6WLsWoI/aEsDn+rDHkKoH7AwKLBnny6Yh4t
	oeh21OfqhhtUJXe3pMvurd77uXPOztSyt1ATfO5PBRjssU+4NV0bT5fuh2Vok7VesPFYUT943ip8H
	nMpVAYVw==;
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfnb-00000004GSH-1GLn;
	Tue, 28 Jan 2025 07:14:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] generic/418: use min_dio_alignment
Date: Tue, 28 Jan 2025 08:14:12 +0100
Message-ID: <20250128071412.676396-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise this test uses the wrong sector size on the RT device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/418 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/418 b/tests/generic/418
index 4321e2984663..36789198c88e 100755
--- a/tests/generic/418
+++ b/tests/generic/418
@@ -28,7 +28,7 @@ _require_test_program "feature"
 
 diotest=$here/src/dio-invalidate-cache
 testfile=$TEST_DIR/$seq-diotest
-sectorsize=`blockdev --getss $TEST_DEV`
+sectorsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
 pagesize=`$here/src/feature -s`
 
 # test case array, test different write/read combinations
-- 
2.45.2

