Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A68644C60
	for <fstests@vger.kernel.org>; Sat, 27 Apr 2024 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714204537; cv=none; b=Iv2uSmMlyHC+uo+hTe0VbFk2zhoFAdIcRf1Y99GCwXOKMgMbhoGYBEkL+ymcobgkfY5ug3vjbjHxFqZCDLl5dRuNqdkRSuS7ugNXce3T1sAKqAFvWQf4ST86jngo2SBYwceduGMpXvqiDzA9W8wbY11l2b8DHVahfoBuuhYResM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714204537; c=relaxed/simple;
	bh=0S+xP0Im82/poaYWbFODYFlA4Id7K+gXgFcpQHTpg4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JwZyVvdoUlZMrxAPZRDnkyaPcHBPYYxE/WRc+wd/J1vdVevGCOk+5plc+HOY10PKmvYPdqx2/Kz/P4dwoHod5CiZhVwDpW3tJa28X1kY+6n+uqy9n57LiuVgguoWAjj/ngI43kHUMhsubHzj2S+6mt8jEqXQsiCmR/2HXlz1YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uC3NXVsq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uC3NXVsq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vM0FcgRSC9/ztlLGLlcLRYuRcxQISg3JqAzcqM4sLNc=; b=uC3NXVsqdxs4waOr75ugk/Bq5k
	U3i8eoRTwVtyy2ItpYDuXsFNdd54ezd0rrenubR6IcejCER4bO18GOyZ5JGJNZmdjqycziL60+BUq
	50SBkWA4UN8UT9sVmTUr3KqjaT4msqgROOKwyINakO3q6G7ceTB1XO+vuFiY73UBJNcQbM8yLwpcg
	cToZ9Q7J7iqDTVD8T5QcRp/2XH2xHIIIAsNNS+zKq+CdRh9HdjIQ7eiYGC/b5CEZlcgpaHbefNsYx
	pJ9my3MQI05OEMk9Ya+TvM65r0qR54vaePbQkB9ssmwvsbqONGvljbTwVZGzIGg9fOZbOd/5Hw1kS
	dbeep5hw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0cuE-0000000F6R5-1zmi;
	Sat, 27 Apr 2024 07:55:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] generic/095: add to the quick group
Date: Sat, 27 Apr 2024 09:55:30 +0200
Message-Id: <20240427075530.1236045-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

generic/095 doesn't take more than 4 seconds on any of my test setups,
but is exercises code that handles buffered write iterations interrupted
by concurrent direct I/O that no other test in the quick group does.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/095 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/095 b/tests/generic/095
index 80448200b..9d0446e98 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -7,7 +7,7 @@
 # Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice) on the same files
 #
 . ./common/preamble
-_begin_fstest auto rw stress
+_begin_fstest auto quick rw stress
 
 # Import common functions.
 . ./common/filter
-- 
2.39.2

