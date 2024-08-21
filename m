Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39062595
	for <fstests@vger.kernel.org>; Wed, 21 Aug 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724215669; cv=none; b=Ikp7cHW1RXQVYSDa7UpOz0+GhIpcbcoVpuClWcWWdzU0bntP3JlGAviuQy/9QMTUK1mMUZpFrGEqSPuGGnJWO00W4KBOe75I1iREQ/8Mo7upvKNCpx2a2mCsTDZAExveCMFp1chZZXCu0erQjMeDOcI1AAUTpD0vyMvMo38EYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724215669; c=relaxed/simple;
	bh=G7fyDnL8JsL38pFymT+fD6qbnEIZJnjHqiyXDqdEPMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udKXLn1dUlK39iVYgSerWeVZ+6qka2vYMA/7d2BA+Yy1V/gt0OqZOWmxdNnTPFECbU4uH97uxEhKya05Y3ep0qBM6Kgd7ErK6TN58wYYxfi6fhRAknW6D7OH16cxXC5kxLiRj3+RMFwZ0IqAJhUqO81Lq1djHkvY9AfXMtwf60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OGpmsY6o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OGpmsY6o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5K/ZGZYoILjFkKFlN/5SGCOfD+Ip1IJ1yz+yQK1hzmM=; b=OGpmsY6oFmg61gX4go9TPJaYHQ
	QojnDTdTCSLORCFndtADRjgG3S36u92LjpebwOsZ6E5kRsVZQn/8oDdLYqIcJDogUBTO5e5rSXopP
	qgGFn05BdJlDtTDlfH+/cBty0w6nuzzEnSFtV3F7HrlKXhjw6e/SxBBIFM0tXyBiNqJuFCAYvGULM
	xJtCIRV7BJ6jEzTemzCLZLVOvjYu8fl48lSt1o9VlGYllrVgtagx0rUCo+ySGRFXmZ8A+346pWcth
	ZjjC+QY3yDsJbBoj4Nt07MTYWURu8SEe82Ie3n1ZvUKk57ZUAVwjOTqeSH0DDdKMlQxzKG0bnvbMx
	bz6V5Z8g==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgdG6-00000007VpT-49dy;
	Wed, 21 Aug 2024 04:47:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] generic/615: add to the quick group
Date: Wed, 21 Aug 2024 06:47:43 +0200
Message-ID: <20240821044743.603691-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is a simple and very quick test, add it to the quick group.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/615 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/615 b/tests/generic/615
index 71cdb9ac8..66dd1aa08 100755
--- a/tests/generic/615
+++ b/tests/generic/615
@@ -9,7 +9,7 @@
 # zero while writeback is in progress.
 #
 . ./common/preamble
-_begin_fstest auto rw
+_begin_fstest auto quick rw
 
 # Import common functions.
 . ./common/filter
-- 
2.43.0

